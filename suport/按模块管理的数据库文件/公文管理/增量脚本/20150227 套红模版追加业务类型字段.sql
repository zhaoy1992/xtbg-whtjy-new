-- Add/modify columns 
alter table OA_WORD_TEMPLATE_TH add busitype_code VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_WORD_TEMPLATE_TH.busitype_code
  is '流程业务类型';