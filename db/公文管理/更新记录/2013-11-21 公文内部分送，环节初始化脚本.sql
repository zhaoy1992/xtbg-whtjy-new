-- Add/modify columns 
alter table OA_ACT_TEXT_STAUTS add is_nbfs CHAR(1);
-- Add comments to the columns 
comment on column OA_ACT_TEXT_STAUTS.is_nbfs
  is '是否内部分送';
  

create or replace procedure FLOW_ACTION_INIT(new_def_id varchar2) is
/**绑定流程环节时初始化配置信息
 *作者：shuqi.liu
 *日期：2013-09-26
 *   @param  new_def_id 新的流程定义id
 */
 --要复制的活动id
CURSOR c_action_cursor IS  select action_id from oa_flow_wfaction where def_id = new_def_id;
begin
FOR c_action IN c_action_cursor LOOP

--插入OA_FLOW_WFACTIONEXT 活动扩展表
insert into oa_flow_wfactionext(actionext_id,action_id,isshowuser,isshowreject,create_time,isshowback,autoassignment,issignjoinbyorder,isdispense) 
values (get_uuid(),c_action.action_id,'Y','',sysdate,'','','','');

--oa_act_text_stauts 环节扩展信息表
insert into oa_act_text_stauts(id,action_id,is_trace,is_red,is_readonly
,extend_attribute,extend_methods,msg_txt,is_msg,is_sign
,is_keeptrace,is_attachment,is_serialnumber,is_gwzl,is_ckcg,
is_ckzw,is_ckmq,is_singname,is_affix,remark1,
is_cklc,is_newflow,is_gk,is_print,is_split,
is_infotype,is_nbfs,is_xd,is_gwff,is_cd)
 values (get_uuid(),c_action.action_id,'1','0','0'
         ,'0','0','','0','1'
         ,'0','1','0','0','0'
         ,'0','0','0','0','0',
         '1','0','0','0','0',
         '0','0','0','0','0');
         
--OA_FLOW_ACTIONTREECONFIG  活动树配置表
insert into oa_flow_actiontreeconfig(config_id,action_id,tree_role,tree_nodetype) 
values (get_uuid(),c_action.action_id,'allPeople','radio');

end loop;
end  FLOW_ACTION_INIT;
/

-- Add/modify columns 
alter table OA_FLOW_BUSITYPE_TYPE add count_type VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_FLOW_BUSITYPE_TYPE.count_type
  is '类型分类登记分类';
  
create or replace procedure copyFlowInfo(new_def_id in varchar2,old_def_id varchar2,old_table_id varchar2) is
/**继承老版本配置信息
 *作者：戴连春
 *日期：2013-06-18
 *   @param  new_def_id 新的流程定义id
 *   @param  old_def_id 要被复制的流程定义id
 *   @param  old_table_id   旧的业务表id
 *
 */
 --判断要被复制的两个流程的业务表id是一样的标记
  v_flag number;
  
  --要复制的活动id
  CURSOR old_action_cursor IS 
    select a.action_id as new_action_id, b.action_alias,  
    b.action_limit,  b.limit_unit,  b.remark 
     from OA_FLOW_WFACTION a, OA_FLOW_WFACTION b
    where a.action_defid = b.action_defid
     and a.def_id = new_def_id
     and b.def_id = old_def_id;    
begin
  
--继承流程活动用户信息
insert into OA_FLOW_WFACTUSER
  (wfactuser_id, action_id, user_id, user_name, actuser_type, create_time)
  select sys_guid(),
         a.action_id,
         c.user_id,
         c.user_name,
         c.actuser_type,
         sysdate
    from OA_FLOW_WFACTION a, OA_FLOW_WFACTION b, OA_FLOW_WFACTUSER c
   where a.action_defid = b.action_defid
     and b.action_id = c.action_id
     and  a.def_id =new_def_id 
     and b.def_id =old_def_id ;

