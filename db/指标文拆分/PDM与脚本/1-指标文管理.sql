ALTER TABLE OA_SPLIT_LOG
   DROP CONSTRAINT FK_OA_SPLIT_REFERENCE_OA_SPLIT;

DROP TABLE OA_SPLIT_UNIT CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_SPLIT_UNIT                                         */
/*==============================================================*/
CREATE TABLE OA_SPLIT_UNIT 
(
   UNIT_ID              VARCHAR2(40)         NOT NULL,
   PARENT_ID            VARCHAR2(40),
   UNIT_NAME            VARCHAR2(200),
   REMARK               VARCHAR2(400),
   IS_VALID             VARCHAR2(1),
   GWCS_ORG_ID          VARCHAR2(40),
   CONSTRAINT PK_OA_SPLIT_UNIT PRIMARY KEY (UNIT_ID)
);


COMMENT ON TABLE OA_SPLIT_UNIT IS
'文件拆分单位维护';

COMMENT ON COLUMN OA_SPLIT_UNIT.UNIT_ID IS
'拆分单位ID';

COMMENT ON COLUMN OA_SPLIT_UNIT.PARENT_ID IS
'上级ID';

COMMENT ON COLUMN OA_SPLIT_UNIT.UNIT_NAME IS
'拆分单位名称';

COMMENT ON COLUMN OA_SPLIT_UNIT.REMARK IS
'备注';

COMMENT ON COLUMN OA_SPLIT_UNIT.IS_VALID IS
'是否有效';

COMMENT ON COLUMN OA_SPLIT_UNIT.GWCS_ORG_ID IS
'公文传输单位id，这个和公文传输对接';



alter table OA_BUDGET_ATTACHMENT
   drop constraint FK_OA_BUDGE_REFERENCE_OA_BUDGE;

drop table OA_BUDGET_ATTACHMENT cascade constraints;

/*==============================================================*/
/* Table: OA_BUDGET_ATTACHMENT                                  */
/*==============================================================*/
create table OA_BUDGET_ATTACHMENT 
(
   ID                   VARCHAR2(40),
   FILE_NAME            VARCHAR2(200)        not null,
   SHOWN_NAME           VARCHAR2(200)        not null,
   FILE_PATH            VARCHAR2(150)        not null,
   FILE_SIZE            NUMBER,
   constraint PK_OA_BUDGET_ATTACHMENT primary key (FILE_NAME)
);

comment on table OA_BUDGET_ATTACHMENT is
'指标文附件';

comment on column OA_BUDGET_ATTACHMENT.ID is
'ID';

comment on column OA_BUDGET_ATTACHMENT.FILE_NAME is
'文件名';

comment on column OA_BUDGET_ATTACHMENT.SHOWN_NAME is
'文件显示名';

comment on column OA_BUDGET_ATTACHMENT.FILE_PATH is
'文件地址';

comment on column OA_BUDGET_ATTACHMENT.FILE_SIZE is
'(单位：字节)';




alter table OA_BUDGET_ATTACHMENT
   drop constraint FK_OA_BUDGE_REFERENCE_OA_BUDGE;

alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_OA_BUDGE;

alter table OA_BUDGET_FILE
   drop constraint FK_OA_BUDGE_REFERENCE_TD_SM_OR;

alter table OA_BUDGET_FILE
   drop constraint FK_OA_BUDGE_REFERENCE_TD_SM_US;

drop table OA_BUDGET_FILE cascade constraints;

/*==============================================================*/
/* Table: OA_BUDGET_FILE                                        */
/*==============================================================*/
create table OA_BUDGET_FILE 
(
   ID                   VARCHAR2(40)         not null,
   FILE_CODE            VARCHAR2(200),
   bus_id               VARCHAR2(40)         not null,
   FILE_NAME            VARCHAR2(200),
   AMOUNT               NUMBER(18,2),
   BRANCH_ID            VARCHAR2(40)         not null,
   USER_ID              VARCHAR2(40)         not null,
   OP_DATE              DATE                 default sysdate not null,
   STATUS               VARCHAR2(1)          default '0' not null,
   constraint PK_OA_BUDGET_FILE primary key (ID),
   constraint AK_KEY_2_OA_BUDGE unique (FILE_CODE)
);

