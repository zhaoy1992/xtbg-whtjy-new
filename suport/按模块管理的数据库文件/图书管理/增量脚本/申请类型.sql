-- Add/modify columns 
alter table TA_OA_REGBOOK add T_REGB_SQTYPE VARCHAR2(100);
-- Add comments to the columns 
comment on column TA_OA_REGBOOK.T_REGB_SQTYPE
  is '申请类型';