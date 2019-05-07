-- Add/modify columns 
alter table OA_WORD_TEXTINPUT add DATA_COME_FROM_TABLE_ID VARCHAR2(40);
alter table OA_WORD_TEXTINPUT add DATA_COME_FROM_COLUMN_ID VARCHAR2(40);
-- Add comments to the columns 
comment on column OA_WORD_TEXTINPUT.DATA_COME_FROM_TABLE_ID
  is '来文表名(支持:页面在初始化时,自动填入其他业务数据)';
comment on column OA_WORD_TEXTINPUT.DATA_COME_FROM_COLUMN_ID
  is '来文列名(支持:页面在初始化时,自动填入其他业务数据)';
  
---修改 该表 相关的存储过程

CREATE OR REPLACE PROCEDURE p_oa_word_template_copy(
       v_oa_word_template_id    in varchar2,
       v_template_userid        in varchar2,
       v_template_username      in varchar2,
       v_org_id                 in varchar2,
       v_org_name                 in varchar2,
       v_out_oa_word_template_id out varchar2) as
  v_new_oa_word_template_id      varchar2(40) := sys_guid();
  v_new_oa_octl_template_file_id varchar2(40) := sys_guid();
  v_oa_word_textinput_id         varchar2(40);
  v_template_sn                  number;
  v_record_sn                    number;
  CURSOR c_oa_word_textinput IS
    select textinput_id,
           template_id,
           textinput_name,
           table_id,
           column_id,
           textinput_value_type,
           textinput_value,
           textinput_help,
           textinput_flag,
           textinput_remark,
           DATA_COME_FROM_TABLE_ID,
           DATA_COME_FROM_COLUMN_ID,
           table_cell
      from oa_word_textinput
     where template_id = v_oa_word_template_id;
/**
 * 流程管理-文档模板管理-复制模板
 * 支持(WordTemplateDaoImpl.copyWordTemplate())
 * tuo.zou
 * 2013-11-28
 * 0,数据准备1,复制word模板表;2,复制通用模板表;3,复制word中输入文本数据表
 */
begin
  --0
  select nvl(max(template_sn),0)+1 into v_template_sn from oa_word_template;
  select nvl(max(record_sn),0)+1 into v_record_sn from oa_octl_template_file;
  --1
  insert into oa_word_template
    (template_id,
     template_name,
     template_creatortime,
     template_userid,
     template_username,
     org_id,
     org_name,
     template_remark,
     is_common,
     lastmodifytime,
     template_sn,
     singn_config)
    select v_new_oa_word_template_id,
           case when regexp_like(template_name,'Copy\d{14}$')
                then substr(template_name,0,instr(template_name,'Copy',-1,1)-1)||'Copy'||(to_char(SYSDATE,'yyyyMMddhh24miss'))
                else substr(template_name||'Copy'||(to_char(SYSDATE,'yyyyMMddhh24miss')),0,250)
           end,
           SYSDATE,
           v_template_userid,
           v_template_username,
           v_org_id,
           v_org_name,
           template_remark,
           is_common,
           SYSDATE,
           v_template_sn,
           singn_config
      from oa_word_template owt
     where owt.template_id = v_oa_word_template_id;
   --2
   insert into oa_octl_template_file
      (templateid,
       recordid,
       filename,
       filetype,
       filesize,
       filedate,
       filebody,
       filepath,
       username,
       descript,
       org_id,
       record_sn)
      select v_new_oa_octl_template_file_id,
             'word'||v_new_oa_word_template_id,
             filename,
             filetype,
             filesize,
             SYSDATE,
             filebody,
             filepath,
             v_template_userid,
             descript,
             v_org_id,
             v_record_sn
        from oa_octl_template_file ootf
       where ootf.recordid = 'word'||v_oa_word_template_id
         and rownum = 1;

  --3
  for onerow in c_oa_word_textinput loop
      v_oa_word_textinput_id := sys_guid();

      insert into oa_word_textinput
        (textinput_id,
         template_id,
         textinput_name,
         table_id,
         column_id,
         textinput_value_type,
         textinput_value,
         textinput_help,
         textinput_flag,
         textinput_remark,
         DATA_COME_FROM_TABLE_ID,
         DATA_COME_FROM_COLUMN_ID,
         table_cell)
      values
        (v_oa_word_textinput_id,
         v_new_oa_word_template_id,
         onerow.textinput_name,
         onerow.table_id,
         onerow.column_id,
         onerow.textinput_value_type,
         onerow.textinput_value,
         onerow.textinput_help,
         onerow.textinput_flag,
         onerow.textinput_remark,
         onerow.DATA_COME_FROM_TABLE_ID,
         onerow.DATA_COME_FROM_COLUMN_ID,
         onerow.table_cell);
  end loop;

  v_out_oa_word_template_id :=v_new_oa_word_template_id;
end;
/

CREATE OR REPLACE PROCEDURE p_oa_word_textinput_copy(
       v_oa_word_template_id_a  in varchar2,
       v_oa_word_template_id_b  in varchar2,
       v_out_mess out varchar2) as
  v_oa_word_textinput_id         varchar2(40);
  CURSOR c_oa_word_textinput IS
    select textinput_id,
           template_id,
           textinput_name,
           table_id,
           column_id,
           textinput_value_type,
           textinput_value,
           textinput_help,
           textinput_flag,
           textinput_remark,
           table_cell,
           DATA_COME_FROM_TABLE_ID,
           DATA_COME_FROM_COLUMN_ID
      from oa_word_textinput
     where template_id = v_oa_word_template_id_a;
/**
 * 流程管理-文档模板管理-复制模板中的textinput
 * 支持(WordTemplateDaoImpl.copyWordTextinput())
 * tuo.zou
 * 2013-11-29
 * 1,删除当前模板关联的文本数据表；2,复制word中输入文本数据表
 */
begin
  --1
  select v_out_mess||'复制前条数:'||count(1)
    into v_out_mess
    from oa_word_textinput cowt
   where cowt.template_id = v_oa_word_template_id_b;
   
  delete oa_word_textinput cowt
   where cowt.template_id = v_oa_word_template_id_b;
  --2
  for onerow in c_oa_word_textinput loop
      v_oa_word_textinput_id := sys_guid();

      insert into oa_word_textinput
        (textinput_id,
         template_id,
         textinput_name,
         table_id,
         column_id,
         textinput_value_type,
         textinput_value,
         textinput_help,
         textinput_flag,
         textinput_remark,
         table_cell,
         DATA_COME_FROM_TABLE_ID,
         DATA_COME_FROM_COLUMN_ID)
      values
        (v_oa_word_textinput_id,
         v_oa_word_template_id_b,
         onerow.textinput_name,
         onerow.table_id,
         onerow.column_id,
         onerow.textinput_value_type,
         onerow.textinput_value,
         onerow.textinput_help,
         onerow.textinput_flag,
         onerow.textinput_remark,
         onerow.table_cell,
         onerow.DATA_COME_FROM_TABLE_ID,
         onerow.DATA_COME_FROM_COLUMN_ID);
  end loop;

  select v_out_mess||'复制后条数:'||count(1)
    into v_out_mess
    from oa_word_textinput cowt
   where cowt.template_id = v_oa_word_template_id_b;
end;
/