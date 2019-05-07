-- Add/modify columns 
alter table TA_OA_WHTJY_CHEWEIXIU add logistics_support2 varchar2(2000);
-- Add comments to the columns 
comment on column TA_OA_WHTJY_CHEWEIXIU.logistics_support2
  is '后勤保障部负责人审核';
