-- Add/modify columns 
alter table TA_OA_INFRE_SUBMITTED_INFO add leadedit_state varchar2(10);
-- Add comments to the columns 
comment on column TA_OA_INFRE_SUBMITTED_INFO.leadedit_state
  is '是否是领导报送';
