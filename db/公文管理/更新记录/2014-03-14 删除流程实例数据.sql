--删除流程实例存储过程
create or replace procedure deleteFlowInsInfo(d_ins_id in varchar2) is
begin

--环节任务表 
delete  from  OA_FLOW_ACTIONUSER where ins_id = d_ins_id;
--流程活动业务表
delete  from OA_FLOW_INSWFACTION  where ins_id = d_ins_id;
--文件传阅表
delete  from OA_CIRCULARIZE_FLOW  where ins_id = d_ins_id;
--意见列表
delete  from OA_FLOW_INSVIEWLIST  where ins_id = d_ins_id;
--流程实例表
delete  from  OA_FLOW_INSTANCE  where ins_id = d_ins_id;

end deleteFlowInsInfo;