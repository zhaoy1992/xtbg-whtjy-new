-- Add/modify columns 
alter table TA_OA_DEVEQUIPMENTACC add t_sl varchar2(20);
-- Add comments to the columns 
comment on column TA_OA_DEVEQUIPMENTACC.t_sl
  is '数量';


-- Create table
create table TA_OA_DEVSETTLEITEM
(
  T_ID          VARCHAR2(40) not null,
  DEVSETTLE_ID  VARCHAR2(50),
  ITEM_NAME     VARCHAR2(200),
  ITEM_TYPE     VARCHAR2(200),
  ITEM_COUNT    VARCHAR2(20),
  ITEM_PRICE    VARCHAR2(100),
  ITEM_NO       VARCHAR2(10),
  ITEM_REPORTID VARCHAR2(50)
);
-- Add comments to the table 
comment on table TA_OA_DEVSETTLEITEM
  is '采购验收结算货品单表';
-- Add comments to the columns 
comment on column TA_OA_DEVSETTLEITEM.T_ID
  is '主键ID';
comment on column TA_OA_DEVSETTLEITEM.DEVSETTLE_ID
  is '采购验收结算ID';
comment on column TA_OA_DEVSETTLEITEM.ITEM_NAME
  is '货品名称';
comment on column TA_OA_DEVSETTLEITEM.ITEM_TYPE
  is '型号规格';
comment on column TA_OA_DEVSETTLEITEM.ITEM_COUNT
  is '数量';
comment on column TA_OA_DEVSETTLEITEM.ITEM_PRICE
  is '单价';
comment on column TA_OA_DEVSETTLEITEM.ITEM_NO
  is '排序号';
comment on column TA_OA_DEVSETTLEITEM.ITEM_REPORTID
  is '验收单ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_DEVSETTLEITEM
  add constraint PK_TA_OA_DEVSETTLEITEM_ID primary key (T_ID);

  
--结算流程表单表，需要在流程配置中数据库中配置的流程表单
-- Create table
--create table TA_OA_DEVSETTLEMENT
--(
--  T_ID            VARCHAR2(50) not null,
--  T_FJ_ID         VARCHAR2(50),
--  T_ZW_ID         VARCHAR2(50),
--  T_TITLE         VARCHAR2(500),
--  T_APPORDER_NO   VARCHAR2(200),
--  T_APPDATE       DATE,
--  T_ORDER_NO      VARCHAR2(200),
--  T_SUPP_UNIT     VARCHAR2(200),
--  T_TECHNOLOGY_YJ VARCHAR2(2000),
--  T_FINANCE_YJ    VARCHAR2(2000),
--  T_SUPP_UNITID   VARCHAR2(100)
--);
---- Add comments to the table 
--comment on table TA_OA_DEVSETTLEMENT
--  is '政府采购验收结算表';
---- Add comments to the columns 
--comment on column TA_OA_DEVSETTLEMENT.T_ID
--  is '主键';
--comment on column TA_OA_DEVSETTLEMENT.T_FJ_ID
--  is '附件id';
--comment on column TA_OA_DEVSETTLEMENT.T_ZW_ID
--  is '正文id';
--comment on column TA_OA_DEVSETTLEMENT.T_TITLE
--  is '标题';
--comment on column TA_OA_DEVSETTLEMENT.T_APPORDER_NO
--  is '政府采购编号';
--comment on column TA_OA_DEVSETTLEMENT.T_APPDATE
--  is '申请日期';
--comment on column TA_OA_DEVSETTLEMENT.T_ORDER_NO
--  is '编号';
--comment on column TA_OA_DEVSETTLEMENT.T_SUPP_UNIT
--  is '供货单位';
--comment on column TA_OA_DEVSETTLEMENT.T_TECHNOLOGY_YJ
--  is '技术人员意见';
--comment on column TA_OA_DEVSETTLEMENT.T_FINANCE_YJ
--  is '财务意见';
--comment on column TA_OA_DEVSETTLEMENT.T_SUPP_UNITID
--  is '供货单位Id';
---- Create/Recreate primary, unique and foreign key constraints 
--alter table TA_OA_DEVSETTLEMENT
--  add constraint PK_TA_OA_DEVSETTLEMENT primary key (T_ID);

--加入仪器管理政府采购验收结算流程表单
insert into oa_flow_form (FORM_PATH, FORM_NAME, FORM_DESC, CREATOR_TIME)
values ('/ccapp/xtbg/tjy/device/jsp/devsettlement.jsp', '政府采购验收结算', '政府采购验收结算', to_date('15-03-2014 11:00:00', 'dd-mm-yyyy hh24:mi:ss'));


