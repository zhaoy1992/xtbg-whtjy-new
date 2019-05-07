-- Drop table
drop table OA_FLOW_ACTCOUNTERSIGNUSER cascade constraints;
-- Create table
create global temporary table OA_FLOW_ACTCOUNTERSIGNUSER
(
  ACTIONUSER_ID          VARCHAR2(50),
  INS_ID                 VARCHAR2(50),
  ACT_DEFID              VARCHAR2(100),
  ACTIVITY               VARCHAR2(100),
  ACTIVITYPROCESSID      VARCHAR2(100),
  ACTIVITYPROCESSDEFNAME VARCHAR2(100),
  USER_NAME              VARCHAR2(100),
  IS_HANDLE              VARCHAR2(2),
  COUNTERSIGN_TYPE       VARCHAR2(50),
  COUNTERSIGN_ORDER      NUMBER,
  IS_COUNTERSIGNPERSON   VARCHAR2(2)
)
on commit delete rows;
-- Add comments to the table 
comment on table OA_FLOW_ACTCOUNTERSIGNUSER
  is '环节会签表';
-- Add comments to the columns 
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.ACTIONUSER_ID
  is '任务ID';
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.INS_ID
  is '实例ID';
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.ACT_DEFID
  is '环节定义ID';
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.ACTIVITY
  is '环节实例ID';
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.ACTIVITYPROCESSID
  is '环节流程实例ID';
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.ACTIVITYPROCESSDEFNAME
  is '环节流程实例定义名称';
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.USER_NAME
  is '用户登陆名称';
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.IS_HANDLE
  is '是否已处理';
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.COUNTERSIGN_TYPE
  is '会签类型';
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.COUNTERSIGN_ORDER
  is '会签顺序';
comment on column OA_FLOW_ACTCOUNTERSIGNUSER.IS_COUNTERSIGNPERSON
  is '是否是会签当前处理人';
