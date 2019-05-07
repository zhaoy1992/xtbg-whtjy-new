-- Add/modify columns 
alter table TA_OA_PERSONHOLDER add hold_remark varchar2(500);
-- Add comments to the columns 
comment on column TA_OA_PERSONHOLDER.hold_remark
  is '备注';
