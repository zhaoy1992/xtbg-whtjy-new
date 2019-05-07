--------ƽ̨V3.0ϵͳ����ƽ̨����ű���ʼ--------
--------ϵͳ����ű���ʼ--------
CREATE TABLE TABLEINFO
(
  TABLE_NAME          VARCHAR2(255)        NOT NULL,
  TABLE_ID_NAME       VARCHAR2(255),
  TABLE_ID_INCREMENT  NUMBER(5)                 DEFAULT 1,
  TABLE_ID_VALUE      NUMBER(20)                DEFAULT 0,
  TABLE_ID_GENERATOR  VARCHAR2(255),
  TABLE_ID_TYPE       VARCHAR2(255),
  TABLE_ID_PREFIX     VARCHAR2(255)
);

COMMENT ON TABLE TABLEINFO IS '����Ϣά������';
COMMENT ON COLUMN TABLEINFO.TABLE_NAME IS '������';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_NAME IS '�����������';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_INCREMENT IS '�������������ȱʡΪ1';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_VALUE IS '������ǰֵ��ȱʡΪ0';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_GENERATOR IS '�Զ�����������ɻ��Ʊ����com.frameworkset.common.poolman.sql.PrimaryKey����';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_TYPE IS '�������ͣ�string,int��';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_PREFIX IS '����Ϊstring������ǰ׺����ָ���ɲ�ָ��,ȱʡֵΪ""';

CREATE UNIQUE INDEX PK_TABLEINFO0 ON TABLEINFO(TABLE_NAME);

ALTER TABLE TABLEINFO ADD CONSTRAINT PK_TABLEINFO0 PRIMARY KEY (TABLE_NAME);

CREATE TABLE TD_SM_GROUP
(
  GROUP_ID    INTEGER                           NOT NULL,
  GROUP_NAME  VARCHAR2(100),
  GROUP_DESC  VARCHAR2(100),
  REMARK1     VARCHAR2(100),
  REMARK2     VARCHAR2(100),
  REMARK3     VARCHAR2(100),
  REMARK4     VARCHAR2(100),
  REMARK5     VARCHAR2(100),
  PARENT_ID   INTEGER,
  OWNER_ID              NUMBER                         default 1
);

CREATE UNIQUE INDEX PK_TD_SM_GROUP ON TD_SM_GROUP(GROUP_ID);

ALTER TABLE TD_SM_GROUP ADD   CONSTRAINT PK_TD_SM_GROUP PRIMARY KEY  (GROUP_ID);
---------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_ROLE
(
  ROLE_ID     VARCHAR2(50)    NOT NULL,
  ROLE_NAME   VARCHAR2(100)   NOT NULL,
  ROLE_TYPE   VARCHAR2(100),
  ROLE_DESC   VARCHAR2(200),
  ROLE_USAGE  VARCHAR2(1),
  REMARK1     VARCHAR2(100),
  REMARK2     VARCHAR2(100),
  REMARK3     VARCHAR2(100),
  OWNER_ID    NUMBER           default 1
);

ALTER TABLE TD_SM_ROLE ADD CONSTRAINT PK_TD_SM_ROLE PRIMARY KEY (ROLE_ID);
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_JOB
(
  JOB_ID         VARCHAR2(50 BYTE)              NOT NULL,
  JOB_NAME       VARCHAR2(100 BYTE),
  JOB_DESC       VARCHAR2(200 BYTE),
  JOB_FUNCTION   VARCHAR2(200 BYTE),
  JOB_AMOUNT     VARCHAR2(100 BYTE),
  JOB_NUMBER     VARCHAR2(100 BYTE),
  JOB_CONDITION  VARCHAR2(200 BYTE),
  JOB_RANK       VARCHAR2(100 BYTE)
);

COMMENT ON COLUMN TD_SM_JOB.JOB_ID IS '��λID';
COMMENT ON COLUMN TD_SM_JOB.JOB_NAME IS '��λ����';
COMMENT ON COLUMN TD_SM_JOB.JOB_DESC IS '��λ����';
COMMENT ON COLUMN TD_SM_JOB.JOB_FUNCTION IS '��λְ��';
COMMENT ON COLUMN TD_SM_JOB.JOB_AMOUNT IS '��λ��������';
COMMENT ON COLUMN TD_SM_JOB.JOB_NUMBER IS '��λ���';
COMMENT ON COLUMN TD_SM_JOB.JOB_CONDITION IS '��ְ����';
COMMENT ON COLUMN TD_SM_JOB.JOB_RANK IS '��λ����';

ALTER TABLE TD_SM_JOB ADD   CONSTRAINT PK_TD_SM_JOB  PRIMARY KEY  (JOB_ID);
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_LOG
(
  LOG_ID          INTEGER         NOT NULL,
  LOG_OPERUSER    VARCHAR2(100),
  LOG_OPER        VARCHAR2(200),
  LOG_VISITORIAL  VARCHAR2(200),
  LOG_OPERTIME    DATE,
  LOG_TYPE        clob,
  REMARK1         VARCHAR2(100),
  REMARK2         VARCHAR2(100),
  REMARK3         VARCHAR2(100)
);

CREATE UNIQUE INDEX PK_TD_SM_LOG ON TD_SM_LOG (LOG_ID);

ALTER TABLE TD_SM_LOG ADD   CONSTRAINT PK_TD_SM_LOG PRIMARY KEY (LOG_ID);
-----------------------------------------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: TD_SM_ORGANIZATION                                    */
/*==============================================================*/
create table TD_SM_ORGANIZATION  (
   ORG_ID               VARCHAR2(50)                     not null,
   ORG_SN               NUMBER                           not null,
   ORG_NAME             VARCHAR2(40)                     not null,
   PARENT_ID            VARCHAR2(100)                    not null,
   PATH                 VARCHAR2(1000),
   LAYER                VARCHAR2(200),
   CHILDREN             VARCHAR2(1000),
   CODE                 VARCHAR2(100),
   JP                   VARCHAR2(40),
   QP                   VARCHAR2(40),
   CREATINGTIME         DATE,
   CREATOR              VARCHAR2(100),
   ORGNUMBER            VARCHAR2(100),
   ORGDESC              VARCHAR2(300),
   REMARK1              VARCHAR2(100),
   REMARK2              VARCHAR2(100),
   REMARK3              VARCHAR2(100),
   REMARK4              VARCHAR2(100),
   REMARK5              VARCHAR2(100),
   CHARGEORGID          VARCHAR2(50),
   ISPARTYBUSSINESS NUMBER(1) default 1,
   SATRAPJOBID          VARCHAR2(50),
   ORG_LEVEL        VARCHAR2(1) default '1' ,
   ORG_xzqm        VARCHAR2(10),
   constraint PK_TD_SM_ORGANIZATION primary key (ORG_ID)
);
comment on column TD_SM_ORGANIZATION.ORG_ID is '����ID';
comment on column TD_SM_ORGANIZATION.ORG_SN is '��������ID';
comment on column TD_SM_ORGANIZATION.ORG_NAME is '��������';
comment on column TD_SM_ORGANIZATION.PARENT_ID is '������ID';
comment on column TD_SM_ORGANIZATION.PATH is '·��';
comment on column TD_SM_ORGANIZATION.LAYER is '�㣨�״Σ�';
comment on column TD_SM_ORGANIZATION.CHILDREN is '�ӻ���';
comment on column TD_SM_ORGANIZATION.CODE is '��������';
comment on column TD_SM_ORGANIZATION.JP is '��ƴ';
comment on column TD_SM_ORGANIZATION.QP is 'ȫƴ';
comment on column TD_SM_ORGANIZATION.CREATINGTIME is '����ʱ��';
comment on column TD_SM_ORGANIZATION.CREATOR is '������';
comment on column TD_SM_ORGANIZATION.ORGNUMBER is '�������';
comment on column TD_SM_ORGANIZATION.ORGDESC is '��������';
comment on column TD_SM_ORGANIZATION.REMARK1 is '�����ֶ�1';
comment on column TD_SM_ORGANIZATION.REMARK2 is '�����ֶ�2';
comment on column TD_SM_ORGANIZATION.REMARK3 is '��������';
comment on column TD_SM_ORGANIZATION.REMARK4 is '�����ֶ�4';
comment on column TD_SM_ORGANIZATION.REMARK5 is '������������';
comment on column TD_SM_ORGANIZATION.CHARGEORGID is '���ܻ���';
comment on column TD_SM_ORGANIZATION.ISPARTYBUSSINESS is '��ʾ�����Ƿ���ҵ���� 0-�� 1-���� Ĭ��Ϊ1';
comment on column TD_SM_ORGANIZATION.ORG_LEVEL is '������������1��ʡ����2�����ݼ���3����������4��������';
comment on column TD_SM_ORGANIZATION.SATRAPJOBID is '���ܸ�λ';
comment on column TD_SM_ORGANIZATION.Org_xzqm is '��������';
----------------------------------------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: TD_SM_USER                                            */
/*==============================================================*/
CREATE TABLE TD_SM_USER  (
   USER_ID              NUMBER                           NOT NULL,
   USER_SN              NUMBER                           NOT NULL,
   USER_NAME            VARCHAR2(200)                    NOT NULL,
   USER_PASSWORD        VARCHAR2(40)                     NOT NULL,
   USER_REALNAME        VARCHAR2(100)                    NOT NULL,
   USER_PINYIN          VARCHAR2(100),
   USER_SEX             VARCHAR2(100),
   USER_HOMETEL         VARCHAR2(100),
   USER_WORKTEL         VARCHAR2(100),
   USER_WORKNUMBER      VARCHAR2(100),
   USER_MOBILETEL1      VARCHAR2(100),
   USER_MOBILETEL2      VARCHAR2(100),
   USER_FAX             VARCHAR2(100),
   USER_OICQ            VARCHAR2(100),
   USER_BIRTHDAY        DATE,
   USER_EMAIL           VARCHAR2(100),
   USER_ADDRESS         VARCHAR2(200),
   USER_POSTALCODE      VARCHAR2(10),
   USER_IDCARD          VARCHAR2(50),
   USER_ISVALID         NUMBER,
   USER_REGDATE         DATE,
   USER_LOGINCOUNT      NUMBER,
   USER_TYPE            VARCHAR2(100),
   REMARK1              VARCHAR2(100),
   REMARK2              VARCHAR2(100),
   REMARK3              VARCHAR2(100),
   REMARK4              VARCHAR2(100),
   REMARK5              VARCHAR2(100),
   PAST_TIME            DATE,
   DREDGE_TIME          VARCHAR2(50),
   LASTLOGIN_DATE       DATE,
   WORKLENGTH           VARCHAR2(50),
   POLITICS             VARCHAR2(100),
   CONSTRAINT PK_TD_SM_USER PRIMARY KEY (USER_ID)
);
COMMENT ON COLUMN TD_SM_USER.USER_ID IS '�û�ID';
COMMENT ON COLUMN TD_SM_USER.USER_SN IS '�û������';
COMMENT ON COLUMN TD_SM_USER.USER_NAME IS '�û��ʺ�';
COMMENT ON COLUMN TD_SM_USER.USER_PASSWORD IS '�û�����';
COMMENT ON COLUMN TD_SM_USER.USER_REALNAME IS '�û�ʵ��';
COMMENT ON COLUMN TD_SM_USER.USER_PINYIN IS 'ƴ��';
COMMENT ON COLUMN TD_SM_USER.USER_SEX IS '�Ա�';
COMMENT ON COLUMN TD_SM_USER.USER_HOMETEL IS '��ͥ�绰';
COMMENT ON COLUMN TD_SM_USER.USER_WORKTEL IS '��˾�绰';
COMMENT ON COLUMN TD_SM_USER.USER_WORKNUMBER IS '��˾��ַ';
COMMENT ON COLUMN TD_SM_USER.USER_MOBILETEL1 IS '�ֻ�1';
COMMENT ON COLUMN TD_SM_USER.USER_MOBILETEL2 IS '�ֻ�2';
COMMENT ON COLUMN TD_SM_USER.USER_FAX IS '����';
COMMENT ON COLUMN TD_SM_USER.USER_OICQ IS 'OICQ';
COMMENT ON COLUMN TD_SM_USER.USER_BIRTHDAY IS '����';
COMMENT ON COLUMN TD_SM_USER.USER_EMAIL IS '����';
COMMENT ON COLUMN TD_SM_USER.USER_ADDRESS IS 'סַ';
COMMENT ON COLUMN TD_SM_USER.USER_POSTALCODE IS '�ʱ�';
COMMENT ON COLUMN TD_SM_USER.USER_IDCARD IS '���֤';
COMMENT ON COLUMN TD_SM_USER.USER_ISVALID IS '�Ƿ�ʹ��';
COMMENT ON COLUMN TD_SM_USER.USER_REGDATE IS 'ע������';
COMMENT ON COLUMN TD_SM_USER.USER_LOGINCOUNT IS '��½����';
COMMENT ON COLUMN TD_SM_USER.USER_TYPE IS '�û�����';
COMMENT ON COLUMN TD_SM_USER.REMARK1 IS '�����Ƿ��� ����,�������Ϣ��ʾ***���� ����ʾ��Ϣ';
COMMENT ON COLUMN TD_SM_USER.REMARK2 IS '�����ֶ�2';
COMMENT ON COLUMN TD_SM_USER.REMARK3 IS '�����ֶ�3';
COMMENT ON COLUMN TD_SM_USER.REMARK4 IS '�����ֶ�4';
COMMENT ON COLUMN TD_SM_USER.REMARK5 IS '�����ֶ�5';
COMMENT ON COLUMN TD_SM_USER.PAST_TIME IS '����ʱ��';
COMMENT ON COLUMN TD_SM_USER.DREDGE_TIME IS '��ͨʱ��';
COMMENT ON COLUMN TD_SM_USER.LASTLOGIN_DATE IS '�û�����½ʱ��';
/*==============================================================*/
/* Index: PK_TD_SM_USER_UNAME                                   */
/*==============================================================*/
CREATE UNIQUE INDEX PK_TD_SM_USER_UNAME ON TD_SM_USER (USER_NAME ASC);
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_RES
(
  RES_ID      VARCHAR2(50)                 NOT NULL,
  RESTYPE_ID  VARCHAR2(50),
  TITLE       VARCHAR2(500),
  ROLE_USAGE  VARCHAR2(1),
  PARENT_ID   VARCHAR2(50),
  PATH        VARCHAR2(1000),
  MARKER      VARCHAR2(200),
  RESERVED1   VARCHAR2(200),
  RESERVED3   VARCHAR2(200),
  RESERVED4   VARCHAR2(200),
  RESERVED5   VARCHAR2(200),
  ATTR1       VARCHAR2(200),
  ATTR2       VARCHAR2(200),
  ATTR3       VARCHAR2(200),
  ATTR4       VARCHAR2(200),
  ATTR5       VARCHAR2(200),
  ATTR6       VARCHAR2(200),
  ATTR7       VARCHAR2(200),
  ATTR8       VARCHAR2(200),
  ATTR9       VARCHAR2(200),
  ATTR10      VARCHAR2(200),
  ATTR11      VARCHAR2(200),
  ATTR12      VARCHAR2(200),
  ATTR13      VARCHAR2(200),
  ATTR14      VARCHAR2(200),
  ATTR15      VARCHAR2(200),
  ATTR16      VARCHAR2(200),
  ATTR17      VARCHAR2(200),
  ATTR18      VARCHAR2(200),
  ATTR19      VARCHAR2(200),
  ATTR20      VARCHAR2(200),
  ATTR21      VARCHAR2(200),
  ATTR22      VARCHAR2(200),
  ATTR23      VARCHAR2(200),
  ATTR24      VARCHAR2(200),
  ATTR25      VARCHAR2(200),
  ATTR26      VARCHAR2(200),
  ATTR27      VARCHAR2(1000)
);
CREATE INDEX RELATIONSHIP_1_FK ON TD_SM_RES(RESTYPE_ID);

CREATE UNIQUE INDEX PK_TD_SM_RES ON TD_SM_RES(RES_ID);

ALTER TABLE TD_SM_RES ADD   CONSTRAINT PK_TD_SM_RES PRIMARY KEY (RES_ID);
----------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_ORGJOB
(
  ORG_ID  VARCHAR2(50)                     NOT NULL,
  JOB_ID  VARCHAR2(50)                     NOT NULL,
  JOB_SN  INTEGER
);
CREATE UNIQUE INDEX PK_TD_SM_ORGJOB ON TD_SM_ORGJOB(ORG_ID, JOB_ID);

CREATE INDEX TD_SM_ORGJOB_FK ON TD_SM_ORGJOB(ORG_ID);
CREATE INDEX TD_SM_ORGJOB_FK2 ON TD_SM_ORGJOB(JOB_ID);

ALTER TABLE TD_SM_ORGJOB ADD CONSTRAINT PK_TD_SM_ORGJOB PRIMARY KEY (ORG_ID, JOB_ID);
ALTER TABLE TD_SM_ORGJOB ADD CONSTRAINT FK_TD_SM_OR_TD_SM_ORG_TD_SM_JO  FOREIGN KEY (JOB_ID) REFERENCES TD_SM_JOB (JOB_ID);
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_ORGROLE
(
  ORG_ID   VARCHAR2(50)                    NOT NULL,
  ROLE_ID  VARCHAR2(50)                    NOT NULL
);
CREATE UNIQUE INDEX PK_TD_SM_ORGROLE ON TD_SM_ORGROLE(ORG_ID, ROLE_ID);

CREATE INDEX TD_SM_ORGROLE_FK ON TD_SM_ORGROLE(ORG_ID);
CREATE INDEX TD_SM_ORGROLE_FK2 ON TD_SM_ORGROLE(ROLE_ID);

ALTER TABLE TD_SM_ORGROLE ADD   CONSTRAINT PK_TD_SM_ORGROLE PRIMARY KEY (ORG_ID, ROLE_ID);
ALTER TABLE TD_SM_ORGROLE ADD   CONSTRAINT FK_TD_SM_OR_TD_SM_ORO_TD_SM_RO  FOREIGN KEY (ROLE_ID)  REFERENCES TD_SM_ROLE (ROLE_ID);
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_GROUPROLE
(
  GROUP_ID  INTEGER                             NOT NULL,
  ROLE_ID   VARCHAR2(50)                   NOT NULL
);
CREATE UNIQUE INDEX PK_TD_SM_GROUPROLE ON TD_SM_GROUPROLE(GROUP_ID, ROLE_ID);

