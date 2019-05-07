-- Add/modify columns 
alter table SX_TA_OA_ELECTCHECK_INFO add Details varchar2(3000);
-- Add comments to the columns 
comment on column SX_TA_OA_ELECTCHECK_INFO.Details
  is '³öÇÚÏêÏ¸ĞÅÏ¢';