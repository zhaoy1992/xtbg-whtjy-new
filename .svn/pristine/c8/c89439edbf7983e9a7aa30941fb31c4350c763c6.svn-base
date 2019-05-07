-- Create table
create table TA_OA_DEVCALIBRATERECODE
(
  CALIB_ID       VARCHAR2(40) not null,
  T_SB_ID        VARCHAR2(50),
  CALIB_NO       VARCHAR2(200),
  CALIB_ORG_ID   VARCHAR2(100),
  CALIB_ORG_NAME VARCHAR2(100),
  CALIB_TIME     DATE,
  CALIB_VALITIME DATE,
  CALIB_PARRANGE VARCHAR2(1000),
  CALIB_TYPE     VARCHAR2(20)
);
-- Add comments to the table 
comment on table TA_OA_DEVCALIBRATERECODE
  is '设备校准记录表';
-- Add comments to the columns 
comment on column TA_OA_DEVCALIBRATERECODE.CALIB_ID
  is '主键ID';
comment on column TA_OA_DEVCALIBRATERECODE.T_SB_ID
  is '设备ID';
comment on column TA_OA_DEVCALIBRATERECODE.CALIB_NO
  is '校准证书编号';
comment on column TA_OA_DEVCALIBRATERECODE.CALIB_ORG_ID
  is '校准单位ID';
comment on column TA_OA_DEVCALIBRATERECODE.CALIB_ORG_NAME
  is '校准单位名称';
comment on column TA_OA_DEVCALIBRATERECODE.CALIB_TIME
  is '校准日期';
comment on column TA_OA_DEVCALIBRATERECODE.CALIB_VALITIME
  is '有效期';
comment on column TA_OA_DEVCALIBRATERECODE.CALIB_PARRANGE
  is '参数范围';
comment on column TA_OA_DEVCALIBRATERECODE.CALIB_TYPE
  is '校准类型';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_DEVCALIBRATERECODE
  add constraint PK_TA_OA_DEVCALIBRATERECODE_ID primary key (CALIB_ID);
  
 -- Create table
create table TA_OA_DEVCOMPARERECODE
(
  COMP_ID      VARCHAR2(40) not null,
  T_SB_ID      VARCHAR2(40),
  COMP_SB_ID   VARCHAR2(40),
  COMP_RESULT  VARCHAR2(4000),
  REMARK       VARCHAR2(4000),
  CREATOR_TIME DATE
);
-- Add comments to the table 
comment on table TA_OA_DEVCOMPARERECODE
  is '仪器设备对比记录';
-- Add comments to the columns 
comment on column TA_OA_DEVCOMPARERECODE.COMP_ID
  is '主键ID';
comment on column TA_OA_DEVCOMPARERECODE.T_SB_ID
  is '设备ID';
comment on column TA_OA_DEVCOMPARERECODE.COMP_SB_ID
  is '对比设备ID';
comment on column TA_OA_DEVCOMPARERECODE.COMP_RESULT
  is '比对结果';
comment on column TA_OA_DEVCOMPARERECODE.REMARK
  is '备注';
comment on column TA_OA_DEVCOMPARERECODE.CREATOR_TIME
  is '创建时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_DEVCOMPARERECODE
  add constraint PK_TA_OA_DEVCOMPARERECODE_ID primary key (COMP_ID);

 -- Create table
create table TA_OA_DEVSUBJECTRECORD
(
  SUB_ID     VARCHAR2(40) not null,
  T_SB_ID    VARCHAR2(50),
  SUB_NAME   VARCHAR2(300),
  SUB_RESULT VARCHAR2(1000),
  REMARK     VARCHAR2(1000)
);
-- Add comments to the table 
comment on table TA_OA_DEVSUBJECTRECORD
  is '仪器设备标对记录表';
-- Add comments to the columns 
comment on column TA_OA_DEVSUBJECTRECORD.SUB_ID
  is '主键ID';
comment on column TA_OA_DEVSUBJECTRECORD.T_SB_ID
  is '设备ID';
comment on column TA_OA_DEVSUBJECTRECORD.SUB_NAME
  is '标样名称';
comment on column TA_OA_DEVSUBJECTRECORD.SUB_RESULT
  is '标对结果';
comment on column TA_OA_DEVSUBJECTRECORD.REMARK
  is '备注';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_DEVSUBJECTRECORD
  add constraint PK_TA_OA_DEVSUBJECTRECORD_ID primary key (SUB_ID);

-- Create table
create table TA_OA_DEVISSUEDPLAN
(
  PLAN_ID          VARCHAR2(40) not null,
  T_SB_ID          VARCHAR2(50),
  CHECKUSER_ID     VARCHAR2(40),
  CHECKUSER_NAME   VARCHAR2(100),
  CHECKTYPE        VARCHAR2(40),
  COMPLTIME        DATE,
  COMPLFLAG        VARCHAR2(50),
  REMARK           VARCHAR2(1000),
  CREATER_USERID   VARCHAR2(50),
  CREATER_USERNAME VARCHAR2(100),
  UNIT_ID          VARCHAR2(50),
  UNIT_NAME        VARCHAR2(100)
);
-- Add comments to the table 
comment on table TA_OA_DEVISSUEDPLAN
  is '仪器设备下达核检计划';
-- Add comments to the columns 
comment on column TA_OA_DEVISSUEDPLAN.PLAN_ID
  is '主键ID';
comment on column TA_OA_DEVISSUEDPLAN.T_SB_ID
  is '设备ID';
comment on column TA_OA_DEVISSUEDPLAN.CHECKUSER_ID
  is '核检负责人ID';
comment on column TA_OA_DEVISSUEDPLAN.CHECKUSER_NAME
  is '核检负责人名称';
comment on column TA_OA_DEVISSUEDPLAN.CHECKTYPE
  is '检验类型';
comment on column TA_OA_DEVISSUEDPLAN.COMPLTIME
  is '计划完成时间';
comment on column TA_OA_DEVISSUEDPLAN.COMPLFLAG
  is '完成状态';
comment on column TA_OA_DEVISSUEDPLAN.REMARK
  is '备注';
comment on column TA_OA_DEVISSUEDPLAN.CREATER_USERID
  is '创建人ID';
comment on column TA_OA_DEVISSUEDPLAN.CREATER_USERNAME
  is '创建人名称';
comment on column TA_OA_DEVISSUEDPLAN.UNIT_ID
  is '创建人单位ID';
comment on column TA_OA_DEVISSUEDPLAN.UNIT_NAME
  is '创建人单位名称ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_DEVISSUEDPLAN
  add constraint PK_TA_OA_DEVISSUEDPLAN_ID primary key (PLAN_ID);
  
  
  