CREATE INDEX TD_SM_GROUPROLE_FK ON TD_SM_GROUPROLE(GROUP_ID);
CREATE INDEX TD_SM_GROUPROLE_FK2 ON TD_SM_GROUPROLE(ROLE_ID);

ALTER TABLE TD_SM_GROUPROLE ADD   CONSTRAINT PK_TD_SM_GROUPROLE PRIMARY KEY (GROUP_ID, ROLE_ID);
ALTER TABLE TD_SM_GROUPROLE ADD   CONSTRAINT FK_TD_SM_GR_TD_SM_GRO_TD_SM_RO  FOREIGN KEY (ROLE_ID)  REFERENCES TD_SM_ROLE (ROLE_ID);
-----------------------------------------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: TD_SM_ROLERESOP                                       */
/*==============================================================*/
create table TD_SM_ROLERESOP  (
   OP_ID                VARCHAR2(50)                     not null,
   RES_ID               VARCHAR2(100)                    not null,
   ROLE_ID              VARCHAR2(50)                     not null,
   RESTYPE_ID           VARCHAR2(50)                     not null,
   AUTO                 VARCHAR2(50),
   RES_NAME             VARCHAR2(500),
   TYPES                VARCHAR2(50)                     not null,
   constraint PK_TD_SM_ROLERESOP primary key (OP_ID, RES_ID, ROLE_ID, RESTYPE_ID, TYPES)
);
comment on column TD_SM_ROLERESOP.OP_ID is '����ID';
comment on column TD_SM_ROLERESOP.RES_ID is '��ԴID';
comment on column TD_SM_ROLERESOP.ROLE_ID is '��ɫID';
comment on column TD_SM_ROLERESOP.RESTYPE_ID is '��Դ����ID';
comment on column TD_SM_ROLERESOP.AUTO is '��ʶ��Դά����ʽ��0�Զ�ά����1�ֶ�ά��';
comment on column TD_SM_ROLERESOP.RES_NAME is '��Դ����';
comment on column TD_SM_ROLERESOP.TYPES is '��Դ���ࣨ�ǽ�ɫ��Դ�����û���Դ��';

--2008/02/25
--��Դ�� ��ɫID������Լ��, ��ֹroleid�ֶγ���nullֵ
alter table TD_SM_ROLERESOP add constraint ROLE_ID_NUMCHECK check (to_number(role_id)  > 0);
/*==============================================================*/
/* Index: TD_SM_ROLERESOP_FK                                    */
/*==============================================================*/
create index TD_SM_ROLERESOP_FK on TD_SM_ROLERESOP (OP_ID ASC);
/*==============================================================*/
/* Index: TD_SM_ROLERESOP_FK2                                   */
/*==============================================================*/
create index TD_SM_ROLERESOP_FK2 on TD_SM_ROLERESOP (RES_ID ASC);
/*==============================================================*/
/* Index: TD_SM_ROLERESOP_FK3                                   */
/*==============================================================*/
create index TD_SM_ROLERESOP_FK3 on TD_SM_ROLERESOP (ROLE_ID ASC);
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_USERGROUP
(
  GROUP_ID  INTEGER                             NOT NULL,
  USER_ID   INTEGER                             NOT NULL
);
CREATE UNIQUE INDEX PK_TD_SM_USERGROUP ON TD_SM_USERGROUP(GROUP_ID, USER_ID);

CREATE INDEX TD_SM_USERGROUP_FK ON TD_SM_USERGROUP(GROUP_ID);
CREATE INDEX TD_SM_USERGROUP_FK2 ON TD_SM_USERGROUP(USER_ID);

ALTER TABLE TD_SM_USERGROUP ADD  CONSTRAINT PK_TD_SM_USERGROUP PRIMARY KEY  (GROUP_ID, USER_ID);
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_USERJOBORG
(
  USER_ID           INTEGER                     NOT NULL,
  JOB_ID            VARCHAR2(50)           NOT NULL,
  ORG_ID            VARCHAR2(50)           NOT NULL,
  SAME_JOB_USER_SN  INTEGER,
  JOB_SN            INTEGER,
  JOB_STARTTIME     DATE,
  JOB_FETTLE        INTEGER
);
CREATE UNIQUE INDEX PK_TD_SM_USERJOBORG ON TD_SM_USERJOBORG(USER_ID, JOB_ID, ORG_ID);

CREATE INDEX TD_SM_USERJOBORG_FK ON TD_SM_USERJOBORG(USER_ID);
CREATE INDEX TD_SM_USERJOBORG_FK2 ON TD_SM_USERJOBORG(JOB_ID);
CREATE INDEX TD_SM_USERJOBORG_FK3 ON TD_SM_USERJOBORG(ORG_ID);

ALTER TABLE TD_SM_USERJOBORG ADD   CONSTRAINT PK_TD_SM_USERJOBORG PRIMARY KEY (USER_ID, JOB_ID, ORG_ID);
ALTER TABLE TD_SM_USERJOBORG ADD   CONSTRAINT FK_TD_SM_US_TD_SM_USE_TD_SM_JO  FOREIGN KEY (JOB_ID)  REFERENCES TD_SM_JOB (JOB_ID);
---------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_USERROLE
(
  USER_ID  INTEGER                              NOT NULL,
  ROLE_ID  VARCHAR2(50)                    NOT NULL
);
CREATE UNIQUE INDEX PK_TD_SM_USERROLE ON TD_SM_USERROLE(USER_ID, ROLE_ID);

CREATE INDEX TD_SM_USERROLE_FK ON TD_SM_USERROLE(USER_ID);
CREATE INDEX TD_SM_USERROLE_FK2 ON TD_SM_USERROLE(ROLE_ID);

ALTER TABLE TD_SM_USERROLE ADD   CONSTRAINT PK_TD_SM_USERROLE PRIMARY KEY (USER_ID, ROLE_ID);
ALTER TABLE TD_SM_USERROLE ADD  CONSTRAINT FK_TD_SM_US_TD_SM_USE_TD_SM_RO   FOREIGN KEY (ROLE_ID)  REFERENCES TD_SM_ROLE (ROLE_ID);
----------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_USERJOBORG_HISTORY
(
  USER_ID        INTEGER                        NOT NULL,
  JOB_ID         VARCHAR2(50)              NOT NULL,
  ORG_ID         VARCHAR2(50)              NOT NULL,
  JOB_STARTTIME  DATE,
  JOB_QUASHTIME  DATE,
  JOB_FETTLE     INTEGER
);
-------------------------------------------------------------------------------------------------------------------------------------
/*==============================================================*/
/* Table: TD_SM_ORGJOBROLE                                      */
/*==============================================================*/
create table TD_SM_ORGJOBROLE  (
   ORG_ID               VARCHAR2(50)                     not null,
   JOB_ID               VARCHAR2(50)                     not null,
   ROLE_ID              VARCHAR2(50)                     not null,
   constraint ORG_JOB_ROLE_RELATION primary key (ORG_ID, JOB_ID, ROLE_ID)
);
comment on table TD_SM_ORGJOBROLE is '���Ϊ������λ���õĽ�ɫ��Ϣ';
comment on column TD_SM_ORGJOBROLE.ORG_ID is '����id����������������';
comment on column TD_SM_ORGJOBROLE.JOB_ID is '��λid�����λ����������';
comment on column TD_SM_ORGJOBROLE.ROLE_ID is '��ɫid�����ɫ����������';

alter table TD_SM_ORGJOBROLE add constraint F_JOB_ROLE_ORG foreign key (JOB_ID) references TD_SM_JOB (JOB_ID) not deferrable;
alter table TD_SM_ORGJOBROLE add constraint F_ORG_JOB_ROLE foreign key (ORG_ID) references TD_SM_ORGANIZATION (ORG_ID) not deferrable;
alter table TD_SM_ORGJOBROLE add constraint F_ROLE_ORG_JOB foreign key (ROLE_ID) references TD_SM_ROLE (ROLE_ID) not deferrable;
----------------------------------------------------------
CREATE TABLE TD_SD_SCHEDULAR
(
  SCHEDULAR_ID    NUMBER                        NOT NULL,
  PLANNER_ID      NUMBER,
  EXECUTOR_ID     NUMBER,
  REQUEST_ID      NUMBER,
  TOPIC           VARCHAR2(255),
  PLACE           VARCHAR2(255),
  CONTENT         VARCHAR2(1000),
  BEGINTIME       DATE,
  ENDTIME         DATE,
  TYPE            VARCHAR2(255),
  ISPUBLICAFFAIR  NUMBER,
  ESSENTIALITY    VARCHAR2(255),
  ISHISTORY       NUMBER,
  ISLEISURE       NUMBER,
  STATUS          NUMBER,
  ISOPEN          NUMBER                        DEFAULT null,
  PARTNER         VARCHAR2(255)
);
COMMENT ON COLUMN TD_SD_SCHEDULAR.SCHEDULAR_ID IS '�ճ�id������';
COMMENT ON COLUMN TD_SD_SCHEDULAR.PLANNER_ID IS '�ճ̰�����id�����ճ�����typeΪ"����ԤԼ"ʱ��ʾԤԼ�����ˡ�';
COMMENT ON COLUMN TD_SD_SCHEDULAR.EXECUTOR_ID IS '�ճ�ִ����id�����ճ�����typeΪ"����ԤԼ"ʱ��ʾԤԼ�ˡ�';
COMMENT ON COLUMN TD_SD_SCHEDULAR.REQUEST_ID IS '����id��δʹ��';
COMMENT ON COLUMN TD_SD_SCHEDULAR.TOPIC IS '����';
COMMENT ON COLUMN TD_SD_SCHEDULAR.BEGINTIME IS '�ճ̿�ʼʱ��';
COMMENT ON COLUMN TD_SD_SCHEDULAR.TYPE IS '�ճ����ͣ����Լ����ţ����˰��ţ����鰲�ţ�����ԤԼ�ȡ�';
COMMENT ON COLUMN TD_SD_SCHEDULAR.ISPUBLICAFFAIR IS '1��ʾ����,0 ��ʾ˽��.';
COMMENT ON COLUMN TD_SD_SCHEDULAR.ESSENTIALITY IS 'ȷ����Ҫ�ԣ�����Ҫ(0)��һ��(1)������Ҫ(2)��';
COMMENT ON COLUMN TD_SD_SCHEDULAR.ISHISTORY IS '1��ʾ��ʷ�ճ�,0��ʾ����ʷ�ճ�';
COMMENT ON COLUMN TD_SD_SCHEDULAR.ISLEISURE IS '1��ʾæ,0��ʾ����';
COMMENT ON COLUMN TD_SD_SCHEDULAR.STATUS IS '0��ʾ��ִ��,1��ʾ������,2��ʾ����׼,3��ʾδ����׼,4��ʾ�ܾ�����,5��ʾ�����ճ�,6��ʾ��ʷ�ճ�.';
COMMENT ON COLUMN TD_SD_SCHEDULAR.ISOPEN IS '1��ʾ����,0��ʾ��������';
COMMENT ON COLUMN TD_SD_SCHEDULAR.PARTNER IS '���ճ�����Ϊ����ԤԼʱ����ʾ����ԤԼ�ճ̵�����ִ���ˡ�';

CREATE UNIQUE INDEX SCHEDULAR ON TD_SD_SCHEDULAR(SCHEDULAR_ID);

ALTER TABLE TD_SD_SCHEDULAR ADD   CONSTRAINT SCHEDULAR PRIMARY KEY (SCHEDULAR_ID);
ALTER TABLE TD_SD_SCHEDULAR ADD   CONSTRAINT EXECUTOR_ID  FOREIGN KEY (EXECUTOR_ID)  REFERENCES TD_SM_USER (USER_ID);
ALTER TABLE TD_SD_SCHEDULAR ADD   CONSTRAINT PLANNER_ID  FOREIGN KEY (PLANNER_ID)  REFERENCES TD_SM_USER (USER_ID);
----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SD_NOTIC
(
  CONTENT           VARCHAR2(1000),
  BEGINTIME         DATE,
  ENDTIME           DATE,
  PLACE             VARCHAR2(255),
  EXECUTOR_ID       NUMBER,
  NOTIC_ID          NUMBER                      NOT NULL,
  STATUS            NUMBER                      DEFAULT 0,
  TOPIC             VARCHAR2(255),
  SOURCE            VARCHAR2(255),
  NOTIC_PLANNER_ID  NUMBER
);
COMMENT ON COLUMN TD_SD_NOTIC.TOPIC IS '֪ͨ����';
COMMENT ON COLUMN TD_SD_NOTIC.SOURCE IS '֪ͨ��Դ����ʾ��֪ͨʱ���񣬻������������';
COMMENT ON COLUMN TD_SD_NOTIC.NOTIC_PLANNER_ID IS '֪ͨ������ID';
COMMENT ON COLUMN TD_SD_NOTIC.NOTIC_ID IS '֪ͨid������';
COMMENT ON COLUMN TD_SD_NOTIC.BEGINTIME IS '�����ͨ��ʾ������߻��飬���ʾ��������Ŀ�ʼʱ��';
COMMENT ON COLUMN TD_SD_NOTIC.ENDTIME IS '�����ͨ��ʾ������߻��飬���ʾ��������Ľ���ʱ��';
COMMENT ON COLUMN TD_SD_NOTIC.EXECUTOR_ID IS '֪ͨ������';
COMMENT ON COLUMN TD_SD_NOTIC.STATUS IS '0��ʾδ���ţ�1��ʾ���ź���';

CREATE UNIQUE INDEX NOTIC ON TD_SD_NOTIC(NOTIC_ID);

ALTER TABLE TD_SD_NOTIC ADD   CONSTRAINT NOTIC PRIMARY KEY (NOTIC_ID);
ALTER TABLE TD_SD_NOTIC ADD   CONSTRAINT EXECUTOR  FOREIGN KEY (EXECUTOR_ID)  REFERENCES TD_SM_USER (USER_ID);
ALTER TABLE TD_SD_NOTIC ADD   CONSTRAINT NOTIC_PLANNER  FOREIGN KEY (NOTIC_PLANNER_ID)  REFERENCES TD_SM_USER (USER_ID);
----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SD_REMIND
(
  REMIND_ID          NUMBER                     NOT NULL,
  ISSYSTEM           NUMBER,
  ISEMAIL            NUMBER,
  ISMESSAGE          NUMBER,
  SCHEDULAR_ID       NUMBER,
  REMIND_BEGIN_TIME  DATE,
  REMIND_END_TIME    DATE,
  INTERVAL_TIME           NUMBER,
  INTERVALTYPE       NUMBER,
  TRIGGERTYPE        NUMBER                     DEFAULT 0,
  CRON_TIME          VARCHAR2(255)
);
COMMENT ON COLUMN TD_SD_REMIND.TRIGGERTYPE IS 'quartz���������ͣ�0��ʾ�����ͣ�1��ʾcron����������';
COMMENT ON COLUMN TD_SD_REMIND.CRON_TIME IS 'cronʱ���ʽ������triggertypeΪ1ʱ������';
COMMENT ON COLUMN TD_SD_REMIND.REMIND_BEGIN_TIME IS '���ѿ�ʼʱ��';
COMMENT ON COLUMN TD_SD_REMIND.REMIND_END_TIME IS '���ѽ���ʱ��';
COMMENT ON COLUMN TD_SD_REMIND.INTERVAL_TIME IS '���Ѽ��';
COMMENT ON COLUMN TD_SD_REMIND.INTERVALTYPE IS '�����λ��0��ʾ�֣�1��ʾСʱ��2��ʾ��';
COMMENT ON COLUMN TD_SD_REMIND.REMIND_ID IS '����';
COMMENT ON COLUMN TD_SD_REMIND.ISSYSTEM IS '�Ƿ����ϵͳ����';
COMMENT ON COLUMN TD_SD_REMIND.ISEMAIL IS '�Ƿ�����ʼ�����';
COMMENT ON COLUMN TD_SD_REMIND.ISMESSAGE IS '�Ƿ���ö�������';
COMMENT ON COLUMN TD_SD_REMIND.SCHEDULAR_ID IS '�ճ�id';

CREATE UNIQUE INDEX REMIND ON TD_SD_REMIND(REMIND_ID);

ALTER TABLE TD_SD_REMIND ADD   CONSTRAINT REMIND PRIMARY KEY (REMIND_ID);
ALTER TABLE TD_SD_REMIND ADD   CONSTRAINT REMIND_SCHEDULAR  FOREIGN KEY (SCHEDULAR_ID)  REFERENCES TD_SD_SCHEDULAR (SCHEDULAR_ID);
-----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SD_RATIFYADVICE
(
  SCHEDULAR_ID     NUMBER,
  RATIFIER_ID      NUMBER,
  ADVICE           VARCHAR2(1000),
  RATIFYADVICE_ID  NUMBER                       NOT NULL
);
COMMENT ON COLUMN TD_SD_RATIFYADVICE.SCHEDULAR_ID IS '�ճ�id';
COMMENT ON COLUMN TD_SD_RATIFYADVICE.RATIFIER_ID IS '��׼��id';
COMMENT ON COLUMN TD_SD_RATIFYADVICE.ADVICE IS '��׼����';
COMMENT ON COLUMN TD_SD_RATIFYADVICE.RATIFYADVICE_ID IS '����';

CREATE UNIQUE INDEX RATIFYADVICE ON TD_SD_RATIFYADVICE(RATIFYADVICE_ID);

ALTER TABLE TD_SD_RATIFYADVICE ADD   CONSTRAINT RATIFYADVICE PRIMARY KEY (RATIFYADVICE_ID);
ALTER TABLE TD_SD_RATIFYADVICE ADD   CONSTRAINT RATIFIER  FOREIGN KEY (RATIFIER_ID)  REFERENCES TD_SM_USER (USER_ID);
ALTER TABLE TD_SD_RATIFYADVICE ADD   CONSTRAINT SCHEDULAR_ID  FOREIGN KEY (SCHEDULAR_ID)  REFERENCES TD_SD_SCHEDULAR (SCHEDULAR_ID);
-----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SD_SHARE
(
  VIEWUSER_ID   NUMBER                          NOT NULL,
  SCHEDULAR_ID  NUMBER                          NOT NULL
);
CREATE UNIQUE INDEX PK ON TD_SD_SHARE(VIEWUSER_ID, SCHEDULAR_ID);