comment on table OA_BUDGET_FILE is
'指标文总信息';

comment on column OA_BUDGET_FILE.ID is
'ID';

comment on column OA_BUDGET_FILE.FILE_CODE is
'文号';

comment on column OA_BUDGET_FILE.bus_id is
'流程实例id';

comment on column OA_BUDGET_FILE.FILE_NAME is
'名称';

comment on column OA_BUDGET_FILE.AMOUNT is
'金额';

comment on column OA_BUDGET_FILE.BRANCH_ID is
'归口处室';

comment on column OA_BUDGET_FILE.USER_ID is
'操作人';

comment on column OA_BUDGET_FILE.OP_DATE is
'操作时间';

comment on column OA_BUDGET_FILE.STATUS is
'处理状态(0:未处理完;1:已处理完;)';



alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_TD_BUDGE;

drop table td_budget_top cascade constraints;

/*==============================================================*/
/* Table: td_budget_top                                         */
/*==============================================================*/
create table td_budget_top 
(
   ID                   VARCHAR2(10)         not null,
   BUDGET_CODE          VARCHAR2(20)         not null,
   FILE_CODE            VARCHAR2(50)         not null,
   order_no             VARCHAR2(5)          not null,
   BUDGET_NAME          VARCHAR2(80)         not null,
   AMOUNT               number               not null,
   REMARK               VARCHAR2(100),
   REC_DATE             DATE                 not null,
   constraint PK_TD_BUDGET_TOP primary key (ID),
   constraint AK_KEY_2_TD_BUDGE unique (BUDGET_CODE),
   constraint AK_KEY_3_TD_BUDGE unique (FILE_CODE, order_no)
);

comment on table td_budget_top is
'从平台接收过来的总指标';

comment on column td_budget_top.ID is
'id';

comment on column td_budget_top.BUDGET_CODE is
'指标编号';

comment on column td_budget_top.FILE_CODE is
'文号';

comment on column td_budget_top.order_no is
'序号';

comment on column td_budget_top.BUDGET_NAME is
'BUDGET_NAME';

comment on column td_budget_top.AMOUNT is
'金额';

comment on column td_budget_top.REMARK is
'说明';

comment on column td_budget_top.REC_DATE is
'接收时间';


alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_TB_CAPIT;

drop table TB_CAPITAL_TYPE cascade constraints;

/*==============================================================*/
/* Table: TB_CAPITAL_TYPE                                       */
/*==============================================================*/
create table TB_CAPITAL_TYPE 
(
   CAPITAL_TYPE         VARCHAR2(10)         not null,
   CAPITAL_NAME         VARCHAR2(30)         not null,
   ENABLED              VARCHAR2(1)          not null,
   BUDGET_KIND          VARCHAR2(1)          not null,
   constraint PK_TB_CAPITAL_TYPE primary key (CAPITAL_TYPE)
);

comment on table TB_CAPITAL_TYPE is
'资金性质';

comment on column TB_CAPITAL_TYPE.CAPITAL_TYPE is
'资金类型编码';

comment on column TB_CAPITAL_TYPE.CAPITAL_NAME is
'资金类型名称';

comment on column TB_CAPITAL_TYPE.ENABLED is
'是否可用';

comment on column TB_CAPITAL_TYPE.BUDGET_KIND is
'预算种类 0：预算内，1：预算外，2：其它';


alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_TB_FUN_C;

drop table TB_FUN_CLASS cascade constraints;

/*==============================================================*/
/* Table: TB_FUN_CLASS                                          */
/*==============================================================*/
create table TB_FUN_CLASS 
(
   FUN_CLASS            VARCHAR2(20)         not null,
   FUN_NAME             VARCHAR2(60)         not null,
   FUN_FULL             VARCHAR2(200),
   ENABLED              VARCHAR2(1)          not null,
   PARENT_CODE          VARCHAR2(20),
   constraint PK_TB_FUN_CLASS primary key (FUN_CLASS)
);

