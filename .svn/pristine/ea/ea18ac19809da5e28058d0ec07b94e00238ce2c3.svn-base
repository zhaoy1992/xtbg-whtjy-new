/*==============================================================*/
/* Database name:  Database_1                                   */
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-7-18 10:23:10                           */
/*==============================================================*/


drop table OA_PERSONDIRECT_RELATION cascade constraints;

drop table OA_PERSONWORK_ATTACH cascade constraints;

drop table OA_PERSONWORK_EXTRAINFO cascade constraints;

drop table OA_PERSONWORK_GROUP cascade constraints;

drop table OA_PERSONWORK_PERSONGROUP cascade constraints;

drop table OA_PERSONWORK_PERSONINFO cascade constraints;

drop table OA_PERSONWORK_PERSONINFOPAR cascade constraints;

drop table OA_PERSONWORK_ROLE cascade constraints;

drop table OA_USERANDSN cascade constraints;

/*==============================================================*/
/* Database: Database_1                                         */
/*==============================================================*/
create database Database_1;

/*==============================================================*/
/* Table: OA_PERSONDIRECT_RELATION                              */
/*==============================================================*/
create table OA_PERSONDIRECT_RELATION 
(
   RELATIONSHIP_ID      VARCHAR2(50)         not null,
   USER_ID              VARCHAR2(50)         not null,
   DIRECTORYID          NUMBER               not null
);

comment on table OA_PERSONDIRECT_RELATION is
'个人通讯录与名录关系表';

comment on column OA_PERSONDIRECT_RELATION.USER_ID is
'用户id';

comment on column OA_PERSONDIRECT_RELATION.DIRECTORYID is
'名录id';

/*==============================================================*/
/* Table: OA_PERSONWORK_ATTACH                                  */
/*==============================================================*/
create table OA_PERSONWORK_ATTACH 
(
   ATTACH_ID            VARCHAR2(50)         not null,
   PERSON_ID            VARCHAR2(50),
   ATTACHCONTENT        BLOB,
   TYPE                 VARCHAR2(5)          not null,
   FILENAME             CHAR(255)            not null,
   EXTEND               CHAR(255)            not null,
   CREATOR              VARCHAR2(50)         not null,
   CREATETIME           DATE                 not null
);

comment on table OA_PERSONWORK_ATTACH is
'人员附件信息表';

comment on column OA_PERSONWORK_ATTACH.PERSON_ID is
'人员主键';

comment on column OA_PERSONWORK_ATTACH.ATTACHCONTENT is
'附件内容';

comment on column OA_PERSONWORK_ATTACH.TYPE is
'类型';

comment on column OA_PERSONWORK_ATTACH.FILENAME is
'附件名称';

comment on column OA_PERSONWORK_ATTACH.EXTEND is
'附件扩展名';

comment on column OA_PERSONWORK_ATTACH.CREATOR is
'创建人';

comment on column OA_PERSONWORK_ATTACH.CREATETIME is
'创建时间';

/*==============================================================*/
/* Table: OA_PERSONWORK_EXTRAINFO                               */
/*==============================================================*/
create table OA_PERSONWORK_EXTRAINFO 
(
   EXTRA_ID             VARCHAR2(50)         not null,
   PERSON_ID            VARCHAR2(50)         not null,
   FIELD_NAME           VARCHAR2(30)         not null,
   FIELD_VALUE          VARCHAR2(200)        not null,
   TYPE                 VARCHAR2(5)          not null,
   SHOWINDEX            CHAR(10)             not null
);

comment on table OA_PERSONWORK_EXTRAINFO is
'人员信息扩展表';

comment on column OA_PERSONWORK_EXTRAINFO.PERSON_ID is
'人员主键';

comment on column OA_PERSONWORK_EXTRAINFO.FIELD_NAME is
'字段名称';

comment on column OA_PERSONWORK_EXTRAINFO.FIELD_VALUE is
'字段值';

comment on column OA_PERSONWORK_EXTRAINFO.TYPE is
'类型';

comment on column OA_PERSONWORK_EXTRAINFO.SHOWINDEX is
'显示顺序';

/*==============================================================*/
/* Table: OA_PERSONWORK_GROUP                                   */
/*==============================================================*/
create table OA_PERSONWORK_GROUP 
(
   GROUP_ID             VARCHAR2(50)         not null,
   USER_ID              VARCHAR2(50)         not null,
   GROUP_NAME           VARCHAR2(50)         not null,
   is_public_group      char(1)             
      constraint CKC_IS_PUBLIC_GROUP_OA_PERSO check (is_public_group is null or (is_public_group in ('1','0')))
);

comment on table OA_PERSONWORK_GROUP is
'人员分组表';

comment on column OA_PERSONWORK_GROUP.USER_ID is
'用户id';

comment on column OA_PERSONWORK_GROUP.GROUP_NAME is
'分组名称';

comment on column OA_PERSONWORK_GROUP.is_public_group is
'是否是公共组';