ALTER TABLE TD_SD_SHARE ADD   CONSTRAINT PK PRIMARY KEY (VIEWUSER_ID, SCHEDULAR_ID);
ALTER TABLE TD_SD_SHARE ADD   CONSTRAINT SD  FOREIGN KEY (SCHEDULAR_ID)  REFERENCES TD_SD_SCHEDULAR (SCHEDULAR_ID);
ALTER TABLE TD_SD_SHARE ADD   CONSTRAINT VIEWUSER  FOREIGN KEY (VIEWUSER_ID)  REFERENCES TD_SM_USER (USER_ID);
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SEC_SMS_INTERFACE
(
  MESSAGE_ID    VARCHAR2(20),
  CONTENT       VARCHAR2(2000),
  DONETIME      VARCHAR2(40),
  STATUS        NUMBER                          DEFAULT 0,
  MESSAGE_TYPE  NUMBER                          DEFAULT 0,
  SRCMOBILE     VARCHAR2(20),
  DSTMOBILE     VARCHAR2(40),
  WORKER_NAME   VARCHAR2(40),
  ID            NUMBER                          NOT NULL,
  SENDTIME      VARCHAR2(40),
  MEETINGID     VARCHAR2(50),
  RETRY         NUMBER                          DEFAULT 0
);
-----------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SD_NOTEPAPER
(
  NOTEPAPER_ID  NUMBER,
  TIME          DATE,
  CONTENT       VARCHAR2(1024),
  USER_ID       NUMBER
);
CREATE UNIQUE INDEX NOTEPAPER_ID ON TD_SD_NOTEPAPER(NOTEPAPER_ID);

ALTER TABLE TD_SD_NOTEPAPER ADD   CONSTRAINT NOTEPAPER_ID PRIMARY KEY (NOTEPAPER_ID);
ALTER TABLE TD_SD_NOTEPAPER ADD   CONSTRAINT NOTEPAPERUSER_ID  FOREIGN KEY (USER_ID)  REFERENCES TD_SM_USER (USER_ID);
---------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE TD_SM_ORGUSER
(
  ORG_ID   VARCHAR2(50 BYTE)                    NOT NULL,
  USER_ID  INTEGER                              NOT NULL
); 
alter table TD_SM_ORGUSER add constraint PK_TD_SM_ORGUSER1 primary key (USER_ID);
alter table TD_SM_ORGUSER add constraint FK_TD_SM_ORGUSER1 foreign key (ORG_ID) references TD_SM_ORGANIZATION (ORG_ID);
alter table TD_SM_ORGUSER add constraint FK_TD_SM_ORGUSER2 foreign key (USER_ID) references TD_SM_USER (USER_ID);

CREATE TABLE TD_REMINDINFO
(
  ID       NUMBER,
  TIME     DATE,
  TYPE     VARCHAR2(255 BYTE),
  SOURCE   VARCHAR2(255 BYTE),
  CONTENT  VARCHAR2(1000 BYTE),
  USER_ID  NUMBER
);
COMMENT ON COLUMN TD_REMINDINFO.TIME IS '����ʱ��';
COMMENT ON COLUMN TD_REMINDINFO.TYPE IS '���ѷ�ʽ�����ú���������ϵͳ�����ţ��ʼ�����';
COMMENT ON COLUMN TD_REMINDINFO.SOURCE IS '�������ͣ���Դ';
COMMENT ON COLUMN TD_REMINDINFO.CONTENT IS '��������';
COMMENT ON COLUMN TD_REMINDINFO.USER_ID IS '���Ѷ���';

CREATE UNIQUE INDEX REMIND_PRIMARY ON TD_REMINDINFO (ID);

ALTER TABLE TD_REMINDINFO ADD   CONSTRAINT REMIND_PRIMARY PRIMARY KEY (ID);
ALTER TABLE TD_REMINDINFO ADD   CONSTRAINT REMIND_USER  FOREIGN KEY (USER_ID)  REFERENCES TD_SM_USER (USER_ID);
-----����ί��������------------------------------------------------------------------------
CREATE TABLE ASSIGNMENT_AGENT ( 
  ID           NUMBER (19), 
  CLIENT       VARCHAR2 (50), 
  AGENT        VARCHAR2 (50), 
  STARTTIME    DATE, 
  ENDTIME      DATE, 
  REALENDTIME  DATE, 
  PROCDEFID    VARCHAR2 (100) ) ; 

CREATE TABLE AGENT_WORKLOAD ( 
  AGENTID        NUMBER (19), 
  BUSINESSID     VARCHAR2 (200), 
  BUSINESSNAME   VARCHAR2 (254), 
  TASKNAME       VARCHAR2 (254), 
  COMMITTIME     DATE, 
  RESULT         VARCHAR2 (256), 
  PERFORMER      VARCHAR2 (32), 
  NEXTPERFORMER  VARCHAR2 (32), 
  EXT1           NUMBER (19), 
  EXT2           VARCHAR2 (32), 
  EXT3           VARCHAR2 (64) ) ;
--------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW USERTABLE ( USERID, FIRSTNAME, LASTNAME, PASSWD, EMAIL,OID, VERSION ) AS select u.user_name as USERID , u.user_realname as FIRSTNAME,u.user_realname as LASTNAME, u.user_password as PASSWD,u.user_email as EMAIL, u.user_id as OID, '1' as VERSION from td_sm_user u;
/*==============================================================*/
/* Table: TD_SM_LOGMODULE                                       */
/*==============================================================*/
create table TD_SM_LOGMODULE  (
   LOGMODULE            VARCHAR2(50),
   STATUS               NUMBER,
   MODULE_DESC          VARCHAR2(50),
   ID                   VARCHAR2(50)                     not null,
   constraint LOGMODULE_ID primary key (ID)
);
comment on column TD_SM_LOGMODULE.LOGMODULE is '��־ģ���ƣ���Ӧ��ҵ��ģ��Ĳ˵�id';
comment on column TD_SM_LOGMODULE.STATUS is '��¼��־״̬��0��¼��־��1����¼��־';
comment on column TD_SM_LOGMODULE.MODULE_DESC is '��־ģ������';
comment on column TD_SM_LOGMODULE.ID is '��־ģ��ID';
---��ʼ������------------------------------------------------------------------------------------------------------------------------
INSERT INTO TD_SM_USER ("USER_ID" ,"USER_SN" ,"USER_NAME" ,"USER_PASSWORD" ,"USER_REALNAME","USER_ISVALID","USER_TYPE",USER_SEX  )   VALUES (1 ,1 ,'admin' ,'123456' ,'ϵͳ����Ա','2','0','M'  );
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) VALUES ('1' ,'administrator' ,'1' ,'��������Ա��ɫ���˽�ɫ��Ҫ�޸�' ,'' ,'' ,'' ,''  );
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) VALUES ('2' ,'roleofeveryone' ,'1' ,'ÿ���û���ȱʡӵ�еĽ�ɫ���˽�ɫ��Ҫ�޸�' ,'' ,'' ,'' ,''  );
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) VALUES ('3' ,'orgmanager' ,'1' ,'���Ź���Ա��ɫ,�˽�ɫ��Ҫ�޸�' ,'' ,'' ,'' ,''  );
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) VALUES ('4' ,'orgmanagerroletemplate' ,'1' ,'���Ź���Ա��ɫģ��,����ɫ����ɾ����Ҳ����������ͨ�û���ֻ�ܹ���Ȩ��һ������Ȩ�޺����еĲ��Ź���Ա��ӵ����ЩȨ�ޣ����Ź���Ա��ɫֻ�г�������Ա���ܸ�����Ȩ' ,'' ,'' ,'' ,''  );

INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('add', 'globalrole','3' ,'role' ,'0' , '��ɫ��Դ', 'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('lisanusermanager', 'orgunit','3' ,'orgunit' ,'0' , '������Դ', 'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('lisanusertoorg', 'orgunit','3' ,'orgunit' ,'0' , '������Դ', 'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('visible', 'org_taxcode','3' ,'column' ,'0' ,'������Ȩ����ά��' ,'role');
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('visible', 'usualorg_taxcode','3' ,'column' ,'0' ,'�������ñ���ά��' ,'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('visible', 'rolemanager','3' ,'column' ,'0' ,'��ɫ����' ,'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('visible', 'usermanage','3' ,'column' ,'0' ,'�û�����' ,'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('visible', 'orgmanager','3' ,'column' ,'0' ,'��������' ,'role' );

INSERT INTO TD_SM_USERROLE ("USER_ID" ,"ROLE_ID" ) VALUES (1 ,'1'  );

INSERT INTO TD_SM_JOB ("JOB_ID" ,"JOB_NAME" ,"JOB_DESC" ) VALUES ('1' ,'��ְ' ,'����ɾ��' )  ; 

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sd_notic', 'notic_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sd_ratifyadvice', 'ratifyadvice_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sd_schedular', 'schedular_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_dictdata', 'dictdata_id', 1, 0, NULL, 'string', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_dicttype', 'dicttype_id', 1, 0, NULL, 'string', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_group', 'group_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_job', 'job_id', 1, 0, NULL, 'string', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_organization', 'org_id', 1, 0, NULL, 'string', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_res', 'res_id', 1, 0, NULL, 'string', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_role', 'role_id', 1, 100, NULL, 'string', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sd_remind', 'remind_id', 1, 0, NULL, 'int ', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_user', 'user_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_log', 'log_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sd_notepaper', 'notepaper_id', 1, 0, NULL, 'int', NULL); 
commit;

--��ͼ�ű�
create or replace view v_user_org as
select a.user_id,a.org_id,b.parent_id,b.org_sn,b.orgnumber
	from (select a.user_id, min(a.job_sn), a.org_id
	from td_sm_userjoborg a group by a.user_id, a.org_id) a
	  inner join td_sm_ORGANIZATION b on a.org_id=b.org_id;
	  commit;

create or replace view v_user_one_org_one_job as
select a.user_id,a.org_id, b. parent_id,b.org_sn,b.orgnumber,min(a.job_id) job_id, min(a.JOB_SN) job_sn,min(a.SAME_JOB_USER_SN) SAME_JOB_USER_SN
	from td_sm_userjoborg a right join v_user_org b on a.user_id=b.user_id and a.org_id=b.org_id
	group by a.user_id,a.org_id, b.org_sn,b.orgnumber,b.parent_id;
	commit;

--�û������н�ɫ��ͼ
create or replace view v_tb_user_allrole as
select "USER_ID","ROLE_ID"
    from (
--һ���û����еĽ�ɫ�Ļ�����Դ
--�û���ɫ
select u_role.user_id, u_role.role_id from td_sm_userrole u_role
union
--�û������û���� ��ɫ
select u_group.user_id,g_role.role_id from td_sm_usergroup u_group
join td_sm_grouprole g_role on u_group.group_id=g_role.group_id
union
--�û����������Ľ�ɫ
select org_user.user_id,org_role.role_id from td_sm_userjoborg org_user
join td_sm_orgrole org_role on  org_user.org_id=org_role.org_id
union
--�û�������λ�Ľ�ɫ
select u_job.user_id,org_job_role.role_id from td_sm_userjoborg u_job
 inner join td_sm_orgjobrole org_job_role
 on u_job.job_id=org_job_role.job_id and u_job.org_id=org_job_role.org_id);

--��ȡ�û����ڵĸ�λ����,�����λ��"��"����, ����һ���� 
--�� job1��job2��job3...
--start
create or replace function getUserjobinfos(userid varchar2,orgid varchar2) return varchar2 is
  rs varchar2(4000);
  cursor cur is (select t.job_name from td_sm_job t inner join td_sm_userjoborg c on t.job_id = c.job_id where c.user_id = userid and c.org_id = orgid group by t.job_name);
  cc cur%rowtype;
begin
  rs := null;
  open cur;
  loop
  fetch cur into cc;
  exit when cur%NOTFOUND;
    if nvl(rs,'null')='null' then 
        rs := rs || cc.job_name ;
    else
       rs := rs || '��' || cc.job_name ;
    end if;
 end loop;
 close cur;
  return(rs);
end ;
--end;

--��ȡ�û����ڵĻ�������,���������"��"����, ����һ����
--�� org1��org2��org3...
--start
create or replace function getUserorginfos(userid varchar2) return varchar2 is
  rs varchar2(4000);
  cursor cur is (
    select distinct bb.*,ROW_NUMBER() over(order by   bb.sn) from(
      select t.org_id,t.remark5,t.org_sn ,1 as sn from td_sm_organization t where t.org_id=(
        select ou.org_id from td_sm_orguser ou where ou.user_id=userid
      )
      union 
      select mi.*, 2 as sn from(
        select t.org_id,t.remark5,t.org_sn from td_sm_organization t inner join 
        td_sm_userjoborg c on t.org_id= c.org_id inner join td_sm_user b on b.user_id = 
        c.user_id where b.user_id = userid group by t.org_id,t.remark5 ,t.org_sn
        minus
        select t.org_id,t.remark5,t.org_sn  from td_sm_organization t where t.org_id=(
          select ou.org_id from td_sm_orguser ou where ou.user_id=userid
        )
      )mi 
    ) bb
  );
  cc cur%rowtype;
begin
  rs := null;
  open cur;
  loop
  fetch cur into cc;
  exit when cur%NOTFOUND;
    if nvl(rs,'null')='null' then 
        rs := rs || cc.remark5   ;
    else rs := rs || '��' ||  cc.remark5   ;
    end if;
 end loop;
 close cur;
  return(rs);
end ;
--end;

--��ȡ�û����ڵĻ�������(��λ����),���������"��"����, ����һ����
--�� org1(job1��job2��job3...)��org2(job1��job2��job3...)��org3(job1��job2��job3...)...
--start
create or replace function getUserorgjobinfos(userid varchar2) return varchar2 is
  rs varchar2(4000);
  cursor cur is (
    select distinct bb.*,ROW_NUMBER() over(order by   bb.sn) from(
      select t.org_id,t.remark5,t.org_sn ,1 as sn from td_sm_organization t where t.org_id=(
        select ou.org_id from td_sm_orguser ou where ou.user_id=userid
      )
      union 
      select mi.*, 2 as sn from(
        select t.org_id,t.remark5,t.org_sn from td_sm_organization t inner join 
        td_sm_userjoborg c on t.org_id= c.org_id inner join td_sm_user b on b.user_id = 
        c.user_id where b.user_id = userid group by t.org_id,t.remark5 ,t.org_sn
        minus
        select t.org_id,t.remark5,t.org_sn  from td_sm_organization t where t.org_id=(
          select ou.org_id from td_sm_orguser ou where ou.user_id=userid
        )
      )mi 
    ) bb
  );
  cc cur%rowtype;
begin
  rs := null;
  open cur;
  loop
  fetch cur into cc;
  exit when cur%NOTFOUND; 
    if nvl(rs,'null')='null'  then 
        rs := rs || cc.remark5 || '(' || getUserjobinfos(userid,cc.org_id) || ')'; 
    else 
        rs := rs || '��' || cc.remark5 || '(' || getUserjobinfos(userid,cc.org_id) || ')'; 
    end if;    
 end loop;
 close cur;

  return(rs);
end ;
--end;

/*==============================================================*/
/* Table: TD_SM_ORGMANAGER                                      */
/*==============================================================*/
create table TD_SM_ORGMANAGER  (
   USER_ID              NUMBER                           not null,
   ORG_ID               VARCHAR(50)                      not null,
   constraint PK_TD_SM_ORGMANAGER primary key (USER_ID, ORG_ID)
);
comment on table TD_SM_ORGMANAGER is '�û���������Ա��';
comment on column TD_SM_ORGMANAGER.USER_ID is '��������Աid';

alter table TD_SM_ORGMANAGER add constraint FK_TD_SM_ORGMGRUS foreign key (USER_ID) references TD_SM_USER (USER_ID);
alter table TD_SM_ORGMANAGER add constraint FK_TD_SM_MGRORG foreign key (ORG_ID) references TD_SM_ORGANIZATION (ORG_ID);
/*==============================================================*/
/* Database name:  �ֵ���� ��ʼ���ű�                          */
/* DBMS name:      ORACLE Version 9i                            */
/* Created on:     2007-12-18 14:41:59                          */
/*==============================================================*/
/*==============================================================*/
/* Table: TB_SM_INPUTTYPE                                       */
/*==============================================================*/
create table TB_SM_INPUTTYPE  (
   INPUT_TYPE_ID        NUMBER(5)                        not null,
   INPUT_TYPE_DESC      VARCHAR(200),                     
   DATASOURCE_PATH      VARCHAR(200),
   INPUT_TYPE_NAME      VARCHAR(200)                    not null,
   SCRIPT               VARCHAR(4000),
   constraint PK_TB_SM_INPUTTYPE primary key (INPUT_TYPE_ID)
);
comment on table TB_SM_INPUTTYPE is '�ֵ���������������';

comment on column TB_SM_INPUTTYPE.DATASOURCE_PATH is '����Դѡ�����';
comment on column TB_SM_INPUTTYPE.SCRIPT is '�������͵Ľű�';
/*==============================================================*/
/* Table: TD_SM_DICATTACHFIELD                                  */
/*==============================================================*/
create table TD_SM_DICATTACHFIELD  (
   DICTTYPE_ID          VARCHAR2(50),
   FIELD_NAME           VARCHAR(50),
   LABEL                VARCHAR(100),
   INPUT_TYPE_ID        NUMBER(5),
   TABLE_COLUMN         VARCHAR(50),
   ISNULLABLE           number(1)
);
comment on column TD_SM_DICATTACHFIELD.DICTTYPE_ID is '�ֵ�����ID';
comment on column TD_SM_DICATTACHFIELD.FIELD_NAME is '������ݿ��ֶ�,�Լ���Ӧ���������͵ĸ�����Ϣ����������: ��������, ѡ���ֵ� ����Ҫά������ֶ� filedName:'''':''''';
comment on column TD_SM_DICATTACHFIELD.TABLE_COLUMN is '�ֵ��ֶζ�Ӧ���ݿ��';
comment on column TD_SM_DICATTACHFIELD.ISNULLABLE is '�ֶ��Ƿ���� 0:���Ǳ��� 1:����';

--�����ֶα� td_sm_dicattachfield
alter table td_sm_dicattachfield add DATEFORMAT VARCHAR2(50);
alter table td_sm_dicattachfield add ISUNIQUE number(1);

comment on column  td_sm_dicattachfield.DATEFORMAT is '���������ֶ�';
comment on column  td_sm_dicattachfield.ISUNIQUE is '�ֶε�ֵ�Ƿ�Ψһ�Ա�֤  1-Ψһ,�ֵ�ά��ʱ��Ҫ����Ψһ�Լ��  0-���ظ���ȱʡֵ';
/*==============================================================*/
/* Table: TD_SM_DICTDATA                                        */
/*==============================================================*/
create table TD_SM_DICTDATA  (
   DICTDATA_ID          VARCHAR2(50)                     not null,
   DICTTYPE_ID          VARCHAR2(50),
   DICTDATA_NAME        VARCHAR2(100),
   DICTDATA_VALUE       VARCHAR2(100),
   DICTDATA_ORDER       NUMBER(10)                     default 0,
   constraint PK_TD_SM_DICTDATA primary key (DICTDATA_ID)
);
comment on column TD_SM_DICTDATA.DICTDATA_ID is '�ֵ�ID';
comment on column TD_SM_DICTDATA.DICTTYPE_ID is '�ֵ�����ID';
comment on column TD_SM_DICTDATA.DICTDATA_NAME is '�ֵ�����';
comment on column TD_SM_DICTDATA.DICTDATA_VALUE is '�ֵ��ֵ';
comment on column TD_SM_DICTDATA.DICTDATA_ORDER is '�ֵ����������ֶΣ�ȱʡֵΪ0';
/*==============================================================*/
/* Index: RELATIONSHIP_12_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_12_FK on TD_SM_DICTDATA (DICTTYPE_ID ASC);
/*==============================================================*/
/* Table: TD_SM_DICTTYPE                                        */
/*==============================================================*/
create table TD_SM_DICTTYPE  (
   DATA_VALIDATE_FIELD  VARCHAR(50),
   DATA_CREATE_ORGID_FIELD VARCHAR(50),
   DICTTYPE_TYPE        NUMBER(2),
   IS_TREE              NUMBER(1)                      default 0,
   DICTTYPE_ID          VARCHAR2(50)                     not null,
   USER_ID              NUMBER,
   DICTTYPE_NAME        VARCHAR2(100),
   DICTTYPE_DESC        VARCHAR2(100),
   DICTTYPE_PARENT      VARCHAR2(50),
   DATA_TABLE_NAME      VARCHAR(50),
   DATA_NAME_FILED      VARCHAR2(50),
   DATA_VALUE_FIELD     VARCHAR2(50),
   DATA_ORDER_FIELD     VARCHAR2(50),
   DATA_TYPEID_FIELD    VARCHAR2(50),
   DATA_DBNAME          VARCHAR2(50),
   DATA_PARENTID_FIELD  VARCHAR(50),
   constraint PK_TD_SM_DICTTYPE primary key (DICTTYPE_ID)
);
comment on column TD_SM_DICTTYPE.DICTTYPE_TYPE is '0:�����ֵ�����;1:��Ȩ��ҵ���ֵ�2:��Ȩ��ҵ���ֵ�';
comment on column TD_SM_DICTTYPE.IS_TREE is '�ж��ֵ�����������״�Ļ����б��͵������� 0-�б����ͣ�ȱʡֵ 1-��״�ṹ������ָ��DATA_PARENT_FIELD�ֶ�';
comment on column TD_SM_DICTTYPE.DICTTYPE_ID is '�ֵ�����ID';
comment on column TD_SM_DICTTYPE.USER_ID is '�û�ID';
comment on column TD_SM_DICTTYPE.DICTTYPE_NAME is '�ֵ���������';
comment on column TD_SM_DICTTYPE.DICTTYPE_DESC is '�ֵ���������';
comment on column TD_SM_DICTTYPE.DATA_TABLE_NAME is '�ֵ����ݴ�ű�����ȱʡΪtd_sm_dictdata';
comment on column TD_SM_DICTTYPE.DATA_NAME_FILED is '�ֵ��������ƴ���ֶΣ�ȱʡΪDICTDATA_NAME';
comment on column TD_SM_DICTTYPE.DATA_VALUE_FIELD is '�ֵ�����ֵ����ֶΣ�ȱʡֵΪDICTDATA_value';
comment on column TD_SM_DICTTYPE.DATA_ORDER_FIELD is '�ֵ����������ֶΣ�ȱʡֵΪDICTDATA_ORDER';
comment on column TD_SM_DICTTYPE.DATA_DBNAME is '�ֵ���Ӧ�����ݿ�';
comment on column TD_SM_DICTTYPE.DATA_PARENTID_FIELD is '��״�ṹ�����ֵ���ÿ���������Ӧ�ĸ��ڵ��ֶ�����';

--�ֵ����ͱ� td_sm_dicttype 
alter table td_sm_dicttype add  DATA_NAME_CN VARCHAR2(100) ;
alter table td_sm_dicttype add  DATA_VALUE_CN VARCHAR2(100) ;
alter table td_sm_dicttype add  KEY_GENERAL_TYPE NUMBER(2);
alter table td_sm_dicttype modify (DATA_NAME_CN default '����');
alter table td_sm_dicttype modify (DATA_VALUE_CN default '��ʵֵ');

comment on column  td_sm_dicttype.DATA_NAME_CN is '�ֵ������ֶβɼ�ʱ����������';
comment on column  td_sm_dicttype.DATA_VALUE_CN is 'ֵ�ֶβɼ�ʱ����������';
comment on column  td_sm_dicttype.KEY_GENERAL_TYPE is '0:�ֹ�¼��;1:�Զ����� tableinfo��';
/*==============================================================*/
/* Table: TD_SM_TAXCODE_ORGANIZATION                            */
/*==============================================================*/
create table TD_SM_TAXCODE_ORGANIZATION  (
   ORG_ID               VARCHAR2(50)                     not null,
   DICTTYPE_ID          VARCHAR2(50)                     not null,
   DATA_VALUE           VARCHAR(100)                     not null,
   OPCODE               VARCHAR2(10),
   DATA_NAME            VARCHAR2(100),
   constraint PK_TD_SM_TAXCODE_ORGANIZATION primary key (ORG_ID, DICTTYPE_ID, DATA_VALUE,OPCODE)
);
comment on table TD_SM_TAXCODE_ORGANIZATION is '˰����ض�Ӧ�ı�������';

comment on column TD_SM_TAXCODE_ORGANIZATION.ORG_ID is '����ID';
comment on column TD_SM_TAXCODE_ORGANIZATION.DICTTYPE_ID is '�ֵ�����ID';
comment on column TD_SM_TAXCODE_ORGANIZATION.DATA_VALUE is '�������ֵ';
comment on column TD_SM_TAXCODE_ORGANIZATION.OPCODE is '������𣺿ɼ�(read),����(usual)';
comment on column TD_SM_TAXCODE_ORGANIZATION.DATA_NAME is '����������';

alter table TD_SM_DICATTACHFIELD add constraint FK_TD_SM_DI_REFERENCE_TD_SM_DI foreign key (DICTTYPE_ID) references TD_SM_DICTTYPE (DICTTYPE_ID);
alter table TD_SM_DICATTACHFIELD add constraint FK_FIELD_TYPE foreign key (INPUT_TYPE_ID) references TB_SM_INPUTTYPE (INPUT_TYPE_ID);

alter table TD_SM_DICTDATA add constraint FK_TD_TYPE_DATA foreign key (DICTTYPE_ID) references TD_SM_DICTTYPE (DICTTYPE_ID) not deferrable;

alter table TD_SM_DICTTYPE add constraint FK_TD_SM_DI_REFERENCE_TD_SM_US foreign key (USER_ID) references TD_SM_USER (USER_ID);

alter table TD_SM_TAXCODE_ORGANIZATION add constraint FK_TD_SM_TA_REFERENCE_TD_SM_OR foreign key (ORG_ID) references TD_SM_ORGANIZATION (ORG_ID);
alter table TD_SM_TAXCODE_ORGANIZATION add constraint FK_TD_SM_TA_REFERENCE_TD_SM_DI foreign key (DICTTYPE_ID) references TD_SM_DICTTYPE (DICTTYPE_ID);

--��ʼ���������ͱ�
delete tb_sm_inputtype;
commit;
delete TD_SM_DICTDATA;
commit;
delete TD_SM_DICTTYPE;
commit;

insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(1,'�ı�����','','',''); 
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(2,'ѡ���ֵ�','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(3,'ѡ��ʱ��','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(4,'��������','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(5,'ѡ�����','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(6,'ѡ����Ա','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(7,'��ǰ�û�','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(8,'��ǰ����','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(9,'��ǰ�û�','','','');
commit;

--��ʼ���ֵ����ͱ�
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('9', 'isPublicAffair', '�ճ̹����Ƿ���', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('6', 'intervalType', '�ճ̹�������ʱ������λ', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('2', 'isvalid', '��Ч��', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('1', 'sex', '�Ա�', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('5', 'orgType', '��������', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('4', 'MailPostfix', '�����׺', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('3', 'userType', '�û�����', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('7', 'essentiality', '�ճ̹�����Ҫ��', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('8', 'isLeisure', '�ճ̹����Ƿ����', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE) VALUES ('45', 'ispartybussiness', '�����Ƿ�ҵ����', '0', 0); 

delete from TD_SM_DICTDATA where DICTDATA_ID=70;
delete from TD_SM_DICTDATA where DICTDATA_ID=71;
delete from TD_SM_DICTTYPE where DICTTYPE_ID = '2312';
commit;

INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT ) VALUES ('2312', '�Ƿ��ֵ�', '�Ƿ��ֵ�', '0');

INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 70, '2312', '��', '1','0');
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 71 , '2312', '��', '0','1');
commit;
 
--��ʼ���ֵ����ݱ� 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE,DICTDATA_ORDER ) VALUES ('60', '9', '����', '0', 1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE,DICTDATA_ORDER ) VALUES ('61', '9', '˽��', '1', 2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('62', '6', '��', '0',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('63', '6', 'Сʱ', '1',2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('64', '6', '��', '2',3); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('65', '7', '��Ҫ', '0',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('66', '7', 'һ��', '1',2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('67', '7', '����Ҫ', '2',3); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('68', '8', 'æ', '0',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('69', '8', '����', '1',2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('11', '1', '��', 'M',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('12', '1', 'Ů', 'F',2);
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('126', '2', '��ͨ', '2','0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('127', '2', 'ͣ��', '3','1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('31', '4', 'kechuang.com', 'kechuang.com',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('32', '4', 'furongwang.com', 'furongwang.com',2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('33', '4', 'china.com', 'china.com',3); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('13', '1', 'δ֪', '-1',3); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('41', '5', '��Ч', '0',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('42', '5', '��Ч', '1',2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('51', '3', '�ⲿ�û�', '1','2'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('53', '3', 'ϵͳ�û�', '0','1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME, DICTDATA_VALUE,DICTDATA_ORDER ) VALUES ('192', '45', '��', '0', 1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME, DICTDATA_VALUE,DICTDATA_ORDER ) VALUES ('193', '45', '��', '1', 2); 

/*==============================================================*/
/* Database name:  ϵͳ�������ݿ� �ڼ��չ�������Ѿ���ʼ����       */
/* DBMS name:      ORACLE Version 9i                            */
/* Created on:     2008-2-26 19:31:52                           */
/*==============================================================*/
/*==============================================================*/
/* Table: TD_SM_INITYEAR_HOLIDAY                                */
/*==============================================================*/
create table TD_SM_INITYEAR_HOLIDAY  (
   ORG_ID               VARCHAR2(50),
   YHOLIDAY             VARCHAR(4)                       not null,
   constraint PK_TD_SM_INITYEAR_HOLIDAY primary key (YHOLIDAY)
);
comment on table TD_SM_INITYEAR_HOLIDAY is 'ϵͳ�������ݿ� �ڼ��չ�������Ѿ���ʼ����';
comment on column TD_SM_INITYEAR_HOLIDAY.ORG_ID is '�ڼ��ն�Ӧ�Ļ���ID';
comment on column TD_SM_INITYEAR_HOLIDAY.YHOLIDAY is '�Ѿ������˽ڼ��յ����, ���Ѿ���ʼ���ڼ��յ����';
  
-- alter table   
alter table td_sm_roleresop add AUTHORIZATION_TYPE  NUMBER default 0;
alter table td_sm_roleresop add USE_COUNT           NUMBER;
alter table td_sm_roleresop add AUTHORIZATION_STIME DATE;
alter table td_sm_roleresop add  AUTHORIZATION_ETIME DATE;

-- Add comments to the columns  
comment on column TD_SM_ROLERESOP.AUTHORIZATION_TYPE is '��Ȩ�ķ�ʽ:0/null:������Ȩ,1:������Ȩ,2:ʱЧ��Ȩ';
comment on column TD_SM_ROLERESOP.USE_COUNT is '��Ȩ��ʹ�ô���';
comment on column TD_SM_ROLERESOP.AUTHORIZATION_STIME is '��Ȩ��ʼʱ��';
comment on column TD_SM_ROLERESOP.AUTHORIZATION_ETIME is '��Ȩ����ʱ��';

--alter table TD_SM_DICTTYPE add DICTTYPE_TYPE       NUMBER(2) default 0
--alter table TD_SM_DICTTYPE add DATA_VALIDATE_FIELD VARCHAR2(50)
--alter table TD_SM_DICTTYPE add DATA_CREATE_ORGID_FIELD VARCHAR2(50) default '1'
--alter table TD_SM_DICTTYPE add KEY_GENERAL_TYPE NUMBER(2) default 0

-- Add comments to the columns 
comment on column TD_SM_DICTTYPE.DICTTYPE_ID is '�ֵ�����ID';
comment on column TD_SM_DICTTYPE.DICTTYPE_NAME is '�ֵ���������';
comment on column TD_SM_DICTTYPE.DICTTYPE_DESC is '�ֵ���������';
comment on column TD_SM_DICTTYPE.DATA_TABLE_NAME is '�ֵ����ݴ�ű�����ȱʡΪtd_sm_dictdata';
comment on column TD_SM_DICTTYPE.DATA_NAME_FILED is '�ֵ��������ƴ���ֶΣ�ȱʡΪDICTDATA_NAME';
comment on column TD_SM_DICTTYPE.DATA_VALUE_FIELD is '�ֵ�����ֵ����ֶΣ�ȱʡֵΪDICTDATA_value';
comment on column TD_SM_DICTTYPE.DATA_ORDER_FIELD is '�ֵ����������ֶΣ�ȱʡֵΪDICTDATA_ORDER';
comment on column TD_SM_DICTTYPE.DATA_TYPEID_FIELD is '�ֵ�����ID�ֶΣ�ȱʡֵΪDICTTYPE_ID';
comment on column TD_SM_DICTTYPE.DATA_PARENTID_FIELD is '�����ID';
comment on column TD_SM_DICTTYPE.IS_TREE is '0:��������,1:����';
comment on column TD_SM_DICTTYPE.DICTTYPE_TYPE is '0:�����ֵ�����;1:��Ȩ��ҵ���ֵ�2:��Ȩ��ҵ���ֵ�';
comment on column TD_SM_DICTTYPE.DATA_VALIDATE_FIELD is '�������Ƿ�ʹ�õ��ֶ�';
comment on column TD_SM_DICTTYPE.DATA_CREATE_ORGID_FIELD is '������Ĵ�������ID�ֶ�';

--drop table TB_SM_INPUTTYPE cascade constraints

--alter table td_sm_dictdata add dictdata_order number(10) default 0
comment on column TD_SM_DICTDATA.DICTDATA_ORDER is '�ֵ������';

-- Create table
--create table TD_SM_ORGJOBROLE
--(
--  ORG_ID  VARCHAR2(50) not null,
--  JOB_ID  VARCHAR2(50) not null,
--  ROLE_ID VARCHAR2(50) not null
--);
-- Create/Recreate primary, unique and foreign key constraints 

  -- Create table

-- Add comments to the table 

-- Create/Recreate primary, unique and foreign key constraints 

alter table td_sm_user add istaxmanager number(1);

comment on column TD_SM_USER.ISTAXMANAGER is '�Ƿ�˰��Ա';
comment on column TD_SM_ROLE.OWNER_ID is '������id��Ĭ��άϵͳ����Ա';
comment on column TD_SM_ROLE.OWNER_ID is '������id��Ĭ��άϵͳ����Ա';

--�û������н�ɫ��ͼ
create or replace view v_tb_user_allrole as
select "USER_ID","ROLE_ID"
    from (
--һ���û����еĽ�ɫ�Ļ�����Դ
--�û���ɫ
select u_role.user_id, u_role.role_id from td_sm_userrole u_role
union
--�û������û���� ��ɫ
select u_group.user_id,g_role.role_id from td_sm_usergroup u_group
join td_sm_grouprole g_role on u_group.group_id=g_role.group_id
union
--�û����������Ľ�ɫ
select org_user.user_id,org_role.role_id from td_sm_userjoborg org_user
join td_sm_orgrole org_role on  org_user.org_id=org_role.org_id
union
--�û�������λ�Ľ�ɫ
select u_job.user_id,org_job_role.role_id from td_sm_userjoborg u_job
 inner join td_sm_orgjobrole org_job_role
 on u_job.job_id=org_job_role.job_id and u_job.org_id=org_job_role.org_id);

--��ɫ�ɷ��ʵĻ�����Դ��ͼ
create or replace view v_tb_res_org_role as
select roleres.role_id, roleres.res_id as org_id , roleres.op_id,roleres.restype_id, org.parent_id  
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id    
where roleres.types='role' and roleres.restype_id='orgunit';

--�û�ӵ�еĽ�ɫ��ͼ����ȡ��roleofeveryone֮������н�ɫ
/* Formatted on 2008/04/15 10:55 (Formatter Plus v4.8.7) */

CREATE OR REPLACE VIEW v_td_sm_user_allrole (user_id, role_id)
AS
   SELECT t.user_id AS user_id, t.role_id AS role_id
     FROM (
           --һ���û����еĽ�ɫ
           --�û���ɫ
           SELECT u_role.user_id, u_role.role_id
             FROM td_sm_userrole u_role
           UNION
           --�û������û���� ��ɫ
           SELECT u_group.user_id, g_role.role_id
             FROM td_sm_usergroup u_group JOIN td_sm_grouprole g_role
                  ON u_group.GROUP_ID = g_role.GROUP_ID
           UNION
           --�û����������Ľ�ɫ
           SELECT org_user.user_id, org_role.role_id
             FROM td_sm_userjoborg org_user JOIN td_sm_orgrole org_role
                  ON org_user.org_id = org_role.org_id
           UNION
           --�û�������λ�Ľ�ɫ
           SELECT u_job.user_id, org_job_role.role_id
             FROM td_sm_userjoborg u_job INNER JOIN td_sm_orgjobrole org_job_role
                  ON u_job.job_id = org_job_role.job_id
                AND u_job.org_id = org_job_role.org_id
                  ) t
          INNER JOIN
          td_sm_role r ON r.role_id = t.role_id;

--�û��ɷ��ʵĻ�����Դ��ͼ
CREATE OR REPLACE VIEW V_TB_RES_ORG_USER
(USER_ID, ORG_ID, PARENT_ID, OP_ID, RESTYPE_ID)
AS 
select to_char(allroles.user_id) as user_id,
  orgres_role.org_id as org_id,orgres_role.parent_id as parent_id,
  orgres_role.op_id as op_id,orgres_role.restype_id  as restype_id
from v_td_sm_user_allrole allroles,
--ͨ����ɫID,����CS��Դ��ͼ,û�а�����roleofeveryone��
v_tb_res_org_role orgres_role
where  orgres_role.role_id = allroles.role_id
-- ��ȡ ��roleofeveryone���ɷ���˰�����Ȩ��
union
select to_char(u.user_id) as user_id,org_id,parent_id,op_id,restype_id from (
select roleres.res_id as org_id , roleres.op_id,roleres.restype_id, org.parent_id
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id
where roleres.types='role' and roleres.restype_id='orgunit' and roleres.role_id='2') roleres,td_sm_user u
union
--union ֱ�ӷ�����û�����Դ
select to_char(roleres.role_id) as user_id,
       roleres.res_id as org_id,
       org.parent_id as parent_id,
       roleres.op_id as op_id,
       roleres.restype_id  as restype_id
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id
where roleres.types='user' and roleres.restype_id='orgunit'
union
--union ֱ�ӷ�����û���������Դ
select to_char(userjoborg.user_id) as user_id,
       roleres.res_id as org_id,
       org.parent_id as parent_id,
       roleres.op_id as op_id,
       roleres.restype_id  as restype_id
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id
    join td_sm_userjoborg userjoborg on  userjoborg.org_id = roleres.role_id
where roleres.types='organization' and roleres.restype_id='orgunit';

--��ɫ�ɷ��ʵĽ�ɫ��Դ��ͼ
create or replace view v_tb_res_role_role as
select roleres.role_id as role_id,roleres.res_id as res_id, roleres.op_id,roleres.restype_id
    from td_sm_roleresop roleres
    join td_sm_role role on roleres.res_id=role.role_id
where roleres.types='role' and roleres.restype_id='role';

--�û��ɷ��ʵĽ�ɫ��Դ��ͼ
/* Formatted on 2008/03/25 11:32 (Formatter Plus v4.8.7) */
CREATE OR REPLACE VIEW v_tb_res_role_user (user_id, role_id, op_id,
                                           restype_id)
AS
SELECT TO_CHAR (allroles.user_id) AS user_id, roleres_role.res_id AS role_id,
       roleres_role.op_id AS op_id, roleres_role.restype_id AS restype_id
  FROM (
--һ���û����еĽ�ɫ�Ľ�ɫ��Դ
--�û���ɫ
        SELECT u_role.user_id, u_role.role_id
          FROM td_sm_userrole u_role
        UNION
--�û������û���� ��ɫ
        SELECT u_group.user_id, g_role.role_id
          FROM td_sm_usergroup u_group JOIN td_sm_grouprole g_role
               ON u_group.GROUP_ID = g_role.GROUP_ID
        UNION
--�û����������Ľ�ɫ
        SELECT org_user.user_id, org_role.role_id
          FROM td_sm_userjoborg org_user JOIN td_sm_orgrole org_role
               ON org_user.org_id = org_role.org_id
        UNION
--�û�������λ�Ľ�ɫ
        SELECT u_job.user_id, org_job_role.role_id
          FROM td_sm_userjoborg u_job INNER JOIN td_sm_orgjobrole org_job_role
               ON u_job.job_id = org_job_role.job_id
             AND u_job.org_id = org_job_role.org_id
               ) allroles,v_tb_res_role_role roleres_role
 WHERE roleres_role.role_id = allroles.role_id
--��ͨ�û���ɫ��Դ��roleofeveryone�� ��ɫidΪ2
UNION
SELECT TO_CHAR(u.user_id) AS user_id, 
      roleres_role.res_id AS role_id,
       roleres_role.op_id AS op_id, roleres_role.restype_id AS restype_id
  FROM 
  (
  SELECT roleres.role_id AS role_id, roleres.res_id AS res_id,r.role_name,
               roleres.op_id, roleres.restype_id
          FROM td_sm_roleresop roleres ,td_sm_role r		  
         WHERE roleres.TYPES = 'role'
           --AND roleres.restype_id = 'role'
           AND roleres.role_id = '2' and roleres.role_id = r.role_id
)  roleres_role,td_sm_user u
UNION
--union ֱ�ӷ�����û�����Դ
SELECT TO_CHAR (roleres.role_id) AS user_id, roleres.res_id AS role_id,
       roleres.op_id AS op_id, roleres.restype_id AS restype_id
  FROM td_sm_roleresop roleres
 WHERE roleres.TYPES = 'user' AND roleres.restype_id = 'role'
UNION
--union ֱ�ӷ�����û���������Դ
SELECT TO_CHAR (userjoborg.user_id) AS user_id, roleres.res_id AS role_id,
       roleres.op_id AS op_id, roleres.restype_id AS restype_id
  FROM td_sm_roleresop roleres JOIN td_sm_userjoborg userjoborg
       ON userjoborg.org_id = roleres.role_id
 WHERE roleres.TYPES = 'organization' AND roleres.restype_id = 'role';

---��ʼ������------------------------------------------------------------------------------------------------------------------------
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") VALUES ('visible', 'userManageItem','3' ,'column' ,'0' ,'Ȩ��ά��' ,'role' ,0);
commit;

drop table TD_SM_DICATTACHFIELD cascade constraints;
/*==============================================================*/
/* Table: TD_SM_DICATTACHFIELD          �����ֶα�               */
/*==============================================================*/
create table TD_SM_DICATTACHFIELD  (
   DICTTYPE_ID          VARCHAR2(50),
   FIELD_NAME           VARCHAR(50),
   LABEL                VARCHAR(100),
   INPUT_TYPE_ID        NUMBER(5),
   TABLE_COLUMN         VARCHAR(50),
   ISNULLABLE           number(1)
);
comment on column TD_SM_DICATTACHFIELD.DICTTYPE_ID is '�ֵ�����ID';

-- Add/modify columns 
-- alter table TD_SM_LOG modify LOG_TYPE VARCHAR2(4000)
alter table TD_SM_ROLE modify (ROLE_DESC varchar2(1024));

comment on column TD_SM_ORGANIZATION.ORG_XZQM is '��������';

--alter table TD_SM_ORGANIZATION rename column ORG_CODE to ORG_XZQM
commit;

alter table TD_SM_DICATTACHFIELD add  ISUNIQUE NUMBER(1) ;
alter table TD_SM_DICATTACHFIELD modify (ISUNIQUE default 0);

comment on column  TD_SM_DICATTACHFIELD.ISUNIQUE is '�ֶε�ֵ�Ƿ�Ψһ�Ա�֤1-Ψһ,�ֵ�ά��ʱ��Ҫ����Ψһ�Լ��0-���ظ���ȱʡֵ';

update TD_SM_ROLE set ROLE_NAME='orgmanager' where ROLE_ID='3';
commit;

--������Ȩ���ֽű�
alter table TD_SM_ROLERESOP modify (AUTHORIZATION_TYPE default 0);
comment on column  TD_SM_ROLERESOP.AUTHORIZATION_TYPE is '��Ȩ�ķ�ʽ:0:������Ȩ,1:������Ȩ,2:ʱЧ��Ȩ';
comment on column  TD_SM_ROLERESOP.USE_COUNT is '��Ȩ��ʹ�ô���';
  
alter table TD_SM_ROLERESOP add  USE_COUNTED NUMBER ;

comment on column  TD_SM_ROLERESOP.USE_COUNTED is 'Ȩ����ʹ�ô���';
comment on column  TD_SM_ROLERESOP.AUTHORIZATION_STIME is '��Ȩʹ�ÿ�ʼʱ��';
comment on column  TD_SM_ROLERESOP.AUTHORIZATION_ETIME is '��Ȩʹ�ý���ʱ��';

--��Դ�������սű�
/*==============================================================*/
/* Table: TD_SM_PERMISSION_ORIGINE                              */
/*==============================================================*/
create table TD_SM_PERMISSION_ORIGINE  (
   ORIGINE_TYPE         VARCHAR2(50)                     not null,
   ORIGINE_ID           VARCHAR(20)                      not null,
   OP_ID                VARCHAR2(50)                     not null,
   RES_ID               VARCHAR2(100)                    not null,
   ROLE_ID              VARCHAR2(50)                     not null,
   RESTYPE_ID           VARCHAR2(50)                     not null,
   TYPES                VARCHAR2(50)                     not null,
   constraint PK_TD_SM_PERMISSION_ORIGINE primary key (ORIGINE_TYPE, ORIGINE_ID, OP_ID, RES_ID, ROLE_ID, RESTYPE_ID, TYPES)
);
comment on table TD_SM_PERMISSION_ORIGINE is 'TD_SM_PERMISSION_ORIGINE��Ϣά������Ȩʱ�����ȷ�����Ȩ�˲�����Ȩ�޵���Դ�������¼��֣��ǲ�����Ȩ�˱������Դ������ǽ���Դ��Ϣ���뱾���ǲ�����Ȩ��������������Դ������ǽ���Դ��Ϣ���뱾���ǲ�����Ȩ��ӵ�еĽ�ɫ����Դ������ǽ������ɫ��Ϣ����¼���뱾��ȡ����Ȩʱ���������м�鱻��Ȩ���Ƿ񽫸�Ȩ�����������û��������������Ҫȡ���ɱ���Ȩ��������û���Ȩ�ޣ���˵ݹ�ִ�У��Ƿ�ȡ��Ȩ�޻����жϱ���Ȩ���ڱ����л���ͨ������������ø�Ȩ�ޣ����û����ɾ��Ȩ�ޱ��еĸ�����¼��ͬʱɾ�������е����Ȩ����Դ��Ϣ';
comment on column TD_SM_PERMISSION_ORIGINE.ORIGINE_TYPE is 'Ȩ����Դ���ͣ�user,role,organization';
comment on column TD_SM_PERMISSION_ORIGINE.ORIGINE_ID is 'Ȩ����Դ��ɫid�����ݽ�ɫ����ȷ��Ϊ���û�id����ɫid������id';
comment on column TD_SM_PERMISSION_ORIGINE.OP_ID is '����ID';
comment on column TD_SM_PERMISSION_ORIGINE.RES_ID is '��ԴID';
comment on column TD_SM_PERMISSION_ORIGINE.ROLE_ID is '��ɫID';
comment on column TD_SM_PERMISSION_ORIGINE.RESTYPE_ID is '��Դ����ID';
comment on column TD_SM_PERMISSION_ORIGINE.TYPES is '��Դ���ࣨ�ǽ�ɫ��Դ�����û���Դ��';

--��ɫ���սű�
--�û���ɫ��
alter table TD_SM_USERROLE add  RESOP_ORIGIN_USERID VARCHAR2(50) ;
alter table TD_SM_USERROLE modify (RESOP_ORIGIN_USERID default '1');

comment on column  TD_SM_USERROLE.RESOP_ORIGIN_USERID is '�����ɫ���û�';

--�û����ɫ��
alter table TD_SM_GROUPROLE add  RESOP_ORIGIN_USERID VARCHAR2(50) ;
alter table TD_SM_GROUPROLE modify (RESOP_ORIGIN_USERID default '1');
comment on column  TD_SM_GROUPROLE.RESOP_ORIGIN_USERID is '�����ɫ���û�';

--������λ��ɫ��
alter table TD_SM_ORGJOBROLE add  RESOP_ORIGIN_USERID VARCHAR2(50) ;
alter table TD_SM_ORGJOBROLE modify (RESOP_ORIGIN_USERID default '1');
comment on column  TD_SM_ORGJOBROLE.RESOP_ORIGIN_USERID is '�����ɫ���û�';
  
  
--������ɫ��
alter table TD_SM_ORGROLE add  RESOP_ORIGIN_USERID VARCHAR2(50) ;
alter table TD_SM_ORGROLE modify (RESOP_ORIGIN_USERID default '1');
comment on column  TD_SM_ORGROLE.RESOP_ORIGIN_USERID is '�����ɫ���û�';

--Ϊ��ɫ����ӽ�ɫ�����ֶ�
comment on column  TD_SM_ROLE.ROLE_TYPE is '��ɫ����';
/*==============================================================*/
/* Table: TD_SM_ROLETYPE                                        */
/*==============================================================*/
create table TD_SM_ROLETYPE  (
   TYPE_NAME            VARCHAR(100),
   TYPE_DESC            VARCHAR(500),
   TYPE_ID              NUMBER
);
comment on table TD_SM_ROLETYPE is '��ɫ������Ϣ��';
comment on column TD_SM_ROLETYPE.TYPE_NAME is '��ɫ��������';
comment on column TD_SM_ROLETYPE.TYPE_DESC is '��ɫ��������';

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_roletype', 'type_id', 1, 0, NULL, 'int', NULL); 
commit;

--���ý�ɫ���ͱ�����
alter table TD_SM_ROLETYPE add constraint role_type_pk primary key (TYPE_ID);

insert into td_sm_roletype(type_name,type_desc,type_id) values('ͨ�ý�ɫ����','ͨ�ý�ɫ����','1');
commit;

update td_sm_role set role_type = '1' where role_type is null ;

update TABLEINFO set TABLE_ID_VALUE=100 where TABLE_NAME='td_sm_role'; 

commit; 

--�����Ź���Ա��Ȩ��ά���˵�Ȩ��
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") VALUES ('visible', 'permissionmanager','3' ,'column' ,'0' ,'Ȩ��ά��' ,'role' ,0);
commit;

-- Add/modify columns 
alter table TD_SM_DICATTACHFIELD add DATEFORMAT VARCHAR2(20);
-- Add comments to the columns 
comment on column TD_SM_DICATTACHFIELD.DATEFORMAT is '���ڸ�ʽ���������ֶε�����λ��������ʱ��ָ�����ֶε����ڸ�ʽ';
--Ϊ���Ź���Ա���  ϵͳ�ʺ��޸� �˵�Ȩ��
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") VALUES ('visible', 'sysuserpassword','3' ,'column' ,'0' ,'ϵͳ�˻��޸�' ,'role' ,0);
commit;

update td_sm_dicttype bb set bb.dicttype_name=bb.dicttype_desc where bb.dicttype_name is null or bb.dicttype_name = '';
update td_sm_dicttype bb set bb.dicttype_desc=bb.dicttype_name where bb.dicttype_desc is null or bb.dicttype_desc = '';
commit;       
/*==============================================================*/
/* Table: TD_SP_HOLIDAY                                         */
/*==============================================================*/
create table TD_SP_HOLIDAY  (
   HOLIDAY              VARCHAR(10)                      not null,
   YHOLIDAY             VARCHAR(4),
   MHOLIDAY             VARCHAR(2),
   constraint PK_TD_SP_HOLIDAY primary key (HOLIDAY)
);
comment on table TD_SP_HOLIDAY is '�ڼ������ñ�';
comment on column TD_SP_HOLIDAY.HOLIDAY is '�����������';
comment on column TD_SP_HOLIDAY.YHOLIDAY is '���������������֣�����4λ';
comment on column TD_SP_HOLIDAY.MHOLIDAY is '����ڼ����������·ݣ�����2λ';

-- Add/modify columns 
alter table TD_SM_ORGANIZATION add ISDIRECTLYPARTY      NUMBER(1)                      default 0;
alter table TD_SM_ORGANIZATION add ISFOREIGNPARTY       NUMBER(1)                      default 0;
alter table TD_SM_ORGANIZATION add ISJICHAPARTY         NUMBER(1)                      default 0;
alter table TD_SM_ORGANIZATION add ISDIRECTGUANHU       NUMBER(1)                      default 0;
-- Add comments to the columns 
comment on column TD_SM_ORGANIZATION.ISDIRECTLYPARTY is '�Ƿ�ֱ���� 0-���ǣ�ȱʡֵ 1-��';
comment on column TD_SM_ORGANIZATION.ISFOREIGNPARTY  is '�Ƿ������ 0-�ǣ�ȱʡֵ 1-����';
comment on column TD_SM_ORGANIZATION.ISJICHAPARTY  is '�Ƿ����� 0-���ǣ�ȱʡֵ 1-��';  
comment on column TD_SM_ORGANIZATION.ISDIRECTGUANHU is '�Ƿ�ֱ�ӹܻ���λ 0-���ǣ�ȱʡֵ 1-��';
/*==============================================================*/
/* Table: TD_SM_TAXCODE_ORGANIZATION                            */
/*==============================================================*/
alter table TD_SP_HOLIDAY add  ORG_ID  VARCHAR2(50);
alter table TD_SP_HOLIDAY add constraint FK_TD_SP_HO_REFERENCE_TD_SM_OR foreign key (ORG_ID) references TD_SM_ORGANIZATION (ORG_ID);

comment on column TD_SP_HOLIDAY.ORG_ID is '�ڼ��ն�Ӧ�Ļ���ID';

--�ֵ����ͱ� td_sm_dicttype 
alter table td_sm_dicttype modify (DATA_NAME_CN default '����');
alter table td_sm_dicttype modify (DATA_VALUE_CN default '��ʵֵ');

comment on column  td_sm_dicttype.DATA_NAME_CN is '�ֵ������ֶβɼ�ʱ����������';
comment on column  td_sm_dicttype.DATA_VALUE_CN is 'ֵ�ֶβɼ�ʱ����������';
/*==============================================================*/
/* Database name:  ϵͳ�������ݿ�--�ڼ��չ�������Ѿ���ʼ����      */
/* DBMS name:      ORACLE Version 9i                            */
/* Created on:     2008-2-26 19:31:52                           */
/*==============================================================*/
drop table TD_SM_INITYEAR_HOLIDAY cascade constraints;
/*==============================================================*/
/* Table: TD_SM_INITYEAR_HOLIDAY                                */
/*==============================================================*/
create table TD_SM_INITYEAR_HOLIDAY  (
   ORG_ID               VARCHAR2(50),
   YHOLIDAY             VARCHAR(4)                       not null,
   constraint PK_TD_SM_INITYEAR_HOLIDAY primary key (YHOLIDAY)
);
comment on table TD_SM_INITYEAR_HOLIDAY is 'ϵͳ�������ݿ� �ڼ��չ�������Ѿ���ʼ����';
comment on column TD_SM_INITYEAR_HOLIDAY.ORG_ID is '�ڼ��ն�Ӧ�Ļ���ID';
comment on column TD_SM_INITYEAR_HOLIDAY.YHOLIDAY is '�Ѿ������˽ڼ��յ����, ���Ѿ���ʼ���ڼ��յ����';

--�޸Ľڼ��ձ������ TD_SP_HOLIDAY
alter table TD_SP_HOLIDAY  drop constraint PK_TD_SP_HOLIDAY ;
alter table TD_SP_HOLIDAY add constraint PK_TD_SP_HOLIDAY primary key (HOLIDAY, YHOLIDAY, MHOLIDAY);

delete from td_sm_roleresop where ROLE_ID = '3' and RES_ID = 'purviewmanager' and types='role' and RESTYPE_ID='column';

INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") VALUES ('visible', 'purviewmanager','3' ,'column' ,'0' ,'Ȩ�޹���' ,'role' ,0);
commit;

-- Add/modify columns 
alter table TD_SM_DICATTACHFIELD add SN number(5) default 1;

-- Add comments to the columns 
comment on column TD_SM_DICATTACHFIELD.SN is '�߼��ֶ�����';

commit;

update TD_SM_DICATTACHFIELD set sn=1 where sn is null;

commit;

   --alter table TD_SM_DICTTYPE drop (  
   --NAME_GENERAL_TYPE,
  -- KEY_GENERAL_INFO,   
   --NEEDCACHE            
   --)
--/
alter table TD_SM_DICTTYPE add (
	NAME_GENERAL_TYPE    VARCHAR(100),
	KEY_GENERAL_INFO     VARCHAR(100),   
	NEEDCACHE            NUMBER(1)  default 1
);

alter table TD_SM_DICTTYPE add (
   ENABLE_VALUE_MODIFY  NUMBER(1)                      default 0
);
comment on column TD_SM_DICTTYPE.NAME_GENERAL_TYPE is '�������ɹ��򣬴��ֵ�����������ѡ�񣬸�ʽΪ��inputid:dataformat inputid:dictid:scope inputid:auto: inputid:sequence:seqname inputid:';
comment on column TD_SM_DICTTYPE.KEY_GENERAL_INFO is '�������ɹ��򣬴��ֵ�����������ѡ�񣬸�ʽΪ��inputid:dataformat inputid:dictid:scope inputid:auto: inputid:sequence:seqname inputid:';
comment on column TD_SM_DICTTYPE.NEEDCACHE is '�Ƿ���Ҫ�������� 0-����Ҫ 1-��Ҫ';
comment on column TD_SM_DICTTYPE.ENABLE_VALUE_MODIFY is '�Ƿ������޸��ֵ��ֵ�ֶε�ֵ 0-������Ĭ��ֵ 1-�����޸�';

update TD_SM_DICTTYPE set ENABLE_VALUE_MODIFY='0' where ENABLE_VALUE_MODIFY is null;

commit;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TD_SM_LOGMODULE', 'id', 1, 8, NULL, 'int', NULL);
COMMIT;

--���Ӹ�λ���и�λ�������ֶ�
alter table TD_SM_JOB add OWNER_ID NUMBER DEFAULT 1;
  
update TD_SM_JOB set owner_id = '1' where owner_id is null;

commit;
/*==============================================================*/
/* Table: TD_SM_DICTKEYWORDS                                    */
/*==============================================================*/
create table TD_SM_DICTKEYWORDS  (
   KEYWORD_ID           NUMBER(10)                       not null,
   DICTTYPE_ID           VARCHAR2(50),
   FILED_NAME           VARCHAR2(50),
   JAVA_PROPERTY        VARCHAR2(50),
   constraint PK_TD_SM_DICTKEYWORDS primary key (KEYWORD_ID)
);
comment on column TD_SM_DICTKEYWORDS.KEYWORD_ID is '�ؼ��ֶ�id';
comment on column TD_SM_DICTKEYWORDS.DICTTYPE_ID is '�ֵ�����id';
comment on column TD_SM_DICTKEYWORDS.FILED_NAME is '�ؼ��ֶ����ƣ���Ӧ�ֵ����ֶ�����';
comment on column TD_SM_DICTKEYWORDS.JAVA_PROPERTY is '�ؼ��ֶζ�Ӧ��java��������';

alter table TD_SM_DICTKEYWORDS add constraint FK_TD_DICTKEYWORDS foreign key (DICTTYPE_ID) references TD_SM_DICTTYPE (DICTTYPE_ID);
/*==============================================================*/
/* SEQUENCE: SEQ_DICTKEYWORD �����ֵ�ؼ��ֶ�����sequence       */
/*==============================================================*/
create sequence SEQ_DICTKEYWORD
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

delete from TABLEINFO where TABLE_NAME='TD_SM_DICTKEYWORDS';

--������Ϣ���ɻ���
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TD_SM_DICTKEYWORDS', 'KEYWORD_ID', 1, 0, 'SEQ_DICTKEYWORD', 'sequence', NULL);

COMMIT;

alter table td_sm_user add LOGON_IP         VARCHAR2(15);

CREATE OR REPLACE VIEW V_TB_RES_ROLE_USER
(USER_ID, ROLE_ID, OP_ID, RESTYPE_ID)
AS 
SELECT TO_CHAR (allroles.user_id) AS user_id, roleres_role.res_id AS role_id, 
       roleres_role.op_id AS op_id, roleres_role.restype_id AS restype_id 
  FROM ( 
--һ���û����еĽ�ɫ�Ľ�ɫ��Դ 
--�û���ɫ 
        SELECT u_role.user_id, u_role.role_id 
          FROM td_sm_userrole u_role 
        UNION 
--�û������û���� ��ɫ 
        SELECT u_group.user_id, g_role.role_id 
          FROM td_sm_usergroup u_group JOIN td_sm_grouprole g_role 
               ON u_group.GROUP_ID = g_role.GROUP_ID 
        UNION 
--�û����������Ľ�ɫ 
        SELECT org_user.user_id, org_role.role_id 
          FROM td_sm_userjoborg org_user JOIN td_sm_orgrole org_role 
               ON org_user.org_id = org_role.org_id 
        UNION 
--�û�������λ�Ľ�ɫ 
        SELECT u_job.user_id, org_job_role.role_id 
          FROM td_sm_userjoborg u_job INNER JOIN td_sm_orgjobrole org_job_role 
               ON u_job.job_id = org_job_role.job_id 
             AND u_job.org_id = org_job_role.org_id 
               ) allroles,v_tb_res_role_role roleres_role 
 WHERE roleres_role.role_id = allroles.role_id 
--��ͨ�û���ɫ��Դ��roleofeveryone�� ��ɫidΪ2 
UNION 
SELECT TO_CHAR(u.user_id) AS user_id, 
      roleres_role.res_id AS role_id, 
       roleres_role.op_id AS op_id, roleres_role.restype_id AS restype_id 
  FROM 
  ( 
  SELECT roleres.role_id AS role_id, roleres.res_id AS res_id,r.role_name, 
               roleres.op_id, roleres.restype_id 
          FROM td_sm_roleresop roleres ,td_sm_role r 
         WHERE roleres.TYPES = 'role' 
           --AND roleres.restype_id = 'role' 
           AND roleres.role_id = '2' and roleres.role_id = r.role_id 
)  roleres_role,td_sm_user u 
UNION 
--union ֱ�ӷ�����û�����Դ 
SELECT TO_CHAR (roleres.role_id) AS user_id, roleres.res_id AS role_id, 
       roleres.op_id AS op_id, roleres.restype_id AS restype_id 
  FROM td_sm_roleresop roleres 
 WHERE roleres.TYPES = 'user' AND roleres.restype_id = 'role' 
UNION 
--union ֱ�ӷ�����û���������Դ 
SELECT TO_CHAR (userjoborg.user_id) AS user_id, roleres.res_id AS role_id, 
       roleres.op_id AS op_id, roleres.restype_id AS restype_id 
  FROM td_sm_roleresop roleres JOIN td_sm_userjoborg userjoborg 
       ON userjoborg.org_id = roleres.role_id 
 WHERE roleres.TYPES = 'organization' AND roleres.restype_id = 'role';

--ǿ�ƽ�idΪ4�Ľ�ɫ���Ƹ�Ϊ 

update TD_SM_ROLE set ROLE_NAME='administrator'  ,ROLE_TYPE='1' ,ROLE_DESC='��������Ա��ɫ���˽�ɫ��Ҫ�޸ģ���������Աadmin�Զ�ӵ�б���ɫ��ֻ��admin���Խ�����ɫ���������û�������ɫҲ����Ҫ����Ȩ�ޣ�Ĭ��ӵ��ϵͳ�е�����Ȩ��' where role_id='1';
update TD_SM_ROLE set ROLE_NAME='roleofeveryone'  ,ROLE_TYPE='1' ,ROLE_DESC='ÿ���û���ȱʡӵ�еĽ�ɫ���˽�ɫ���ܱ��޸ģ�Ҳ���ܱ�ɾ��' where role_id='2';
update TD_SM_ROLE set ROLE_NAME='orgmanager'  ,ROLE_TYPE='1' ,ROLE_DESC='���Ź���Ա��ɫ,�˽�ɫ���ܱ��޸ģ�Ҳ���ܱ�ɾ�������в��Ź���Ա�Զ�ӵ�б���ɫ' where role_id='3';
update TD_SM_ROLE set ROLE_NAME='orgmanagerroletemplate'  ,ROLE_TYPE='1' ,ROLE_DESC='���Ź���Ա��ɫģ��,����ɫ���ܱ�ɾ�����޸ģ�����������ͨ�û���ֻ�ܹ���Ȩ���������Ź���Աʱ�Զ�ӵ�б���ɫ��ֻ�г�������Ա���ܸ����Ź���Ա��ɫģ����Ȩ' where role_id='4';

commit;

/*
	���������˳�ʼ��Ϊ1
*/
alter table TD_SM_ORGANIZATION modify CREATOR default 1;

update td_sm_organization set creator='1' where creator is null;

commit;

/*
	��ɫ������Ӵ����˺ʹ��������ֶ�
*/
--alter table TD_SM_ROLETYPE drop column CREATOR_USER_ID;
--commit;
--alter table TD_SM_ROLETYPE drop column CREATOR_ORG_ID;
--commit;

alter table TD_SM_ROLETYPE add creator_user_id varchar2(20) default 1;

comment on column TD_SM_ROLETYPE.creator_user_id is '������ID';

commit;

alter table TD_SM_ROLETYPE add creator_org_id varchar2(20) default 1;

comment on column TD_SM_ROLETYPE.creator_org_id is '��������ID';

commit;

create unique index idx_tableinfo on tableinfo (upper(trim(table_name)));

drop table TD_SM_LOGMODULE cascade constraints;
/*==============================================================*/
/* Table: TD_SM_LOGMODULE                                       */
/*==============================================================*/
create table TD_SM_LOGMODULE  (
   LOGMODULE            VARCHAR2(50),
   STATUS               NUMBER,
   MODULE_DESC          VARCHAR2(50),
   ID                   VARCHAR2(50)                     not null,
   constraint LOGMODULE_ID primary key (ID)
);
comment on column TD_SM_LOGMODULE.LOGMODULE is '��־ģ���ƣ���Ӧ��ҵ��ģ��Ĳ˵�id';
comment on column TD_SM_LOGMODULE.STATUS is '��¼��־״̬��0��¼��־��1����¼��־';
comment on column TD_SM_LOGMODULE.MODULE_DESC is '��־ģ������';
comment on column TD_SM_LOGMODULE.ID is '��־ģ��ID';

drop table TD_SM_LOG cascade constraints;
/*==============================================================*/
/* Table: TD_SM_LOG                                             */
/*==============================================================*/
create table TD_SM_LOG  (
   LOG_ID               NUMBER                           not null,
   LOG_OPERUSER         VARCHAR2(50),
   OP_ORGID             VARCHAR2(50),
   OPER_MODULE          VARCHAR2(200),
   LOG_VISITORIAL       VARCHAR2(200),
   LOG_OPERTIME         DATE,
   LOG_CONTENT          clob,
   REMARK1              VARCHAR2(100),
   OPER_TYPE            NUMBER(1),
   constraint PK_TD_SM_LOG primary key (LOG_ID)
);
comment on column TD_SM_LOG.OP_ORGID is '����Ա��������ID';
comment on column TD_SM_LOG.OPER_MODULE is 'ϵͳ�еĲ��������Ĳ˵�id����һ��';
comment on column TD_SM_LOG.LOG_VISITORIAL is '������Դ��һ��Ϊ����Ա����ip��';
comment on column TD_SM_LOG.LOG_CONTENT is '�������� �������ݸ�ʽ����1�����������͸�ʽ��������������ֵ��Ϊ�������ݡ���ʽ��������1������ֵ1��������2������ֵ2���� ��2�������ݲ����͸�ʽ���Ǽǻ�ID�������ID����XXXX���Ǽǻ����ƣ�XXXXX�����ݵĹؼ�ֵ���������ϸ��Ϣ���һ�£���ע���걨�����У�ƾ֤���ࡢӦ��˰�˰��˰Ŀ�ǹؼ�ֵ��';
comment on column TD_SM_LOG.OPER_TYPE is '�������� 1:���� 2:ɾ�� 3:�޸� 4:����';
/*==============================================================*/
/* Table: TD_SM_LOGDETAIL                                       */
/*==============================================================*/
create table TD_SM_LOGDETAIL  (
   DETAIL_ID            NUMBER(10)                       not null,
   OPER_TABLE           VARCHAR2(50),
   LOG_ID               NUMBER,
   OP_KEY_ID            VARCHAR2(50),
   DETAIL_CONTENT       clob,
   OP_TYPE              NUMBER(1),
   constraint PK_TD_SM_LOGDETAIL primary key (DETAIL_ID)
);
comment on table TD_SM_LOGDETAIL is '��־��ϸ��';
comment on column TD_SM_LOGDETAIL.DETAIL_ID is '��־��ϸ��¼id';
comment on column TD_SM_LOGDETAIL.OPER_TABLE is '��־�����ı�';
comment on column TD_SM_LOGDETAIL.LOG_ID is '��־id';
comment on column TD_SM_LOGDETAIL.OP_KEY_ID is '�����������idֵ';
comment on column TD_SM_LOGDETAIL.DETAIL_CONTENT is '������¼������ϸ��Ϣ����ֶ���1���ֶ�ֵ1���ֶ���2���ֶ�ֵ2��..';
comment on column TD_SM_LOGDETAIL.OP_TYPE is '�������� 1:���� 2:ɾ�� 3:�޸� 4:����';

alter table TD_SM_LOGDETAIL add constraint FK_TD_SM_LOG_DETAIL foreign key (LOG_ID) references TD_SM_LOG (LOG_ID);
/*==============================================================*/
/* Table: TD_SM_LOG_HIS                                         */
/*==============================================================*/
create table TD_SM_LOG_HIS  (
   LOG_ID               NUMBER                           not null,
   LOG_OPERUSER         VARCHAR2(50),
   OP_ORGID             VARCHAR2(50),
   OPER_MODULE          VARCHAR2(200),
   LOG_VISITORIAL       VARCHAR2(200),
   LOG_OPERTIME         DATE,
   LOG_CONTENT          clob,
   REMARK1              VARCHAR2(100),
   OPER_TYPE            NUMBER(1),
   constraint PK_TD_SM_LOG_HIS primary key (LOG_ID)
);
comment on table TD_SM_LOG_HIS is 'ϵͳ��ʷ��־��';
comment on column TD_SM_LOG_HIS.OP_ORGID is '����Ա��������ID';
comment on column TD_SM_LOG_HIS.OPER_MODULE is 'ϵͳ�еĲ��������Ĳ˵�id����һ��';
comment on column TD_SM_LOG_HIS.LOG_VISITORIAL is '������Դ��һ��Ϊ����Ա����ip��';
comment on column TD_SM_LOG_HIS.LOG_CONTENT is '�������� �������ݸ�ʽ����1�����������͸�ʽ��������������ֵ��Ϊ�������ݡ���ʽ��������1������ֵ1��������2������ֵ2���� ��2�������ݲ����͸�ʽ���Ǽǻ�ID�������ID����XXXX���Ǽǻ����ƣ�XXXXX�����ݵĹؼ�ֵ���������ϸ��Ϣ���һ�£��� ע���걨�����У�ƾ֤���ࡢӦ��˰�˰��˰Ŀ�ǹؼ�ֵ��';
comment on column TD_SM_LOG_HIS.OPER_TYPE is '�������� 1:���� 2:ɾ�� 3:�޸� 4:����';
/*==============================================================*/
/* Table: TD_SM_LOGDETAIL_HIS                                   */
/*==============================================================*/
create table TD_SM_LOGDETAIL_HIS  (
   DETAIL_ID            NUMBER(10)                       not null,
   OPER_TABLE           VARCHAR2(50),
   LOG_ID               NUMBER,
   OP_KEY_ID            VARCHAR2(50),
   DETAIL_CONTENT       clob,
   OP_TYPE              NUMBER(1),
   constraint PK_TD_SM_LOGDETAIL_HIS primary key (DETAIL_ID)
);
comment on table TD_SM_LOGDETAIL_HIS is '��־��ʷ��ϸ��';
comment on column TD_SM_LOGDETAIL_HIS.DETAIL_ID is '��־��ϸ��¼id';
comment on column TD_SM_LOGDETAIL_HIS.OPER_TABLE is '��־�����ı�';
comment on column TD_SM_LOGDETAIL_HIS.LOG_ID is '��־id';
comment on column TD_SM_LOGDETAIL_HIS.OP_KEY_ID is '�����������idֵ';
comment on column TD_SM_LOGDETAIL_HIS.DETAIL_CONTENT is '������¼���� ��ϸ��Ϣ����ֶ���1���ֶ�ֵ1���ֶ���2���ֶ�ֵ2��..';
comment on column TD_SM_LOGDETAIL_HIS.OP_TYPE is '�������� 1:���� 2:ɾ�� 3:�޸� 4:����';

alter table TD_SM_LOGDETAIL_HIS add constraint FK_TD_SM_LOG_DETAIL_HIS foreign key (LOG_ID) references TD_SM_LOG_HIS (LOG_ID);

create sequence SEQ_LOG
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(LOG_ID || '')) into maxseq from td_sm_log;
	if(maxseq > 0)
	then
	  for i in 1..maxseq loop
		 --seq_td_sm_organization.nextval;
		 select SEQ_LOG.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

create sequence SEQ_LOG_DETAIL
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(LOG_ID || '')) into maxseq from td_sm_logdetail;
	if(maxseq > 0)
	then
	  for i in 1..maxseq loop
		 --seq_td_sm_organization.nextval;
		 select SEQ_LOG_DETAIL.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

delete from TABLEINFO where upper(TABLE_NAME)='TD_SM_LOGDETAIL';

--������Ϣ���ɻ���
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TD_SM_LOGDETAIL', 'DETAIL_ID', 1, 0, 'SEQ_LOG_DETAIL', 'sequence', NULL);
COMMIT;

delete from TABLEINFO where upper(table_name)=upper('td_sm_log');

--������Ϣ���ɻ���
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TD_SM_LOG', 'LOG_ID', 1, 0, 'SEQ_LOG', 'sequence', NULL);
COMMIT;

---��־���ݴ洢����
--start
CREATE OR REPLACE PROCEDURE log_backup(backup_date IN NUMBER)
--��־���ݣ�backup_date ��ʾ��ǰϵͳʱ���������ǰ��������Ҫ����
 AS
BEGIN
  --������־����
  INSERT INTO TD_SM_LOG_HIS
    SELECT * FROM TD_SM_LOG t where to_char(t.log_opertime,'yyyy-mm-dd') <= to_char(sysdate - backup_date,'yyyy-mm-dd');
  --������־��ϸ��
  INSERT INTO TD_SM_LOGDETAIL_HIS
    SELECT * FROM TD_SM_LOGDETAIL
       where log_id in ( select log_id from TD_SM_LOG t where to_char(t.log_opertime,'yyyy-mm-dd') <= to_char(sysdate - backup_date,'yyyy-mm-dd'));
  --ɾ����־��ϸ��
  DELETE FROM TD_SM_LOGDETAIL
   where log_id in
         (select log_id from TD_SM_LOG t where to_char(t.log_opertime,'yyyy-mm-dd') <= to_char(sysdate - backup_date,'yyyy-mm-dd'));
 --ɾ����־����
  DELETE FROM TD_SM_LOG t where to_char(t.log_opertime,'yyyy-mm-dd') <= to_char(sysdate - backup_date,'yyyy-mm-dd');
  COMMIT;
END;
--end;
   
ALTER TABLE TD_SM_ROLERESOP MODIFY(AUTHORIZATION_STIME  DEFAULT sysdate);

drop table TD_SM_USERJOBORG_HISTORY;

CREATE TABLE TD_SM_USERJOBORG_HISTORY
(
  USER_ID        NUMBER                    NOT NULL,
  JOB_ID         VARCHAR2(50)              NOT NULL,
  job_name       VARCHAR2 (100)            not null,
  ORG_ID         VARCHAR2(50)              NOT NULL,
  org_name       VARCHAR2 (100)            NOT NULL,
  JOB_STARTTIME  DATE,
  JOB_QUASHTIME  DATE,
  JOB_FETTLE     INTEGER
);

----��������
CREATE table V_TB_RES_ORG_USER_WRITE(
	user_id varchar2(50) not null,
	org_id varchar2(100) not null);

----����Ψһ����
create index IDX_ORG_USER_WRITE on V_TB_RES_ORG_USER_WRITE(to_number(user_id),org_id);

INSERT INTO V_TB_RES_ORG_USER_WRITE SELECT user_id, org_id FROM v_tb_res_org_user;
commit;

/**
 * td_sd_notic
 */
CREATE SEQUENCE SEQ_TD_SD_NOTIC
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SD_NOTIC',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sd_notic');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(notic_id || '')) into maxseq from td_sd_notic;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SD_NOTIC.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sd_ratifyadvice
 */
CREATE SEQUENCE SEQ_TD_SD_RATIFYADVICE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SD_RATIFYADVICE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sd_ratifyadvice');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(ratifyadvice_id || '')) into maxseq from td_sd_ratifyadvice;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SD_RATIFYADVICE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sd_schedular
 */
CREATE SEQUENCE SEQ_TD_SD_SCHEDULAR
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SD_SCHEDULAR',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sd_schedular');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(schedular_id || '')) into maxseq from td_sd_schedular;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SD_SCHEDULAR.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sm_dictdata
 */
CREATE SEQUENCE SEQ_TD_SM_DICTDATA
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SM_DICTDATA',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sm_dictdata');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(dictdata_id || '')) into maxseq from td_sm_dictdata;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SM_DICTDATA.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sm_dicttype
 */
CREATE SEQUENCE SEQ_TD_SM_DICTTYPE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SM_DICTTYPE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sm_dicttype');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(dicttype_id || '')) into maxseq from td_sm_dicttype;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SM_DICTTYPE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sm_group
 */
CREATE SEQUENCE SEQ_TD_SM_GROUP
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SM_GROUP',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sm_group');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(group_id || '')) into maxseq from td_sm_group;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SM_GROUP.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sm_job
 */
CREATE SEQUENCE SEQ_TD_SM_JOB
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SM_JOB',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sm_job');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(job_id || '')) into maxseq from td_sm_job;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SM_JOB.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sm_organization
 */
CREATE SEQUENCE SEQ_TD_SM_ORGANIZATION
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SM_ORGANIZATION',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sm_organization');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(org_id || '')) into maxseq from td_sm_organization;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SM_ORGANIZATION.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sm_res
 */
CREATE SEQUENCE SEQ_TD_SM_RES
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SM_RES',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sm_res');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(res_id || '')) into maxseq from td_sm_res;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SM_RES.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sm_role
 */
CREATE SEQUENCE SEQ_TD_SM_ROLE
  START WITH 101
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SM_ROLE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sm_role');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(role_id || '')) into maxseq from td_sm_role;
	if(maxseq > 100)
	then
	  for i in 1..(maxseq-100) loop
		 select SEQ_TD_SM_ROLE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sd_remind
 */
CREATE SEQUENCE SEQ_TD_SD_REMIND
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SD_REMIND',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sd_remind');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(remind_id || '')) into maxseq from td_sd_remind;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SD_REMIND.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sm_user
 */
CREATE SEQUENCE SEQ_TD_SM_USER
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SM_USER',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sm_user');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(user_id || '')) into maxseq from td_sm_user;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SM_USER.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sd_notepaper
 */
CREATE SEQUENCE SEQ_TD_SD_NOTEPAPER
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SD_NOTEPAPER',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sd_notepaper');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(notepaper_id || '')) into maxseq from td_sd_notepaper;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SD_NOTEPAPER.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * td_sm_roletype
 */
CREATE SEQUENCE SEQ_TD_SM_ROLETYPE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SM_ROLETYPE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_sm_roletype');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(type_id || '')) into maxseq from td_sm_roletype;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SM_ROLETYPE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * TD_SM_LOGMODULE
 */
CREATE SEQUENCE SEQ_TD_SM_LOGMODULE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_SM_LOGMODULE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_SM_LOGMODULE');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from TD_SM_LOGMODULE;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_SM_LOGMODULE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * TD_SM_DICTKEYWORDS
 */
DROP SEQUENCE SEQ_DICTKEYWORD;

CREATE SEQUENCE SEQ_DICTKEYWORD
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_DICTKEYWORD',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_SM_DICTKEYWORDS');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(KEYWORD_ID || '')) into maxseq from TD_SM_DICTKEYWORDS;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_DICTKEYWORD.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * TD_SM_LOGDETAIL
 */
DROP SEQUENCE SEQ_LOG_DETAIL;

CREATE SEQUENCE SEQ_LOG_DETAIL
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_LOG_DETAIL',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_SM_LOGDETAIL');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(DETAIL_ID || '')) into maxseq from TD_SM_LOGDETAIL;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_LOG_DETAIL.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

