-- Add/modify columns 
alter table OA_FORM_TAG_CONFIG add DRAG_IN_VALUE VARCHAR2(400);
-- Add comments to the columns 
comment on column OA_FORM_TAG_CONFIG.DRAG_IN_VALUE
  is '收文转发文时存放值';

insert into OA_TAG_TYPE (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('number', '文号');

  -- Add/modify columns 
alter table OA_FLOW_WFACTIONEXT add IS_AUTO_COMPLETE CHAR(1);
-- Add comments to the columns 
comment on column OA_FLOW_WFACTIONEXT.IS_AUTO_COMPLETE
  is '是否自动办结(该配置只对办结环节(OA_FLOW_WFACTION.actiontype_code=''03'')有效)';
  

create or replace procedure deleteFlowInfo(flow_ids in varchar2) is
begin
  
--删除活动扩展表
delete OA_FLOW_WFACTIONEXT where action_id in ( select action_id from OA_FLOW_WFACTION where def_id in (select def_id from OA_FLOW_DEFINFO where flow_id in (select flow_id from OA_FLOW_BASEINFO where flow_id in (flow_ids)) ) );

--删除活动树配置表
delete OA_FLOW_ACTIONTREECONFIG where action_id in ( select action_id from OA_FLOW_WFACTION where def_id in (select def_id from OA_FLOW_DEFINFO where flow_id in (select flow_id from OA_FLOW_BASEINFO where flow_id in (flow_ids)) ) );

--删除流程活动用户表
delete OA_FLOW_WFACTUSER where action_id in ( select action_id from OA_FLOW_WFACTION where def_id in (select def_id from OA_FLOW_DEFINFO where flow_id in (select flow_id from OA_FLOW_BASEINFO where flow_id in (flow_ids)) ) );

--删除活动表单定义表
delete OA_FLOW_ACTIONFROMDEFID where action_id in ( select action_id from OA_FLOW_WFACTION where def_id in (select def_id from OA_FLOW_DEFINFO where flow_id in (select flow_id from OA_FLOW_BASEINFO where flow_id in (flow_ids)) ) );

--删除流程活动表正文状态控制表(环节字段状态表)
delete oa_act_text_stauts where action_id in ( select action_id from OA_FLOW_WFACTION where def_id in (select def_id from OA_FLOW_DEFINFO where flow_id in (select flow_id from OA_FLOW_BASEINFO where flow_id in (flow_ids)) ) );

-- 删除流程活动表单元素状态表(环节字段状态表)
delete oa_act_col_stauts where action_id in ( select action_id from OA_FLOW_WFACTION where def_id in (select def_id from OA_FLOW_DEFINFO where flow_id in (select flow_id from OA_FLOW_BASEINFO where flow_id in (flow_ids)) ) );

--删除流程活动定义表
delete OA_FLOW_WFACTION where def_id in (select def_id from OA_FLOW_DEFINFO where flow_id in (select flow_id from OA_FLOW_BASEINFO where flow_id in (flow_ids)) );

--删除流程定义表
delete OA_FLOW_DEFINFO where flow_id in (select flow_id from OA_FLOW_BASEINFO where flow_id in (flow_ids));

--删除流程基本信息表
delete OA_FLOW_BASEINFO where flow_id in (flow_ids);


end deleteFlowInfo;
/
