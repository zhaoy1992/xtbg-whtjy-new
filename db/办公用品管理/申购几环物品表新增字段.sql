-- Add/modify columns 
alter table TA_OA_OSAPP_OBJECT add rk_id varchar2(50);
alter table TA_OA_OSAPP_OBJECT add rk_name varchar2(100);
alter table TA_OA_OSAPP_OBJECT add rk_date date;
-- Add comments to the columns 
comment on column TA_OA_OSAPP_OBJECT.rk_id
  is '入库人id';
comment on column TA_OA_OSAPP_OBJECT.rk_name
  is '入库人名';
comment on column TA_OA_OSAPP_OBJECT.rk_date
  is '入库时间';