/**
 * TD_SM_LOG
 */
DROP SEQUENCE SEQ_LOG;

CREATE SEQUENCE SEQ_LOG
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_LOG',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_SM_LOG');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(LOG_ID || '')) into maxseq from TD_SM_LOG;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_LOG.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TB_SM_INPUTTYPE', 'INPUT_TYPE_ID', 1, 0, NULL, 'int', NULL);
commit;

/**
 * SEQ_TB_SM_INPUTTYPE
 */
CREATE SEQUENCE SEQ_TB_SM_INPUTTYPE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TB_SM_INPUTTYPE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TB_SM_INPUTTYPE');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(INPUT_TYPE_ID || '')) into maxseq from TB_SM_INPUTTYPE;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TB_SM_INPUTTYPE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

--start
CREATE OR REPLACE PROCEDURE "GENFUNCTIONFOREPP" (USERNAME IN VARCHAR2)
IS
      FUNCSTR VARCHAR2(4000);                  -- �����ű�

BEGIN
  FUNCSTR := 'create or replace function '||USERNAME||'.getUserorginfos(userid varchar2) return varchar2 is
  rs varchar2(4000);
  cursor cur is (
    select distinct bb.*,ROW_NUMBER() over(order by   bb.sn) from(
      select t.org_id,t.remark5,t.org_sn ,1 as sn from td_sm_organization t where t.org_id=(
        select ou.org_id from td_sm_orguser ou where ou.user_id=userid
      )
      union
      select mi.*, 2 as sn from(
        select t.org_id,t.remark5,t.org_sn from td_sm_organization t inner join
        td_sm_userjoborg c on t.org_id= c.org_id inner join td_sm_user b on b.user_id =
        c.user_id where b.user_id = userid group by t.org_id,t.remark5 ,t.org_sn
        minus
        select t.org_id,t.remark5,t.org_sn  from td_sm_organization t where t.org_id=(
          select ou.org_id from td_sm_orguser ou where ou.user_id=userid
        )
      )mi
    ) bb
  );
  cc cur%rowtype;
