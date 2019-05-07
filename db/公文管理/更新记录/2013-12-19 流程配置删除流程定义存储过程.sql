create or replace procedure deleteFlowDefInfo(v_def_ids in varchar2) is
  CURSOR c_def_id_list IS
    select column_value def_id from table(split(v_def_ids));
begin
  
/**
 * 流程管理-流程配置
 * 支持(FlowInfoDaoImpl.deleteFlowDefInfo())
 * jie,xiao
 * 2013-12-19
 * 流程配置-删除流程列表中流程相关信息
 */
    for onerow in c_def_id_list loop

  --删除活动扩展表
  delete OA_FLOW_WFACTIONEXT
   where action_id in
         (select action_id from OA_FLOW_WFACTION where def_id in (onerow.def_id));

  --删除活动树配置表
  delete OA_FLOW_ACTIONTREECONFIG
   where action_id in
         (select action_id from OA_FLOW_WFACTION where def_id in (onerow.def_id));

  --删除流程活动用户表
  delete OA_FLOW_WFACTUSER
   where action_id in
         (select action_id from OA_FLOW_WFACTION where def_id in (onerow.def_id));

  --删除活动表单定义表
  delete OA_FLOW_ACTIONFROMDEFID
   where action_id in
         (select action_id from OA_FLOW_WFACTION where def_id in (onerow.def_id));

  --删除流程活动表正文状态控制表(环节字段状态表)
  delete oa_act_text_stauts
   where action_id in
         (select action_id from OA_FLOW_WFACTION where def_id in (onerow.def_id));

  -- 删除流程活动表单元素状态表(环节字段状态表)
  delete oa_act_col_stauts
   where action_id in
         (select action_id from OA_FLOW_WFACTION where def_id in (onerow.def_id));

  --删除流程活动定义表
  delete OA_FLOW_WFACTION where def_id in (onerow.def_id);

  --删除流程定义表
  delete OA_FLOW_DEFINFO where def_id in (onerow.def_id);

    end loop;
end deleteFlowDefInfo;
/
