drop table CZT_FACE_SPLIT_UNIT cascade constraints;

create table CZT_FACE_SPLIT_UNIT 
(
   UNIT_ID              VARCHAR2(40)         not null,
   ITEMID               NUMBER(9)            not null,
   constraint PK_CZT_FACE_SPLIT_UNIT primary key (UNIT_ID, ITEMID)
);

comment on table CZT_FACE_SPLIT_UNIT is
'单位映射表';

comment on column CZT_FACE_SPLIT_UNIT.UNIT_ID is
'拆分单位ID';

comment on column CZT_FACE_SPLIT_UNIT.ITEMID is
'ITEMID';

drop table CZT_FACE_BRANCH cascade constraints;

create table CZT_FACE_BRANCH 
(
   ORG_ID               VARCHAR2(50)         not null,
   ITEMID               NUMBER(9)            not null,
   constraint PK_CZT_FACE_BRANCH primary key (ORG_ID, ITEMID)
);

comment on table CZT_FACE_BRANCH is
'处室映射表';

comment on column CZT_FACE_BRANCH.ORG_ID is
'机构ID';

comment on column CZT_FACE_BRANCH.ITEMID is
'ITEMID';

drop table TB_E_CLASS cascade constraints;

create table TB_E_CLASS 
(
   E_CLASS_ID           VARCHAR2(40)         not null,
   E_CLASS              VARCHAR2(50)         not null,
   E_NAME               VARCHAR2(100)        not null,
   SHORTNAME            VARCHAR2(100),
   E_FULL               VARCHAR2(100),
   LEVELNO              NUMBER(3)            not null,
   ISLEAF               NUMBER(2)            not null,
   PARENT_CODE          NUMBER(9),
   constraint PK_TB_E_CLASS primary key (E_CLASS_ID)
);

comment on table TB_E_CLASS is
'经济分类';

comment on column TB_E_CLASS.E_CLASS_ID is
'经济分类id';

comment on column TB_E_CLASS.E_CLASS is
'代码';

comment on column TB_E_CLASS.E_NAME is
'名称';

comment on column TB_E_CLASS.SHORTNAME is
'简称';

comment on column TB_E_CLASS.E_FULL is
'全称';

comment on column TB_E_CLASS.LEVELNO is
'该项的级次';

comment on column TB_E_CLASS.ISLEAF is
'是否最末级';

comment on column TB_E_CLASS.PARENT_CODE is
'上级流水号';

drop table CZT_FACE_E_CLASS cascade constraints;

create table CZT_FACE_E_CLASS 
(
   E_CLASS_ID           VARCHAR2(40)         not null,
   ITEMID               NUMBER(9)            not null,
   constraint PK_CZT_FACE_E_CLASS primary key (E_CLASS_ID, ITEMID)
);

comment on table CZT_FACE_E_CLASS is
'平台经济分类映射表';

comment on column CZT_FACE_E_CLASS.E_CLASS_ID is
'E_CLASS_ID';

comment on column CZT_FACE_E_CLASS.ITEMID is
'ITEMID';

drop table CZT_FUN_CLASS_YEAR cascade constraints;

/*==============================================================*/
/* Table: CZT_FUN_CLASS_YEAR                                    */
/*==============================================================*/
create table CZT_FUN_CLASS_YEAR 
(
   FUN_CLASS_ID         VARCHAR2(40)         not null,
   ANNULA               VARCHAR2(4)          not null,
   constraint PK_CZT_FUN_CLASS_YEAR primary key (FUN_CLASS_ID, ANNULA)
);

comment on table CZT_FUN_CLASS_YEAR is
'年度有效功能分类';

comment on column CZT_FUN_CLASS_YEAR.FUN_CLASS_ID is
'功能分类id';

comment on column CZT_FUN_CLASS_YEAR.ANNULA is
'ANNUAL';

drop table TB_FUN_CLASS cascade constraints;

