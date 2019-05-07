drop table ta_oa_whtjy_gdzc cascade constraints;

/*==============================================================*/
/* Table: ta_oa_whtjy_gdzc                                    */
/*==============================================================*/
create table ta_oa_whtjy_gdzc  (
   id                 varchar2(50)                    not null,
   internal_no        varchar2(50),
   num                varchar2(50),
   name               varchar2(200),
   type_id            varchar2(50),
   type_name          varchar2(200),
   address            varchar2(200),
   area               varchar2(50),
   ownership_no       varchar2(200),
   fazheng_date       DATE,
   it                 varchar2(200),
   manufacturer       varchar2(2000),
   body_no            varchar2(200),
   bar_code           varchar2(200),
   finance_no         varchar2(200),
   original_value     varchar2(200),
   buy_time           DATE,
   user_id            varchar2(50),
   user_name          varchar2(200),
   org_id             varchar2(50),
   org_name           varchar2(200),
   use_date           DATE,
   location_place     varchar2(200),
   this_calibration_time DATE,
   next_calibration_time DATE,
   is_allocation      varchar2(1)                    default 0,
   is_lease           varchar2(1)                    default 0,
   allocation_place   varchar2(200),
   lease_place        varchar2(200),
   allocation_date    DATE,
   lease_date         DATE,
   state              varchar2(50),
   dealt              varchar2(50),
   dealt_date         DATE,
   location_id        varchar2(50),
   location_name      varchar2(200),
   location_org_id    varchar2(50),
   location_org       varchar2(200),
   classify           varchar2(1),
   constraint PK_TA_OA_WHTJY_GDZC primary key (id)
);

comment on table ta_oa_whtjy_gdzc is
'固定资产表';

comment on column ta_oa_whtjy_gdzc.id is
'主键id';

comment on column ta_oa_whtjy_gdzc.internal_no is
'内部编号';

comment on column ta_oa_whtjy_gdzc.num is
'编号';

comment on column ta_oa_whtjy_gdzc.name is
'名称';

comment on column ta_oa_whtjy_gdzc.type_id is
'类别id';

comment on column ta_oa_whtjy_gdzc.type_name is
'类别名';

comment on column ta_oa_whtjy_gdzc.address is
'地址';

comment on column ta_oa_whtjy_gdzc.area is
'面积';

comment on column ta_oa_whtjy_gdzc.ownership_no is
'权属证号';

comment on column ta_oa_whtjy_gdzc.fazheng_date is
'发证时间';

comment on column ta_oa_whtjy_gdzc.it is
'型号规格';

comment on column ta_oa_whtjy_gdzc.manufacturer is
'生产厂家';

comment on column ta_oa_whtjy_gdzc.body_no is
'机身号';

comment on column ta_oa_whtjy_gdzc.bar_code is
'条形码';

comment on column ta_oa_whtjy_gdzc.finance_no is
'财政编号';

comment on column ta_oa_whtjy_gdzc.original_value is
'原值';

comment on column ta_oa_whtjy_gdzc.buy_time is
'购置时间';

comment on column ta_oa_whtjy_gdzc.user_id is
'领用人id';

comment on column ta_oa_whtjy_gdzc.user_name is
'领用人名';

comment on column ta_oa_whtjy_gdzc.org_id is
'领用部门id';

comment on column ta_oa_whtjy_gdzc.org_name is
'领用部门';

comment on column ta_oa_whtjy_gdzc.use_date is
'领用时间';

comment on column ta_oa_whtjy_gdzc.location_place is
'放置地点';

comment on column ta_oa_whtjy_gdzc.this_calibration_time is
'本次校准日期';

comment on column ta_oa_whtjy_gdzc.next_calibration_time is
'下次校准日期';

comment on column ta_oa_whtjy_gdzc.is_allocation is
'是否调拨 0否1是';

comment on column ta_oa_whtjy_gdzc.is_lease is
'是否出租 0否1是';

comment on column ta_oa_whtjy_gdzc.allocation_place is
'调拨地点';

comment on column ta_oa_whtjy_gdzc.lease_place is
'出租地点';

comment on column ta_oa_whtjy_gdzc.allocation_date is
'调拨日期';

comment on column ta_oa_whtjy_gdzc.lease_date is
'出租日期';

comment on column ta_oa_whtjy_gdzc.state is
'状态';

comment on column ta_oa_whtjy_gdzc.dealt is
'处置方式';

comment on column ta_oa_whtjy_gdzc.dealt_date is
'处置日期';