begin
  rs := null;
  open cur;
  loop
  fetch cur into cc;
  exit when cur%NOTFOUND;
    if nvl(rs,''null'')=''null'' then
        rs := rs || cc.remark5   ;
    else rs := rs || ''��'' ||  cc.remark5   ;
    end if;
 end loop;
 close cur;
end;';

EXECUTE IMMEDIATE FUNCSTR;

FUNCSTR:='create or replace function '||USERNAME||'.getUserjobinfos(userid varchar2,orgid varchar2) return varchar2 is
  rs varchar2(4000);
  cursor cur is (select t.job_name from td_sm_job t inner join td_sm_userjoborg c on t.job_id = c.job_id where c.user_id = userid and c.org_id = orgid group by t.job_name);
  cc cur%rowtype;
begin
  rs := null;
  open cur;
  loop
  fetch cur into cc;
  exit when cur%NOTFOUND;
    if nvl(rs,''null'')=''null'' then
        rs := rs || cc.job_name ;
    else
       rs := rs || ''��'' || cc.job_name ;
    end if;
 end loop;
 close cur;
  return(rs);
end ;';
EXECUTE IMMEDIATE FUNCSTR;

FUNCSTR:='create or replace function '||USERNAME||'.getUserorgjobinfos(userid varchar2) return varchar2 is
  rs varchar2(4000);
  cursor cur is (
    select distinct bb.*,ROW_NUMBER() over(order by   bb.sn) from(
      select t.org_id,t.remark5,t.org_sn ,1 as sn from td_sm_organization t where t.org_id=(
        select ou.org_id from td_sm_orguser ou where ou.user_id=userid
      )
      union
      select mi.*, 2 as sn from(
        select t.org_id,t.remark5,t.org_sn from td_sm_organization t inner join
        td_sm_userjoborg c on t.org_id= c.org_id inner join td_sm_user b on b.user_id =
        c.user_id where b.user_id = userid group by t.org_id,t.remark5 ,t.org_sn
        minus
        select t.org_id,t.remark5,t.org_sn  from td_sm_organization t where t.org_id=(
          select ou.org_id from td_sm_orguser ou where ou.user_id=userid
        )
      )mi
    ) bb
  );
  cc cur%rowtype;
