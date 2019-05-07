-- Add/modify columns 
alter table TA_OA_WORKIP add WORKIP_remark varchar2(2000);
-- Add comments to the columns 
comment on column TA_OA_WORKIP.WORKIP_remark
  is '备注';