-- Add/modify columns 
alter table TA_OA_OSAPPREG_OBJECT add is_rk varchar2(1) default 0;
alter table TA_OA_OSAPPREG_OBJECT add rk_user_id varchar2(40);
alter table TA_OA_OSAPPREG_OBJECT add rk_user_name varchar2(200);
alter table TA_OA_OSAPPREG_OBJECT add rk_date date;
-- Add comments to the columns 
comment on column TA_OA_OSAPPREG_OBJECT.is_rk
  is '是否入库，0未入库 1已入库';
comment on column TA_OA_OSAPPREG_OBJECT.rk_user_id
  is '入库人id';
comment on column TA_OA_OSAPPREG_OBJECT.rk_user_name
  is '入库人名';
comment on column TA_OA_OSAPPREG_OBJECT.rk_date
  is '入库时间';