comment on column ta_oa_whtjy_gdzc.location_id is
'所在地id';

comment on column ta_oa_whtjy_gdzc.location_name is
'所在地名';

comment on column ta_oa_whtjy_gdzc.location_org_id is
'所在部门id';

comment on column ta_oa_whtjy_gdzc.location_org is
'所在部门';

comment on column ta_oa_whtjy_gdzc.classify is
'分类1.办公设备、2.仪器设备、3.土地房屋、4.电器、5.公用物资、6.家具、7.车辆';



---------------------------------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_WHTJY_GDZC add state_id varchar2(50);
-- Add comments to the columns 
comment on column TA_OA_WHTJY_GDZC.state_id
  is '状态id';
----------------------------------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_WHTJY_GDZC add color varchar2(50);
alter table TA_OA_WHTJY_GDZC add vin_number varchar2(200);
alter table TA_OA_WHTJY_GDZC add engine_number varchar2(200);
alter table TA_OA_WHTJY_GDZC add car_number varchar2(50);
alter table TA_OA_WHTJY_GDZC add displacement varchar2(50);
-- Add comments to the columns 
comment on column TA_OA_WHTJY_GDZC.color
  is '颜色';
comment on column TA_OA_WHTJY_GDZC.vin_number
  is '车架号';
comment on column TA_OA_WHTJY_GDZC.engine_number
  is '发动机号';
comment on column TA_OA_WHTJY_GDZC.car_number
  is '车牌号';
comment on column TA_OA_WHTJY_GDZC.displacement
  is '排量';
  
----------------------------------------------------------------------------------------------
drop table ta_oa_whtjy_gdzc_history cascade constraints;

/*==============================================================*/
/* Table: ta_oa_whtjy_gdzc_history                            */
/*==============================================================*/
create table ta_oa_whtjy_gdzc_history  (
   id                 varchar2(50)                    not null,
   gdzc_id            varchar2(50),
   gdzc_name          varchar2(200),
   user_id            varchar2(50),
   user_name          varchar2(200),
   org_id             varchar2(50),
   org_name           varchar2(200),
   use_type           varchar2(200),
   user_date          DATE,
   constraint PK_TA_OA_WHTJY_GDZC_HISTORY primary key (id)
);

comment on table ta_oa_whtjy_gdzc_history is
'固定资产历史使用记录';

comment on column ta_oa_whtjy_gdzc_history.id is
'主键id';

comment on column ta_oa_whtjy_gdzc_history.gdzc_id is
'固定资产id';

comment on column ta_oa_whtjy_gdzc_history.gdzc_name is
'固定资产物品名';

comment on column ta_oa_whtjy_gdzc_history.user_id is
'使用人id';

comment on column ta_oa_whtjy_gdzc_history.user_name is
'使用人名';

comment on column ta_oa_whtjy_gdzc_history.org_id is
'使用部门id';

comment on column ta_oa_whtjy_gdzc_history.org_name is
'使用部门名';

comment on column ta_oa_whtjy_gdzc_history.use_type is
'使用类型(借用/领用/归还等)';

comment on column ta_oa_whtjy_gdzc_history.user_date is
'使用时间';
----------------------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_WHTJY_GDZC_HISTORY add ghdj_id varchar2(50);
-- Add comments to the columns 
comment on column TA_OA_WHTJY_GDZC_HISTORY.ghdj_id
  is '归还登记表id';
-------------------------------------------------------------------------------------
drop table ta_oa_whtjy_gdzc_manager cascade constraints;

/*==============================================================*/
/* Table: ta_oa_whtjy_gdzc_manager                            */
/*==============================================================*/
create table ta_oa_whtjy_gdzc_manager  (
   m_id               varchar2(50)                    not null,
   m_type             varchar2(200),
   use_date           DATE,
   user_id            varchar2(50),
   user_name          varchar2(200),
   org_id             varchar2(50),
   org_name           varchar2(200),
   register_user_id   varchar2(50),
   register_user_name varchar2(200),
   register_date      DATE,
   constraint PK_TA_OA_WHTJY_GDZC_MANAGER primary key (m_id)
);

comment on table ta_oa_whtjy_gdzc_manager is
'固定资产使用管理表';

comment on column ta_oa_whtjy_gdzc_manager.m_id is
'主键id';

comment on column ta_oa_whtjy_gdzc_manager.m_type is
'管理类型(借用/借用归还等)';

comment on column ta_oa_whtjy_gdzc_manager.use_date is
'使用时间';

