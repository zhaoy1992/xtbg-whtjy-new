-- Add/modify columns 
alter table TA_OA_OSAPP_OBJECT add ofustype_money number;
-- Add comments to the columns 
comment on column TA_OA_OSAPP_OBJECT.ofustype_money
  is 'µ¥¼Û';