begin
  rs := null;
  open cur;
  loop
  fetch cur into cc;
  exit when cur%NOTFOUND;
    if nvl(rs,''null'')=''null''  then
        rs := rs || cc.remark5 || ''('' || getUserjobinfos(userid,cc.org_id) || '')'';
    else
        rs := rs || ''��'' || cc.remark5 || ''(''|| getUserjobinfos(userid,cc.org_id) || '')'';
    end if;
 end loop;
 close cur;

  return(rs);
end ;';
EXECUTE IMMEDIATE FUNCSTR;

END GENFUNCTIONFOREPP;
--end;

--------ϵͳ����ű�����--------

--------ƽ̨����ű���ʼ--------

-- Create table
create table TB_FORM_CLASS
(
  APP_ID   VARCHAR2(20),
  EC_ID    VARCHAR2(20) not null,
  EC_NAME  VARCHAR2(64) not null,
  EC_UPID  VARCHAR2(20) not null,
  REMARK   VARCHAR2(512),
  OWNER_ID NUMBER default 1,
  EC_SN    NUMBER
);
-- Add comments to the table 
comment on table TB_FORM_CLASS is 'ҵ�����';
-- Add comments to the columns 
comment on column TB_FORM_CLASS.APP_ID is 'Ӧ��ID';
comment on column TB_FORM_CLASS.EC_ID is 'ҵ�������';
comment on column TB_FORM_CLASS.EC_NAME is 'ҵ���������';
comment on column TB_FORM_CLASS.EC_UPID is '�ϼ������';
comment on column TB_FORM_CLASS.REMARK is 'ҵ���������';
comment on column TB_FORM_CLASS.OWNER_ID is '������';
comment on column TB_FORM_CLASS.EC_SN is 'ҵ����������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TB_FORM_CLASS add constraint PK_TB_FORM_CLASS primary key (EC_ID);
commit;

-- Create table
create table TD_SM_SHORTCUTMENU_USER
(
  USER_ID NUMBER,
  MENU_ID VARCHAR2(2000)
);
-- Add comments to the table 
comment on table TD_SM_SHORTCUTMENU_USER is 'Ӧ�����û���ݲ˵�';
-- Add comments to the columns 
comment on column TD_SM_SHORTCUTMENU_USER.USER_ID is '�û�id';
comment on column TD_SM_SHORTCUTMENU_USER.MENU_ID is '�˵�id';
commit;

-- Create table ������ʱ���¼��
create table TB_WORKDATE
(
  BEGIN_DATE       VARCHAR2(20),
  END_DATE         VARCHAR2(20),
  AM_END_TIME      VARCHAR2(10),
  WORK_ID          VARCHAR2(32) not null,
  PM_END_TIME      VARCHAR2(10),
  AM_BEGIN_TIME    VARCHAR2(10),
  PM_BEGIN_TIME    VARCHAR2(10),
  REMARK           VARCHAR2(1000),
  LAST_MODIFY_TIME DATE default sysdate
);
-- Add comments to the columns 
comment on column TB_WORKDATE.BEGIN_DATE is '��ʼ����';
comment on column TB_WORKDATE.END_DATE is '��������';
comment on column TB_WORKDATE.AM_END_TIME is '��������ʱ��';
comment on column TB_WORKDATE.WORK_ID is '����ID';
comment on column TB_WORKDATE.PM_END_TIME is '��������ʱ��';
comment on column TB_WORKDATE.AM_BEGIN_TIME is '����࿪ʼʱ��';
comment on column TB_WORKDATE.PM_BEGIN_TIME is '����࿪ʼʱ��';
comment on column TB_WORKDATE.REMARK is '��ע˵��';
comment on column TB_WORKDATE.LAST_MODIFY_TIME is '����޸�ʱ��';
commit;
--------ƽ̨����ű�����--------

--------ģ����½ű���ʼ--------
-- Create table
create table TD_MODULE_CONFIG_TYPE
(
  MODULE_NAME VARCHAR2(10) not null,
  MODULE_TYPE VARCHAR2(10) not null
);
-- Add comments to the table 
comment on table TD_MODULE_CONFIG_TYPE is 'ģ���������ͱ�';
-- Add comments to the columns 
comment on column TD_MODULE_CONFIG_TYPE.MODULE_NAME is 'ģ����������';
comment on column TD_MODULE_CONFIG_TYPE.MODULE_TYPE is 'ģ������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_MODULE_CONFIG_TYPE add constraint PK_MODULE_TYPE primary key (MODULE_TYPE);
commit;