comment on table TB_FUN_CLASS is
'功能分类';

comment on column TB_FUN_CLASS.FUN_CLASS is
'分类代码';

comment on column TB_FUN_CLASS.FUN_NAME is
'分类名称';

comment on column TB_FUN_CLASS.FUN_FULL is
'全称';

comment on column TB_FUN_CLASS.ENABLED is
'是否可用';

comment on column TB_FUN_CLASS.PARENT_CODE is
'PARENT_CODE';


alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_TB_E_CLA;

drop table TB_E_CLASS cascade constraints;

/*==============================================================*/
/* Table: TB_E_CLASS                                            */
/*==============================================================*/
create table TB_E_CLASS 
(
   E_CLASS              VARCHAR2(10)         not null,
   E_NAME               VARCHAR2(50)         not null,
   E_FULL               VARCHAR2(200),
   ENABLED              VARCHAR2(1)          not null,
   PARENT_CODE          VARCHAR2(10),
   constraint PK_TB_E_CLASS primary key (E_CLASS)
);

comment on table TB_E_CLASS is
'经济分类';

comment on column TB_E_CLASS.E_CLASS is
'经济分类代码';

comment on column TB_E_CLASS.E_NAME is
'经济分类名称';

comment on column TB_E_CLASS.E_FULL is
'全名';

comment on column TB_E_CLASS.ENABLED is
'十分使用';

comment on column TB_E_CLASS.PARENT_CODE is
'PARENT_CODE';


alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_TD_SM_US;

alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_OA_BUDGE;

alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_TB_CAPIT;

alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_TB_FUN_C;

alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_TB_E_CLA;

alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_TD_BUDGE;

alter table OA_BUDGET_DETAIL
   drop constraint FK_OA_BUDGE_REFERENCE_OA_SPLIT;

drop table OA_BUDGET_DETAIL cascade constraints;

/*==============================================================*/
/* Table: OA_BUDGET_DETAIL                                      */
/*==============================================================*/
create table OA_BUDGET_DETAIL 
(
   DETAIL_ID            VARCHAR2(40)         not null,
   BUDGET_FILE_ID       VARCHAR2(40)         not null,
   UNIT_ID              VARCHAR2(40)         not null,
   SHOWN_NAME           VARCHAR2(100)        not null,
   CAPITAL_TYPE         VARCHAR2(10),
   FUN_CLASS            VARCHAR2(20),
   E_CLASS              VARCHAR2(10),
   BUDGET_TOP_ID        VARCHAR2(10),
   AMOUNT               NUMBER(18,2)         not null,
   STAFFID              VARCHAR2(40),
   STAFF_DATE           DATE,
   SEND_DATE            DATE,
   FILE_NAME            VARCHAR2(100)        not null,
   FILE_PATH            VARCHAR2(150)         not null,
   FILE_SIZE            NUMBER,
   REMARK               VARCHAR2(1000),
   constraint PK_OA_BUDGET_DETAIL primary key (DETAIL_ID),
   constraint AK_KEY_3_OA_BUDGE unique (BUDGET_FILE_ID, SHOWN_NAME),
   constraint AK_KEY_4_OA_BUDGE unique (BUDGET_FILE_ID, UNIT_ID)
);

comment on table OA_BUDGET_DETAIL is
'明细信息';

comment on column OA_BUDGET_DETAIL.DETAIL_ID is
'DETAIL_ID';

comment on column OA_BUDGET_DETAIL.BUDGET_FILE_ID is
'指标文信息ID';

comment on column OA_BUDGET_DETAIL.UNIT_ID is
'拆分单位ID';

comment on column OA_BUDGET_DETAIL.SHOWN_NAME is
'附件显示名';

comment on column OA_BUDGET_DETAIL.CAPITAL_TYPE is
'资金类型编码';

