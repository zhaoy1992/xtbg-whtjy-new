--------平台V3.0系统管理、平台管理脚本开始--------
--------系统管理脚本开始--------
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

COMMENT ON TABLE TABLEINFO IS '表信息维护对象';
COMMENT ON COLUMN TABLEINFO.TABLE_NAME IS '表名称';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_NAME IS '表的主键名称';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_INCREMENT IS '表的主键递增量缺省为1';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_VALUE IS '主键当前值：缺省为0';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_GENERATOR IS '自定义表主键生成机制必需从com.frameworkset.common.poolman.sql.PrimaryKey集成';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_TYPE IS '主键类型（string,int）';
COMMENT ON COLUMN TABLEINFO.TABLE_ID_PREFIX IS '类型为string的主键前缀，可指定可不指定,缺省值为""';

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

COMMENT ON COLUMN TD_SM_JOB.JOB_ID IS '岗位ID';
COMMENT ON COLUMN TD_SM_JOB.JOB_NAME IS '岗位名称';
COMMENT ON COLUMN TD_SM_JOB.JOB_DESC IS '岗位描述';
COMMENT ON COLUMN TD_SM_JOB.JOB_FUNCTION IS '岗位职责';
COMMENT ON COLUMN TD_SM_JOB.JOB_AMOUNT IS '岗位编制人数';
COMMENT ON COLUMN TD_SM_JOB.JOB_NUMBER IS '岗位编号';
COMMENT ON COLUMN TD_SM_JOB.JOB_CONDITION IS '任职条件';
COMMENT ON COLUMN TD_SM_JOB.JOB_RANK IS '岗位级别';

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
comment on column TD_SM_ORGANIZATION.ORG_ID is '机构ID';
comment on column TD_SM_ORGANIZATION.ORG_SN is '机构排序ID';
comment on column TD_SM_ORGANIZATION.ORG_NAME is '机构名称';
comment on column TD_SM_ORGANIZATION.PARENT_ID is '父机构ID';
comment on column TD_SM_ORGANIZATION.PATH is '路径';
comment on column TD_SM_ORGANIZATION.LAYER is '层（阶次）';
comment on column TD_SM_ORGANIZATION.CHILDREN is '子机构';
comment on column TD_SM_ORGANIZATION.CODE is '机构代号';
comment on column TD_SM_ORGANIZATION.JP is '简拼';
comment on column TD_SM_ORGANIZATION.QP is '全拼';
comment on column TD_SM_ORGANIZATION.CREATINGTIME is '创建时间';
comment on column TD_SM_ORGANIZATION.CREATOR is '创建人';
comment on column TD_SM_ORGANIZATION.ORGNUMBER is '机构编号';
comment on column TD_SM_ORGANIZATION.ORGDESC is '机构描述';
comment on column TD_SM_ORGANIZATION.REMARK1 is '备用字段1';
comment on column TD_SM_ORGANIZATION.REMARK2 is '备用字段2';
comment on column TD_SM_ORGANIZATION.REMARK3 is '机构类型';
comment on column TD_SM_ORGANIZATION.REMARK4 is '备用字段4';
comment on column TD_SM_ORGANIZATION.REMARK5 is '机构显现名称';
comment on column TD_SM_ORGANIZATION.CHARGEORGID is '主管机构';
comment on column TD_SM_ORGANIZATION.ISPARTYBUSSINESS is '表示机构是否是业务部门 0-是 1-不是 默认为1';
comment on column TD_SM_ORGANIZATION.ORG_LEVEL is '机构行政级别，1：省级，2：市州级，3：县区级，4：科所级';
comment on column TD_SM_ORGANIZATION.SATRAPJOBID is '主管岗位';
comment on column TD_SM_ORGANIZATION.Org_xzqm is '行政区码';
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
COMMENT ON COLUMN TD_SM_USER.USER_ID IS '用户ID';
COMMENT ON COLUMN TD_SM_USER.USER_SN IS '用户排序号';
COMMENT ON COLUMN TD_SM_USER.USER_NAME IS '用户帐号';
COMMENT ON COLUMN TD_SM_USER.USER_PASSWORD IS '用户密码';
COMMENT ON COLUMN TD_SM_USER.USER_REALNAME IS '用户实名';
COMMENT ON COLUMN TD_SM_USER.USER_PINYIN IS '拼音';
COMMENT ON COLUMN TD_SM_USER.USER_SEX IS '性别';
COMMENT ON COLUMN TD_SM_USER.USER_HOMETEL IS '家庭电话';
COMMENT ON COLUMN TD_SM_USER.USER_WORKTEL IS '公司电话';
COMMENT ON COLUMN TD_SM_USER.USER_WORKNUMBER IS '公司地址';
COMMENT ON COLUMN TD_SM_USER.USER_MOBILETEL1 IS '手机1';
COMMENT ON COLUMN TD_SM_USER.USER_MOBILETEL2 IS '手机2';
COMMENT ON COLUMN TD_SM_USER.USER_FAX IS '传真';
COMMENT ON COLUMN TD_SM_USER.USER_OICQ IS 'OICQ';
COMMENT ON COLUMN TD_SM_USER.USER_BIRTHDAY IS '生日';
COMMENT ON COLUMN TD_SM_USER.USER_EMAIL IS '邮箱';
COMMENT ON COLUMN TD_SM_USER.USER_ADDRESS IS '住址';
COMMENT ON COLUMN TD_SM_USER.USER_POSTALCODE IS '邮编';
COMMENT ON COLUMN TD_SM_USER.USER_IDCARD IS '身份证';
COMMENT ON COLUMN TD_SM_USER.USER_ISVALID IS '是否使用';
COMMENT ON COLUMN TD_SM_USER.USER_REGDATE IS '注册日期';
COMMENT ON COLUMN TD_SM_USER.USER_LOGINCOUNT IS '登陆次数';
COMMENT ON COLUMN TD_SM_USER.USER_TYPE IS '用户类型';
COMMENT ON COLUMN TD_SM_USER.REMARK1 IS '设置是否保密 若是,则各项信息显示***若否 则显示信息';
COMMENT ON COLUMN TD_SM_USER.REMARK2 IS '备用字段2';
COMMENT ON COLUMN TD_SM_USER.REMARK3 IS '备用字段3';
COMMENT ON COLUMN TD_SM_USER.REMARK4 IS '备用字段4';
COMMENT ON COLUMN TD_SM_USER.REMARK5 IS '备用字段5';
COMMENT ON COLUMN TD_SM_USER.PAST_TIME IS '过期时间';
COMMENT ON COLUMN TD_SM_USER.DREDGE_TIME IS '开通时间';
COMMENT ON COLUMN TD_SM_USER.LASTLOGIN_DATE IS '用户最后登陆时间';
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
comment on column TD_SM_ROLERESOP.OP_ID is '操作ID';
comment on column TD_SM_ROLERESOP.RES_ID is '资源ID';
comment on column TD_SM_ROLERESOP.ROLE_ID is '角色ID';
comment on column TD_SM_ROLERESOP.RESTYPE_ID is '资源类型ID';
comment on column TD_SM_ROLERESOP.AUTO is '标识资源维护方式，0自动维护，1手动维护';
comment on column TD_SM_ROLERESOP.RES_NAME is '资源名称';
comment on column TD_SM_ROLERESOP.TYPES is '资源分类（是角色资源还是用户资源）';

