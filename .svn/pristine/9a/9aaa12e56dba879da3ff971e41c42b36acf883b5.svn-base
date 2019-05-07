/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-7-2 14:31:51                            */
/*==============================================================*/


alter table OA_NOTICE_RECEIVER_UNIT
   drop constraint FK_OA_NOTIC_REFERENCS_OA_NOTIC;

alter table oa_notice_msg
   drop constraint FK_OA_NOTIC_REFERENCR_OA_NOTIC;

alter table oa_notice_receiver_user
   drop constraint FK_OA_NOTIC_REFERENCE_OA_NOTIC;

alter table OA_NOTICE_RECEIVER_UNIT
   drop primary key cascade;

drop table OA_NOTICE_RECEIVER_UNIT cascade constraints;

alter table oa_notice_baseinfo
   drop primary key cascade;

drop table oa_notice_baseinfo cascade constraints;

alter table oa_notice_msg
   drop primary key cascade;

drop table oa_notice_msg cascade constraints;

alter table oa_notice_receiver_user
   drop primary key cascade;

drop table oa_notice_receiver_user cascade constraints;

/*==============================================================*/
/* Table: OA_NOTICE_RECEIVER_UNIT                               */
/*==============================================================*/
create table OA_NOTICE_RECEIVER_UNIT 
(
   N_RECEIVER_UNITID    VARCHAR2(50)         not null,
   n_notice_id          VARCHAR2(50),
   N_ORGID              VARCHAR2(50),
   N_ORGNAME            VARCHAR2(200),
   N_ISVIEW             VARCHAR2(1)          default '0',
   N_CREATOR_TIME       DATE                 default SYSDATE
);

comment on table OA_NOTICE_RECEIVER_UNIT is
'通知公告接收单位表';

comment on column OA_NOTICE_RECEIVER_UNIT.N_RECEIVER_UNITID is
'主键ID';

comment on column OA_NOTICE_RECEIVER_UNIT.n_notice_id is
'公告ID';

comment on column OA_NOTICE_RECEIVER_UNIT.N_ORGID is
'接收单位';

comment on column OA_NOTICE_RECEIVER_UNIT.N_ORGNAME is
'接收单位名称';

comment on column OA_NOTICE_RECEIVER_UNIT.N_ISVIEW is
'是否已查看(1:是，0:不是)';

comment on column OA_NOTICE_RECEIVER_UNIT.N_CREATOR_TIME is
'创建时间';

alter table OA_NOTICE_RECEIVER_UNIT
   add constraint PK_OA_NOTICE_RECEIVER_UNIT primary key (N_RECEIVER_UNITID);

/*==============================================================*/
/* Table: oa_notice_baseinfo                                    */
/*==============================================================*/
create table oa_notice_baseinfo 
(
   n_notice_id          VARCHAR2(50)         not null,
   n_title              VARCHAR2(200),
   n_content            CLOB,
   n_creator_userid     VARCHAR2(50),
   n_creator_username   VARCHAR2(200),
   n_creator_time       DATE                 default SYSDATE,
   n_release_userid     VARCHAR2(50),
   n_release_username   VARCHAR2(200),
   n_release_time       DATE,
   n_state              VARCHAR2(2),
   n_attach_id          VARCHAR2(50),
   n_orgid              VARCHAR2(50),
   n_orgname            VARCHAR2(200),
   n_unit_id            VARCHAR2(50),
   n_unit_name          VARCHAR2(200),
   n_unit_or_personal   VARCHAR2(1),
   n_isphone            VARCHAR2(2)          default 'N',
   n_megtype            VARCHAR2(2),
   n_receiver_userid    CLOB,
   n_receiver_username  CLOB,
   n_receiver_orgid     CLOB,
   n_receiver_orgname   CLOB
);

comment on table oa_notice_baseinfo is
'通知公告基本信息表';

comment on column oa_notice_baseinfo.n_notice_id is
'公告ID';

comment on column oa_notice_baseinfo.n_title is
'公告标题';

comment on column oa_notice_baseinfo.n_content is
'公告内容';

comment on column oa_notice_baseinfo.n_creator_userid is
'创建人ID';

comment on column oa_notice_baseinfo.n_creator_username is
'创建人名称';

comment on column oa_notice_baseinfo.n_creator_time is
'创建时间';

comment on column oa_notice_baseinfo.n_release_userid is
'发布人id';

comment on column oa_notice_baseinfo.n_release_username is
'发布人名称';

