-- Add/modify columns 
alter table OA_ACT_TEXT_STAUTS add is_ckls CHAR(1);
-- Add comments to the columns 
comment on column OA_ACT_TEXT_STAUTS.is_ckls
  is '是否查看历史';