/*==============================================================*/
/* Table: TB_FUN_CLASS                                          */
/*==============================================================*/
create table TB_FUN_CLASS 
(
   FUN_CLASS_ID         VARCHAR2(40)         not null,
   FUN_CLASS            VARCHAR2(20)         not null,
   FUN_NAME             VARCHAR2(60)         not null,
   FUN_FULL             VARCHAR2(200),
   LEVELNO              NUMBER(3)            not null,
   ISLEAF               NUMBER(2)            not null,
   PARENT_CODE          VARCHAR2(40),
   constraint PK_TB_FUN_CLASS primary key (FUN_CLASS_ID)
);

comment on table TB_FUN_CLASS is
'功能分类';

comment on column TB_FUN_CLASS.FUN_CLASS_ID is
'功能分类id';

comment on column TB_FUN_CLASS.FUN_CLASS is
'分类代码';

comment on column TB_FUN_CLASS.FUN_NAME is
'分类名称';

comment on column TB_FUN_CLASS.FUN_FULL is
'全称';

comment on column TB_FUN_CLASS.LEVELNO is
'该项的级次';

comment on column TB_FUN_CLASS.ISLEAF is
'是否最末级';

comment on column TB_FUN_CLASS.PARENT_CODE is
'PARENT_CODE';

drop table CZT_FACE_FUN_CLASS cascade constraints;

/*==============================================================*/
/* Table: CZT_FACE_FUN_CLASS                                    */
/*==============================================================*/
create table CZT_FACE_FUN_CLASS 
(
   FUN_CLASS_ID         VARCHAR2(40)         not null,
   ITEMID               NUMBER(9)            not null,
   constraint PK_CZT_FACE_FUN_CLASS primary key (FUN_CLASS_ID, ITEMID)
);

comment on table CZT_FACE_FUN_CLASS is
'功能分类映射';

comment on column CZT_FACE_FUN_CLASS.FUN_CLASS_ID is
'功能分类id';

comment on column CZT_FACE_FUN_CLASS.ITEMID is
'ITEMID';

DROP TABLE TB_CAPITAL_TYPE cascade constraints;


alter table CZT_FACE_SPLIT_UNIT
   add constraint FK_CZT_FACE_REFERENCE_OA_SPLIT foreign key (UNIT_ID)
      references OA_SPLIT_UNIT (UNIT_ID);

alter table CZT_FACE_SPLIT_UNIT
   add constraint FK_CZT_FACE_REFERENCE_T_PUBAGE foreign key (ITEMID)
      references T_PUBAGENCY (ITEMID);

alter table CZT_FACE_BRANCH
   add constraint FK_CZT_FACE_REFERENCE_TD_SM_OR foreign key (ORG_ID)
      references TD_SM_ORGANIZATION (ORG_ID);

alter table CZT_FACE_BRANCH
   add constraint FK_CZT_FACE_REFERENCE_T_PUBMOF foreign key (ITEMID)
      references T_PUBMOFDEP (ITEMID);

alter table CZT_FACE_E_CLASS
   add constraint FK_CZT_FACE_REFERENCE_TB_E_CLA foreign key (E_CLASS_ID)
      references TB_E_CLASS (E_CLASS_ID);

alter table CZT_FACE_E_CLASS
   add constraint FK_CZT_FACE_REFERENCE_T_PUBEXP foreign key (ITEMID)
      references T_PUBEXPECO (ITEMID);

alter table CZT_FUN_CLASS_YEAR
   add constraint FK_CZT_FUN__REFERENCE_TB_FUN_C foreign key (FUN_CLASS_ID)
      references TB_FUN_CLASS (FUN_CLASS_ID);

alter table CZT_FACE_FUN_CLASS
   add constraint FK_CZT_FACE_REFERENCE_T_PUBEXP foreign key (ITEMID)
      references T_PUBEXPFUNC (ITEMID);

alter table CZT_FACE_FUN_CLASS
   add constraint FK_CZT_FACE_REFERENCE_TB_FUN_C foreign key (FUN_CLASS_ID)
      references TB_FUN_CLASS (FUN_CLASS_ID);

-- Add/modify columns 
alter table OA_BUDGET_FILE add ANNUAL varchar2(4) not null;
-- Add comments to the columns 
comment on column OA_BUDGET_FILE.ANNUAL
  is 'ANNUAL';

