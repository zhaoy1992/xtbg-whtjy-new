CREATE OR REPLACE PROCEDURE p_oa_word_textinput_copy(v_oa_word_template_id_a in varchar2,
                                                     v_oa_word_template_id_b in varchar2,
                                                     v_out_mess              out varchar2) as
  v_oa_word_textinput_id varchar2(40);
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
           table_cell
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
  select v_out_mess || '复制前条数:' || count(1)
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
       table_cell)
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
       onerow.table_cell);
  end loop;

  select v_out_mess || '复制后条数:' || count(1)
    into v_out_mess
    from oa_word_textinput cowt
   where cowt.template_id = v_oa_word_template_id_b;
end;
/