/*==============================================================*/
/* Table: OA_PERSONWORK_PERSONGROUP                             */
/*==============================================================*/
create table OA_PERSONWORK_PERSONGROUP 
(
   PERSONGROUP_ID       VARCHAR2(50)         not null,
   PERSON_ID            VARCHAR2(50)         not null,
   GROUP_ID             VARCHAR2(50)         not null
);

comment on table OA_PERSONWORK_PERSONGROUP is
'人员分组关系表';

comment on column OA_PERSONWORK_PERSONGROUP.PERSON_ID is
'人员id';

comment on column OA_PERSONWORK_PERSONGROUP.GROUP_ID is
'分组id';

/*==============================================================*/
/* Table: OA_PERSONWORK_PERSONINFO                              */
/*==============================================================*/
create table OA_PERSONWORK_PERSONINFO 
(
   PERSON_ID            VARCHAR2(50)         not null,
   USER_ID              VARCHAR2(50)         not null,
   NAME                 VARCHAR2(30)         not null,
   NICK_NAME            VARCHAR2(30)         not null,
   CREATE_TIME          DATE                 default SYSDATE not null,
   INFO_TYPE            VARCHAR2(20),
   ENG_NAME             VARCHAR2(50),
   ORG_ID               VARCHAR2(50),
   is_public            char(1)             
      constraint CKC_IS_PUBLIC_OA_PERSO check (is_public is null or (is_public in ('1','0')))
);

comment on table OA_PERSONWORK_PERSONINFO is
'人员信息表';

comment on column OA_PERSONWORK_PERSONINFO.USER_ID is
'所属用户';

comment on column OA_PERSONWORK_PERSONINFO.NAME is
'姓名';

comment on column OA_PERSONWORK_PERSONINFO.NICK_NAME is
'昵称';

comment on column OA_PERSONWORK_PERSONINFO.CREATE_TIME is
'创建时间';

comment on column OA_PERSONWORK_PERSONINFO.INFO_TYPE is
'信息类型';

comment on column OA_PERSONWORK_PERSONINFO.ENG_NAME is
'姓名拼音';

comment on column OA_PERSONWORK_PERSONINFO.ORG_ID is
'所属机构';

comment on column OA_PERSONWORK_PERSONINFO.is_public is
'是否是公共通讯录';

/*==============================================================*/
/* Table: OA_PERSONWORK_PERSONINFOPAR                           */
/*==============================================================*/
create table OA_PERSONWORK_PERSONINFOPAR 
(
   ID                   VARCHAR2(50)         not null,
   FIELD_NAME           VARCHAR2(50)         not null,
   PARENT_ID            VARCHAR2(5),
   IS_PC                CHAR(1)              default 'Y',
   IS_MOBILE            CHAR(1)              default 'Y',
   SHOWINDEX            CHAR(10)             not null
);

comment on table OA_PERSONWORK_PERSONINFOPAR is
'人员信息字典表';

comment on column OA_PERSONWORK_PERSONINFOPAR.FIELD_NAME is
'字段名称';

comment on column OA_PERSONWORK_PERSONINFOPAR.PARENT_ID is
'类型';

comment on column OA_PERSONWORK_PERSONINFOPAR.IS_PC is
'pc端有效';

comment on column OA_PERSONWORK_PERSONINFOPAR.IS_MOBILE is
'手机端有效';

comment on column OA_PERSONWORK_PERSONINFOPAR.SHOWINDEX is
'显示顺序';

/*==============================================================*/
/* Table: OA_PERSONWORK_ROLE                                    */
/*==============================================================*/
create table OA_PERSONWORK_ROLE 
(
   ROLE_ID              VARCHAR2(50)         not null,
   USER_ID              VARCHAR2(50)         not null,
   LEADERS              VARCHAR2(200)        not null,
   LEADERS_USERID       VARCHAR2(400)        not null
);

comment on table OA_PERSONWORK_ROLE is
'人员查看权限表';

comment on column OA_PERSONWORK_ROLE.USER_ID is
'用户id';

comment on column OA_PERSONWORK_ROLE.LEADERS is
'可查看领导';

comment on column OA_PERSONWORK_ROLE.LEADERS_USERID is
'可查看领导id';

