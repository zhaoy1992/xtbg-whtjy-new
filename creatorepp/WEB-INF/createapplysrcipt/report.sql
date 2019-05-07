--------平台V3.0报表脚本开始--------
-- Create table
create table TD_REPORT_FILE
(
  REP_ID   VARCHAR2(20) not null primary key,
  REP_BODY BLOB
);
-- Add comments to the table 
comment on table TD_REPORT_FILE
  is '报表文件存储表';
-- Add comments to the columns 
comment on column TD_REPORT_FILE.REP_ID
  is '报表编号';
comment on column TD_REPORT_FILE.REP_BODY
  is '报表文件';
-- Create/Recreate primary, unique and foreign key constraints 
create table TB_REPORT
(
  REP_ID       VARCHAR2(20) not null primary key,
  REP_NAME     VARCHAR2(128),
  REP_ID2      VARCHAR2(20) not null,
  EC_ID        VARCHAR2(20),
  REP_VER      VARCHAR2(32),
  REP_DESC     VARCHAR2(1023),
  CREATOR      VARCHAR2(32) not null,
  CREATTIME    DATE not null,
  PUBLISHSTATE NUMBER(1) default 0 not null,
  PUBLISHTIME  DATE,
  PUBLISHER    VARCHAR2(32),
  REP_STYPE    NUMBER(1) default 0 not null
);
-- Add comments to the table 
comment on table TB_REPORT
  is '报表数据表';
-- Add comments to the columns 
comment on column TB_REPORT.REP_ID
  is '报表编号';
comment on column TB_REPORT.REP_NAME
  is '主报表名称';
comment on column TB_REPORT.REP_ID2
  is '副报表编号';
comment on column TB_REPORT.EC_ID
  is '业务类别编号';
comment on column TB_REPORT.REP_VER
  is '报表版本号';
comment on column TB_REPORT.REP_DESC
  is '报表描述';
comment on column TB_REPORT.CREATOR
  is '创建人';
comment on column TB_REPORT.CREATTIME
  is '创建时间';
comment on column TB_REPORT.PUBLISHSTATE
  is '发布状态';
comment on column TB_REPORT.PUBLISHTIME
  is '发布时间';
comment on column TB_REPORT.PUBLISHER
  is '发布人';
comment on column TB_REPORT.REP_STYPE
  is '0、普通报表 1、参数报表';
-- Create/Recreate primary, unique and foreign key constraints 
--alter table TB_REPORT
--  add constraint FK_CLASS_REPORT foreign key (EC_ID)
--  references TB_FORM_CLASS (EC_ID);
--alter table TB_REPORT
--  add constraint FK_REP_ID2_FILE foreign key (REP_ID2)
--  references TD_REPORT_FILE (REP_ID);
--alter table TB_REPORT
--  add constraint FK_REP_ID_FILE foreign key (REP_ID)
--  references TD_REPORT_FILE (REP_ID);
  
create table TD_REPORT_LOCK(
LOCK_ID VARCHAR2(30) PRIMARY KEY,
REP_ID VARCHAR2(30),
OPEN_TIME DATE,
OPEN_USER VARCHAR2(30),
REP_TYPE VARCHAR2(2),
STATUES VARCHAR2(2),
REP_REF_FILE VARCHAR2(100),
TIME_OUT_TIME DATE,
OPEN_USER_IP VARCHAR2(30),
REP_NAME VARCHAR2(50)
);
-- Add comments to the table 
comment on table TD_REPORT_LOCK
  is '报表远程设计器打开文档的文档锁定记录表';
-- Add comments to the columns 
comment on column TD_REPORT_LOCK.LOCK_ID
  is '流水ID';
comment on column TD_REPORT_LOCK.REP_ID
  is '报表ID';
comment on column TD_REPORT_LOCK.OPEN_TIME
  is '打开时间';
comment on column TD_REPORT_LOCK.OPEN_USER
  is '打开人';
comment on column TD_REPORT_LOCK.REP_TYPE
  is '报表类型';
comment on column TD_REPORT_LOCK.STATUES
  is '状态 Y 表示锁定 N表示未锁定';
comment on column TD_REPORT_LOCK.REP_REF_FILE
  is '引用子报表';
comment on column TD_REPORT_LOCK.TIME_OUT_TIME
  is '锁定超时时间';
comment on column TD_REPORT_LOCK.OPEN_USER_IP
  is '报表打开者IP';
comment on column TD_REPORT_LOCK.REP_NAME
  is '报表名称';
  
--新建远程数据源信息存储表
create table TB_REPORT_BEAN
(
  BEAN_REPORT_ID VARCHAR2(32) not null,
  CLASS_NAME     VARCHAR2(100),
  METHOD_NAME    VARCHAR2(100),
  ADD_TIME       DATE
);
-- Add comments to the table 
comment on table TB_REPORT_BEAN
  is '针对于javabean数据源提供的存储对应报表的工厂类和方法的记录表';
-- Add comments to the columns 
comment on column TB_REPORT_BEAN.BEAN_REPORT_ID
  is '报表ID 对应TB_REPORT中的报表ID';
comment on column TB_REPORT_BEAN.CLASS_NAME
  is '该报表使用的工厂类';
comment on column TB_REPORT_BEAN.METHOD_NAME
  is '工厂类对应的方法';
comment on column TB_REPORT_BEAN.ADD_TIME
  is '添加时间';


-- 子资源表
create table TD_REPORT_SUBRESOURCE
(
  RESOURCE_ID     VARCHAR2(32) not null,
  RESOURCE_TYPE   NUMBER(2),
  RESOURCE_COLB   CLOB,
  RESOURCE_BOLB   BLOB,
  RESOURCE_SUFFIX VARCHAR2(20),
  RESOURCE_NAME  VARCHAR2(100)
);
-- Add comments to the columns 
comment on column TD_REPORT_SUBRESOURCE.RESOURCE_ID
  is '子资源的ID，主键';
comment on column TD_REPORT_SUBRESOURCE.RESOURCE_TYPE
  is '子资源类型，子报表或者图片';
comment on column TD_REPORT_SUBRESOURCE.RESOURCE_COLB
  is '子资源内容，非二进制';
comment on column TD_REPORT_SUBRESOURCE.RESOURCE_BOLB
  is '子资源内容，二进制（如图片）';
comment on column TD_REPORT_SUBRESOURCE.RESOURCE_SUFFIX
  is '子资源文件后缀名';

commit;
--------平台V3.0报表脚本结束--------