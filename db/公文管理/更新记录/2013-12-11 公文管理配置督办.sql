-- Add/modify columns 
alter table OA_FLOW_INSTANCE add chief_endtime date;
-- Add comments to the columns 
comment on column OA_FLOW_INSTANCE.chief_endtime
  is '督办结束时间';

-- Add/modify columns 
alter table OA_ACT_TEXT_STAUTS add is_chief CHAR(1);
-- Add comments to the columns 
comment on column OA_ACT_TEXT_STAUTS.is_chief
  is '是否督办';