--------ƽ̨V3.0����ű���ʼ--------
-- Create table
create table TD_REPORT_FILE
(
  REP_ID   VARCHAR2(20) not null primary key,
  REP_BODY BLOB
);
-- Add comments to the table 
comment on table TD_REPORT_FILE
  is '�����ļ��洢��';
-- Add comments to the columns 
comment on column TD_REPORT_FILE.REP_ID
  is '������';
comment on column TD_REPORT_FILE.REP_BODY
  is '�����ļ�';
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
  is '�������ݱ�';
-- Add comments to the columns 
comment on column TB_REPORT.REP_ID
  is '������';
comment on column TB_REPORT.REP_NAME
  is '����������';
comment on column TB_REPORT.REP_ID2
  is '��������';
comment on column TB_REPORT.EC_ID
  is 'ҵ�������';
comment on column TB_REPORT.REP_VER
  is '����汾��';
comment on column TB_REPORT.REP_DESC
  is '��������';
comment on column TB_REPORT.CREATOR
  is '������';
comment on column TB_REPORT.CREATTIME
  is '����ʱ��';
comment on column TB_REPORT.PUBLISHSTATE
  is '����״̬';
comment on column TB_REPORT.PUBLISHTIME
  is '����ʱ��';
comment on column TB_REPORT.PUBLISHER
  is '������';
comment on column TB_REPORT.REP_STYPE
  is '0����ͨ���� 1����������';
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
  is '����Զ����������ĵ����ĵ�������¼��';
-- Add comments to the columns 
comment on column TD_REPORT_LOCK.LOCK_ID
  is '��ˮID';
comment on column TD_REPORT_LOCK.REP_ID
  is '����ID';
comment on column TD_REPORT_LOCK.OPEN_TIME
  is '��ʱ��';
comment on column TD_REPORT_LOCK.OPEN_USER
  is '����';
comment on column TD_REPORT_LOCK.REP_TYPE
  is '��������';
comment on column TD_REPORT_LOCK.STATUES
  is '״̬ Y ��ʾ���� N��ʾδ����';
comment on column TD_REPORT_LOCK.REP_REF_FILE
  is '�����ӱ���';
comment on column TD_REPORT_LOCK.TIME_OUT_TIME
  is '������ʱʱ��';
comment on column TD_REPORT_LOCK.OPEN_USER_IP
  is '�������IP';
comment on column TD_REPORT_LOCK.REP_NAME
  is '��������';
  
--�½�Զ������Դ��Ϣ�洢��
create table TB_REPORT_BEAN
(
  BEAN_REPORT_ID VARCHAR2(32) not null,
  CLASS_NAME     VARCHAR2(100),
  METHOD_NAME    VARCHAR2(100),
  ADD_TIME       DATE
);
-- Add comments to the table 
comment on table TB_REPORT_BEAN
  is '�����javabean����Դ�ṩ�Ĵ洢��Ӧ����Ĺ�����ͷ����ļ�¼��';
-- Add comments to the columns 
comment on column TB_REPORT_BEAN.BEAN_REPORT_ID
  is '����ID ��ӦTB_REPORT�еı���ID';
comment on column TB_REPORT_BEAN.CLASS_NAME
  is '�ñ���ʹ�õĹ�����';
comment on column TB_REPORT_BEAN.METHOD_NAME
  is '�������Ӧ�ķ���';
comment on column TB_REPORT_BEAN.ADD_TIME
  is '���ʱ��';


-- ����Դ��
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
  is '����Դ��ID������';
comment on column TD_REPORT_SUBRESOURCE.RESOURCE_TYPE
  is '����Դ���ͣ��ӱ������ͼƬ';
comment on column TD_REPORT_SUBRESOURCE.RESOURCE_COLB
  is '����Դ���ݣ��Ƕ�����';
comment on column TD_REPORT_SUBRESOURCE.RESOURCE_BOLB
  is '����Դ���ݣ������ƣ���ͼƬ��';
comment on column TD_REPORT_SUBRESOURCE.RESOURCE_SUFFIX
  is '����Դ�ļ���׺��';

commit;
--------ƽ̨V3.0����ű�����--------