/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-9-4 11:10:09                           */
/*==============================================================*/

drop table OA_GUESTRECEPTION_INFO cascade constraints;

drop table OA_GUESTNAMELIST cascade constraints;

drop table OA_GUESTTRAVEL cascade constraints;

drop table OA_GUESTINFORECEIVELIST cascade constraints;

drop table OA_GUESTRECEIVE cascade constraints;

drop table OA_GUESTRECEPTION_TYPE cascade constraints;

/*==============================================================*/
/* Table: OA_GUESTRECEPTION_INFO                                */
/*==============================================================*/
create table OA_GUESTRECEPTION_INFO 
(
   grinfo_id          VARCHAR2(50)         not null,
   grinfo_titile      VARCHAR2(150),
   grinfo_org         VARCHAR2(150),
   grinfo_personnum   VARCHAR2(50),
   grinfo_receptionorg VARCHAR2(150),
   grinfo_dutyofficer VARCHAR2(50),
   grinfo_startime    DATE,
   grinfo_endtime     DATE,
   grinfo_tel         VARCHAR2(50),
   grinfo_content     VARCHAR2(500),
   grstatus_id        VARCHAR2(50),
   grinfo_orgid       VARCHAR2(50),
   grinfo_receptionorgid VARCHAR2(50),
   grinfo_dutyofficerid VARCHAR2(50),
   grinfo_sendpersonid VARCHAR2(50),
   grinfo_createtime  DATE,
   grinfo_guestcontact VARCHAR2(50),
   grinfo_guestphone  VARCHAR2(50),
   grinfo_mpersonid   VARCHAR2(50),
   grinfo_mpersonname VARCHAR2(50),
   constraint PK_OA_GUESTRECEPTION_INFO primary key (grinfo_id)
);

comment on table OA_GUESTRECEPTION_INFO is
'来宾接待信息表';

comment on column OA_GUESTRECEPTION_INFO.grinfo_id is
'主键id';

comment on column OA_GUESTRECEPTION_INFO.grinfo_titile is
'主题';

comment on column OA_GUESTRECEPTION_INFO.grinfo_org is
'接待单位';

comment on column OA_GUESTRECEPTION_INFO.grinfo_personnum is
'人数';

comment on column OA_GUESTRECEPTION_INFO.grinfo_receptionorg is
'宾客单位';

comment on column OA_GUESTRECEPTION_INFO.grinfo_dutyofficer is
'负责人';

comment on column OA_GUESTRECEPTION_INFO.grinfo_startime is
'开始时间';

comment on column OA_GUESTRECEPTION_INFO.grinfo_endtime is
'结束时间';

comment on column OA_GUESTRECEPTION_INFO.grinfo_tel is
'负责人电话';

comment on column OA_GUESTRECEPTION_INFO.grinfo_content is
'内容';

comment on column OA_GUESTRECEPTION_INFO.grstatus_id is
'状态';

comment on column OA_GUESTRECEPTION_INFO.grinfo_orgid is
'接待单位id';

comment on column OA_GUESTRECEPTION_INFO.grinfo_receptionorgid is
'宾客单位id';

comment on column OA_GUESTRECEPTION_INFO.grinfo_dutyofficerid is
'负责人id';

comment on column OA_GUESTRECEPTION_INFO.grinfo_sendpersonid is
'发送人id';

comment on column OA_GUESTRECEPTION_INFO.grinfo_createtime is
'创建时间';

comment on column OA_GUESTRECEPTION_INFO.grinfo_guestcontact is
'来宾联系人';

comment on column OA_GUESTRECEPTION_INFO.grinfo_guestphone is
'来宾联系人手机号码';

comment on column OA_GUESTRECEPTION_INFO.grinfo_mpersonid is
'发送多人的id';

comment on column OA_GUESTRECEPTION_INFO.grinfo_mpersonname is
'发送多人的name';


/*==============================================================*/
/* Table: OA_GUESTNAMELIST                                      */
/*==============================================================*/
create table OA_GUESTNAMELIST 
(
   PID                  VARCHAR2(50)         not null,
   GRINFO_ID            VARCHAR2(50),
   GUESTNAME            VARCHAR2(50),
   GUESTSEX             VARCHAR2(50),
   GUESTPOST            VARCHAR2(200),
   REMARK1              VARCHAR2(50),
   REMARK2              VARCHAR2(50),
   CREATETIME           DATE,
   constraint PK_OA_GUESTNAMELIST primary key (PID)
);

comment on table OA_GUESTNAMELIST is
'来宾名单表';

comment on column OA_GUESTNAMELIST.PID is
'本表主键';

comment on column OA_GUESTNAMELIST.GRINFO_ID is
'主键id';

comment on column OA_GUESTNAMELIST.GUESTNAME is
'来宾姓名';

comment on column OA_GUESTNAMELIST.GUESTSEX is
'来宾性别';

comment on column OA_GUESTNAMELIST.GUESTPOST is
'来宾单位和职位';

comment on column OA_GUESTNAMELIST.REMARK1 is
'备用1';

comment on column OA_GUESTNAMELIST.REMARK2 is
'备用2';

comment on column OA_GUESTNAMELIST.CREATETIME is
'创建时间';

