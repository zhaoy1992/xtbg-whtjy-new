-- Add/modify columns 
alter table TA_OA_REGBOOK add T_REGB_AUDITOPINION varchar2(4000);
-- Add comments to the columns 
comment on column TA_OA_REGBOOK.T_REGB_AUDITOPINION
  is '审核意见信息';