comment on column ta_oa_whtjy_gdzc_manager.user_id is
'使用人id';

comment on column ta_oa_whtjy_gdzc_manager.user_name is
'使用人名';

comment on column ta_oa_whtjy_gdzc_manager.org_id is
'使用部门id';

comment on column ta_oa_whtjy_gdzc_manager.org_name is
'使用部门';

comment on column ta_oa_whtjy_gdzc_manager.register_user_id is
'登记人id';

comment on column ta_oa_whtjy_gdzc_manager.register_user_name is
'登记人名';

comment on column ta_oa_whtjy_gdzc_manager.register_date is
'登记时间';
------------------------------------------------------------------------------------
drop table ta_oa_whtjy_gdzc_details cascade constraints;

/*==============================================================*/
/* Table: ta_oa_whtjy_gdzc_details                              */
/*==============================================================*/
create table ta_oa_whtjy_gdzc_details  (
   id                 varchar2(50)                    not null,
   m_id               varchar2(50),
   internal_no        varchar2(200),
   gdzc_num           varchar2(200),
   gdzc_id            varchar2(50),
   gdzc_name          varchar2(200),
   bar_code           varchar2(200),
   body_no            varchar2(200),
   state              varchar2(200),
   constraint PK_TA_OA_WHTJY_GDZC_DETAILS primary key (id)
);

comment on table ta_oa_whtjy_gdzc_details is
'固定资产管理清单表
';

comment on column ta_oa_whtjy_gdzc_details.id is
'主键id';

comment on column ta_oa_whtjy_gdzc_details.m_id is
'管理表id';

comment on column ta_oa_whtjy_gdzc_details.internal_no is
'内部编号';

comment on column ta_oa_whtjy_gdzc_details.gdzc_num is
'编号';

comment on column ta_oa_whtjy_gdzc_details.gdzc_id is
'固定资产id';

comment on column ta_oa_whtjy_gdzc_details.gdzc_name is
'固定资产名';

comment on column ta_oa_whtjy_gdzc_details.bar_code is
'条形码';

comment on column ta_oa_whtjy_gdzc_details.body_no is
'机身号';

comment on column ta_oa_whtjy_gdzc_details.state is
'状态';
--------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_WHTJY_GDZC_MANAGER add gdzc_classify varchar2(50);
-- Add comments to the columns 
comment on column TA_OA_WHTJY_GDZC_MANAGER.gdzc_classify
  is '资产类别';
  
------------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_DEVISSUEDPLAN add plan_internal_no varchar2(50);
alter table TA_OA_DEVISSUEDPLAN add plan_title varchar2(200);
-- Add comments to the columns 
comment on column TA_OA_DEVISSUEDPLAN.plan_internal_no
  is '内部编号';
comment on column TA_OA_DEVISSUEDPLAN.plan_title
  is '计划标题';
---------------------------------------------------------------------------
-- Create table
create table ta_oa_devissuedplan_detail
(
  id        varchar2(50) not null,
  plan_id   varchar2(50),
  sb_id     varchar2(50),
  last_date date
)
;
-- Add comments to the table 
comment on table ta_oa_devissuedplan_detail
  is '核验设备清单表';
-- Add comments to the columns 
comment on column ta_oa_devissuedplan_detail.id
  is '主键id';
comment on column ta_oa_devissuedplan_detail.plan_id
  is '核验表id';
comment on column ta_oa_devissuedplan_detail.sb_id
  is '设备id';
comment on column ta_oa_devissuedplan_detail.last_date
  is '上次检定日期';
--------------------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_DEVAPPRAISAL add appr_method_id varchar2(50);
alter table TA_OA_DEVAPPRAISAL add appr_method varchar2(200);
alter table TA_OA_DEVAPPRAISAL add appr_result varchar2(50);
alter table TA_OA_DEVAPPRAISAL add next_appr_time date;
-- Add comments to the columns 
comment on column TA_OA_DEVAPPRAISAL.appr_method_id
  is '检定方式id';
comment on column TA_OA_DEVAPPRAISAL.appr_method
  is '检定方式';
comment on column TA_OA_DEVAPPRAISAL.appr_result
  is '检定结果';
comment on column TA_OA_DEVAPPRAISAL.next_appr_time
  is '下次检定日期';
----------------------------------------------------------------------------------
--清空表
delete from TA_OA_DEVSCRAP;

delete from ta_oa_devissuedplan;

delete from ta_oa_devappraisal;

delete from ta_oa_devtakcare;


