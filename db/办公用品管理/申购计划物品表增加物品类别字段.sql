-- Add/modify columns 
alter table TA_OA_OSAPP_OBJECT add type_id varchar2(50);
alter table TA_OA_OSAPP_OBJECT add type varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_OSAPP_OBJECT.type_id
  is '物品类别id';
comment on column TA_OA_OSAPP_OBJECT.type
  is '物品类别';
