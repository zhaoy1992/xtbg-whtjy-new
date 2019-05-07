-- Create table
create table TA_OA_PERSONHOLDER
(
  HOLD_ID         VARCHAR2(40) not null,
  HOLD_NAME       VARCHAR2(100),
  HOLD_ORG        VARCHAR2(100),
  HOLD_NUMBER     VARCHAR2(50),
  HOLD_RATIFYTIME DATE,
  HOLD_VALIDTIME  DATE,
  HOLD_REPLACTIME DATE,
  HOLD_LEVEL      VARCHAR2(20),
  HOLD_STATE      VARCHAR2(20),
  REGISTER_FLAG   VARCHAR2(20),
  CREATOR_TIME    DATE,
  HOLD_USESNID    VARCHAR2(50)
);
-- Add comments to the columns 
comment on column TA_OA_PERSONHOLDER.HOLD_ID
  is '持证ID';
comment on column TA_OA_PERSONHOLDER.HOLD_NAME
  is '持证项目';
comment on column TA_OA_PERSONHOLDER.HOLD_ORG
  is '审批机构';
comment on column TA_OA_PERSONHOLDER.HOLD_NUMBER
  is '证书编号';
comment on column TA_OA_PERSONHOLDER.HOLD_RATIFYTIME
  is '批准日期';
comment on column TA_OA_PERSONHOLDER.HOLD_VALIDTIME
  is '有效日期';
comment on column TA_OA_PERSONHOLDER.HOLD_REPLACTIME
  is '换证日期';
comment on column TA_OA_PERSONHOLDER.HOLD_LEVEL
  is '持证级别';
comment on column TA_OA_PERSONHOLDER.HOLD_STATE
  is '持证状态';
comment on column TA_OA_PERSONHOLDER.REGISTER_FLAG
  is '是否注册';
comment on column TA_OA_PERSONHOLDER.CREATOR_TIME
  is '创建日期';
comment on column TA_OA_PERSONHOLDER.HOLD_USESNID
  is '人员信息关联表ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_PERSONHOLDER
  add constraint PK_TA_OA_PERSONHOLDER_ID primary key (HOLD_ID);