/*==============================================================*/
/* Table: OA_GUESTTRAVEL                                        */
/*==============================================================*/
create table OA_GUESTTRAVEL 
(
   PID                  VARCHAR2(50)         not null,
   GRINFO_ID            VARCHAR2(50),
   TSTARTTIME           VARCHAR2(50),
   TTSTARTTIME          VARCHAR2(50),
   FROMCONTENT          VARCHAR2(200),
   PLACE                VARCHAR2(200),
   ACCOMPANY            VARCHAR2(3000),
   ACCOMPANYID          VARCHAR2(3000),
   REMARK1              VARCHAR2(50),
   REMARK2              VARCHAR2(50),
   CREATETIME           DATE,
   constraint PK_OA_GUESTTRAVEL primary key (PID)
);

comment on table OA_GUESTTRAVEL is
'行程安排表';

comment on column OA_GUESTTRAVEL.PID is
'本表主键';

comment on column OA_GUESTTRAVEL.GRINFO_ID is
'主键id';

comment on column OA_GUESTTRAVEL.TSTARTTIME is
'接待日期';

comment on column OA_GUESTTRAVEL.TTSTARTTIME is
'接待时间';

comment on column OA_GUESTTRAVEL.FROMCONTENT is
'内容';

comment on column OA_GUESTTRAVEL.PLACE is
'地点';

comment on column OA_GUESTTRAVEL.ACCOMPANY is
'陪同人员';

comment on column OA_GUESTTRAVEL.ACCOMPANYID is
'陪同人员id';

comment on column OA_GUESTTRAVEL.REMARK1 is
'备用1';

comment on column OA_GUESTTRAVEL.REMARK2 is
'备用2';

comment on column OA_GUESTTRAVEL.CREATETIME is
'创建时间';


/*==============================================================*/
/* Table: OA_GUESTRECEIVE                                       */
/*==============================================================*/
create table OA_GUESTRECEIVE 
(
   PID                  VARCHAR2(50)         not null,
   GRINFO_ID            VARCHAR2(50),
   PTUSERNAME           VARCHAR2(50),
   PTUSERID             CHAR(10),
   PTSEX                VARCHAR2(50),
   PTPOST               VARCHAR2(200),
   REMARK1              VARCHAR2(50),
   REMARK2              VARCHAR2(50),
   CREATTIME            DATE,
   constraint PK_OA_GUESTRECEIVE primary key (PID)
);

comment on table OA_GUESTRECEIVE is
'接待人员名单表';

comment on column OA_GUESTRECEIVE.PID is
'本表主键';

comment on column OA_GUESTRECEIVE.GRINFO_ID is
'主键id';

comment on column OA_GUESTRECEIVE.PTUSERNAME is
'接待人员姓名';

comment on column OA_GUESTRECEIVE.PTUSERID is
'接待人员姓名id';

comment on column OA_GUESTRECEIVE.PTSEX is
'接待人员性别';

comment on column OA_GUESTRECEIVE.PTPOST is
'接待人员单位和职位';

comment on column OA_GUESTRECEIVE.REMARK1 is
'备用1';

comment on column OA_GUESTRECEIVE.REMARK2 is
'备用2';

comment on column OA_GUESTRECEIVE.CREATTIME is
'创建时间按';


/*==============================================================*/
/* Table: OA_GUESTINFORECEIVELIST                               */
/*==============================================================*/
create table OA_GUESTINFORECEIVELIST 
(
   PID                  VARCHAR2(50)         not null,
   GRINFO_ID            VARCHAR2(50),
   USERID               VARCHAR2(50),
   STATICID             VARCHAR2(2),
   CREATETIME           DATE,
   REMARK1              VARCHAR2(50),
   REMARK2              VARCHAR2(50),
   constraint PK_OA_GUESTINFORECEIVELIST primary key (PID)
);

comment on table OA_GUESTINFORECEIVELIST is
'接收人列表';

comment on column OA_GUESTINFORECEIVELIST.PID is
'本表主键';

comment on column OA_GUESTINFORECEIVELIST.GRINFO_ID is
'主键id';

comment on column OA_GUESTINFORECEIVELIST.USERID is
'用户id';

comment on column OA_GUESTINFORECEIVELIST.STATICID is
'状态';

comment on column OA_GUESTINFORECEIVELIST.CREATETIME is
'创建时间';

comment on column OA_GUESTINFORECEIVELIST.REMARK1 is
'备用1';

comment on column OA_GUESTINFORECEIVELIST.REMARK2 is
'备用2';

/*==============================================================*/
/* Table: OA_GUESTRECEPTION_TYPE                                */
/*==============================================================*/
create table OA_GUESTRECEPTION_TYPE 
(
   GRSTATUS_ID          VARCHAR2(50)         not null,
   GRSTATUS_NAME        VARCHAR2(50),
   constraint PK_OA_GUESTRECEPTION_TYPE primary key (GRSTATUS_ID)
);

comment on table OA_GUESTRECEPTION_TYPE is
'来宾信息状态表';

comment on column OA_GUESTRECEPTION_TYPE.GRSTATUS_ID is
'状态id';

comment on column OA_GUESTRECEPTION_TYPE.GRSTATUS_NAME is
'状态名称';