/*==============================================================*/
/* Table: OA_USERANDSN                                          */
/*==============================================================*/
create table OA_USERANDSN 
(
   ID                   VARCHAR2(50)         not null,
   USERID               VARCHAR2(50),
   MOBILE_SN            VARCHAR2(100),
   DIRECTORYSTATE       VARCHAR2(40),
   EDUCATION            VARCHAR2(40),
   DEGREE               VARCHAR2(40),
   SENIORITY            VARCHAR2(40),
   SCHOOL               VARCHAR2(100),
   NATION               VARCHAR2(40),
   POLITICS             VARCHAR2(40),
   NATIVES              VARCHAR2(40),
   SPECIALTY            VARCHAR2(40),
   HOMEADRESS           VARCHAR2(100),
   DUTY                 VARCHAR2(1000),
   RESUME               VARCHAR2(1000),
   ORGID                VARCHAR2(100),
   ORGNAME              VARCHAR2(100),
   DUTIES               VARCHAR2(100),
   WORKTIME             DATE,
   JOINPARTTIME         DATE,
   DIRECTORYLEVEL       VARCHAR2(40),
   DEPARTMENT           VARCHAR2(100),
   PHOTO                BLOB,
   PORTALANDOA_ID       VARCHAR2(40),
   DEPT_ID              VARCHAR2(1000),
   DEPT_NAME            VARCHAR2(1000),
   NUMBERONE            VARCHAR2(10)         default '否',
   OLDUSERNAME          VARCHAR2(100),
   USERNUMBER           VARCHAR2(50),
   ISMARRY              VARCHAR2(50),
   JOINTIME             DATE,
   NATIVESADDRESS       CLOB,
   USERFILESPACE        CLOB,
   LANGUAGETYPE         VARCHAR2(50),
   LANGUAGELEVEL        VARCHAR2(50),
   POSTALCODE           VARCHAR2(50),
   EMAIL                VARCHAR2(50),
   FAMILYMEMBERS        CLOB,
   JCRECORD             CLOB,
   PXRECORD             CLOB,
   CERTIFICATE          CLOB,
   REMARK               CLOB,
   ATTACHMENTID         CLOB,
   PICID                VARCHAR2(50),
   TITLES               VARCHAR2(50),
   USERTYPE             VARCHAR2(50),
   TITLETYPE            VARCHAR2(50)
);

comment on table OA_USERANDSN is
'人员sn关联表';

comment on column OA_USERANDSN.ID is
'主键id';

comment on column OA_USERANDSN.USERID is
'用户id';

comment on column OA_USERANDSN.MOBILE_SN is
'手机sn';

comment on column OA_USERANDSN.DIRECTORYSTATE is
'在职状态';

comment on column OA_USERANDSN.EDUCATION is
'学历';

comment on column OA_USERANDSN.DEGREE is
'学位';

comment on column OA_USERANDSN.SENIORITY is
'工龄';

comment on column OA_USERANDSN.SCHOOL is
'毕业院校';

comment on column OA_USERANDSN.NATION is
'民族';

comment on column OA_USERANDSN.POLITICS is
'政治面貌';

comment on column OA_USERANDSN.NATIVES is
'籍贯';

comment on column OA_USERANDSN.SPECIALTY is
'所学专业';

comment on column OA_USERANDSN.HOMEADRESS is
'住宅地址';

comment on column OA_USERANDSN.DUTY is
'工作职责';

comment on column OA_USERANDSN.RESUME is
'个人简介';

comment on column OA_USERANDSN.ORGID is
'所属单位id';

comment on column OA_USERANDSN.ORGNAME is
'所属单位名称';

comment on column OA_USERANDSN.DUTIES is
'职务';

comment on column OA_USERANDSN.WORKTIME is
'参加工作时间';

comment on column OA_USERANDSN.JOINPARTTIME is
'入党时间';

comment on column OA_USERANDSN.DIRECTORYLEVEL is
'级别';

comment on column OA_USERANDSN.DEPARTMENT is
'所在科室';

comment on column OA_USERANDSN.PHOTO is
'用户照片';

comment on column OA_USERANDSN.PORTALANDOA_ID is
'门户与OA用户对应字段';

comment on column OA_USERANDSN.DEPT_ID is
'兼职部门id';

comment on column OA_USERANDSN.DEPT_NAME is
'兼职部门Nmae';

comment on column OA_USERANDSN.NUMBERONE is
'是否党政一把手';

comment on column OA_USERANDSN.OLDUSERNAME is
'曾用名';

comment on column OA_USERANDSN.USERNUMBER is
'编号';

comment on column OA_USERANDSN.ISMARRY is
'姻婚状况';

comment on column OA_USERANDSN.JOINTIME is
'加入本单位时间';

comment on column OA_USERANDSN.NATIVESADDRESS is
'户籍地址';

comment on column OA_USERANDSN.USERFILESPACE is
'人事档案存放处';

comment on column OA_USERANDSN.LANGUAGETYPE is
'掌握何种外国语言';

comment on column OA_USERANDSN.LANGUAGELEVEL is
'外语水平（等级）';

comment on column OA_USERANDSN.POSTALCODE is
'邮编';

comment on column OA_USERANDSN.EMAIL is
'电子邮件';

comment on column OA_USERANDSN.FAMILYMEMBERS is
'家庭成员';

comment on column OA_USERANDSN.JCRECORD is
'奖惩记录';

comment on column OA_USERANDSN.PXRECORD is
'培训记录';

comment on column OA_USERANDSN.CERTIFICATE is
'证书';

comment on column OA_USERANDSN.REMARK is
'备注';

comment on column OA_USERANDSN.ATTACHMENTID is
'附件id';

comment on column OA_USERANDSN.PICID is
'照片id';

comment on column OA_USERANDSN.TITLES is
'职称';

comment on column OA_USERANDSN.USERTYPE is
'人员类型';