--2008/02/25
--资源表 角色ID的类型约束, 防止roleid字段出现null值
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
comment on table TD_SM_ORGJOBROLE is '存放为机构岗位设置的角色信息';
comment on column TD_SM_ORGJOBROLE.ORG_ID is '机构id，与机构表外键关联';
comment on column TD_SM_ORGJOBROLE.JOB_ID is '岗位id，与岗位表主键关联';
comment on column TD_SM_ORGJOBROLE.ROLE_ID is '角色id，与角色表主键关联';

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
COMMENT ON COLUMN TD_SD_SCHEDULAR.SCHEDULAR_ID IS '日程id主键。';
COMMENT ON COLUMN TD_SD_SCHEDULAR.PLANNER_ID IS '日程安排人id，当日程类型type为"他人预约"时表示预约发起人。';
COMMENT ON COLUMN TD_SD_SCHEDULAR.EXECUTOR_ID IS '日程执行人id，当日程类型type为"他人预约"时表示预约人。';
COMMENT ON COLUMN TD_SD_SCHEDULAR.REQUEST_ID IS '请求id，未使用';
COMMENT ON COLUMN TD_SD_SCHEDULAR.TOPIC IS '主题';
COMMENT ON COLUMN TD_SD_SCHEDULAR.BEGINTIME IS '日程开始时间';
COMMENT ON COLUMN TD_SD_SCHEDULAR.TYPE IS '日程类型，有自己安排，他人安排，会议安排，他人预约等。';
COMMENT ON COLUMN TD_SD_SCHEDULAR.ISPUBLICAFFAIR IS '1表示公事,0 表示私事.';
COMMENT ON COLUMN TD_SD_SCHEDULAR.ESSENTIALITY IS '确定重要性，分重要(0)和一般(1)，不重要(2)。';
COMMENT ON COLUMN TD_SD_SCHEDULAR.ISHISTORY IS '1表示历史日程,0表示非历史日程';
COMMENT ON COLUMN TD_SD_SCHEDULAR.ISLEISURE IS '1表示忙,0表示空闲';
COMMENT ON COLUMN TD_SD_SCHEDULAR.STATUS IS '0表示待执行,1表示待安排,2表示待批准,3表示未获批准,4表示拒绝安排,5表示过期日程,6表示历史日程.';
COMMENT ON COLUMN TD_SD_SCHEDULAR.ISOPEN IS '1表示公开,0表示不公开。';
COMMENT ON COLUMN TD_SD_SCHEDULAR.PARTNER IS '当日程类型为他人预约时，表示此类预约日程的所有执行人。';

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
COMMENT ON COLUMN TD_SD_NOTIC.TOPIC IS '通知主题';
COMMENT ON COLUMN TD_SD_NOTIC.SOURCE IS '通知来源，表示该通知时任务，会议或其他类型';
COMMENT ON COLUMN TD_SD_NOTIC.NOTIC_PLANNER_ID IS '通知安排人ID';
COMMENT ON COLUMN TD_SD_NOTIC.NOTIC_ID IS '通知id，主键';
COMMENT ON COLUMN TD_SD_NOTIC.BEGINTIME IS '如果该通表示任务或者会议，则表示任务或会议的开始时间';
COMMENT ON COLUMN TD_SD_NOTIC.ENDTIME IS '如果该通表示任务或者会议，则表示任务或会议的结束时间';
COMMENT ON COLUMN TD_SD_NOTIC.EXECUTOR_ID IS '通知发送人';
COMMENT ON COLUMN TD_SD_NOTIC.STATUS IS '0表示未安排，1表示安排好了';

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
COMMENT ON COLUMN TD_SD_REMIND.TRIGGERTYPE IS 'quartz触发器类型，0表示简单类型，1表示cron触发器类型';
COMMENT ON COLUMN TD_SD_REMIND.CRON_TIME IS 'cron时间格式串，当triggertype为1时有意义';
COMMENT ON COLUMN TD_SD_REMIND.REMIND_BEGIN_TIME IS '提醒开始时间';
COMMENT ON COLUMN TD_SD_REMIND.REMIND_END_TIME IS '提醒结束时间';
COMMENT ON COLUMN TD_SD_REMIND.INTERVAL_TIME IS '提醒间隔';
COMMENT ON COLUMN TD_SD_REMIND.INTERVALTYPE IS '间隔单位，0表示分，1表示小时，2表示天';
COMMENT ON COLUMN TD_SD_REMIND.REMIND_ID IS '主键';
COMMENT ON COLUMN TD_SD_REMIND.ISSYSTEM IS '是否采用系统提醒';
COMMENT ON COLUMN TD_SD_REMIND.ISEMAIL IS '是否采用邮件提醒';
COMMENT ON COLUMN TD_SD_REMIND.ISMESSAGE IS '是否采用短信提醒';
COMMENT ON COLUMN TD_SD_REMIND.SCHEDULAR_ID IS '日程id';

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
COMMENT ON COLUMN TD_SD_RATIFYADVICE.SCHEDULAR_ID IS '日程id';
COMMENT ON COLUMN TD_SD_RATIFYADVICE.RATIFIER_ID IS '批准人id';
COMMENT ON COLUMN TD_SD_RATIFYADVICE.ADVICE IS '批准建议';
COMMENT ON COLUMN TD_SD_RATIFYADVICE.RATIFYADVICE_ID IS '主键';

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
COMMENT ON COLUMN TD_REMINDINFO.TIME IS '提醒时间';
COMMENT ON COLUMN TD_REMINDINFO.TYPE IS '提醒方式即采用何种提醒有系统，短信，邮件三种';
COMMENT ON COLUMN TD_REMINDINFO.SOURCE IS '提醒类型，来源';
COMMENT ON COLUMN TD_REMINDINFO.CONTENT IS '提醒内容';
COMMENT ON COLUMN TD_REMINDINFO.USER_ID IS '提醒对象。';

CREATE UNIQUE INDEX REMIND_PRIMARY ON TD_REMINDINFO (ID);

ALTER TABLE TD_REMINDINFO ADD   CONSTRAINT REMIND_PRIMARY PRIMARY KEY (ID);
ALTER TABLE TD_REMINDINFO ADD   CONSTRAINT REMIND_USER  FOREIGN KEY (USER_ID)  REFERENCES TD_SM_USER (USER_ID);
-----任务委托新增表------------------------------------------------------------------------
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
comment on column TD_SM_LOGMODULE.LOGMODULE is '日志模名称，对应于业务模块的菜单id';
comment on column TD_SM_LOGMODULE.STATUS is '记录日志状态，0记录日志，1不记录日志';
comment on column TD_SM_LOGMODULE.MODULE_DESC is '日志模块描述';
comment on column TD_SM_LOGMODULE.ID is '日志模块ID';
---初始化数据------------------------------------------------------------------------------------------------------------------------
INSERT INTO TD_SM_USER ("USER_ID" ,"USER_SN" ,"USER_NAME" ,"USER_PASSWORD" ,"USER_REALNAME","USER_ISVALID","USER_TYPE",USER_SEX  )   VALUES (1 ,1 ,'admin' ,'123456' ,'系统管理员','2','0','M'  );
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) VALUES ('1' ,'administrator' ,'1' ,'超级管理员角色，此角色不要修改' ,'' ,'' ,'' ,''  );
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) VALUES ('2' ,'roleofeveryone' ,'1' ,'每个用户都缺省拥有的角色，此角色不要修改' ,'' ,'' ,'' ,''  );
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) VALUES ('3' ,'orgmanager' ,'1' ,'部门管理员角色,此角色不要修改' ,'' ,'' ,'' ,''  );
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) VALUES ('4' ,'orgmanagerroletemplate' ,'1' ,'部门管理员角色模板,本角色不能删除，也不能授予普通用户，只能够授权，一旦授了权限后所有的部门管理员都拥有这些权限，部门管理员角色只有超级管理员才能给它授权' ,'' ,'' ,'' ,''  );

INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('add', 'globalrole','3' ,'role' ,'0' , '角色资源', 'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('lisanusermanager', 'orgunit','3' ,'orgunit' ,'0' , '机构资源', 'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('lisanusertoorg', 'orgunit','3' ,'orgunit' ,'0' , '机构资源', 'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('visible', 'org_taxcode','3' ,'column' ,'0' ,'机构授权编码维护' ,'role');
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('visible', 'usualorg_taxcode','3' ,'column' ,'0' ,'机构常用编码维护' ,'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('visible', 'rolemanager','3' ,'column' ,'0' ,'角色管理' ,'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('visible', 'usermanage','3' ,'column' ,'0' ,'用户管理' ,'role' );
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) VALUES ('visible', 'orgmanager','3' ,'column' ,'0' ,'机构管理' ,'role' );

INSERT INTO TD_SM_USERROLE ("USER_ID" ,"ROLE_ID" ) VALUES (1 ,'1'  );

INSERT INTO TD_SM_JOB ("JOB_ID" ,"JOB_NAME" ,"JOB_DESC" ) VALUES ('1' ,'在职' ,'不能删除' )  ; 

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

--视图脚本
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

--用户的所有角色视图
create or replace view v_tb_user_allrole as
select "USER_ID","ROLE_ID"
    from (
--一个用户所有的角色的机构资源
--用户角色
select u_role.user_id, u_role.role_id from td_sm_userrole u_role
union
--用户所在用户组的 角色
select u_group.user_id,g_role.role_id from td_sm_usergroup u_group
join td_sm_grouprole g_role on u_group.group_id=g_role.group_id
union
--用户所属机构的角色
select org_user.user_id,org_role.role_id from td_sm_userjoborg org_user
join td_sm_orgrole org_role on  org_user.org_id=org_role.org_id
union
--用户机构岗位的角色
select u_job.user_id,org_job_role.role_id from td_sm_userjoborg u_job
 inner join td_sm_orgjobrole org_job_role
 on u_job.job_id=org_job_role.job_id and u_job.org_id=org_job_role.org_id);

--获取用户所在的岗位名称,多个岗位以"、"连接, 返回一个串 
--如 job1、job2、job3...
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
       rs := rs || '、' || cc.job_name ;
    end if;
 end loop;
 close cur;
  return(rs);
end ;
--end;

--获取用户所在的机构名称,多个机构以"、"连接, 返回一个串
--如 org1、org2、org3...
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
    else rs := rs || '、' ||  cc.remark5   ;
    end if;
 end loop;
 close cur;
  return(rs);
end ;
--end;

--获取用户所在的机构名称(岗位名称),多个机构以"、"连接, 返回一个串
--如 org1(job1、job2、job3...)、org2(job1、job2、job3...)、org3(job1、job2、job3...)...
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
        rs := rs || '、' || cc.remark5 || '(' || getUserjobinfos(userid,cc.org_id) || ')'; 
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
comment on table TD_SM_ORGMANAGER is '用户机构管理员表';
comment on column TD_SM_ORGMANAGER.USER_ID is '机构管理员id';

alter table TD_SM_ORGMANAGER add constraint FK_TD_SM_ORGMGRUS foreign key (USER_ID) references TD_SM_USER (USER_ID);
alter table TD_SM_ORGMANAGER add constraint FK_TD_SM_MGRORG foreign key (ORG_ID) references TD_SM_ORGANIZATION (ORG_ID);
/*==============================================================*/
/* Database name:  字典管理 初始化脚本                          */
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
comment on table TB_SM_INPUTTYPE is '字典数据项输入类型';

comment on column TB_SM_INPUTTYPE.DATASOURCE_PATH is '数据源选择界面';
comment on column TB_SM_INPUTTYPE.SCRIPT is '输入类型的脚本';
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
comment on column TD_SM_DICATTACHFIELD.DICTTYPE_ID is '字典类型ID';
comment on column TD_SM_DICATTACHFIELD.FIELD_NAME is '存放数据库字段,以及对应的输入类型的附加信息当输入类型: 主键生成, 选择字典 都需要维护这个字段 filedName:'''':''''';
comment on column TD_SM_DICATTACHFIELD.TABLE_COLUMN is '字典字段对应数据库表';
comment on column TD_SM_DICATTACHFIELD.ISNULLABLE is '字段是否必填 0:不是必填 1:必填';

--附加字段表 td_sm_dicattachfield
alter table td_sm_dicattachfield add DATEFORMAT VARCHAR2(50);
alter table td_sm_dicattachfield add ISUNIQUE number(1);

comment on column  td_sm_dicattachfield.DATEFORMAT is '日期类型字段';
comment on column  td_sm_dicattachfield.ISUNIQUE is '字段的值是否唯一性保证  1-唯一,字典维护时需要进行唯一性检测  0-可重复，缺省值';
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
comment on column TD_SM_DICTDATA.DICTDATA_ID is '字典ID';
comment on column TD_SM_DICTDATA.DICTTYPE_ID is '字典类型ID';
comment on column TD_SM_DICTDATA.DICTDATA_NAME is '字典名称';
comment on column TD_SM_DICTDATA.DICTDATA_VALUE is '字典的值';
comment on column TD_SM_DICTDATA.DICTDATA_ORDER is '字典排序数据字段，缺省值为0';
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
comment on column TD_SM_DICTTYPE.DICTTYPE_TYPE is '0:基础字典类型;1:无权限业务字典2:带权限业务字典';
comment on column TD_SM_DICTTYPE.IS_TREE is '判断字典数据项是树状的还是列表型的数据项 0-列表类型，缺省值 1-树状结构，必须指定DATA_PARENT_FIELD字段';
comment on column TD_SM_DICTTYPE.DICTTYPE_ID is '字典类型ID';
comment on column TD_SM_DICTTYPE.USER_ID is '用户ID';
comment on column TD_SM_DICTTYPE.DICTTYPE_NAME is '字典类型名称';
comment on column TD_SM_DICTTYPE.DICTTYPE_DESC is '字典类型描述';
comment on column TD_SM_DICTTYPE.DATA_TABLE_NAME is '字典数据存放表名，缺省为td_sm_dictdata';
comment on column TD_SM_DICTTYPE.DATA_NAME_FILED is '字典数据名称存放字段，缺省为DICTDATA_NAME';
comment on column TD_SM_DICTTYPE.DATA_VALUE_FIELD is '字典数据值存放字段，缺省值为DICTDATA_value';
comment on column TD_SM_DICTTYPE.DATA_ORDER_FIELD is '字典数据排序字段，缺省值为DICTDATA_ORDER';
comment on column TD_SM_DICTTYPE.DATA_DBNAME is '字典表对应的数据库';
comment on column TD_SM_DICTTYPE.DATA_PARENTID_FIELD is '树状结构数据字典中每个数据项对应的父节点字段名称';

--字典类型表 td_sm_dicttype 
alter table td_sm_dicttype add  DATA_NAME_CN VARCHAR2(100) ;
alter table td_sm_dicttype add  DATA_VALUE_CN VARCHAR2(100) ;
alter table td_sm_dicttype add  KEY_GENERAL_TYPE NUMBER(2);
alter table td_sm_dicttype modify (DATA_NAME_CN default '名称');
alter table td_sm_dicttype modify (DATA_VALUE_CN default '真实值');

comment on column  td_sm_dicttype.DATA_NAME_CN is '字典名称字段采集时的中文名称';
comment on column  td_sm_dicttype.DATA_VALUE_CN is '值字段采集时的中文名称';
comment on column  td_sm_dicttype.KEY_GENERAL_TYPE is '0:手工录入;1:自动生成 tableinfo表';
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
comment on table TD_SM_TAXCODE_ORGANIZATION is '税务机关对应的编码数据';

comment on column TD_SM_TAXCODE_ORGANIZATION.ORG_ID is '机构ID';
comment on column TD_SM_TAXCODE_ORGANIZATION.DICTTYPE_ID is '字典类型ID';
comment on column TD_SM_TAXCODE_ORGANIZATION.DATA_VALUE is '数据项的值';
comment on column TD_SM_TAXCODE_ORGANIZATION.OPCODE is '操作类别：可见(read),常用(usual)';
comment on column TD_SM_TAXCODE_ORGANIZATION.DATA_NAME is '数据项名称';

alter table TD_SM_DICATTACHFIELD add constraint FK_TD_SM_DI_REFERENCE_TD_SM_DI foreign key (DICTTYPE_ID) references TD_SM_DICTTYPE (DICTTYPE_ID);
alter table TD_SM_DICATTACHFIELD add constraint FK_FIELD_TYPE foreign key (INPUT_TYPE_ID) references TB_SM_INPUTTYPE (INPUT_TYPE_ID);

alter table TD_SM_DICTDATA add constraint FK_TD_TYPE_DATA foreign key (DICTTYPE_ID) references TD_SM_DICTTYPE (DICTTYPE_ID) not deferrable;

alter table TD_SM_DICTTYPE add constraint FK_TD_SM_DI_REFERENCE_TD_SM_US foreign key (USER_ID) references TD_SM_USER (USER_ID);

alter table TD_SM_TAXCODE_ORGANIZATION add constraint FK_TD_SM_TA_REFERENCE_TD_SM_OR foreign key (ORG_ID) references TD_SM_ORGANIZATION (ORG_ID);
alter table TD_SM_TAXCODE_ORGANIZATION add constraint FK_TD_SM_TA_REFERENCE_TD_SM_DI foreign key (DICTTYPE_ID) references TD_SM_DICTTYPE (DICTTYPE_ID);

--初始化输入类型表
delete tb_sm_inputtype;
commit;
delete TD_SM_DICTDATA;
commit;
delete TD_SM_DICTTYPE;
commit;

insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(1,'文本类型','','',''); 
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(2,'选择字典','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(3,'选择时间','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(4,'主键生成','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(5,'选择机构','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(6,'选择人员','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(7,'当前用户','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(8,'当前机构','','','');
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT) values(9,'当前用户','','','');
commit;

--初始化字典类型表
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('9', 'isPublicAffair', '日程管理是否公事', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('6', 'intervalType', '日程管理提醒时间间隔单位', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('2', 'isvalid', '有效否', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('1', 'sex', '性别', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('5', 'orgType', '机构类型', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('4', 'MailPostfix', '邮箱后缀', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('3', 'userType', '用户类型', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('7', 'essentiality', '日程管理重要性', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ('8', 'isLeisure', '日程管理是否空闲', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT,DICTTYPE_TYPE) VALUES ('45', 'ispartybussiness', '机构是否业务部门', '0', 0); 

delete from TD_SM_DICTDATA where DICTDATA_ID=70;
delete from TD_SM_DICTDATA where DICTDATA_ID=71;
delete from TD_SM_DICTTYPE where DICTTYPE_ID = '2312';
commit;

INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,DICTTYPE_PARENT ) VALUES ('2312', '是否字典', '是否字典', '0');

INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 70, '2312', '是', '1','0');
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 71 , '2312', '否', '0','1');
commit;
 
--初始化字典数据表 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE,DICTDATA_ORDER ) VALUES ('60', '9', '公事', '0', 1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE,DICTDATA_ORDER ) VALUES ('61', '9', '私事', '1', 2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('62', '6', '分', '0',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('63', '6', '小时', '1',2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('64', '6', '天', '2',3); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('65', '7', '重要', '0',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('66', '7', '一般', '1',2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('67', '7', '不重要', '2',3); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('68', '8', '忙', '0',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('69', '8', '空闲', '1',2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('11', '1', '男', 'M',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('12', '1', '女', 'F',2);
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('126', '2', '开通', '2','0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('127', '2', '停用', '3','1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('31', '4', 'kechuang.com', 'kechuang.com',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('32', '4', 'furongwang.com', 'furongwang.com',2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('33', '4', 'china.com', 'china.com',3); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('13', '1', '未知', '-1',3); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('41', '5', '有效', '0',1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('42', '5', '无效', '1',2); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('51', '3', '外部用户', '1','2'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ('53', '3', '系统用户', '0','1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME, DICTDATA_VALUE,DICTDATA_ORDER ) VALUES ('192', '45', '是', '0', 1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME, DICTDATA_VALUE,DICTDATA_ORDER ) VALUES ('193', '45', '否', '1', 2); 

/*==============================================================*/
/* Database name:  系统管理数据库 节假日管理年份已经初始化表       */
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
comment on table TD_SM_INITYEAR_HOLIDAY is '系统管理数据库 节假日管理年份已经初始化表';
comment on column TD_SM_INITYEAR_HOLIDAY.ORG_ID is '节假日对应的机构ID';
comment on column TD_SM_INITYEAR_HOLIDAY.YHOLIDAY is '已经保存了节假日的年份, 即已经初始化节假日的年份';
  
-- alter table   
alter table td_sm_roleresop add AUTHORIZATION_TYPE  NUMBER default 0;
alter table td_sm_roleresop add USE_COUNT           NUMBER;
alter table td_sm_roleresop add AUTHORIZATION_STIME DATE;
alter table td_sm_roleresop add  AUTHORIZATION_ETIME DATE;

-- Add comments to the columns  
comment on column TD_SM_ROLERESOP.AUTHORIZATION_TYPE is '授权的方式:0/null:永久授权,1:计数授权,2:时效授权';
comment on column TD_SM_ROLERESOP.USE_COUNT is '授权可使用次数';
comment on column TD_SM_ROLERESOP.AUTHORIZATION_STIME is '授权开始时间';
comment on column TD_SM_ROLERESOP.AUTHORIZATION_ETIME is '授权结束时间';

--alter table TD_SM_DICTTYPE add DICTTYPE_TYPE       NUMBER(2) default 0
--alter table TD_SM_DICTTYPE add DATA_VALIDATE_FIELD VARCHAR2(50)
--alter table TD_SM_DICTTYPE add DATA_CREATE_ORGID_FIELD VARCHAR2(50) default '1'
--alter table TD_SM_DICTTYPE add KEY_GENERAL_TYPE NUMBER(2) default 0

-- Add comments to the columns 
comment on column TD_SM_DICTTYPE.DICTTYPE_ID is '字典类型ID';
comment on column TD_SM_DICTTYPE.DICTTYPE_NAME is '字典类型名称';
comment on column TD_SM_DICTTYPE.DICTTYPE_DESC is '字典类型描述';
comment on column TD_SM_DICTTYPE.DATA_TABLE_NAME is '字典数据存放表名，缺省为td_sm_dictdata';
comment on column TD_SM_DICTTYPE.DATA_NAME_FILED is '字典数据名称存放字段，缺省为DICTDATA_NAME';
comment on column TD_SM_DICTTYPE.DATA_VALUE_FIELD is '字典数据值存放字段，缺省值为DICTDATA_value';
comment on column TD_SM_DICTTYPE.DATA_ORDER_FIELD is '字典数据排序字段，缺省值为DICTDATA_ORDER';
comment on column TD_SM_DICTTYPE.DATA_TYPEID_FIELD is '字典类型ID字段，缺省值为DICTTYPE_ID';
comment on column TD_SM_DICTTYPE.DATA_PARENTID_FIELD is '数据项父ID';
comment on column TD_SM_DICTTYPE.IS_TREE is '0:不是树形,1:树形';
comment on column TD_SM_DICTTYPE.DICTTYPE_TYPE is '0:基础字典类型;1:无权限业务字典2:带权限业务字典';
comment on column TD_SM_DICTTYPE.DATA_VALIDATE_FIELD is '数据项是否使用的字段';
comment on column TD_SM_DICTTYPE.DATA_CREATE_ORGID_FIELD is '数据项的创建机构ID字段';

--drop table TB_SM_INPUTTYPE cascade constraints

--alter table td_sm_dictdata add dictdata_order number(10) default 0
comment on column TD_SM_DICTDATA.DICTDATA_ORDER is '字典排序号';

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

comment on column TD_SM_USER.ISTAXMANAGER is '是否税管员';
comment on column TD_SM_ROLE.OWNER_ID is '创建人id，默认维系统管理员';
comment on column TD_SM_ROLE.OWNER_ID is '创建人id，默认维系统管理员';

--用户的所有角色视图
create or replace view v_tb_user_allrole as
select "USER_ID","ROLE_ID"
    from (
--一个用户所有的角色的机构资源
--用户角色
select u_role.user_id, u_role.role_id from td_sm_userrole u_role
union
--用户所在用户组的 角色
select u_group.user_id,g_role.role_id from td_sm_usergroup u_group
join td_sm_grouprole g_role on u_group.group_id=g_role.group_id
union
--用户所属机构的角色
select org_user.user_id,org_role.role_id from td_sm_userjoborg org_user
join td_sm_orgrole org_role on  org_user.org_id=org_role.org_id
union
--用户机构岗位的角色
select u_job.user_id,org_job_role.role_id from td_sm_userjoborg u_job
 inner join td_sm_orgjobrole org_job_role
 on u_job.job_id=org_job_role.job_id and u_job.org_id=org_job_role.org_id);

--角色可访问的机构资源视图
create or replace view v_tb_res_org_role as
select roleres.role_id, roleres.res_id as org_id , roleres.op_id,roleres.restype_id, org.parent_id  
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id    
where roleres.types='role' and roleres.restype_id='orgunit';

--用户拥有的角色视图，获取除roleofeveryone之外的所有角色
/* Formatted on 2008/04/15 10:55 (Formatter Plus v4.8.7) */

CREATE OR REPLACE VIEW v_td_sm_user_allrole (user_id, role_id)
AS
   SELECT t.user_id AS user_id, t.role_id AS role_id
     FROM (
           --一个用户所有的角色
           --用户角色
           SELECT u_role.user_id, u_role.role_id
             FROM td_sm_userrole u_role
           UNION
           --用户所在用户组的 角色
           SELECT u_group.user_id, g_role.role_id
             FROM td_sm_usergroup u_group JOIN td_sm_grouprole g_role
                  ON u_group.GROUP_ID = g_role.GROUP_ID
           UNION
           --用户所属机构的角色
           SELECT org_user.user_id, org_role.role_id
             FROM td_sm_userjoborg org_user JOIN td_sm_orgrole org_role
                  ON org_user.org_id = org_role.org_id
           UNION
           --用户机构岗位的角色
           SELECT u_job.user_id, org_job_role.role_id
             FROM td_sm_userjoborg u_job INNER JOIN td_sm_orgjobrole org_job_role
                  ON u_job.job_id = org_job_role.job_id
                AND u_job.org_id = org_job_role.org_id
                  ) t
          INNER JOIN
          td_sm_role r ON r.role_id = t.role_id;

--用户可访问的机构资源视图
CREATE OR REPLACE VIEW V_TB_RES_ORG_USER
(USER_ID, ORG_ID, PARENT_ID, OP_ID, RESTYPE_ID)
AS 
select to_char(allroles.user_id) as user_id,
  orgres_role.org_id as org_id,orgres_role.parent_id as parent_id,
  orgres_role.op_id as op_id,orgres_role.restype_id  as restype_id
from v_td_sm_user_allrole allroles,
--通过角色ID,关联CS资源视图,没有包含【roleofeveryone】
v_tb_res_org_role orgres_role
where  orgres_role.role_id = allroles.role_id
-- 获取 【roleofeveryone】可访问税务机关权限
union
select to_char(u.user_id) as user_id,org_id,parent_id,op_id,restype_id from (
select roleres.res_id as org_id , roleres.op_id,roleres.restype_id, org.parent_id
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id
where roleres.types='role' and roleres.restype_id='orgunit' and roleres.role_id='2') roleres,td_sm_user u
union
--union 直接分配给用户的资源
select to_char(roleres.role_id) as user_id,
       roleres.res_id as org_id,
       org.parent_id as parent_id,
       roleres.op_id as op_id,
       roleres.restype_id  as restype_id
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id
where roleres.types='user' and roleres.restype_id='orgunit'
union
--union 直接分配给用户机构的资源
select to_char(userjoborg.user_id) as user_id,
       roleres.res_id as org_id,
       org.parent_id as parent_id,
       roleres.op_id as op_id,
       roleres.restype_id  as restype_id
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id
    join td_sm_userjoborg userjoborg on  userjoborg.org_id = roleres.role_id
where roleres.types='organization' and roleres.restype_id='orgunit';

--角色可访问的角色资源视图
create or replace view v_tb_res_role_role as
select roleres.role_id as role_id,roleres.res_id as res_id, roleres.op_id,roleres.restype_id
    from td_sm_roleresop roleres
    join td_sm_role role on roleres.res_id=role.role_id
where roleres.types='role' and roleres.restype_id='role';

--用户可访问的角色资源视图
/* Formatted on 2008/03/25 11:32 (Formatter Plus v4.8.7) */
CREATE OR REPLACE VIEW v_tb_res_role_user (user_id, role_id, op_id,
                                           restype_id)
AS
SELECT TO_CHAR (allroles.user_id) AS user_id, roleres_role.res_id AS role_id,
       roleres_role.op_id AS op_id, roleres_role.restype_id AS restype_id
  FROM (
--一个用户所有的角色的角色资源
--用户角色
        SELECT u_role.user_id, u_role.role_id
          FROM td_sm_userrole u_role
        UNION
--用户所在用户组的 角色
        SELECT u_group.user_id, g_role.role_id
          FROM td_sm_usergroup u_group JOIN td_sm_grouprole g_role
               ON u_group.GROUP_ID = g_role.GROUP_ID
        UNION
--用户所属机构的角色
        SELECT org_user.user_id, org_role.role_id
          FROM td_sm_userjoborg org_user JOIN td_sm_orgrole org_role
               ON org_user.org_id = org_role.org_id
        UNION
--用户机构岗位的角色
        SELECT u_job.user_id, org_job_role.role_id
          FROM td_sm_userjoborg u_job INNER JOIN td_sm_orgjobrole org_job_role
               ON u_job.job_id = org_job_role.job_id
             AND u_job.org_id = org_job_role.org_id
               ) allroles,v_tb_res_role_role roleres_role
 WHERE roleres_role.role_id = allroles.role_id
--普通用户角色资源【roleofeveryone】 角色id为2
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
--union 直接分配给用户的资源
SELECT TO_CHAR (roleres.role_id) AS user_id, roleres.res_id AS role_id,
       roleres.op_id AS op_id, roleres.restype_id AS restype_id
  FROM td_sm_roleresop roleres
 WHERE roleres.TYPES = 'user' AND roleres.restype_id = 'role'
UNION
--union 直接分配给用户机构的资源
SELECT TO_CHAR (userjoborg.user_id) AS user_id, roleres.res_id AS role_id,
       roleres.op_id AS op_id, roleres.restype_id AS restype_id
  FROM td_sm_roleresop roleres JOIN td_sm_userjoborg userjoborg
       ON userjoborg.org_id = roleres.role_id
 WHERE roleres.TYPES = 'organization' AND roleres.restype_id = 'role';

---初始化数据------------------------------------------------------------------------------------------------------------------------
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") VALUES ('visible', 'userManageItem','3' ,'column' ,'0' ,'权限维护' ,'role' ,0);
commit;

drop table TD_SM_DICATTACHFIELD cascade constraints;
/*==============================================================*/
/* Table: TD_SM_DICATTACHFIELD          附加字段表               */
/*==============================================================*/
create table TD_SM_DICATTACHFIELD  (
   DICTTYPE_ID          VARCHAR2(50),
   FIELD_NAME           VARCHAR(50),
   LABEL                VARCHAR(100),
   INPUT_TYPE_ID        NUMBER(5),
   TABLE_COLUMN         VARCHAR(50),
   ISNULLABLE           number(1)
);
comment on column TD_SM_DICATTACHFIELD.DICTTYPE_ID is '字典类型ID';

-- Add/modify columns 
-- alter table TD_SM_LOG modify LOG_TYPE VARCHAR2(4000)
alter table TD_SM_ROLE modify (ROLE_DESC varchar2(1024));

comment on column TD_SM_ORGANIZATION.ORG_XZQM is '行政区码';

--alter table TD_SM_ORGANIZATION rename column ORG_CODE to ORG_XZQM
commit;

alter table TD_SM_DICATTACHFIELD add  ISUNIQUE NUMBER(1) ;
alter table TD_SM_DICATTACHFIELD modify (ISUNIQUE default 0);

comment on column  TD_SM_DICATTACHFIELD.ISUNIQUE is '字段的值是否唯一性保证1-唯一,字典维护时需要进行唯一性检测0-可重复，缺省值';

update TD_SM_ROLE set ROLE_NAME='orgmanager' where ROLE_ID='3';
commit;

--单次授权部分脚本
alter table TD_SM_ROLERESOP modify (AUTHORIZATION_TYPE default 0);
comment on column  TD_SM_ROLERESOP.AUTHORIZATION_TYPE is '授权的方式:0:永久授权,1:计数授权,2:时效授权';
comment on column  TD_SM_ROLERESOP.USE_COUNT is '授权可使用次数';
  
alter table TD_SM_ROLERESOP add  USE_COUNTED NUMBER ;

comment on column  TD_SM_ROLERESOP.USE_COUNTED is '权限已使用次数';
comment on column  TD_SM_ROLERESOP.AUTHORIZATION_STIME is '授权使用开始时间';
comment on column  TD_SM_ROLERESOP.AUTHORIZATION_ETIME is '授权使用结束时间';

--资源操作回收脚本
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
comment on table TD_SM_PERMISSION_ORIGINE is 'TD_SM_PERMISSION_ORIGINE信息维护：授权时，首先反查授权人操作的权限的来源，分以下几种：是不是授权人本身的资源，如果是将来源信息存入本表是不是授权人所属机构的资源，如果是将来源信息存入本表是不是授权人拥有的角色的资源，如果是将多个角色信息条记录存入本表取消授权时，到本表中检查被授权人是否将该权限授予其他用户，如果授予则需要取消由被授权人授予该用户的权限，如此递归执行，是否取消权限还需判断被授权人在本表中还有通过其他渠道获得该权限，如果没有则删除权限表中的该条记录，同时删除本表中的相关权限来源信息';
comment on column TD_SM_PERMISSION_ORIGINE.ORIGINE_TYPE is '权限来源类型：user,role,organization';
comment on column TD_SM_PERMISSION_ORIGINE.ORIGINE_ID is '权限来源角色id，根据角色类型确定为：用户id，角色id，机构id';
comment on column TD_SM_PERMISSION_ORIGINE.OP_ID is '操作ID';
comment on column TD_SM_PERMISSION_ORIGINE.RES_ID is '资源ID';
comment on column TD_SM_PERMISSION_ORIGINE.ROLE_ID is '角色ID';
comment on column TD_SM_PERMISSION_ORIGINE.RESTYPE_ID is '资源类型ID';
comment on column TD_SM_PERMISSION_ORIGINE.TYPES is '资源分类（是角色资源还是用户资源）';

--角色回收脚本
--用户角色表
alter table TD_SM_USERROLE add  RESOP_ORIGIN_USERID VARCHAR2(50) ;
alter table TD_SM_USERROLE modify (RESOP_ORIGIN_USERID default '1');

comment on column  TD_SM_USERROLE.RESOP_ORIGIN_USERID is '授予角色的用户';

--用户组角色表
alter table TD_SM_GROUPROLE add  RESOP_ORIGIN_USERID VARCHAR2(50) ;
alter table TD_SM_GROUPROLE modify (RESOP_ORIGIN_USERID default '1');
comment on column  TD_SM_GROUPROLE.RESOP_ORIGIN_USERID is '授予角色的用户';

--机构岗位角色表
alter table TD_SM_ORGJOBROLE add  RESOP_ORIGIN_USERID VARCHAR2(50) ;
alter table TD_SM_ORGJOBROLE modify (RESOP_ORIGIN_USERID default '1');
comment on column  TD_SM_ORGJOBROLE.RESOP_ORIGIN_USERID is '授予角色的用户';
  
  
--机构角色表
alter table TD_SM_ORGROLE add  RESOP_ORIGIN_USERID VARCHAR2(50) ;
alter table TD_SM_ORGROLE modify (RESOP_ORIGIN_USERID default '1');
comment on column  TD_SM_ORGROLE.RESOP_ORIGIN_USERID is '授予角色的用户';

--为角色表添加角色类型字段
comment on column  TD_SM_ROLE.ROLE_TYPE is '角色类型';
/*==============================================================*/
/* Table: TD_SM_ROLETYPE                                        */
/*==============================================================*/
create table TD_SM_ROLETYPE  (
   TYPE_NAME            VARCHAR(100),
   TYPE_DESC            VARCHAR(500),
   TYPE_ID              NUMBER
);
comment on table TD_SM_ROLETYPE is '角色类型信息表';
comment on column TD_SM_ROLETYPE.TYPE_NAME is '角色类型名称';
comment on column TD_SM_ROLETYPE.TYPE_DESC is '角色类型描述';

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_sm_roletype', 'type_id', 1, 0, NULL, 'int', NULL); 
commit;

--设置角色类型表主键
alter table TD_SM_ROLETYPE add constraint role_type_pk primary key (TYPE_ID);

insert into td_sm_roletype(type_name,type_desc,type_id) values('通用角色类型','通用角色类型','1');
commit;

update td_sm_role set role_type = '1' where role_type is null ;

update TABLEINFO set TABLE_ID_VALUE=100 where TABLE_NAME='td_sm_role'; 

commit; 

--给部门管理员加权限维护菜单权限
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") VALUES ('visible', 'permissionmanager','3' ,'column' ,'0' ,'权限维护' ,'role' ,0);
commit;

-- Add/modify columns 
alter table TD_SM_DICATTACHFIELD add DATEFORMAT VARCHAR2(20);
-- Add comments to the columns 
comment on column TD_SM_DICATTACHFIELD.DATEFORMAT is '日期格式，当附加字段的类型位日期类型时，指定本字段的日期格式';
--为部门管理员添加  系统帐号修改 菜单权限
INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") VALUES ('visible', 'sysuserpassword','3' ,'column' ,'0' ,'系统账户修改' ,'role' ,0);
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
comment on table TD_SP_HOLIDAY is '节假日设置表';
comment on column TD_SP_HOLIDAY.HOLIDAY is '保存假日日期';
comment on column TD_SP_HOLIDAY.YHOLIDAY is '保存假日所属的年分，保存4位';
comment on column TD_SP_HOLIDAY.MHOLIDAY is '保存节假日所属的月份，保存2位';

-- Add/modify columns 
alter table TD_SM_ORGANIZATION add ISDIRECTLYPARTY      NUMBER(1)                      default 0;
alter table TD_SM_ORGANIZATION add ISFOREIGNPARTY       NUMBER(1)                      default 0;
alter table TD_SM_ORGANIZATION add ISJICHAPARTY         NUMBER(1)                      default 0;
alter table TD_SM_ORGANIZATION add ISDIRECTGUANHU       NUMBER(1)                      default 0;
-- Add comments to the columns 
comment on column TD_SM_ORGANIZATION.ISDIRECTLYPARTY is '是否直属局 0-不是，缺省值 1-是';
comment on column TD_SM_ORGANIZATION.ISFOREIGNPARTY  is '是否涉外局 0-是，缺省值 1-不是';
comment on column TD_SM_ORGANIZATION.ISJICHAPARTY  is '是否稽查局 0-不是，缺省值 1-是';  
comment on column TD_SM_ORGANIZATION.ISDIRECTGUANHU is '是否直接管户单位 0-不是，缺省值 1-是';
/*==============================================================*/
/* Table: TD_SM_TAXCODE_ORGANIZATION                            */
/*==============================================================*/
alter table TD_SP_HOLIDAY add  ORG_ID  VARCHAR2(50);
alter table TD_SP_HOLIDAY add constraint FK_TD_SP_HO_REFERENCE_TD_SM_OR foreign key (ORG_ID) references TD_SM_ORGANIZATION (ORG_ID);

comment on column TD_SP_HOLIDAY.ORG_ID is '节假日对应的机构ID';

--字典类型表 td_sm_dicttype 
alter table td_sm_dicttype modify (DATA_NAME_CN default '名称');
alter table td_sm_dicttype modify (DATA_VALUE_CN default '真实值');

comment on column  td_sm_dicttype.DATA_NAME_CN is '字典名称字段采集时的中文名称';
comment on column  td_sm_dicttype.DATA_VALUE_CN is '值字段采集时的中文名称';
/*==============================================================*/
/* Database name:  系统管理数据库--节假日管理年份已经初始化表      */
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
comment on table TD_SM_INITYEAR_HOLIDAY is '系统管理数据库 节假日管理年份已经初始化表';
comment on column TD_SM_INITYEAR_HOLIDAY.ORG_ID is '节假日对应的机构ID';
comment on column TD_SM_INITYEAR_HOLIDAY.YHOLIDAY is '已经保存了节假日的年份, 即已经初始化节假日的年份';

--修改节假日表的主键 TD_SP_HOLIDAY
alter table TD_SP_HOLIDAY  drop constraint PK_TD_SP_HOLIDAY ;
alter table TD_SP_HOLIDAY add constraint PK_TD_SP_HOLIDAY primary key (HOLIDAY, YHOLIDAY, MHOLIDAY);

delete from td_sm_roleresop where ROLE_ID = '3' and RES_ID = 'purviewmanager' and types='role' and RESTYPE_ID='column';

INSERT INTO td_sm_roleresop ("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") VALUES ('visible', 'purviewmanager','3' ,'column' ,'0' ,'权限管理' ,'role' ,0);
commit;

-- Add/modify columns 
alter table TD_SM_DICATTACHFIELD add SN number(5) default 1;

-- Add comments to the columns 
comment on column TD_SM_DICATTACHFIELD.SN is '高级字段排序';

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
comment on column TD_SM_DICTTYPE.NAME_GENERAL_TYPE is '名称生成规则，从字典输入类型中选择，格式为：inputid:dataformat inputid:dictid:scope inputid:auto: inputid:sequence:seqname inputid:';
comment on column TD_SM_DICTTYPE.KEY_GENERAL_INFO is '名称生成规则，从字典输入类型中选择，格式为：inputid:dataformat inputid:dictid:scope inputid:auto: inputid:sequence:seqname inputid:';
comment on column TD_SM_DICTTYPE.NEEDCACHE is '是否需要缓冲数据 0-不需要 1-需要';
comment on column TD_SM_DICTTYPE.ENABLE_VALUE_MODIFY is '是否允许修改字典的值字段的值 0-不允许，默认值 1-可以修改';

update TD_SM_DICTTYPE set ENABLE_VALUE_MODIFY='0' where ENABLE_VALUE_MODIFY is null;

commit;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TD_SM_LOGMODULE', 'id', 1, 8, NULL, 'int', NULL);
COMMIT;

--增加岗位表中岗位创建人字段
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
comment on column TD_SM_DICTKEYWORDS.KEYWORD_ID is '关键字段id';
comment on column TD_SM_DICTKEYWORDS.DICTTYPE_ID is '字典类型id';
comment on column TD_SM_DICTKEYWORDS.FILED_NAME is '关键字段名称，对应字典表的字段名称';
comment on column TD_SM_DICTKEYWORDS.JAVA_PROPERTY is '关键字段对应的java属性名称';

alter table TD_SM_DICTKEYWORDS add constraint FK_TD_DICTKEYWORDS foreign key (DICTTYPE_ID) references TD_SM_DICTTYPE (DICTTYPE_ID);
/*==============================================================*/
/* SEQUENCE: SEQ_DICTKEYWORD 定义字典关键字段主键sequence       */
/*==============================================================*/
create sequence SEQ_DICTKEYWORD
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

delete from TABLEINFO where TABLE_NAME='TD_SM_DICTKEYWORDS';

--主键信息生成机制
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TD_SM_DICTKEYWORDS', 'KEYWORD_ID', 1, 0, 'SEQ_DICTKEYWORD', 'sequence', NULL);

COMMIT;

alter table td_sm_user add LOGON_IP         VARCHAR2(15);

CREATE OR REPLACE VIEW V_TB_RES_ROLE_USER
(USER_ID, ROLE_ID, OP_ID, RESTYPE_ID)
AS 
SELECT TO_CHAR (allroles.user_id) AS user_id, roleres_role.res_id AS role_id, 
       roleres_role.op_id AS op_id, roleres_role.restype_id AS restype_id 
  FROM ( 
--一个用户所有的角色的角色资源 
--用户角色 
        SELECT u_role.user_id, u_role.role_id 
          FROM td_sm_userrole u_role 
        UNION 
--用户所在用户组的 角色 
        SELECT u_group.user_id, g_role.role_id 
          FROM td_sm_usergroup u_group JOIN td_sm_grouprole g_role 
               ON u_group.GROUP_ID = g_role.GROUP_ID 
        UNION 
--用户所属机构的角色 
        SELECT org_user.user_id, org_role.role_id 
          FROM td_sm_userjoborg org_user JOIN td_sm_orgrole org_role 
               ON org_user.org_id = org_role.org_id 
        UNION 
--用户机构岗位的角色 
        SELECT u_job.user_id, org_job_role.role_id 
          FROM td_sm_userjoborg u_job INNER JOIN td_sm_orgjobrole org_job_role 
               ON u_job.job_id = org_job_role.job_id 
             AND u_job.org_id = org_job_role.org_id 
               ) allroles,v_tb_res_role_role roleres_role 
 WHERE roleres_role.role_id = allroles.role_id 
--普通用户角色资源【roleofeveryone】 角色id为2 
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
--union 直接分配给用户的资源 
SELECT TO_CHAR (roleres.role_id) AS user_id, roleres.res_id AS role_id, 
       roleres.op_id AS op_id, roleres.restype_id AS restype_id 
  FROM td_sm_roleresop roleres 
 WHERE roleres.TYPES = 'user' AND roleres.restype_id = 'role' 
UNION 
--union 直接分配给用户机构的资源 
SELECT TO_CHAR (userjoborg.user_id) AS user_id, roleres.res_id AS role_id, 
       roleres.op_id AS op_id, roleres.restype_id AS restype_id 
  FROM td_sm_roleresop roleres JOIN td_sm_userjoborg userjoborg 
       ON userjoborg.org_id = roleres.role_id 
 WHERE roleres.TYPES = 'organization' AND roleres.restype_id = 'role';

--强制将id为4的角色名称改为 

update TD_SM_ROLE set ROLE_NAME='administrator'  ,ROLE_TYPE='1' ,ROLE_DESC='超级管理员角色，此角色不要修改，超级管理员admin自动拥有本角色，只有admin可以将本角色授予其他用户，本角色也不需要授予权限，默认拥有系统中的所有权限' where role_id='1';
update TD_SM_ROLE set ROLE_NAME='roleofeveryone'  ,ROLE_TYPE='1' ,ROLE_DESC='每个用户都缺省拥有的角色，此角色不能被修改，也不能被删除' where role_id='2';
update TD_SM_ROLE set ROLE_NAME='orgmanager'  ,ROLE_TYPE='1' ,ROLE_DESC='部门管理员角色,此角色不能被修改，也不能被删除，所有部门管理员自动拥有本角色' where role_id='3';
update TD_SM_ROLE set ROLE_NAME='orgmanagerroletemplate'  ,ROLE_TYPE='1' ,ROLE_DESC='部门管理员角色模板,本角色不能被删除和修改，不能授予普通用户，只能够授权，新增部门管理员时自动拥有本角色，只有超级管理员才能给部门管理员角色模板授权' where role_id='4';

commit;

/*
	机构创建人初始化为1
*/
alter table TD_SM_ORGANIZATION modify CREATOR default 1;

update td_sm_organization set creator='1' where creator is null;

commit;

/*
	角色类别增加创建人和创建机构字段
*/
--alter table TD_SM_ROLETYPE drop column CREATOR_USER_ID;
--commit;
--alter table TD_SM_ROLETYPE drop column CREATOR_ORG_ID;
--commit;

alter table TD_SM_ROLETYPE add creator_user_id varchar2(20) default 1;

comment on column TD_SM_ROLETYPE.creator_user_id is '创建人ID';

commit;

alter table TD_SM_ROLETYPE add creator_org_id varchar2(20) default 1;

comment on column TD_SM_ROLETYPE.creator_org_id is '创建机构ID';

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
comment on column TD_SM_LOGMODULE.LOGMODULE is '日志模名称，对应于业务模块的菜单id';
comment on column TD_SM_LOGMODULE.STATUS is '记录日志状态，0记录日志，1不记录日志';
comment on column TD_SM_LOGMODULE.MODULE_DESC is '日志模块描述';
comment on column TD_SM_LOGMODULE.ID is '日志模块ID';

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
comment on column TD_SM_LOG.OP_ORGID is '操作员所属机构ID';
comment on column TD_SM_LOG.OPER_MODULE is '系统中的操作所属的菜单id保持一致';
comment on column TD_SM_LOG.LOG_VISITORIAL is '操作来源（一般为操作员机器ip）';
comment on column TD_SM_LOG.LOG_CONTENT is '操作内容 操作内容格式：（1）批量操作型格式：将操作的输入值作为操作内容。格式：输入项1：输入值1；输入项2：输入值2…… （2）单数据操作型格式：登记户ID（或身份ID）：XXXX；登记户名称：XXXXX；数据的关键值（风格与详细信息风格一致）。注：申报征收中，凭证种类、应补税额、税种税目是关键值。';
comment on column TD_SM_LOG.OPER_TYPE is '操作类型 1:新增 2:删除 3:修改 4:其他';
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
comment on table TD_SM_LOGDETAIL is '日志明细表';
comment on column TD_SM_LOGDETAIL.DETAIL_ID is '日志明细记录id';
comment on column TD_SM_LOGDETAIL.OPER_TABLE is '日志操作的表';
comment on column TD_SM_LOGDETAIL.LOG_ID is '日志id';
comment on column TD_SM_LOGDETAIL.OP_KEY_ID is '操作表的主键id值';
comment on column TD_SM_LOGDETAIL.DETAIL_CONTENT is '操作记录内容详细信息风格：字段名1：字段值1；字段名2：字段值2…..';
comment on column TD_SM_LOGDETAIL.OP_TYPE is '操作类型 1:新增 2:删除 3:修改 4:其他';

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
comment on table TD_SM_LOG_HIS is '系统历史日志表';
comment on column TD_SM_LOG_HIS.OP_ORGID is '操作员所属机构ID';
comment on column TD_SM_LOG_HIS.OPER_MODULE is '系统中的操作所属的菜单id保持一致';
comment on column TD_SM_LOG_HIS.LOG_VISITORIAL is '操作来源（一般为操作员机器ip）';
comment on column TD_SM_LOG_HIS.LOG_CONTENT is '操作内容 操作内容格式：（1）批量操作型格式：将操作的输入值作为操作内容。格式：输入项1：输入值1；输入项2：输入值2…… （2）单数据操作型格式：登记户ID（或身份ID）：XXXX；登记户名称：XXXXX；数据的关键值（风格与详细信息风格一致）。 注：申报征收中，凭证种类、应补税额、税种税目是关键值。';
comment on column TD_SM_LOG_HIS.OPER_TYPE is '操作类型 1:新增 2:删除 3:修改 4:其他';
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
comment on table TD_SM_LOGDETAIL_HIS is '日志历史明细表';
comment on column TD_SM_LOGDETAIL_HIS.DETAIL_ID is '日志明细记录id';
comment on column TD_SM_LOGDETAIL_HIS.OPER_TABLE is '日志操作的表';
comment on column TD_SM_LOGDETAIL_HIS.LOG_ID is '日志id';
comment on column TD_SM_LOGDETAIL_HIS.OP_KEY_ID is '操作表的主键id值';
comment on column TD_SM_LOGDETAIL_HIS.DETAIL_CONTENT is '操作记录内容 详细信息风格：字段名1：字段值1；字段名2：字段值2…..';
comment on column TD_SM_LOGDETAIL_HIS.OP_TYPE is '操作类型 1:新增 2:删除 3:修改 4:其他';

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

--主键信息生成机制
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TD_SM_LOGDETAIL', 'DETAIL_ID', 1, 0, 'SEQ_LOG_DETAIL', 'sequence', NULL);
COMMIT;

delete from TABLEINFO where upper(table_name)=upper('td_sm_log');

--主键信息生成机制
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TD_SM_LOG', 'LOG_ID', 1, 0, 'SEQ_LOG', 'sequence', NULL);
COMMIT;

---日志备份存储过程
--start
CREATE OR REPLACE PROCEDURE log_backup(backup_date IN NUMBER)
--日志备份，backup_date 表示当前系统时间多少天已前的数据需要备份
 AS
BEGIN
  --备份日志主表
  INSERT INTO TD_SM_LOG_HIS
    SELECT * FROM TD_SM_LOG t where to_char(t.log_opertime,'yyyy-mm-dd') <= to_char(sysdate - backup_date,'yyyy-mm-dd');
  --备份日志明细表
  INSERT INTO TD_SM_LOGDETAIL_HIS
    SELECT * FROM TD_SM_LOGDETAIL
       where log_id in ( select log_id from TD_SM_LOG t where to_char(t.log_opertime,'yyyy-mm-dd') <= to_char(sysdate - backup_date,'yyyy-mm-dd'));
  --删除日志明细表
  DELETE FROM TD_SM_LOGDETAIL
   where log_id in
         (select log_id from TD_SM_LOG t where to_char(t.log_opertime,'yyyy-mm-dd') <= to_char(sysdate - backup_date,'yyyy-mm-dd'));
 --删除日志主表
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

----创建基表
CREATE table V_TB_RES_ORG_USER_WRITE(
	user_id varchar2(50) not null,
	org_id varchar2(100) not null);

----创建唯一索引
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
      FUNCSTR VARCHAR2(4000);                  -- 函数脚本

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
    else rs := rs || ''、'' ||  cc.remark5   ;
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
       rs := rs || ''、'' || cc.job_name ;
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
        rs := rs || ''、'' || cc.remark5 || ''(''|| getUserjobinfos(userid,cc.org_id) || '')'';
    end if;
 end loop;
 close cur;

  return(rs);
end ;';
EXECUTE IMMEDIATE FUNCSTR;

END GENFUNCTIONFOREPP;
--end;

--------系统管理脚本结束--------

--------平台管理脚本开始--------

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
comment on table TB_FORM_CLASS is '业务类别';
-- Add comments to the columns 
comment on column TB_FORM_CLASS.APP_ID is '应用ID';
comment on column TB_FORM_CLASS.EC_ID is '业务类别编号';
comment on column TB_FORM_CLASS.EC_NAME is '业务类别名称';
comment on column TB_FORM_CLASS.EC_UPID is '上级表单编号';
comment on column TB_FORM_CLASS.REMARK is '业务类别描述';
comment on column TB_FORM_CLASS.OWNER_ID is '创建人';
comment on column TB_FORM_CLASS.EC_SN is '业务类别排序号';
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
comment on table TD_SM_SHORTCUTMENU_USER is '应用下用户快捷菜单';
-- Add comments to the columns 
comment on column TD_SM_SHORTCUTMENU_USER.USER_ID is '用户id';
comment on column TD_SM_SHORTCUTMENU_USER.MENU_ID is '菜单id';
commit;

-- Create table 工作日时间记录表
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
comment on column TB_WORKDATE.BEGIN_DATE is '起始日期';
comment on column TB_WORKDATE.END_DATE is '结束日期';
comment on column TB_WORKDATE.AM_END_TIME is '上午班结束时间';
comment on column TB_WORKDATE.WORK_ID is '主键ID';
comment on column TB_WORKDATE.PM_END_TIME is '下午班结束时间';
comment on column TB_WORKDATE.AM_BEGIN_TIME is '上午班开始时间';
comment on column TB_WORKDATE.PM_BEGIN_TIME is '下午班开始时间';
comment on column TB_WORKDATE.REMARK is '备注说明';
comment on column TB_WORKDATE.LAST_MODIFY_TIME is '最后修改时间';
commit;
--------平台管理脚本结束--------

--------模块更新脚本开始--------
-- Create table
create table TD_MODULE_CONFIG_TYPE
(
  MODULE_NAME VARCHAR2(10) not null,
  MODULE_TYPE VARCHAR2(10) not null
);
-- Add comments to the table 
comment on table TD_MODULE_CONFIG_TYPE is '模块配置类型表';
-- Add comments to the columns 
comment on column TD_MODULE_CONFIG_TYPE.MODULE_NAME is '模块类型名称';
comment on column TD_MODULE_CONFIG_TYPE.MODULE_TYPE is '模块类型';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_MODULE_CONFIG_TYPE add constraint PK_MODULE_TYPE primary key (MODULE_TYPE);
commit;

-- insert table
insert into TD_MODULE_CONFIG_TYPE (MODULE_NAME, MODULE_TYPE) values ('业务类别', 'EC_ID');
insert into TD_MODULE_CONFIG_TYPE (MODULE_NAME, MODULE_TYPE) values ('流程ID', 'P_ID');
insert into TD_MODULE_CONFIG_TYPE (MODULE_NAME, MODULE_TYPE) values ('表单ID', 'DJID');
insert into TD_MODULE_CONFIG_TYPE (MODULE_NAME, MODULE_TYPE) values ('报表ID', 'REP_ID');
insert into TD_MODULE_CONFIG_TYPE (MODULE_NAME, MODULE_TYPE) values ('其它文件', 'FILE_NAME');
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
comment on table TD_MODULE_CONFIG is '模块配置表';
-- Add comments to the columns 
comment on column TD_MODULE_CONFIG.MODULE_ID is '菜单ID';
comment on column TD_MODULE_CONFIG.APP_ID is '应用ID';
comment on column TD_MODULE_CONFIG.MODULE_TYPE is '模块类型';
comment on column TD_MODULE_CONFIG.MODULE_DATA is '模块对应数据';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_MODULE_CONFIG add constraint FK_MODULE_TYPE foreign key (MODULE_TYPE) references TD_MODULE_CONFIG_TYPE (MODULE_TYPE);
commit;
--------模块更新脚本结束--------

--------数据同步脚本开始--------
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
comment on column TD_SM_SYNNOTE.SYSTYPE_ID is '系统类型（目前是ldap,rtx）';
comment on column TD_SM_SYNNOTE.OBJTYPE_ID is '对象id';
comment on column TD_SM_SYNNOTE.EGP_ID is '平台id';
comment on column TD_SM_SYNNOTE.OUTER_ID is '外部系统id';
comment on column TD_SM_SYNNOTE.SYNTIME is '同步时间';
comment on column TD_SM_SYNNOTE.REMARK1 is '机构ID';
comment on column TD_SM_SYNNOTE.REMARK2 is '机构名';
comment on column TD_SM_SYNNOTE.REMARK3 is '用户ID';
comment on column TD_SM_SYNNOTE.REMARK4 is '用户名';
comment on column TD_SM_SYNNOTE.REMARK5 is '备用字段';
commit;

-- Create table
create table TD_SM_SYNNOTE_OBJTYPE
(
  OBJTYPE_ID VARCHAR2(20) not null,
  OBJTYPE    VARCHAR2(20)
);
-- Add comments to the columns 
comment on column TD_SM_SYNNOTE_OBJTYPE.OBJTYPE_ID is '对象类型id';
comment on column TD_SM_SYNNOTE_OBJTYPE.OBJTYPE is '对象类型';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_SYNNOTE_OBJTYPE add constraint PK_TD_SM_SYNNOTE_OBJTYPE primary key (OBJTYPE_ID);
commit;

insert into TD_SM_SYNNOTE_OBJTYPE (OBJTYPE_ID, OBJTYPE) values ('org', '机构');
insert into TD_SM_SYNNOTE_OBJTYPE (OBJTYPE_ID, OBJTYPE) values ('user', '用户');
insert into TD_SM_SYNNOTE_OBJTYPE (OBJTYPE_ID, OBJTYPE) values ('role', '角色');
insert into TD_SM_SYNNOTE_OBJTYPE (OBJTYPE_ID, OBJTYPE) values ('job', '岗位');
insert into TD_SM_SYNNOTE_OBJTYPE (OBJTYPE_ID, OBJTYPE) values ('group', '用户组');
commit;

-- Create table
create table TD_SM_SYNNOTE_SYSTYPE
(
  SYSTYPE_ID VARCHAR2(20) not null,
  SYSTYPE    VARCHAR2(20)
);
-- Add comments to the columns 
comment on column TD_SM_SYNNOTE_SYSTYPE.SYSTYPE_ID is '系统类型id';
comment on column TD_SM_SYNNOTE_SYSTYPE.SYSTYPE is '系统类型';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_SYNNOTE_SYSTYPE add constraint PK_TD_SM_SYNNOTE_SYSTYPE primary key (SYSTYPE_ID);
commit;

insert into TD_SM_SYNNOTE_SYSTYPE (SYSTYPE_ID, SYSTYPE) values ('1', 'RTX');
insert into TD_SM_SYNNOTE_SYSTYPE (SYSTYPE_ID, SYSTYPE) values ('2', 'LDAP');
commit;
--------数据同步脚本结束--------

-- 新增部门管理员角色菜单资源
-- 彭盛 2010-1-5
INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") 
VALUES ('visible', 'sysmanager','3' ,'column' ,'0' ,'系统管理' ,'role' ,0);
INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") 
VALUES ('visible', 'dictionarymanager','3' ,'column' ,'0' ,'字典管理' ,'role' ,0);
INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") 
VALUES ('visible', 'personuserinfomodify','3' ,'column' ,'0' ,'个人用户信息修改' ,'role' ,0);
INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ,"AUTHORIZATION_TYPE") 
VALUES ('visible', 'personsecretpassword','3' ,'column' ,'0' ,'个人密码修改' ,'role' ,0);
commit;

-- 用户表新增sn字段，存储证书唯一标识
-- 彭盛 2011-1-6
alter table TD_SM_USER add CERT_SN varchar2(50);
comment on column TD_SM_USER.CERT_SN is '证书key的唯一标识';


-- Add/modify columns 
alter table TD_SD_SCHEDULAR add ISREMIND number;
-- Add comments to the columns 
comment on column TD_SD_SCHEDULAR.ISREMIND is '是否提醒';
  
--删除日程管理的用户表外键关联，
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

---------------------------用户调动-------------------------
-- 彭盛 2011-4-10
-- 新增用户调动标识类型表
create table td_sm_userchangeorg_type
(
  change_type  number not null,
  change_name  varchar2(20),
  change_state number default 1
)
;
comment on table td_sm_userchangeorg_type is '用户调动标识类型表';
comment on column td_sm_userchangeorg_type.change_type is '标识类型';
comment on column td_sm_userchangeorg_type.change_name is '标识名称';
comment on column td_sm_userchangeorg_type.change_state is '标识状态是否有效(0 ：无效 1：有效)';

-- 初始化用户调动标识类型表
insert into td_sm_userchangeorg_type(change_type,change_name,change_state) values(0,'兼职',1);
insert into td_sm_userchangeorg_type(change_type,change_name,change_state) values(1,'借调',1);
commit;

-- 新增用户调动标识表
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
comment on table td_sm_userchangeorg_data is '用户调动标识表';
comment on column td_sm_userchangeorg_data.id is '序号';
comment on column td_sm_userchangeorg_data.user_id is '用户ID';
comment on column td_sm_userchangeorg_data.org_id is '机构ID';
comment on column td_sm_userchangeorg_data.change_type is '标识类型';
comment on column td_sm_userchangeorg_data.start_time is '开始时间';
comment on column td_sm_userchangeorg_data.end_time is '结束时间';
comment on column td_sm_userchangeorg_data.cache_time is '缓冲时间';
comment on column td_sm_userchangeorg_data.cache_type is '缓冲执行状态（0：未执行 1：已执行）';
comment on column td_sm_userchangeorg_data.end_operation is '结束时操作（0：仅提醒 1：自动调回）';
comment on column td_sm_userchangeorg_data.remark is '备注';
comment on column td_sm_userchangeorg_data.remark1 is '备用字段1';
comment on column td_sm_userchangeorg_data.remark2 is '备用字段2';
alter table td_sm_userchangeorg_data add constraint pk_userchangeorg_data_id primary key (ID);

-- 新增用户调动标识历史记录表
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
comment on table td_sm_userchangeorg_history is '用户调动标识历史记录表';
comment on column td_sm_userchangeorg_history.id is '序号';
comment on column td_sm_userchangeorg_history.user_id is '用户ID';
comment on column td_sm_userchangeorg_history.org_id is '机构ID';
comment on column td_sm_userchangeorg_history.change_type is '标识类型';
comment on column td_sm_userchangeorg_history.start_time is '开始时间';
comment on column td_sm_userchangeorg_history.end_time is '结束时间';
comment on column td_sm_userchangeorg_history.real_end_time is '实际结束时间';
comment on column td_sm_userchangeorg_history.cache_time is '缓冲时间';
comment on column td_sm_userchangeorg_data.cache_type is '缓冲执行状态（0：未执行 1：已执行）';
comment on column td_sm_userchangeorg_history.end_operation is '结束时操作（0：仅提醒 1：自动调回）';
comment on column td_sm_userchangeorg_history.remark is '备注';
comment on column td_sm_userchangeorg_history.remark1 is '备用字段1';
comment on column td_sm_userchangeorg_history.remark2 is '备用字段2';
alter table td_sm_userchangeorg_history add constraint pk_userchangeorg_history_id primary key (ID);

-- 新增用户调动标识表SEQ
create sequence seq_userchangeorg_data
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

-- 新增用户调动标识历史记录表SEQ
create sequence seq_userchangeorg_history
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;

-- 初始化用户调动标识表和用户调动标识历史记录表主键生成
delete tableinfo where table_name='td_sm_userchangeorg_data';
delete tableinfo where table_name='td_sm_userchangeorg_history';
insert into tableinfo(table_name,table_id_name,table_id_increment,table_id_value,table_id_generator,table_id_type,table_id_prefix) values('td_sm_userchangeorg_data','id',1,0,'SEQ_USERCHANGEORG_DATA','sequence','');
insert into tableinfo(table_name,table_id_name,table_id_increment,table_id_value,table_id_generator,table_id_type,table_id_prefix) values('td_sm_userchangeorg_history','id',1,0,'SEQ_USERCHANGEORG_HISTORY','sequence','');
commit;

-- 新增用户借调机构临时存放权限表
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
comment on table TD_SM_USERCHECKORG is '用户借调机构临时存放权限表';
comment on column TD_SM_USERCHECKORG.TAB_NAME is '表名';
comment on column TD_SM_USERCHECKORG.USER_ID is '用户名';
comment on column TD_SM_USERCHECKORG.OP_ID is '操作ID';
comment on column TD_SM_USERCHECKORG.RES_ID is '资源ID';
comment on column TD_SM_USERCHECKORG.ROLE_ID is '角色ID';
comment on column TD_SM_USERCHECKORG.RESTYPE_ID is '资源类型ID';
comment on column TD_SM_USERCHECKORG.AUTO is '标识资源维护方式，0自动维护，1手动维护';
comment on column TD_SM_USERCHECKORG.RES_NAME is '资源名称';
comment on column TD_SM_USERCHECKORG.TYPES is '资源分类（是角色资源还是用户资源）';
comment on column TD_SM_USERCHECKORG.AUTHORIZATION_TYPE is '授权的方式:0:永久授权,1:计数授权,2:时效授权';
comment on column TD_SM_USERCHECKORG.USE_COUNT is '授权可使用次数';
comment on column TD_SM_USERCHECKORG.AUTHORIZATION_STIME is '授权使用开始时间';
comment on column TD_SM_USERCHECKORG.AUTHORIZATION_ETIME is '授权使用结束时间';
comment on column TD_SM_USERCHECKORG.USE_COUNTED is '权限已使用次数';
comment on column TD_SM_USERCHECKORG.RESOP_ORIGIN_USERID is '授予角色的用户';
comment on column TD_SM_USERCHECKORG.GROUP_ID is '用户组ID';
comment on column TD_SM_USERCHECKORG.JOB_ID is '岗位ID';
comment on column TD_SM_USERCHECKORG.ORG_ID is '机构ID';
comment on column TD_SM_USERCHECKORG.SAME_JOB_USER_SN is '岗位用户排序号';
comment on column TD_SM_USERCHECKORG.JOB_SN is '岗位排序号';
comment on column TD_SM_USERCHECKORG.JOB_STARTTIME is '岗位设置开始时间';
comment on column TD_SM_USERCHECKORG.JOB_FETTLE is '岗位状态';

-- 用户与角色关系表关联机构
alter table TD_SM_USERROLE add org_id varchar2(50) default '-1' ;
comment on column TD_SM_USERROLE.org_id is '机构ID';
alter table TD_SM_USERROLE modify ORG_ID not null;
alter table TD_SM_USERROLE drop constraint PK_TD_SM_USERROLE cascade;
drop index PK_TD_SM_USERROLE;
alter table TD_SM_USERROLE add constraint PK_TD_SM_USERROLE primary key (USER_ID, ROLE_ID, ORG_ID);

-- 用户与用户组关系表关联机构 
alter table TD_SM_USERGROUP add org_id varchar2(50) default '-1';
comment on column TD_SM_USERGROUP.org_id is '机构ID';
alter table TD_SM_USERGROUP modify ORG_ID not null;
alter table TD_SM_USERGROUP drop constraint PK_TD_SM_USERGROUP cascade;
drop index PK_TD_SM_USERGROUP;
alter table TD_SM_USERGROUP add constraint PK_TD_SM_USERGROUP primary key (GROUP_ID, USER_ID, ORG_ID);

-- 用户与资源关系表关联机构 
alter table TD_SM_ROLERESOP add org_id varchar2(50) default '-1';
comment on column TD_SM_ROLERESOP.org_id is '机构ID';
alter table TD_SM_ROLERESOP modify ORG_ID not null;
alter table TD_SM_ROLERESOP drop constraint PK_TD_SM_ROLERESOP cascade;
alter table TD_SM_ROLERESOP add constraint PK_TD_SM_ROLERESOP primary key (OP_ID, RES_ID, ROLE_ID, RESTYPE_ID, TYPES,ORG_ID);
---------------------------用户调动-------------------------

--------平台V3.0系统管理、平台管理脚本结束--------