-- Drop columns 
alter table OA_BUDGET_DETAIL drop column CAPITAL_TYPE;
alter table OA_BUDGET_DETAIL drop column BUDGET_TOP_ID;
alter table OA_BUDGET_DETAIL rename column FUN_CLASS to FUN_CLASS_ID;
alter table OA_BUDGET_DETAIL rename column E_CLASS to E_CLASS_ID;
-- Add comments to the columns 
comment on column OA_BUDGET_DETAIL.FUN_CLASS_ID
  is '功能分类id';
comment on column OA_BUDGET_DETAIL.E_CLASS_ID
  is '经济分类id';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_BUDGET_DETAIL
  drop constraint FK_OA_BUDGE_REFERENCE_TB_CAPIT;

alter table OA_BUDGET_DETAIL
  drop constraint FK_OA_BUDGE_REFERENCE_TB_E_CLA;
alter table OA_BUDGET_DETAIL
  add constraint FK_OA_BUDGE_REFERENCE_TB_E_CLA foreign key (E_CLASS_ID)
  references TB_E_CLASS (E_CLASS);
alter table OA_BUDGET_DETAIL
  drop constraint FK_OA_BUDGE_REFERENCE_TB_FUN_C;
alter table OA_BUDGET_DETAIL
  add constraint FK_OA_BUDGE_REFERENCE_TB_FUN_C foreign key (FUN_CLASS_ID)
  references TB_FUN_CLASS (FUN_CLASS);
alter table OA_BUDGET_DETAIL
  drop constraint FK_OA_BUDGE_REFERENCE_TD_BUDGE;


alter table CZT_FACE_SPLIT_UNIT
   add constraint FK_CZT_FACE_REFERENCE_OA_SPLIT foreign key (UNIT_ID)
      references OA_SPLIT_UNIT (UNIT_ID);


alter table CZT_FACE_BRANCH
   add constraint FK_CZT_FACE_REFERENCE_TD_SM_OR foreign key (ORG_ID)
      references TD_SM_ORGANIZATION (ORG_ID);

alter table CZT_FACE_E_CLASS
   add constraint FK_CZT_FACE_REFERENCE_TB_E_CLA foreign key (E_CLASS_ID)
      references TB_E_CLASS (E_CLASS_ID);


alter table CZT_FUN_CLASS_YEAR
   add constraint FK_CZT_FUN__REFERENCE_TB_FUN_C foreign key (FUN_CLASS_ID)
      references TB_FUN_CLASS (FUN_CLASS_ID);

alter table CZT_FACE_FUN_CLASS
   add constraint FK_CZT_FACE_REFERENCE_TB_FUN_C foreign key (FUN_CLASS_ID)
      references TB_FUN_CLASS (FUN_CLASS_ID);

-- Add/modify columns 
alter table OA_BUDGET_FILE add ANNUAL varchar2(4) not null;
-- Add comments to the columns 
comment on column OA_BUDGET_FILE.ANNUAL
  is 'ANNUAL';

-- Drop columns 
alter table OA_BUDGET_DETAIL drop column CAPITAL_TYPE;
alter table OA_BUDGET_DETAIL drop column BUDGET_TOP_ID;
alter table OA_BUDGET_DETAIL rename column FUN_CLASS to FUN_CLASS_ID;
alter table OA_BUDGET_DETAIL rename column E_CLASS to E_CLASS_ID;
-- Add comments to the columns 
comment on column OA_BUDGET_DETAIL.FUN_CLASS_ID
  is '功能分类id';
comment on column OA_BUDGET_DETAIL.E_CLASS_ID
  is '经济分类id';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_BUDGET_DETAIL
  drop constraint FK_OA_BUDGE_REFERENCE_TB_CAPIT;

alter table OA_BUDGET_DETAIL
  drop constraint FK_OA_BUDGE_REFERENCE_TB_E_CLA;

alter table OA_BUDGET_DETAIL
  drop constraint FK_OA_BUDGE_REFERENCE_TB_FUN_C;


alter table OA_BUDGET_DETAIL
  drop constraint FK_OA_BUDGE_REFERENCE_TD_BUDGE;