comment on column oa_notice_baseinfo.n_release_time is
'发布时间';

comment on column oa_notice_baseinfo.n_state is
'公告状态(0暂存，1已发布)';

comment on column oa_notice_baseinfo.n_attach_id is
'附件ID';

comment on column oa_notice_baseinfo.n_orgid is
'部门ID';

comment on column oa_notice_baseinfo.n_orgname is
'部门名称';

comment on column oa_notice_baseinfo.n_unit_id is
'单位ID';

comment on column oa_notice_baseinfo.n_unit_name is
'单位名称';

comment on column oa_notice_baseinfo.n_unit_or_personal is
'单位或个人 (1:单位 0:个人)';

comment on column oa_notice_baseinfo.n_isphone is
'是否是手机端发送(1:是，0:不是)';

comment on column oa_notice_baseinfo.n_megtype is
'消息类型(1短信，2站内消息)';

comment on column oa_notice_baseinfo.n_receiver_userid is
'接收人员ID';

comment on column oa_notice_baseinfo.n_receiver_username is
'接收人员名称';

comment on column oa_notice_baseinfo.n_receiver_orgid is
'接收单位ID';

comment on column oa_notice_baseinfo.n_receiver_orgname is
'接收单位名称';

alter table oa_notice_baseinfo
   add constraint PK_OA_NOTICE_BASEINFO primary key (n_notice_id);


/*==============================================================*/
/* Table: oa_notice_msg                                         */
/*==============================================================*/
create table oa_notice_msg 
(
   n_msgid              VARCHAR2(50)         not null,
   n_notice_id          VARCHAR2(50),
   n_megtype            VARCHAR2(2),
   n_msgcontent         VARCHAR2(4000)
);

comment on table oa_notice_msg is
'通知公告消息表';

comment on column oa_notice_msg.n_msgid is
'主键ID';

comment on column oa_notice_msg.n_notice_id is
'公告ID';

comment on column oa_notice_msg.n_megtype is
'消息类型(1短信，2站内消息)';

comment on column oa_notice_msg.n_msgcontent is
'消息内容';

alter table oa_notice_msg
   add constraint PK_OA_NOTICE_MSG primary key (n_msgid);

/*==============================================================*/
/* Table: oa_notice_receiver_user                               */
/*==============================================================*/
create table oa_notice_receiver_user 
(
   n_receiverid         VARCHAR2(50)         not null,
   n_notice_id          VARCHAR2(50),
   n_receiver_userid    VARCHAR2(50),
   n_receiver_username  VARCHAR2(200),
   n_receiveruser_orgid VARCHAR2(50),
   n_receiveruser_orgname VARCHAR2(200),
   n_isview             VARCHAR2(1)          default '0',
   n_creator_time       DATE                 default SYSDATE,
   n_isdel              VARCHAR2(1)          default '0'
);

comment on table oa_notice_receiver_user is
'通知公告接收人表';

comment on column oa_notice_receiver_user.n_receiverid is
'主键ID';

comment on column oa_notice_receiver_user.n_notice_id is
'公告ID';

comment on column oa_notice_receiver_user.n_receiver_userid is
'接收人ID';

comment on column oa_notice_receiver_user.n_receiver_username is
'接收人名称';

comment on column oa_notice_receiver_user.n_receiveruser_orgid is
'接收人单位ID';

comment on column oa_notice_receiver_user.n_receiveruser_orgname is
'接收人单位名称';

comment on column oa_notice_receiver_user.n_isview is
'是否已查看(1:是，0:不是)';

comment on column oa_notice_receiver_user.n_creator_time is
'创建时间';

comment on column oa_notice_receiver_user.n_isdel is
'是否已删除(1:是，0:不是)';

alter table oa_notice_receiver_user
   add constraint PK_OA_NOTICE_RECEIVER_USER primary key (n_receiverid);

alter table OA_NOTICE_RECEIVER_UNIT
   add constraint FK_OA_NOTIC_REFERENCS_OA_NOTIC foreign key (n_notice_id)
      references oa_notice_baseinfo (n_notice_id);

alter table oa_notice_msg
   add constraint FK_OA_NOTIC_REFERENCR_OA_NOTIC foreign key (n_notice_id)
      references oa_notice_baseinfo (n_notice_id);

alter table oa_notice_receiver_user
   add constraint FK_OA_NOTIC_REFERENCE_OA_NOTIC foreign key (n_notice_id)
      references oa_notice_baseinfo (n_notice_id);