-- insert table
insert into TD_MODULE_CONFIG_TYPE (MODULE_NAME, MODULE_TYPE) values ('ҵ�����', 'EC_ID');
insert into TD_MODULE_CONFIG_TYPE (MODULE_NAME, MODULE_TYPE) values ('����ID', 'P_ID');
insert into TD_MODULE_CONFIG_TYPE (MODULE_NAME, MODULE_TYPE) values ('��ID', 'DJID');
insert into TD_MODULE_CONFIG_TYPE (MODULE_NAME, MODULE_TYPE) values ('����ID', 'REP_ID');
insert into TD_MODULE_CONFIG_TYPE (MODULE_NAME, MODULE_TYPE) values ('�����ļ�', 'FILE_NAME');
commit;

-- Create table
create table TD_MODULE_CONFIG
(
  MODULE_ID   VARCHAR2(50) not null,
  APP_ID VARCHAR2(20),
  MODULE_TYPE VARCHAR2(10),
  MODULE_DATA VARCHAR2(1000)
);
-- Add comments to the table 
comment on table TD_MODULE_CONFIG is 'ģ�����ñ�';
-- Add comments to the columns 
comment on column TD_MODULE_CONFIG.MODULE_ID is '�˵�ID';
comment on column TD_MODULE_CONFIG.APP_ID is 'Ӧ��ID';
comment on column TD_MODULE_CONFIG.MODULE_TYPE is 'ģ������';
comment on column TD_MODULE_CONFIG.MODULE_DATA is 'ģ���Ӧ����';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_MODULE_CONFIG add constraint FK_MODULE_TYPE foreign key (MODULE_TYPE) references TD_MODULE_CONFIG_TYPE (MODULE_TYPE);
commit;
--------ģ����½ű�����--------

--------����ͬ���ű���ʼ--------
-- Create table
create table TD_SM_SYNNOTE
(
  SYSTYPE_ID VARCHAR2(20) not null,
  OBJTYPE_ID VARCHAR2(20) not null,
  EGP_ID     VARCHAR2(100) not null,
  OUTER_ID   VARCHAR2(100) not null,
  SYNTIME    VARCHAR2(20) not null,
  REMARK1    VARCHAR2(100),
  REMARK2    VARCHAR2(100),
  REMARK3    VARCHAR2(100),
  REMARK4    VARCHAR2(100),
  REMARK5    VARCHAR2(100)
);
-- Add comments to the columns 
comment on column TD_SM_SYNNOTE.SYSTYPE_ID is 'ϵͳ���ͣ�Ŀǰ��ldap,rtx��';
comment on column TD_SM_SYNNOTE.OBJTYPE_ID is '����id';
comment on column TD_SM_SYNNOTE.EGP_ID is 'ƽ̨id';
comment on column TD_SM_SYNNOTE.OUTER_ID is '�ⲿϵͳid';
comment on column TD_SM_SYNNOTE.SYNTIME is 'ͬ��ʱ��';
comment on column TD_SM_SYNNOTE.REMARK1 is '����ID';
comment on column TD_SM_SYNNOTE.REMARK2 is '������';
comment on column TD_SM_SYNNOTE.REMARK3 is '�û�ID';
comment on column TD_SM_SYNNOTE.REMARK4 is '�û���';
comment on column TD_SM_SYNNOTE.REMARK5 is '�����ֶ�';
commit;

-- Create table
create table TD_SM_SYNNOTE_OBJTYPE
(
  OBJTYPE_ID VARCHAR2(20) not null,
  OBJTYPE    VARCHAR2(20)
);
-- Add comments to the columns 
comment on column TD_SM_SYNNOTE_OBJTYPE.OBJTYPE_ID is '��������id';
comment on column TD_SM_SYNNOTE_OBJTYPE.OBJTYPE is '��������';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_SYNNOTE_OBJTYPE add constraint PK_TD_SM_SYNNOTE_OBJTYPE primary key (OBJTYPE_ID);
commit;

insert into TD_SM_SYNNOTE_OBJTYPE (OBJTYPE_ID, OBJTYPE) values ('org', '����');
insert into TD_SM_SYNNOTE_OBJTYPE (OBJTYPE_ID, OBJTYPE) values ('user', '�û�');
insert into TD_SM_SYNNOTE_OBJTYPE (OBJTYPE_ID, OBJTYPE) values ('role', '��ɫ');
insert into TD_SM_SYNNOTE_OBJTYPE (OBJTYPE_ID, OBJTYPE) values ('job', '��λ');
insert into TD_SM_SYNNOTE_OBJTYPE (OBJTYPE_ID, OBJTYPE) values ('group', '�û���');
commit;

-- Create table
create table TD_SM_SYNNOTE_SYSTYPE
(
  SYSTYPE_ID VARCHAR2(20) not null,
  SYSTYPE    VARCHAR2(20)
);
-- Add comments to the columns 
comment on column TD_SM_SYNNOTE_SYSTYPE.SYSTYPE_ID is 'ϵͳ����id';
comment on column TD_SM_SYNNOTE_SYSTYPE.SYSTYPE is 'ϵͳ����';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_SYNNOTE_SYSTYPE add constraint PK_TD_SM_SYNNOTE_SYSTYPE primary key (SYSTYPE_ID);
commit;

insert into TD_SM_SYNNOTE_SYSTYPE (SYSTYPE_ID, SYSTYPE) values ('1', 'RTX');
insert into TD_SM_SYNNOTE_SYSTYPE (SYSTYPE_ID, SYSTYPE) values ('2', 'LDAP');
commit;
--------����ͬ���ű�����--------

-- �������Ź���Ա��ɫ�˵���Դ
-- ��ʢ 2010-1-5
INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") 
VALUES ('visible', 'sysmanager','3' ,'column' ,'0' ,'ϵͳ����' ,'role' ,0);
INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") 
VALUES ('visible', 'dictionarymanager','3' ,'column' ,'0' ,'�ֵ����' ,'role' ,0);
INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") 
VALUES ('visible', 'personuserinfomodify','3' ,'column' ,'0' ,'�����û���Ϣ�޸�' ,'role' ,0);
INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") 
VALUES ('visible', 'personsecretpassword','3' ,'column' ,'0' ,'���������޸�' ,'role' ,0);
commit;

-- �û�������sn�ֶΣ��洢֤��Ψһ��ʶ
-- ��ʢ 2011-1-6
alter table TD_SM_USER add CERT_SN varchar2(50);
comment on column TD_SM_USER.CERT_SN is '֤��key��Ψһ��ʶ';


-- Add/modify columns 
alter table TD_SD_SCHEDULAR add ISREMIND number;
-- Add comments to the columns 
comment on column TD_SD_SCHEDULAR.ISREMIND is '�Ƿ�����';
  
--ɾ���ճ̹�����û������������
-- Drop primary, unique and foreign key constraints 
alter table TD_SD_NOTIC drop constraint EXECUTOR;
alter table TD_SD_NOTIC drop constraint NOTIC_PLANNER;
-- Drop primary, unique and foreign key constraints 
alter table TD_SD_NOTEPAPER drop constraint NOTEPAPERUSER_ID;
-- Drop primary, unique and foreign key constraints 
alter table TD_SD_RATIFYADVICE drop constraint RATIFIER;
-- Drop primary, unique and foreign key constraints s
alter table TD_SD_SCHEDULAR drop constraint EXECUTOR_ID;
alter table TD_SD_SCHEDULAR drop constraint PLANNER_ID;
-- Drop primary, unique and foreign key constraints 
alter table TD_SD_SHARE drop constraint VIEWUSER;

---------------------------�û�����-------------------------
-- ��ʢ 2011-4-10
-- �����û�������ʶ���ͱ�
create table td_sm_userchangeorg_type
(
  change_type  number not null,
  change_name  varchar2(20),
  change_state number default 1
)
;
comment on table td_sm_userchangeorg_type is '�û�������ʶ���ͱ�';
comment on column td_sm_userchangeorg_type.change_type is '��ʶ����';
comment on column td_sm_userchangeorg_type.change_name is '��ʶ����';
comment on column td_sm_userchangeorg_type.change_state is '��ʶ״̬�Ƿ���Ч(0 ����Ч 1����Ч)';

-- ��ʼ���û�������ʶ���ͱ�
insert into td_sm_userchangeorg_type(change_type,change_name,change_state) values(0,'��ְ',1);
insert into td_sm_userchangeorg_type(change_type,change_name,change_state) values(1,'���',1);
commit;

-- �����û�������ʶ��
create table td_sm_userchangeorg_data
(
  id            varchar2(20) not null,
  user_id       varchar2(20) not null,
  org_id        varchar2(50) not null,
  change_type   number not null,
  start_time    date default sysdate,
  end_time      date default sysdate,
  cache_time    date default sysdate,
  cache_type    number default 0,
  end_operation number default 0,
  remark        varchar2(50),
  remark1       varchar2(50),
  remark2       varchar2(50)
)
;
comment on table td_sm_userchangeorg_data is '�û�������ʶ��';
comment on column td_sm_userchangeorg_data.id is '���';
comment on column td_sm_userchangeorg_data.user_id is '�û�ID';
comment on column td_sm_userchangeorg_data.org_id is '����ID';
comment on column td_sm_userchangeorg_data.change_type is '��ʶ����';
comment on column td_sm_userchangeorg_data.start_time is '��ʼʱ��';
comment on column td_sm_userchangeorg_data.end_time is '����ʱ��';
comment on column td_sm_userchangeorg_data.cache_time is '����ʱ��';
comment on column td_sm_userchangeorg_data.cache_type is '����ִ��״̬��0��δִ�� 1����ִ�У�';
comment on column td_sm_userchangeorg_data.end_operation is '����ʱ������0�������� 1���Զ����أ�';
comment on column td_sm_userchangeorg_data.remark is '��ע';
comment on column td_sm_userchangeorg_data.remark1 is '�����ֶ�1';
comment on column td_sm_userchangeorg_data.remark2 is '�����ֶ�2';
alter table td_sm_userchangeorg_data add constraint pk_userchangeorg_data_id primary key (ID);

-- �����û�������ʶ��ʷ��¼��
create table td_sm_userchangeorg_history
(
  id            varchar2(20) not null,
  user_id       varchar2(20) not null,
  org_id        varchar2(50) not null,
  change_type   number not null,
  start_time    date default sysdate,
  end_time      date default sysdate,
  real_end_time date default sysdate,
  cache_time    date default sysdate,
  cache_type    number default 0,
  end_operation number default 0,
  remark        varchar2(50),
  remark1       varchar2(50),
  remark2       varchar2(50)
)
;
comment on table td_sm_userchangeorg_history is '�û�������ʶ��ʷ��¼��';
comment on column td_sm_userchangeorg_history.id is '���';
comment on column td_sm_userchangeorg_history.user_id is '�û�ID';
comment on column td_sm_userchangeorg_history.org_id is '����ID';
comment on column td_sm_userchangeorg_history.change_type is '��ʶ����';
comment on column td_sm_userchangeorg_history.start_time is '��ʼʱ��';
comment on column td_sm_userchangeorg_history.end_time is '����ʱ��';
comment on column td_sm_userchangeorg_history.real_end_time is 'ʵ�ʽ���ʱ��';
comment on column td_sm_userchangeorg_history.cache_time is '����ʱ��';
comment on column td_sm_userchangeorg_data.cache_type is '����ִ��״̬��0��δִ�� 1����ִ�У�';
comment on column td_sm_userchangeorg_history.end_operation is '����ʱ������0�������� 1���Զ����أ�';
comment on column td_sm_userchangeorg_history.remark is '��ע';
comment on column td_sm_userchangeorg_history.remark1 is '�����ֶ�1';
comment on column td_sm_userchangeorg_history.remark2 is '�����ֶ�2';
alter table td_sm_userchangeorg_history add constraint pk_userchangeorg_history_id primary key (ID);

-- �����û�������ʶ��SEQ
create sequence seq_userchangeorg_data
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

-- �����û�������ʶ��ʷ��¼��SEQ
create sequence seq_userchangeorg_history
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

-- ��ʼ���û�������ʶ����û�������ʶ��ʷ��¼����������
delete tableinfo where table_name='td_sm_userchangeorg_data';
delete tableinfo where table_name='td_sm_userchangeorg_history';
insert into tableinfo(table_name,table_id_name,table_id_increment,table_id_value,table_id_generator,table_id_type,table_id_prefix) values('td_sm_userchangeorg_data','id',1,0,'SEQ_USERCHANGEORG_DATA','sequence','');
insert into tableinfo(table_name,table_id_name,table_id_increment,table_id_value,table_id_generator,table_id_type,table_id_prefix) values('td_sm_userchangeorg_history','id',1,0,'SEQ_USERCHANGEORG_HISTORY','sequence','');
commit;

-- �����û����������ʱ���Ȩ�ޱ�
create table TD_SM_USERCHECKORG
(
  TAB_NAME            VARCHAR2(20) not null,
  USER_ID             VARCHAR2(20) not null,
  OP_ID               VARCHAR2(50),
  RES_ID              VARCHAR2(100),
  ROLE_ID             VARCHAR2(50),
  RESTYPE_ID          VARCHAR2(50),
  AUTO                VARCHAR2(50),
  RES_NAME            VARCHAR2(500),
  TYPES               VARCHAR2(50),
  AUTHORIZATION_TYPE  NUMBER default 0,
  USE_COUNT           NUMBER,
  AUTHORIZATION_STIME DATE default sysdate,
  AUTHORIZATION_ETIME DATE,
  USE_COUNTED         NUMBER,
  RESOP_ORIGIN_USERID VARCHAR2(50) default '1',
  GROUP_ID            INTEGER,
  JOB_ID              VARCHAR2(50),
  ORG_ID              VARCHAR2(50),
  SAME_JOB_USER_SN    INTEGER,
  JOB_SN              INTEGER,
  JOB_STARTTIME       DATE,
  JOB_FETTLE          INTEGER
);
comment on table TD_SM_USERCHECKORG is '�û����������ʱ���Ȩ�ޱ�';
comment on column TD_SM_USERCHECKORG.TAB_NAME is '����';
comment on column TD_SM_USERCHECKORG.USER_ID is '�û���';
comment on column TD_SM_USERCHECKORG.OP_ID is '����ID';
comment on column TD_SM_USERCHECKORG.RES_ID is '��ԴID';
comment on column TD_SM_USERCHECKORG.ROLE_ID is '��ɫID';
comment on column TD_SM_USERCHECKORG.RESTYPE_ID is '��Դ����ID';
comment on column TD_SM_USERCHECKORG.AUTO is '��ʶ��Դά����ʽ��0�Զ�ά����1�ֶ�ά��';
comment on column TD_SM_USERCHECKORG.RES_NAME is '��Դ����';
comment on column TD_SM_USERCHECKORG.TYPES is '��Դ���ࣨ�ǽ�ɫ��Դ�����û���Դ��';
comment on column TD_SM_USERCHECKORG.AUTHORIZATION_TYPE is '��Ȩ�ķ�ʽ:0:������Ȩ,1:������Ȩ,2:ʱЧ��Ȩ';
comment on column TD_SM_USERCHECKORG.USE_COUNT is '��Ȩ��ʹ�ô���';
comment on column TD_SM_USERCHECKORG.AUTHORIZATION_STIME is '��Ȩʹ�ÿ�ʼʱ��';
comment on column TD_SM_USERCHECKORG.AUTHORIZATION_ETIME is '��Ȩʹ�ý���ʱ��';
comment on column TD_SM_USERCHECKORG.USE_COUNTED is 'Ȩ����ʹ�ô���';
comment on column TD_SM_USERCHECKORG.RESOP_ORIGIN_USERID is '�����ɫ���û�';
comment on column TD_SM_USERCHECKORG.GROUP_ID is '�û���ID';
comment on column TD_SM_USERCHECKORG.JOB_ID is '��λID';
comment on column TD_SM_USERCHECKORG.ORG_ID is '����ID';
comment on column TD_SM_USERCHECKORG.SAME_JOB_USER_SN is '��λ�û������';
comment on column TD_SM_USERCHECKORG.JOB_SN is '��λ�����';
comment on column TD_SM_USERCHECKORG.JOB_STARTTIME is '��λ���ÿ�ʼʱ��';
comment on column TD_SM_USERCHECKORG.JOB_FETTLE is '��λ״̬';

-- �û����ɫ��ϵ���������
alter table TD_SM_USERROLE add org_id varchar2(50) default '-1' ;
comment on column TD_SM_USERROLE.org_id is '����ID';
alter table TD_SM_USERROLE modify ORG_ID not null;
alter table TD_SM_USERROLE drop constraint PK_TD_SM_USERROLE cascade;
drop index PK_TD_SM_USERROLE;
alter table TD_SM_USERROLE add constraint PK_TD_SM_USERROLE primary key (USER_ID, ROLE_ID, ORG_ID);

-- �û����û����ϵ��������� 
alter table TD_SM_USERGROUP add org_id varchar2(50) default '-1';
comment on column TD_SM_USERGROUP.org_id is '����ID';
alter table TD_SM_USERGROUP modify ORG_ID not null;
alter table TD_SM_USERGROUP drop constraint PK_TD_SM_USERGROUP cascade;
drop index PK_TD_SM_USERGROUP;
alter table TD_SM_USERGROUP add constraint PK_TD_SM_USERGROUP primary key (GROUP_ID, USER_ID, ORG_ID);

-- �û�����Դ��ϵ��������� 
alter table TD_SM_ROLERESOP add org_id varchar2(50) default '-1';
comment on column TD_SM_ROLERESOP.org_id is '����ID';
alter table TD_SM_ROLERESOP modify ORG_ID not null;
alter table TD_SM_ROLERESOP drop constraint PK_TD_SM_ROLERESOP cascade;
alter table TD_SM_ROLERESOP add constraint PK_TD_SM_ROLERESOP primary key (OP_ID, RES_ID, ROLE_ID, RESTYPE_ID, TYPES,ORG_ID);
---------------------------�û�����-------------------------

--------ƽ̨V3.0ϵͳ����ƽ̨����ű�����--------