--继承活动树配置信息
insert into OA_FLOW_ACTIONTREECONFIG
  (config_id, action_id, tree_role, tree_nodetype)
  select sys_guid(), a.action_id, c.tree_role, c.tree_nodetype
    from OA_FLOW_WFACTION a, OA_FLOW_WFACTION b, OA_FLOW_ACTIONTREECONFIG c
   where a.action_defid = b.action_defid
     and b.action_id = c.action_id
  and  a.def_id =new_def_id 
     and b.def_id =old_def_id;


--继承活动扩展表信息
insert into OA_FLOW_WFACTIONEXT
  (actionext_id,
   action_id,
   isshowuser,
   isshowreject,
   create_time,
   isshowback,
   autoassignment,
   issignjoinbyorder)
  select sys_guid(),
         a.action_id,
         c.isshowuser,
         c.isshowreject,
         sysdate,
         c.isshowback,
         c.autoassignment,
         c.issignjoinbyorder
    from OA_FLOW_WFACTION a, OA_FLOW_WFACTION b, OA_FLOW_WFACTIONEXT c
   where a.action_defid = b.action_defid
     and b.action_id = c.action_id
   and  a.def_id=new_def_id 
     and b.def_id =old_def_id;

--继承流程活动表正文状态控制表信息
insert into oa_act_text_stauts
  (id,action_id,is_trace,is_red,is_readonly
    ,extend_attribute,extend_methods,msg_txt,is_msg,is_sign
    ,is_keeptrace,is_attachment,is_serialnumber,is_gwzl,is_ckcg,
    is_ckzw,is_ckmq,is_singname,is_affix,remark1,
    is_cklc,is_newflow,is_gk,is_print,is_split,
    is_infotype,is_nbfs,is_xd,is_gwff,is_cd)
  select sys_guid(), a.action_id, c.is_trace, c.is_red, c.is_readonly,
         c.extend_attribute,c.extend_methods,c.msg_txt,c.is_msg,c.is_sign,
         c.is_keeptrace,c.is_attachment,c.is_serialnumber,c.is_gwzl,c.is_ckcg,
         c.is_ckzw,c.is_ckmq,c.is_singname,c.is_affix,c.remark1,
         c.is_cklc,c.is_newflow,c.is_gk,c.is_print,c.is_split,
         c.is_infotype,c.is_nbfs,c.is_xd,c.is_cd,c.is_gwff
    from OA_FLOW_WFACTION a, OA_FLOW_WFACTION b, oa_act_text_stauts c
   where a.action_defid = b.action_defid
     and b.action_id = c.action_id
     and a.def_id=new_def_id
     and b.def_id =old_def_id;

 --循环复制动作基本信息
  FOR c_action_cursor IN old_action_cursor LOOP       
    update oa_flow_wfaction
       set action_alias = c_action_cursor.action_alias,
           action_limit = c_action_cursor.action_limit,
           limit_unit = c_action_cursor.limit_unit,
           remark = c_action_cursor.remark     
    where action_id = c_action_cursor.new_action_id ;    
  end loop;

     --判断两个流程的业务表是否一样
   select count(*)
     into v_flag
     from oa_md_table_business_mapping a
    where exists (select *
             from OA_FLOW_BASEINFO b
            where a.BUSITYPE_CODE = b.BUSITYPE_CODE
              and exists (select flow_id
                     from oa_flow_definfo c
                    where c.flow_id = b.flow_id
                      and c.def_id = new_def_id))
      and a.table_id = old_table_id;  
                     
  --如果两个流程配置的 ‘业务表’是一样的，则复制配置信息
  if(v_flag > 0) then

   insert into oa_act_col_stauts
   (id, action_id, table_id, table_code, column_id, column_code, readonly, hidden, disable, required)
   select sys_guid(),
         a.action_id,
         c.table_id, c.table_code, c.column_id, c.column_code, c.readonly, c.hidden, c.disable, c.required
    from OA_FLOW_WFACTION a, OA_FLOW_WFACTION b, oa_act_col_stauts c
   where a.action_defid = b.action_defid
     and b.action_id = c.action_id
     and  a.def_id =new_def_id 
     and b.def_id =old_def_id ;
 end if;
 end  copyFlowInfo;