comment on column OA_BUDGET_DETAIL.FUN_CLASS is
'分类代码';

comment on column OA_BUDGET_DETAIL.E_CLASS is
'经济分类代码';

comment on column OA_BUDGET_DETAIL.BUDGET_TOP_ID is
'总指标id';

comment on column OA_BUDGET_DETAIL.AMOUNT is
'金额';

comment on column OA_BUDGET_DETAIL.STAFFID is
'处理人';

comment on column OA_BUDGET_DETAIL.STAFF_DATE is
'处理时间';

comment on column OA_BUDGET_DETAIL.SEND_DATE is
'发送平台时间';

comment on column OA_BUDGET_DETAIL.FILE_NAME is
'附件id(关联拆分附件表)';

comment on column OA_BUDGET_DETAIL.FILE_PATH is
'附件地址';

comment on column OA_BUDGET_DETAIL.FILE_SIZE is
'文件大小(单位：字节)';

comment on column OA_BUDGET_DETAIL.REMARK is
'备注';



alter table OA_BUDGET_ORG_USER
   drop constraint FK_OA_BUDGE_REFERENCE_TD_SM_OR;

alter table OA_BUDGET_ORG_USER
   drop constraint FK_OA_BUDGE_REFERENCE_TD_SM_US;

drop table OA_BUDGET_ORG_USER cascade constraints;

/*==============================================================*/
/* Table: OA_BUDGET_ORG_USER                                    */
/*==============================================================*/
create table OA_BUDGET_ORG_USER 
(
   USER_ID              number               not null,
   ORG_ID               VARCHAR2(50)         not null,
   constraint PK_OA_BUDGET_ORG_USER primary key (USER_ID, ORG_ID)
);

comment on table OA_BUDGET_ORG_USER is
'处室指标处理权限';

comment on column OA_BUDGET_ORG_USER.USER_ID is
'用户id';

comment on column OA_BUDGET_ORG_USER.ORG_ID is
'科室id';



alter table OA_BUDGET_DETAIL
   add constraint FK_OA_BUDGE_REFERENCE_OA_BUDGE foreign key (BUDGET_FILE_ID)
      references OA_BUDGET_FILE (ID);

alter table OA_BUDGET_DETAIL
   add constraint FK_OA_BUDGE_REFERENCE_TB_CAPIT foreign key (CAPITAL_TYPE)
      references TB_CAPITAL_TYPE (CAPITAL_TYPE);

alter table OA_BUDGET_DETAIL
   add constraint FK_OA_BUDGE_REFERENCE_TB_FUN_C foreign key (FUN_CLASS)
      references TB_FUN_CLASS (FUN_CLASS);

alter table OA_BUDGET_DETAIL
   add constraint FK_OA_BUDGE_REFERENCE_TB_E_CLA foreign key (E_CLASS)
      references TB_E_CLASS (E_CLASS);

alter table OA_BUDGET_DETAIL
   add constraint FK_OA_BUDGE_REFERENCE_TD_BUDGE foreign key (BUDGET_TOP_ID)
      references td_budget_top (ID);

alter table OA_BUDGET_DETAIL
   add constraint FK_OA_BUDGE_REFERENCE_OA_SPLIT foreign key (UNIT_ID)
      references OA_SPLIT_UNIT (UNIT_ID);


alter table OA_BUDGET_FILE
   add constraint FK_OA_BUDGE_REFERENCE_TD_SM_OR foreign key (BRANCH_ID)
      references TD_SM_ORGANIZATION (ORG_ID);

alter table OA_BUDGET_ATTACHMENT
   add constraint FK_OA_BUDGE_REFERENCE_OA_BUDGE foreign key (ID)
      references OA_BUDGET_FILE (ID);


alter table OA_BUDGET_ORG_USER
   add constraint FK_OA_BUDGE_REFERENCE_TD_SM_OR foreign key (ORG_ID)
      references TD_SM_ORGANIZATION (ORG_ID);







