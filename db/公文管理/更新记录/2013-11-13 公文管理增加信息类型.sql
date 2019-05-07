-- Add/modify columns 
alter table OA_ACT_TEXT_STAUTS add is_print CHAR(1);
alter table OA_ACT_TEXT_STAUTS add is_split CHAR(1);
alter table OA_ACT_TEXT_STAUTS add is_infotype CHAR(1);
-- Add comments to the columns 
comment on column OA_ACT_TEXT_STAUTS.is_print
  is '是否打印';
comment on column OA_ACT_TEXT_STAUTS.is_split
  is '是否拆分指标文';
comment on column OA_ACT_TEXT_STAUTS.is_infotype
  is '是否信息分类';
  
  -- Add/modify columns 
alter table OA_FLOW_INSTANCE add info_type VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_FLOW_INSTANCE.info_type
  is '信息类型';