/  
  

-- Add/modify columns 
alter table OA_FLOW_BUSITYPE_TYPE modify BUSITYPE_TYPE_NAME VARCHAR2(500);
alter table OA_FLOW_BUSITYPE_TYPE modify TYPE_DESC VARCHAR2(500);

-- Add/modify columns 
alter table OA_FLOW_BUSITYPE modify BUSITYPE_NAME VARCHAR2(500);
alter table OA_FLOW_BUSITYPE modify TYPE_DESC VARCHAR2(500);

-- Add/modify columns 
alter table OA_FORM_TAG_CONFIG modify TITLE VARCHAR2(500);

CREATE OR REPLACE FUNCTION OA_GETACTION_INDEX(V_INS_ID IN VARCHAR2,
                                              V_FLOW_ACTIONID IN VARCHAR2,
                                              V_USER_NAME IN VARCHAR2)
--根据流程实例ID，环节活动ID 按照时间查询出顺序。
  RETURN VARCHAR2 AS
  ACT_INDEX VARCHAR2(50);
BEGIN
  SELECT ACT_INDEX
    INTO ACT_INDEX
    FROM (SELECT ROW_NUMBER() OVER(ORDER BY W.TACHE_BEGIN_TIME DESC) ACT_INDEX,
                 W.FLOW_ACTION_ID
            FROM OA_FLOW_INSWFACTION W
           WHERE W.INS_ID = V_INS_ID
             AND W.IS_VALID = 'Y' AND W.ACTION_HANDERNAME = V_USER_NAME)
   WHERE FLOW_ACTION_ID = V_FLOW_ACTIONID;
  RETURN(ACT_INDEX);
END;
/

CREATE OR REPLACE FUNCTION OA_IS_BACK(V_INS_ID IN VARCHAR2,
                                      V_USER_NAME IN VARCHAR2)
--该函数用于查询，该用户是否有该流程实例的退回权限，如果是在办的并且上一步提交人是自己就有权限
  RETURN VARCHAR2 AS
  ACT_INDEX VARCHAR2(50);
  T_STATUS_CODE VARCHAR2(50);
BEGIN
  SELECT MIN(ACT_INDEX)
    INTO ACT_INDEX
    FROM (SELECT ROW_NUMBER() OVER(ORDER BY W.TACHE_BEGIN_TIME DESC) ACT_INDEX,
                 W.ACTION_HANDERNAME
            FROM OA_FLOW_INSWFACTION W
           WHERE W.INS_ID = V_INS_ID
             AND W.IS_VALID = 'Y')
   WHERE ACTION_HANDERNAME = V_USER_NAME;
   --如果是2代表，上一步是自己提交
   IF ACT_INDEX = 2 THEN
   SELECT STATUS_CODE INTO T_STATUS_CODE FROM OA_FLOW_INSTANCE WHERE INS_ID = V_INS_ID;
       IF T_STATUS_CODE = '01' THEN
          RETURN 1;
       ELSE
         RETURN 0;
       END IF;
   ELSE
   RETURN 0;
   END IF;
END;
/

-- Add/modify columns 
alter table OA_FLOW_DEFINFO add FLOW_DESC VARCHAR2(500);
-- Add comments to the columns 
comment on column OA_FLOW_DEFINFO.FLOW_DESC
  is '流程描述';

  -- Add/modify columns 
alter table OA_ACT_TEXT_STAUTS add IS_DOBACK CHAR(1);
-- Add comments to the columns 
comment on column OA_ACT_TEXT_STAUTS.IS_DOBACK
  is '是否回退';