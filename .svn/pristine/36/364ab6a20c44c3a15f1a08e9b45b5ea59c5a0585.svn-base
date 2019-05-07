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
values (get_uuid(),c_action.action_id,'N','',sysdate,'','','','');

--oa_act_text_stauts 环节扩展信息表
insert into oa_act_text_stauts(id,action_id,is_trace,is_red,is_readonly
,extend_attribute,extend_methods,msg_txt,is_msg,is_sign
,is_keeptrace,is_attachment,is_serialnumber,is_gwzl,is_ckcg,
is_ckzw,is_ckmq,is_singname,is_affix,remark1)
 values (get_uuid(),c_action.action_id,'0','0','0'
         ,'0','0','','0','0'
         ,'0','1','1','0','0'
         ,'0','0','0','0','0');
         
--OA_FLOW_ACTIONTREECONFIG  活动树配置表
insert into oa_flow_actiontreeconfig(config_id,action_id,tree_role,tree_nodetype) 
values (get_uuid(),c_action.action_id,'allPeople','checkbox');

end loop;
end  FLOW_ACTION_INIT;
/
