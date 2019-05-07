/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013/7/10 18:21:58                           */
/*==============================================================*/


drop table OA_MEETING_MINUTES cascade constraints;

drop table OA_MEETING_MINUTES_READER cascade constraints;

drop table OA_MEETING_NOTE_TEMPLATE cascade constraints;

drop table OA_MEETING_ROOM cascade constraints;

drop table OA_MEETING_ROOM_ADMINISTRATOR cascade constraints;

drop table OA_MEETING_TEMPLATE cascade constraints;

drop table OA_MEETING_TYPE cascade constraints;

drop table oa_meeting_attender cascade constraints;

drop table oa_meeting_check_status cascade constraints;

drop table oa_meeting_flag_type cascade constraints;

drop table oa_meeting_msg_log cascade constraints;

drop table oa_meeting_notice cascade constraints;

drop table oa_meeting_notice_flaglog cascade constraints;

drop table oa_meeting_receiver_unit cascade constraints;

drop table oa_meeting_receiver_user cascade constraints;

drop table oa_meeting_roomoccupancy cascade constraints;

drop table oa_meeting_topic cascade constraints;

/*==============================================================*/
/* Table: OA_MEETING_MINUTES                                    */
/*==============================================================*/
create table OA_MEETING_MINUTES 
(
   M_MINUTES_ID         VARCHAR2(50)         not null,
   M_CURRENT_FLAG       CHAR(1)              not null,
   M_TITLE              VARCHAR2(200)        not null,
   M_CONTENTS           CLOB                 not null,
   M_REG_USER_ID        VARCHAR2(50)         not null,
   M_REG_USER_NAME      VARCHAR2(50)         not null,
   M_REG_TIME           DATE                 default SYSDATE not null,
   M_ATTACH_ID          VARCHAR2(50),
   M_NOTICE_ID          VARCHAR2(50),
   M_BEGIN_TIME         DATE,
   M_READ_PERSON_IDS    CLOB,
   M_READ_PERSON_NAMES  CLOB,
   constraint PK_OA_MEETING_MINUTES primary key (M_MINUTES_ID)
);

comment on table OA_MEETING_MINUTES is
'会议纪要表';

comment on column OA_MEETING_MINUTES.M_MINUTES_ID is
'主键id';

comment on column OA_MEETING_MINUTES.M_CURRENT_FLAG is
'状态(0草稿（暂存）、1发布)';

comment on column OA_MEETING_MINUTES.M_TITLE is
'标题';

comment on column OA_MEETING_MINUTES.M_CONTENTS is
'内容';

comment on column OA_MEETING_MINUTES.M_REG_USER_ID is
'登记人id';

comment on column OA_MEETING_MINUTES.M_REG_USER_NAME is
'登记人name';

comment on column OA_MEETING_MINUTES.M_REG_TIME is
'登记时间';

comment on column OA_MEETING_MINUTES.M_ATTACH_ID is
'附件id';

/*==============================================================*/
/* Table: OA_MEETING_MINUTES_READER                             */
/*==============================================================*/
create table OA_MEETING_MINUTES_READER 
(
   M_READ_ID            VARCHAR2(50)         not null,
   M_MINUTES_ID         VARCHAR2(50)         not null,
   M_USER_ID            VARCHAR2(50)         not null,
   M_USER_NAME          VARCHAR2(40),
   M_FLAG               CHAR(1)              default '0',
   M_READ_TIME          DATE,
   ORDER_NO             VARCHAR2(10),
   constraint PK_OA_MEETING_MINUTES_READER primary key (M_READ_ID)
);

comment on column OA_MEETING_MINUTES_READER.M_READ_ID is
'主键id';

comment on column OA_MEETING_MINUTES_READER.M_MINUTES_ID is
'会议纪要id';

comment on column OA_MEETING_MINUTES_READER.M_USER_ID is
'阅读用户id';

comment on column OA_MEETING_MINUTES_READER.M_USER_NAME is
'阅读用户名';

comment on column OA_MEETING_MINUTES_READER.M_FLAG is
'是否已经阅读 0:未读，1：已读';

comment on column OA_MEETING_MINUTES_READER.M_READ_TIME is
'阅读时间';

comment on column OA_MEETING_MINUTES_READER.ORDER_NO is
'排序字段';

/*==============================================================*/
/* Table: OA_MEETING_NOTE_TEMPLATE                              */
/*==============================================================*/
create table OA_MEETING_NOTE_TEMPLATE 
(
   M_ID                 varchar2(50)         not null,
   M_NAME               varchar2(50)         not null,
   M_NOTICE_ID          varchar2(50),
   M_CONTENTS           varchar2(300)        not null,
   constraint PK_OA_MEETING_NOTE_TEMPLATE primary key (M_ID)
);

comment on table OA_MEETING_NOTE_TEMPLATE is
'会议发送消息模板';

comment on column OA_MEETING_NOTE_TEMPLATE.M_ID is
'主键id';

comment on column OA_MEETING_NOTE_TEMPLATE.M_NAME is
'短信模板名称';

comment on column OA_MEETING_NOTE_TEMPLATE.M_NOTICE_ID is
'会议id';

comment on column OA_MEETING_NOTE_TEMPLATE.M_CONTENTS is
' 短信内容';

/*==============================================================*/
/* Table: OA_MEETING_ROOM                                       */
/*==============================================================*/
create table OA_MEETING_ROOM 
(
   M_ROOM_ID            VARCHAR2(50)         not null,
   M_ROOM_CODE          VARCHAR2(30),
   M_ROOM_NAME          VARCHAR2(50)         not null,
   M_UNIT_ID            VARCHAR2(50)         not null,
   M_ADDRESS            VARCHAR2(400)        not null,
   M_PEOPLE_NUM         NUMBER,
   M_DEPT_ID            VARCHAR2(50),
   M_DEPT_NAME          VARCHAR2(50),
   M_IS_NEED_CHECK      VARCHAR2(1)          not null,
   M_REG_USER_ID        VARCHAR2(50)         not null,
   M_REG_USER_NAME      VARCHAR2(50)         not null,
   M_REG_TIME           DATE                 default SYSDATE not null,
   M_REMARK             VARCHAR2(1000),
   M_UNIT_NAME          VARCHAR2(200),
   M_IS_USE_FLAG        CHAR(1),
   ADMINISTRATOR_IDS    VARCHAR2(1024),
   ADMINISTRATOR_NAMES  VARCHAR2(4000),
   constraint PK_OA_MEETING_ROOM primary key (M_ROOM_ID)
);

comment on table OA_MEETING_ROOM is
'会议室信息表';

comment on column OA_MEETING_ROOM.M_ROOM_ID is
'会议室id';

comment on column OA_MEETING_ROOM.M_ROOM_CODE is
'会议室编码';

comment on column OA_MEETING_ROOM.M_ROOM_NAME is
'会议室名称';

comment on column OA_MEETING_ROOM.M_UNIT_ID is
'所属单位';

comment on column OA_MEETING_ROOM.M_ADDRESS is
'地点';

comment on column OA_MEETING_ROOM.M_PEOPLE_NUM is
'容纳人数';

comment on column OA_MEETING_ROOM.M_DEPT_ID is
'管理部门';

comment on column OA_MEETING_ROOM.M_DEPT_NAME is
'管理部门name';

comment on column OA_MEETING_ROOM.M_IS_NEED_CHECK is
'是否需要会议室管理员审核';

comment on column OA_MEETING_ROOM.M_REG_USER_ID is
'登记人id';

comment on column OA_MEETING_ROOM.M_REG_USER_NAME is
'登记人name';

comment on column OA_MEETING_ROOM.M_REG_TIME is
'登记时间';

comment on column OA_MEETING_ROOM.M_REMARK is
'备注';

comment on column OA_MEETING_ROOM.M_UNIT_NAME is
'所属单位名';

comment on column OA_MEETING_ROOM.M_IS_USE_FLAG is
'是否有效 1：有效，0：无效';

comment on column OA_MEETING_ROOM.ADMINISTRATOR_IDS is
'会议室管理员id列表';

comment on column OA_MEETING_ROOM.ADMINISTRATOR_NAMES is
'会议室管理员姓名列表';

/*==============================================================*/
/* Table: OA_MEETING_ROOM_ADMINISTRATOR                         */
/*==============================================================*/
create table OA_MEETING_ROOM_ADMINISTRATOR 
(
   M_ID                 VARCHAR2(50)         not null,
   M_USER_ID            VARCHAR2(50)         not null,
   M_USER_NAME          VARCHAR2(50)         not null,
   M_ROOM_ID            VARCHAR2(50),
   constraint PK_OA_MEETING_ROOM_ADMINISTRAT primary key (M_ID)
);

comment on table OA_MEETING_ROOM_ADMINISTRATOR is
'会议室管理员';

comment on column OA_MEETING_ROOM_ADMINISTRATOR.M_ID is
'主键id';

comment on column OA_MEETING_ROOM_ADMINISTRATOR.M_USER_ID is
'会议室管理员id';

comment on column OA_MEETING_ROOM_ADMINISTRATOR.M_USER_NAME is
'会议室管理员name';

comment on column OA_MEETING_ROOM_ADMINISTRATOR.M_ROOM_ID is
'会议室id';

/*==============================================================*/
/* Table: OA_MEETING_TEMPLATE                                   */
/*==============================================================*/
create table OA_MEETING_TEMPLATE 
(
   M_TMP_ID             VARCHAR2(50)         not null,
   M_TYPE_ID            VARCHAR2(50),
   M_TYPE_NAME          VARCHAR2(50),
   M_ROOM_ID            VARCHAR2(50),
   M_ROOM_NAME          VARCHAR2(50),
   M_TITLE              VARCHAR2(200),
   M_BEGIN_TIME         DATE,
   M_END_TIME           DATE,
   M_ADDRESS            VARCHAR2(400),
   M_LINK_USER_ID       VARCHAR2(50),
   M_LINK_USER_NAME     VARCHAR2(50),
   M_LINK_DEPT_ID       VARCHAR2(50),
   M_LINK_DEPT_NAME     VARCHAR2(200),
   M_LINK_TEL           VARCHAR2(50),
   M_MASTER_USER_ID     VARCHAR2(50),
   M_MASTER_USER_NAME   VARCHAR2(50),
   M_ATTENDER_COUNT     NUMBER,
   M_CLOSE_TIME         DATE,
   M_SEND_NAME          VARCHAR2(200),
   M_CONTENTS           CLOB,
   M_IS_NEED_SIGNUP     CHAR(1),
   M_RECEIVER_UNIT_IDS  CLOB,
   M_RECEIVER_USER_IDS  CLOB,
   M_RECEIVER_OTHER_UNIT_IDS CLOB,
   M_RECEIVER_OTHER_USER_IDS CLOB,
   M_RECEIVER_UNIT_NAMES CLOB,
   M_RECEIVER_USER_NAMES CLOB,
   M_RECEIVER_OTHER_UNIT_NAMES CLOB,
   M_RECEIVER_OTHER_USER_NAMES CLOB,
   M_TMP_CONTENTS       VARCHAR2(2048),
   M_TMP_CREATE_TIME    DATE,
   M_TMP_CREATOR_ID     VARCHAR2(50),
   M_TMP_CREATOR_NAME   VARCHAR2(50),
   M_MSG_TYPE           VARCHAR2(50),
   M_MSG_CONTENTS       VARCHAR2(300),
   M_TMP_UNIT_ID        VARCHAR2(50),
   M_TMP_UNIT_NAME      VARCHAR2(200),
   constraint PK_OA_MEETING_TEMPLATE primary key (M_TMP_ID)
);

comment on table OA_MEETING_TEMPLATE is
'会议通知模板管理';

comment on column OA_MEETING_TEMPLATE.M_TMP_ID is
'主键id';

comment on column OA_MEETING_TEMPLATE.M_TYPE_ID is
'会议类型id';

comment on column OA_MEETING_TEMPLATE.M_TYPE_NAME is
'会议类型name';

comment on column OA_MEETING_TEMPLATE.M_ROOM_ID is
'会议室id';

comment on column OA_MEETING_TEMPLATE.M_ROOM_NAME is
'会议室name';

comment on column OA_MEETING_TEMPLATE.M_TITLE is
'标题';

comment on column OA_MEETING_TEMPLATE.M_BEGIN_TIME is
'会议开始时间';

comment on column OA_MEETING_TEMPLATE.M_END_TIME is
'会议结束时间';

comment on column OA_MEETING_TEMPLATE.M_ADDRESS is
'地点';

comment on column OA_MEETING_TEMPLATE.M_LINK_USER_ID is
'联系人（默认当前申请人）';

comment on column OA_MEETING_TEMPLATE.M_LINK_USER_NAME is
'联系人name';

comment on column OA_MEETING_TEMPLATE.M_LINK_DEPT_ID is
'联系部门（默认当前申请人所在的部门）';

comment on column OA_MEETING_TEMPLATE.M_LINK_DEPT_NAME is
'部门name';

comment on column OA_MEETING_TEMPLATE.M_LINK_TEL is
'联系电话';

comment on column OA_MEETING_TEMPLATE.M_MASTER_USER_ID is
'主持人id';

comment on column OA_MEETING_TEMPLATE.M_MASTER_USER_NAME is
'主持人name';

comment on column OA_MEETING_TEMPLATE.M_ATTENDER_COUNT is
'与会人数';

comment on column OA_MEETING_TEMPLATE.M_CLOSE_TIME is
'报名截止日期';

comment on column OA_MEETING_TEMPLATE.M_SEND_NAME is
'发送名义（默认为“单位名义发送）';

comment on column OA_MEETING_TEMPLATE.M_CONTENTS is
'会议正文';

comment on column OA_MEETING_TEMPLATE.M_IS_NEED_SIGNUP is
'是否需要报名（0否1是，默认不报名）';

comment on column OA_MEETING_TEMPLATE.M_RECEIVER_UNIT_IDS is
'参会单位ids';

comment on column OA_MEETING_TEMPLATE.M_RECEIVER_USER_IDS is
'参会人员ids';

comment on column OA_MEETING_TEMPLATE.M_RECEIVER_OTHER_UNIT_IDS is
'其他参会单位ids';

comment on column OA_MEETING_TEMPLATE.M_RECEIVER_OTHER_USER_IDS is
'其他参会人员ids';

comment on column OA_MEETING_TEMPLATE.M_RECEIVER_UNIT_NAMES is
'参会单位names';

comment on column OA_MEETING_TEMPLATE.M_RECEIVER_USER_NAMES is
'参会人员names';

comment on column OA_MEETING_TEMPLATE.M_RECEIVER_OTHER_UNIT_NAMES is
'其他参会单位names';

comment on column OA_MEETING_TEMPLATE.M_RECEIVER_OTHER_USER_NAMES is
'其他参会人员names';

comment on column OA_MEETING_TEMPLATE.M_TMP_CONTENTS is
'模板说明';

comment on column OA_MEETING_TEMPLATE.M_TMP_CREATE_TIME is
'模板登记时间';

comment on column OA_MEETING_TEMPLATE.M_TMP_CREATOR_ID is
'模板创建人id';

comment on column OA_MEETING_TEMPLATE.M_TMP_CREATOR_NAME is
'模板创建人姓名';

comment on column OA_MEETING_TEMPLATE.M_MSG_TYPE is
'msg类别 短信or信息';

comment on column OA_MEETING_TEMPLATE.M_MSG_CONTENTS is
'msg内容';

comment on column OA_MEETING_TEMPLATE.M_TMP_UNIT_ID is
'模板所属单位id';

comment on column OA_MEETING_TEMPLATE.M_TMP_UNIT_NAME is
'模板所属单位名';

/*==============================================================*/
/* Table: OA_MEETING_TYPE                                       */
/*==============================================================*/
create table OA_MEETING_TYPE 
(
   M_TYPE_ID            VARCHAR2(50)         not null,
   M_TYPE_CODE          VARCHAR2(50),
   M_TYPE_NAME          VARCHAR2(100)        not null,
   M_UNIT_ID            VARCHAR2(50)         not null,
   M_IS_USE_FLAG        VARCHAR2(1)          not null,
   M_IS_USE_TIME        DATE,
   M_REG_USER_ID        VARCHAR2(50)         not null,
   M_REG_USER_NAME      VARCHAR2(50)         not null,
   M_REG_TIME           DATE                 default SYSDATE not null,
   M_REMARK             VARCHAR2(1000),
   M_UNIT_NAME          VARCHAR2(200),
   constraint PK_OA_MEETING_TYPE primary key (M_TYPE_ID)
);

comment on table OA_MEETING_TYPE is
'会议类型表';

comment on column OA_MEETING_TYPE.M_TYPE_ID is
'会议类型id';

comment on column OA_MEETING_TYPE.M_TYPE_CODE is
'会议类型编码';

comment on column OA_MEETING_TYPE.M_TYPE_NAME is
'会议类型名称';

comment on column OA_MEETING_TYPE.M_UNIT_ID is
'所属单位';

comment on column OA_MEETING_TYPE.M_IS_USE_FLAG is
'是否有效(1有效0无效)';

comment on column OA_MEETING_TYPE.M_IS_USE_TIME is
'有效时间(必须在此时间之前使用)';

comment on column OA_MEETING_TYPE.M_REG_USER_ID is
'登记人id';

comment on column OA_MEETING_TYPE.M_REG_USER_NAME is
'登记人name';

comment on column OA_MEETING_TYPE.M_REG_TIME is
'登记时间';

comment on column OA_MEETING_TYPE.M_REMARK is
'备注';

comment on column OA_MEETING_TYPE.M_UNIT_NAME is
'所属单位名';

/*==============================================================*/
/* Table: oa_meeting_attender                                   */
/*==============================================================*/
create table oa_meeting_attender 
(
   m_id                 varchar2(50)         not null,
   m_receiver_id        varchar2(50)         not null,
   m_user_id            varchar2(50)         not null,
   m_user_name          varchar2(50)         not null,
   m_unit_id            varchar2(50)         not null,
   m_unit_name          varchar2(50)         not null,
   constraint PK_OA_MEETING_ATTENDER primary key (m_id)
);

comment on table oa_meeting_attender is
'参会人员表';

comment on column oa_meeting_attender.m_id is
'主键id';

comment on column oa_meeting_attender.m_receiver_id is
'接收者id';

comment on column oa_meeting_attender.m_user_id is
'人员id';

comment on column oa_meeting_attender.m_user_name is
'人员name';

comment on column oa_meeting_attender.m_unit_id is
'人员所属单位id';

comment on column oa_meeting_attender.m_unit_name is
'人员所属单位name';

/*==============================================================*/
/* Table: oa_meeting_check_status                               */
/*==============================================================*/
create table oa_meeting_check_status 
(
   m_id                 varchar2(50)         not null,
   m_notice_id          varchar2(50)         not null,
   m_user_id            varchar2(50)         not null,
   m_user_name          varchar2(50)         not null,
   m_flag               char(1)              not null,
   m_create_time        DATE                 default SYSDATE not null,
   constraint PK_OA_MEETING_CHECK_STATUS primary key (m_id)
);

comment on table oa_meeting_check_status is
'会议送审情况';

comment on column oa_meeting_check_status.m_id is
'主键id';

comment on column oa_meeting_check_status.m_notice_id is
'会议通知id';

comment on column oa_meeting_check_status.m_user_id is
'审核人id';

comment on column oa_meeting_check_status.m_user_name is
'审核人name';

comment on column oa_meeting_check_status.m_flag is
'审核状态';

comment on column oa_meeting_check_status.m_create_time is
'创建时间';

/*==============================================================*/
/* Table: oa_meeting_flag_type                                  */
/*==============================================================*/
create table oa_meeting_flag_type 
(
   M_TYPE_ID            varchar2(50)         not null,
   M_TYPE_CODE          varchar2(50)         not null,
   M_TYPE_NAME          varchar2(50)         not null
);

comment on table oa_meeting_flag_type is
'会议状态类型';

/*==============================================================*/
/* Table: oa_meeting_msg_log                                    */
/*==============================================================*/
create table oa_meeting_msg_log 
(
   m_id                 VARCHAR2(50)         not null,
   m_notice_id          VARCHAR2(50)         not null,
   m_contents           VARCHAR2(300),
   m_msg_type           VARCHAR2(50)         not null,
   m_msg_send_flag      CHAR(1)              not null,
   m_msg_send_flag_name VARCHAR2(50)         not null,
   constraint PK_OA_MEETING_MSG_LOG primary key (m_id)
);

comment on table oa_meeting_msg_log is
'会议通知发送消息日志';

comment on column oa_meeting_msg_log.m_id is
'主键';

comment on column oa_meeting_msg_log.m_notice_id is
'会议通知id';

comment on column oa_meeting_msg_log.m_contents is
'msg内容';

comment on column oa_meeting_msg_log.m_msg_type is
'msg类别 短信or信息';

comment on column oa_meeting_msg_log.m_msg_send_flag is
'发送类型重发、补发、发布、草稿、催发';

comment on column oa_meeting_msg_log.m_msg_send_flag_name is
'发送类型name';

/*==============================================================*/
/* Table: oa_meeting_notice                                     */
/*==============================================================*/
create table oa_meeting_notice 
(
   m_notice_id          varchar2(50)         not null,
   m_type_id            varchar2(50)         ,
   m_type_name          varchar2(50)         ,
   m_room_id            varchar2(50),
   m_room_name          varchar2(50),
   m_title              varchar2(200)        not null,
   m_begin_time         date                 not null,
   m_end_time           date                 not null,
   m_address            varchar2(400)        not null,
   m_link_user_id       varchar2(50)         not null,
   m_link_user_name     varchar2(50)         not null,
   m_link_dept_id       varchar2(50)         not null,
   m_link_dept_name     varchar2(50)         not null,
   m_link_tel           varchar2(50)         ,
   m_master_user_id     varchar2(50)         ,
   m_master_user_name   varchar2(50)         ,
   m_attender_count     number               ,
   m_close_time         date,
   m_send_name          varchar2(200)        ,
   m_contents           CLOB,
   m_is_need_signup     char(1)              not null,
   m_create_user_id     varchar2(50)         not null,
   m_create_user_name   varchar2(50)         not null,
   m_create_time        date                 default SYSDATE not null,
   m_create_dept_id     varchar2(50)         not null,
   m_create_dept_name   varchar2(200)         not null,
   m_create_unit_id     varchar2(50)          ,
   m_create_unit_name   varchar2(200)          ,
   m_check_flag         varchar2(50)         not null,
   m_check_flag_name    CHAR(10)             not null,
   m_check_user_id      varchar2(50),
   m_check_user_name    varchar2(50),
   m_check_time         date,
   m_current_user_id    varchar2(50),
   m_current_user_name  varchar2(50),
   m_current_time       date,
   m_is_addsend         char(1),
   m_is_resend          char(1),
   m_receiver_unit_ids  CLOB,
   m_receiver_user_ids  CLOB,
   m_receiver_other_unit_ids CLOB,
   m_receiver_other_user_ids CLOB,
   m_receiver_unit_names CLOB,
   m_receiver_user_names CLOB,
   m_receiver_other_unit_names CLOB,
   m_receiver_other_user_names CLOB,
   m_DJBH               varchar2(50),
   m_remark             varchar2(1000),
   m_other_user_input          CLOB,
   constraint PK_OA_MEETING_NOTICE primary key (m_notice_id)
);

comment on table oa_meeting_notice is
'会议通知表';

comment on column oa_meeting_notice.m_notice_id is
'会议通知id';

comment on column oa_meeting_notice.m_type_id is
'会议类型id';

comment on column oa_meeting_notice.m_type_name is
'会议类型name';

comment on column oa_meeting_notice.m_room_id is
'会议室id';

comment on column oa_meeting_notice.m_room_name is
'会议室name';

comment on column oa_meeting_notice.m_title is
'标题';

comment on column oa_meeting_notice.m_begin_time is
'会议开始时间';

comment on column oa_meeting_notice.m_end_time is
'会议结束时间';

comment on column oa_meeting_notice.m_address is
'地点(默认显示会议室地点)';

comment on column oa_meeting_notice.m_link_user_id is
'联系人（默认当前申请人）';

comment on column oa_meeting_notice.m_link_user_name is
'联系人name';

comment on column oa_meeting_notice.m_link_dept_id is
'联系部门（默认当前申请人所在的部门）';

comment on column oa_meeting_notice.m_link_dept_name is
'联系部门name';

comment on column oa_meeting_notice.m_link_tel is
'联系电话';

comment on column oa_meeting_notice.m_master_user_id is
'主持人';

comment on column oa_meeting_notice.m_master_user_name is
'主持人name';

comment on column oa_meeting_notice.m_attender_count is
'与会人数';

comment on column oa_meeting_notice.m_close_time is
'报名截止日期';

comment on column oa_meeting_notice.m_send_name is
'发送名义（默认为“单位名义发送）';

comment on column oa_meeting_notice.m_contents is
'会议正文';

comment on column oa_meeting_notice.m_is_need_signup is
'是否需要报名（0否1是，默认不报名）';

comment on column oa_meeting_notice.m_create_user_id is
'申请人id';

comment on column oa_meeting_notice.m_create_user_name is
'申请人name';

comment on column oa_meeting_notice.m_create_time is
'申请时间';

comment on column oa_meeting_notice.m_create_dept_id is
'申请人部门id';

comment on column oa_meeting_notice.m_create_dept_name is
'申请人部门name';

comment  on column oa_meeting_notice.m_create_unit_id is '申请人单位id';
comment  on column oa_meeting_notice.m_create_unit_name is '申请人单位name';

comment on column oa_meeting_notice.m_check_flag is
'会议通知状态(见后台静态常量)';

comment on column oa_meeting_notice.m_check_flag_name is
'会议通知状态name';

comment on column oa_meeting_notice.m_check_user_id is
'审核人id';

comment on column oa_meeting_notice.m_check_user_name is
'审核人name';

comment on column oa_meeting_notice.m_check_time is
'审核时间';

comment on column oa_meeting_notice.m_current_user_id is
'发布人id';

comment on column oa_meeting_notice.m_current_user_name is
'发布人name';

comment on column oa_meeting_notice.m_current_time is
'发布时间';

comment on column oa_meeting_notice.m_is_addsend is
'是否补发(1是,0否,默认0)';

comment on column oa_meeting_notice.m_is_resend is
'是否重发(1是,0否,默认0)';

comment on column oa_meeting_notice.m_receiver_unit_ids is
'参会单位ids';

comment on column oa_meeting_notice.m_receiver_user_ids is
'参会人员ids';

comment on column oa_meeting_notice.m_receiver_other_unit_ids is
'其他参会单位ids';

comment on column oa_meeting_notice.m_receiver_other_user_ids is
'其他参会人员ids';

comment on column oa_meeting_notice.m_receiver_unit_names is
'参会单位names';

comment on column oa_meeting_notice.m_receiver_user_names is
'参会人员names';

comment on column oa_meeting_notice.m_receiver_other_unit_names is
'其他参会单位names';

comment on column oa_meeting_notice.m_receiver_other_user_names is
'其他参会人员names';

comment on column oa_meeting_notice.m_DJBH is
'附件id';

comment on column oa_meeting_notice.m_remark is
'备注';

comment on column oa_meeting_notice.m_other_user_input is
'其他人员names';
/*==============================================================*/
/* Table: oa_meeting_notice_flaglog                             */
/*==============================================================*/
create table oa_meeting_notice_flaglog 
(
   m_id                 varchar2(50)         not null,
   m_notice_id          varchar2(50),
   m_flag               char(2)              not null,
   m_create_user_id     varchar2(50)         not null,
   m_create_user_name   varchar2(50)         not null,
   m_create_time        date                 default SYSDATE not null,
   constraint PK_OA_MEETING_NOTICE_FLAGLOG primary key (m_id)
);

comment on table oa_meeting_notice_flaglog is
'会议通知状态日志';

comment on column oa_meeting_notice_flaglog.m_id is
'主键id';

comment on column oa_meeting_notice_flaglog.m_notice_id is
'会议通知主键';

comment on column oa_meeting_notice_flaglog.m_flag is
'状态位';

comment on column oa_meeting_notice_flaglog.m_create_user_id is
'操作人员id';

comment on column oa_meeting_notice_flaglog.m_create_user_name is
'操作人员name';

comment on column oa_meeting_notice_flaglog.m_create_time is
'操作时间';

/*==============================================================*/
/* Table: oa_meeting_receiver_unit                              */
/*==============================================================*/
create table oa_meeting_receiver_unit 
(
   m_receiver_id        varchar2(50)         not null,
   m_notice_id          varchar2(50)         not null,
   m_receiver_unit_id   varchar2(50),
   m_receiver_unit_name varchar2(50),
   m_is_other           char(1),
   m_create_time        date                 default SYSDATE,
   m_is_addrend         char(1),
   m_is_resend          char(1),
   m_is_call            char(1),
   m_call_type          varchar2(50),
   m_is_reply           char(1)              default '0' not null,
   m_is_reply_name      varchar2(50),
   m_reply              varchar2(1000),
   m_reply_time         date,
   m_is_read            char(1)              default '0' not null,
   m_read_time          date,
   m_link_user_id       varchar2(50),
   m_link_user_name     varchar2(50),
   m_link_tel           varchar2(50),
   m_is_log             char(50),
   m_attender_count     number,
   m_attender_ids       CLOB,
   m_attender_names     CLOB,
   constraint PK_OA_MEETING_RECEIVER_UNIT primary key (m_receiver_id)
);

comment on table oa_meeting_receiver_unit is
'参会接收者（与会单位）';

comment on column oa_meeting_receiver_unit.m_receiver_id is
'主键id';

comment on column oa_meeting_receiver_unit.m_notice_id is
'会议通知id';

comment on column oa_meeting_receiver_unit.m_receiver_unit_id is
'接收单位id';

comment on column oa_meeting_receiver_unit.m_receiver_unit_name is
'接收单位name';

comment on column oa_meeting_receiver_unit.m_is_other is
'是否是其他人员或单位(1是,0否)';

comment on column oa_meeting_receiver_unit.m_create_time is
'接收时间(记录产生时间,默认插入)';

comment on column oa_meeting_receiver_unit.m_is_addrend is
'是否补发过(1是,0否,默认0)';

comment on column oa_meeting_receiver_unit.m_is_resend is
'是否重发过(1是,0否,默认0)';

comment on column oa_meeting_receiver_unit.m_is_call is
'是否催报过(1是,0否,默认0)';

comment on column oa_meeting_receiver_unit.m_call_type is
'催报类型';

comment on column oa_meeting_receiver_unit.m_is_reply is
'回复状态(1参加,0未报名,2请假)以下在报名时录入';

comment on column oa_meeting_receiver_unit.m_is_reply_name is
'回复状态name';

comment on column oa_meeting_receiver_unit.m_reply is
'回复备注';

comment on column oa_meeting_receiver_unit.m_reply_time is
'回复时间';

comment on column oa_meeting_receiver_unit.m_is_read is
'是否已读(1是,0否,默认0)';

comment on column oa_meeting_receiver_unit.m_read_time is
'已读时间';

comment on column oa_meeting_receiver_unit.m_link_user_id is
'联系人id';

comment on column oa_meeting_receiver_unit.m_link_user_name is
'联系人name';

comment on column oa_meeting_receiver_unit.m_link_tel is
'联系电话';

comment on column oa_meeting_receiver_unit.m_is_log is
'是否写入日程';

comment on column oa_meeting_receiver_unit.m_attender_count is
'参会人数';

comment on column oa_meeting_receiver_unit.m_attender_ids is
'参会人员ids';

comment on column oa_meeting_receiver_unit.m_attender_names is
'参会人员names';

/*==============================================================*/
/* Table: oa_meeting_receiver_user                              */
/*==============================================================*/
create table oa_meeting_receiver_user 
(
   m_receiver_id        varchar2(50)         not null,
   m_notice_id          varchar2(50)         not null,
   m_receiver_user_id   varchar2(50),
   m_receiver_user_name varchar2(50),
   m_receiver_unit_id   varchar2(50),
   m_receiver_unit_name varchar2(50),
   m_is_other           char(1),
   m_create_time        date                 default SYSDATE not null,
   m_is_addrend         char(1),
   m_is_resend          char(1),
   m_is_call            char(1),
   m_call_type          varchar2(50),
   m_is_reply           char(1)              default '0' not null,
   m_is_reply_name      varchar2(50),
   m_reply              varchar2(1000),
   m_reply_time         date,
   m_is_read            char(1)              default '0' not null,
   m_read_time          date,
   m_link_user_id       varchar2(50),
   m_link_user_name     varchar2(50),
   m_link_tel           varchar2(50),
   m_is_log             char(50),
   m_attender_count     number,
   m_attender_ids       CLOB,
   m_attender_names     CLOB,
   constraint PK_OA_MEETING_RECEIVER_USER primary key (m_receiver_id)
);

comment on table oa_meeting_receiver_user is
'参会接收者（与会人员）';

comment on column oa_meeting_receiver_user.m_receiver_id is
'主键id';

comment on column oa_meeting_receiver_user.m_notice_id is
'会议通知id';

comment on column oa_meeting_receiver_user.m_receiver_user_id is
'接收人id';

comment on column oa_meeting_receiver_user.m_receiver_user_name is
'接收人name';

comment on column oa_meeting_receiver_user.m_receiver_unit_id is
'接收人所属单位id';

comment on column oa_meeting_receiver_user.m_receiver_unit_name is
'接收人所属单位name';

comment on column oa_meeting_receiver_user.m_is_other is
'是否是其他人员或单位(1是,0否)';

comment on column oa_meeting_receiver_user.m_create_time is
'接收时间(记录产生时间,默认插入)';

comment on column oa_meeting_receiver_user.m_is_addrend is
'是否补发过(1是,0否,默认0)';

comment on column oa_meeting_receiver_user.m_is_resend is
'是否重发过(1是,0否,默认0)';

comment on column oa_meeting_receiver_user.m_is_call is
'是否催报过(1是,0否,默认0)';

comment on column oa_meeting_receiver_user.m_call_type is
'催报类型';

comment on column oa_meeting_receiver_user.m_is_reply is
'回复状态(1参加,0未报名,2请假)以下在报名时录入';

comment on column oa_meeting_receiver_user.m_is_reply_name is
'回复状态name';

comment on column oa_meeting_receiver_user.m_reply is
'回复备注';

comment on column oa_meeting_receiver_user.m_reply_time is
'回复时间';

comment on column oa_meeting_receiver_user.m_is_read is
'是否已读(1是,0否,默认0)';

comment on column oa_meeting_receiver_user.m_read_time is
'已读时间';

comment on column oa_meeting_receiver_user.m_link_user_id is
'联系人id';

comment on column oa_meeting_receiver_user.m_link_user_name is
'联系人name';

comment on column oa_meeting_receiver_user.m_link_tel is
'联系电话';

comment on column oa_meeting_receiver_user.m_is_log is
'是否写入日程';

comment on column oa_meeting_receiver_user.m_attender_count is
'参会人数';

comment on column oa_meeting_receiver_user.m_attender_ids is
'参会人员ids';

comment on column oa_meeting_receiver_user.m_attender_names is
'参会人员names';

/*==============================================================*/
/* Table: oa_meeting_roomoccupancy                              */
/*==============================================================*/
create table oa_meeting_roomoccupancy 
(
   m_ro_id              varchar2(50)         not null,
   m_room_id            varchar2(50)         not null,
   m_room_name          varchar2(50)         not null,
   m_title              varchar2(200)        not null,
   m_begin_time         date,
   m_end_time           date,
   m_link_userid        varchar2(50),
   m_link_username      varchar2(100),
   m_link_tel           varchar2(50),
   constraint PK_OA_MEETING_ROOMOCCUPANCY primary key (m_ro_id)
);

comment on table oa_meeting_roomoccupancy is
'会议室占用情况';

comment on column oa_meeting_roomoccupancy.m_ro_id is
'主键id';

comment on column oa_meeting_roomoccupancy.m_room_id is
'会议室id';

comment on column oa_meeting_roomoccupancy.m_room_name is
'会议室名称';

comment on column oa_meeting_roomoccupancy.m_title is
'会议标题';

comment on column oa_meeting_roomoccupancy.m_begin_time is
'会议开始时间';

comment on column oa_meeting_roomoccupancy.m_end_time is
'会议结束时间';

comment on column oa_meeting_roomoccupancy.m_link_userid is
'联系人ID';

comment on column oa_meeting_roomoccupancy.m_link_username is
'联系人';

comment on column oa_meeting_roomoccupancy.m_link_tel is
'联系人电话';

/*==============================================================*/
/* Table: oa_meeting_topic                                      */
/*==============================================================*/
create table oa_meeting_topic 
(
   m_topic_id           varchar2(50)         not null,
   m_notice_id          varchar2(50)         not null,
   m_topic_name         varchar2(200)        not null,
   m_begin_time         date                 not null,
   m_user_id            varchar2(50)         not null,
   m_user_name          varchar2(50)         not null,
   m_remark             varchar2(1000),
   m_topic_unit_ids     CLOB,
   m_topic_user_ids     CLOB,
   m_topic_unit_names   CLOB,
   m_topic_user_names   CLOB,
   constraint PK_OA_MEETING_TOPIC primary key (m_topic_id)
);

comment on table oa_meeting_topic is
'会议议题表';

comment on column oa_meeting_topic.m_topic_id is
'议题id';

comment on column oa_meeting_topic.m_notice_id is
'会议通知id';

comment on column oa_meeting_topic.m_topic_name is
'议题名称';

comment on column oa_meeting_topic.m_begin_time is
'开始时间';

comment on column oa_meeting_topic.m_user_id is
'汇报人id';

comment on column oa_meeting_topic.m_user_name is
'汇报人name';

comment on column oa_meeting_topic.m_remark is
'备注';

comment on column oa_meeting_topic.m_topic_unit_ids is
'议题参与单位ids';

comment on column oa_meeting_topic.m_topic_user_ids is
'议题参与人员ids';

comment on column oa_meeting_topic.m_topic_unit_names is
'议题参与单位names';

comment on column oa_meeting_topic.m_topic_user_names is
'议题参与单位names';


/*==============================================================*/
/* View: V_USER_ORG_INFO                                        */
/*==============================================================*/
create or replace view V_USER_ORG_INFO as
select  a.user_id,u.user_name,u.user_realname, a.org_id, b.org_name,u.user_worktel,u.user_mobiletel1
  from (select a.user_id, min(a.job_sn), a.org_id
          from td_sm_userjoborg a
         group by a.user_id, a.org_id) a
 inner join td_sm_ORGANIZATION b on a.org_id = b.org_id
 inner join td_sm_user u       on u.user_id = a.user_id;
 comment on table V_USER_ORG_INFO is
'用户组织与联系信息';


CREATE OR REPLACE FUNCTION get_uuid
RETURN VARCHAR
IS
guid VARCHAR (50);
BEGIN
guid := lower(RAWTOHEX(sys_guid()));
RETURN
substr(guid,1,8)||'-'||substr(guid,9,4)||'-'||substr(guid,13,4)||'-'||substr(guid,17,4)||'-'||substr(guid,21,12);
END get_uuid;

drop trigger MOBILE_BUSI_HUIYI_TR4INSERT
/

drop table MOBILE_BUSI_HUIYI cascade constraints
/

/*==============================================================*/
/* Table: MOBILE_BUSI_HUIYI                                     */
/*==============================================================*/
create table MOBILE_BUSI_HUIYI 
(
   HY_BT                VARCHAR2(200),
   HY_KSSJ              DATE,
   HY_JSSJ              DATE,
   HY_DD                VARCHAR2(200),
   HY_LXBM              VARCHAR2(50),
   HY_LXR               VARCHAR2(50),
   HY_LXDH              VARCHAR2(50),
   HY_CYR               VARCHAR2(200),
   CONTENT              VARCHAR2(200),
   M_TYPE_ID            VARCHAR2(50),
   M_TYPE_NAME          VARCHAR2(50),
   M_IS_NEED_SIGNUP     CHAR,
   M_CREATE_USER_ID     VARCHAR2(50),
   M_CREATE_USER_NAME   VARCHAR2(50),
   M_CREATE_TIME        DATE,
   M_CREATE_DEPT_ID     VARCHAR2(50),
   M_CREATE_DEPT_NAME   VARCHAR2(50),
   M_CHECK_FLAG         CHAR,
   M_CHECK_FLAG_NAME    CHAR(10),
   HY_CYRID             VARCHAR2(200),
   HY_LXRID             VARCHAR2(50),
   HY_LXBMID            VARCHAR2(50),
   M_CURRENT_USER_ID    VARCHAR2(50),
   M_CURRENT_USER_NAME  VARCHAR2(50),
   M_CURRENT_TIME       DATE
)
/

comment on table MOBILE_BUSI_HUIYI is
'移动端会议中间表'
/

comment on column MOBILE_BUSI_HUIYI.HY_BT is
'会议标题'
/

comment on column MOBILE_BUSI_HUIYI.HY_KSSJ is
'开始时间'
/

comment on column MOBILE_BUSI_HUIYI.HY_JSSJ is
'结束时间'
/

comment on column MOBILE_BUSI_HUIYI.HY_DD is
'地点'
/

comment on column MOBILE_BUSI_HUIYI.HY_LXBM is
'联系部门'
/

comment on column MOBILE_BUSI_HUIYI.HY_LXR is
'联系人'
/

comment on column MOBILE_BUSI_HUIYI.HY_LXDH is
'联系电话'
/

comment on column MOBILE_BUSI_HUIYI.HY_CYR is
'参与人'
/

comment on column MOBILE_BUSI_HUIYI.CONTENT is
'内容'
/

comment on column MOBILE_BUSI_HUIYI.M_TYPE_ID is
'会议类型id'
/

comment on column MOBILE_BUSI_HUIYI.M_TYPE_NAME is
'会议类型name'
/

comment on column MOBILE_BUSI_HUIYI.M_IS_NEED_SIGNUP is
'是否需要报名（0否1是，默认不报名）'
/

comment on column MOBILE_BUSI_HUIYI.M_CREATE_USER_ID is
'申请人id'
/

comment on column MOBILE_BUSI_HUIYI.M_CREATE_USER_NAME is
'申请人name'
/

comment on column MOBILE_BUSI_HUIYI.M_CREATE_TIME is
'申请时间'
/

comment on column MOBILE_BUSI_HUIYI.M_CREATE_DEPT_ID is
'申请人部门id'
/

comment on column MOBILE_BUSI_HUIYI.M_CREATE_DEPT_NAME is
'申请人部门name'
/

comment on column MOBILE_BUSI_HUIYI.M_CHECK_FLAG is
'会议通知状态'
/

comment on column MOBILE_BUSI_HUIYI.M_CHECK_FLAG_NAME is
'会议通知状态name'
/

comment on column MOBILE_BUSI_HUIYI.HY_CYRID is
'参与人id'
/

comment on column MOBILE_BUSI_HUIYI.HY_LXRID is
'联系人id'
/

comment on column MOBILE_BUSI_HUIYI.HY_LXBMID is
'联系部门id'
/

comment on column MOBILE_BUSI_HUIYI.M_CURRENT_USER_ID is
'发布人'
/

comment on column MOBILE_BUSI_HUIYI.M_CURRENT_USER_NAME is
'发布name'
/

comment on column MOBILE_BUSI_HUIYI.M_CURRENT_TIME is
'发布时间'
/


create or replace trigger MOBILE_BUSI_HUIYI_TR4INSERT
  after insert
ON mobile_busi_huiyi
  FOR EACH ROW
DECLARE
  NEW_NOTICE_ID varchar2(50);
BEGIN
  select get_uuid() into NEW_NOTICE_ID from dual; --记住主键id值用于从表的插入
  IF INSERTING THEN
    insert into oa_meeting_notice
      (m_notice_id,
       m_title,
       m_type_id,
       m_type_name,
       m_begin_time,
       m_end_time,
       m_address,
       m_link_user_id,
       m_link_user_name,
       m_link_dept_id,
       m_link_dept_name,
       m_link_tel,
       m_is_need_signup, --
       m_create_user_id,
       m_create_user_name,
       m_create_time,
       m_create_dept_id,
       m_create_dept_name,
       m_check_flag,
       m_check_flag_name, --
       m_current_user_id,
       m_current_user_name,
       m_current_time,
       m_is_addsend,
       m_is_resend,
       m_receiver_user_ids,
       m_receiver_user_names,
       m_contents)
    values
      (NEW_NOTICE_ID,
       :new.hy_bt,
       :new.m_type_id,
       :new.m_type_name,
       :new.hy_kssj,
       :new.hy_jssj,
       :new.hy_dd,
       :new.hy_lxrid,
       :new.hy_lxr,
       :new.hy_lxbmid,
       :new.hy_lxbm,
       :new.hy_lxdh,
       :new.m_is_need_signup,
       :new.m_create_user_id,
       :new.m_create_user_name,
       :new.m_create_time,
       :new.m_create_dept_id,
       :new.m_create_dept_name,
       :new.m_check_flag,
       :new.m_check_flag_name,
       :new.m_current_user_id,
       :new.m_current_user_name,
       :new.m_current_time,
       '0',
       '0',
       :new.hy_cyrid,
       :new.hy_cyr,
       :new.content);
  
    if (:new.hy_cyrid is not null) then
      insert into oa_meeting_receiver_user u
        (m_receiver_id,
         m_notice_id,
         m_receiver_user_id,
         m_receiver_user_name,
         m_receiver_unit_id,
         m_receiver_unit_name,
         m_create_time, --接收时间 或者说 发布时间
         m_is_addrend,
         m_is_resend,
         m_is_call)
        select get_uuid(),
               NEW_NOTICE_ID,
               COLUMN_VALUE,
               (select d.user_name
                  from td_sm_user d
                 where d.user_id = COLUMN_VALUE),
               (select org.org_id
                  from td_sm_orguser org
                 where org.user_id = t.COLUMN_VALUE),
               (select t.org_name
                  from td_sm_orguser org, TD_SM_ORGANIZATION t
                 where t.org_id = org.org_id
                   and org.user_id = t.COLUMN_VALUE),
               :new.m_current_time,
               '0',
               '0',
               '0'
          from table(split(:new.HY_CYRID, ',')) t;
    end if;
  end if;
END MOBILE_BUSI_HUIYI_TR4INSERT;
/

drop trigger mobile_busi_huiyihf_TR4INSERT
/

drop table MOBILE_BUSI_HUIYIHF cascade constraints
/

/*==============================================================*/
/* Table: MOBILE_BUSI_HUIYIHF                                   */
/*==============================================================*/
create table MOBILE_BUSI_HUIYIHF 
(
   HY_REPLAY            VARCHAR2(200),
   HY_CYR               VARCHAR2(50),
   HY_REASON            VARCHAR2(200),
   HY_ID                VARCHAR2(200),
   M_CREATE_TIME        DATE,
   M_IS_READ            CHAR,
   M_REPLY_TIME         DATE,
   HY_CYRID             VARCHAR2(50),
   HY_CYRBMID           VARCHAR2(50),
   HY_CYRBM             VARCHAR2(50)
)
/

comment on table MOBILE_BUSI_HUIYIHF is
'移动端会议回复中间表'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_REPLAY is
'回复状态(1参加,0未报名,2请假)'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_CYR is
'参与人'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_REASON is
'请假内容'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_ID is
'会议id'
/

comment on column MOBILE_BUSI_HUIYIHF.M_CREATE_TIME is
'接收时间(会议通知发送的时间 即记录产生时间,默认插入)'
/

comment on column MOBILE_BUSI_HUIYIHF.M_IS_READ is
'是否已读(1是,0否,默认0)'
/

comment on column MOBILE_BUSI_HUIYIHF.M_REPLY_TIME is
'回复时间 (与会人员确认回复时间)'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_CYRID is
'参与人id'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_CYRBMID is
'参与人部门id'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_CYRBM is
'参与人部门'
/


create or replace trigger mobile_busi_huiyihf_TR4INSERT
  after insert
ON mobile_busi_huiyihf
  FOR EACH ROW
DECLARE
  M_RECEIVER_ID varchar2(50);
BEGIN
  select u.m_receiver_id
    into M_RECEIVER_ID
    from oa_meeting_receiver_user u
   where u.m_receiver_user_id = :new.HY_CYRID
     and u.m_notice_id = :new.HY_ID;

  IF INSERTING THEN
    update oa_meeting_receiver_user u
       set u.m_reply_time    = :new.M_CREATE_TIME,
           u.m_read_time     = :new.M_CREATE_TIME,
           u.m_is_reply      = :new.HY_REPLAY,
           u.m_is_read       = '1',
           u.m_is_reply_name = decode(:new.HY_REPLAY,
                                      '1',
                                      '参加',
                                      '2',
                                      '请假',
                                      '0'),
           u.m_reply         = :new.HY_REASON 
     where u.m_receiver_id = M_RECEIVER_ID;
  end if;
END mobile_busi_huiyihf_TR4INSERT;
/
/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013/8/1 17:07:47                            */
/*==============================================================*/




/*==============================================================*/
/* View: MOBILE_VIEW_HUIYI                                      */
/*==============================================================*/
create or replace view MOBILE_VIEW_HUIYI(HY_ID, HY_BT, HY_DD, HY_KSSJ, HY_JSSJ, HY_LXBM, HY_LXR, HY_LXDH, HY_YHRS, HY_BMJZSJ, HY_FJID, HY_ZW, HY_CYR) as
select
t.m_notice_id hy_id, --会议id
t.m_title hy_bt, --会议标题
t.m_address hy_dd, --会议地点
t.m_begin_time hy_kssj, --会议开始时间
t.m_end_time hy_jssj, --会议结束时间
t.m_link_dept_name hy_lxbm, --联系部门
t.m_link_user_name hy_lxr, --联系人
t.m_link_tel hy_lxdh, --联系电话
t.m_attender_count hy_yhrs, --与会人数
t.m_close_time hy_bmjzsj, --报名截止时间
t.m_djbh hy_fjid, --附件id
t.m_contents hy_zw, --正文
t.m_receiver_user_names hy_cyr --参与人
from oa_meeting_notice t;

comment on column MOBILE_VIEW_HUIYI.HY_ID is
'会议通知id';

comment on column MOBILE_VIEW_HUIYI.HY_BT is
'标题';

comment on column MOBILE_VIEW_HUIYI.HY_DD is
'地点(默认显示会议室地点)';

comment on column MOBILE_VIEW_HUIYI.HY_KSSJ is
'会议开始时间';

comment on column MOBILE_VIEW_HUIYI.HY_JSSJ is
'会议结束时间';

comment on column MOBILE_VIEW_HUIYI.HY_LXBM is
'联系部门name';

comment on column MOBILE_VIEW_HUIYI.HY_LXR is
'联系人name';

comment on column MOBILE_VIEW_HUIYI.HY_LXDH is
'联系电话';

comment on column MOBILE_VIEW_HUIYI.HY_YHRS is
'与会人数';

comment on column MOBILE_VIEW_HUIYI.HY_BMJZSJ is
'报名截止日期';

comment on column MOBILE_VIEW_HUIYI.HY_FJID is
'附件id';

comment on column MOBILE_VIEW_HUIYI.HY_ZW is
'会议正文';

comment on column MOBILE_VIEW_HUIYI.HY_CYR is
'参会人员names';

/*==============================================================*/
/* View: MOBILE_VIEW_HUIYI_R                                    */
/*==============================================================*/
create or replace view MOBILE_VIEW_HUIYI_R(HY_ID, HY_FSSJ, HY_BT, HY_ZT, HY_JSR) as
select
t.m_notice_id hy_id, --会议id
u.m_create_time hy_fssj, --会议发送时间
t.m_title hy_bt, --会议标题
t.m_check_flag hy_zt, --会议状态 (0送审，1审核通过，2审核不通过，3暂存，4已发布，5重新发布，6已撤销)
u.m_receiver_user_id hy_jsr --会议接收人（key）
from oa_meeting_notice t,oa_meeting_receiver_user u
where t.m_notice_id=u.m_notice_id;

comment on column MOBILE_VIEW_HUIYI_R.HY_ID is
'会议通知id';

comment on column MOBILE_VIEW_HUIYI_R.HY_FSSJ is
'接收时间(记录产生时间,默认插入)';

comment on column MOBILE_VIEW_HUIYI_R.HY_BT is
'标题';

comment on column MOBILE_VIEW_HUIYI_R.HY_ZT is
'会议通知状态(见后台静态常量)';

comment on column MOBILE_VIEW_HUIYI_R.HY_JSR is
'接收人id';

/*==============================================================*/
/* View: MOBILE_VIEW_HUIYI_S                                    */
/*==============================================================*/
create or replace view MOBILE_VIEW_HUIYI_S(HY_ID, HY_BT, HY_FSSJ, HY_FSR) as
select
t.m_notice_id hy_id, --会议id
t.m_title hy_bt, --会议标题
t.m_current_time  hy_fssj, --会议发送时间
t.m_current_user_name hy_fsr--会议发送人（key）
from oa_meeting_notice t;


----支持的相关方法和视图
create or replace view v_user_info as
select uu.user_id userid,
        uu.user_realname username,
        t.org_id deptid,--部门
        t.org_name deptname
        ,OA_USERPROPERTY(t.org_id, '2') unitid--单位
        ,OA_USERPROPERTY(t.org_id, '1') unitname
   from td_sm_user uu, td_sm_orguser org, TD_SM_ORGANIZATION t
  where uu.user_id = org.user_id
    and org.org_id = t.org_id;
/

CREATE OR REPLACE FUNCTION SPLIT(P_LIST VARCHAR2,
                                 
                                 P_SEP VARCHAR2 := ',')
  RETURN OA_TYPE_SPLIT
  PIPELINED

 IS

  L_IDX PLS_INTEGER;

  V_LIST VARCHAR2(4000) := P_LIST;

BEGIN

  LOOP
  
    L_IDX := INSTR(V_LIST, P_SEP);
  
    IF L_IDX > 0 THEN
    
      PIPE ROW(SUBSTR(V_LIST, 1, L_IDX - 1));
    
      V_LIST := SUBSTR(V_LIST, L_IDX + LENGTH(P_SEP));
    
    ELSE
    
      PIPE ROW(V_LIST);
    
      EXIT;
    
    END IF;
  
  END LOOP;

  RETURN;

END SPLIT;
/
CREATE OR REPLACE FUNCTION get_uuid RETURN VARCHAR IS
guid VARCHAR(50);
BEGIN
guid := lower(RAWTOHEX(sys_guid())); RETURN substr(guid, 1, 8) || '-' || substr(guid, 9, 4) || '-' || substr(guid, 13, 4) || '-' || substr(guid, 17, 4) || '-' || substr(guid, 21, 12);
END get_uuid;
/



drop table M_T_HY;
/
drop table M_T_HY_HF;
/


-- Create table
create table M_T_HY
(
  hy_bt      VARCHAR2(200),
  hy_kssj    VARCHAR2(200),
  hy_jssj    VARCHAR2(200),
  hy_dd      VARCHAR2(200),
  hy_lxbm    VARCHAR2(50),
  hy_lxr     VARCHAR2(50),
  hy_lxdh    VARCHAR2(50),
  hy_cyr     VARCHAR2(4000),
  hy_content VARCHAR2(200),
  hy_sfbm    CHAR(1),
  hy_sqrid   VARCHAR2(200),
  hy_sqr     VARCHAR2(200),
  hy_sqsj    VARCHAR2(200),
  hy_sqrbmid VARCHAR2(200),
  hy_sqrbm   VARCHAR2(200),
  hy_cyrid   VARCHAR2(4000),
  hy_lxrid   VARCHAR2(200),
  hy_lxbmid  VARCHAR2(200)
)
/
-- Add comments to the columns 
comment on column M_T_HY.hy_bt
  is '会议标题';
comment on column M_T_HY.hy_kssj
  is '会议开始时间';
comment on column M_T_HY.hy_jssj
  is '会议结束时间';
comment on column M_T_HY.hy_dd
  is '会议地点';
comment on column M_T_HY.hy_lxbm
  is '会议联系部门';
comment on column M_T_HY.hy_lxr
  is '会议联系人';
comment on column M_T_HY.hy_lxdh
  is '会议联系电话';
comment on column M_T_HY.hy_cyr
  is '会议参与人';
comment on column M_T_HY.hy_content
  is '会议正文';
comment on column M_T_HY.hy_sfbm
  is '是否报名';
comment on column M_T_HY.hy_sqrid
  is '申请人id';
comment on column M_T_HY.hy_sqr
  is '申请人';
comment on column M_T_HY.hy_sqsj
  is '申请时间';
comment on column M_T_HY.hy_sqrbmid
  is '申请人部门id';
comment on column M_T_HY.hy_sqrbm
  is '申请人部门';
comment on column M_T_HY.hy_cyrid
  is '会议参与人id';
comment on column M_T_HY.hy_lxrid
  is '会议联系人id';
comment on column M_T_HY.hy_lxbmid
  is '会议联系部门id';
/


-- Create table
create table M_T_HY_HF
(
  hy_replay VARCHAR2(200),
  hy_cyrid  VARCHAR2(4000),
  hy_cyr    VARCHAR2(4000),
  hy_reason VARCHAR2(200),
  hy_id     VARCHAR2(200),
  hy_bmr    VARCHAR2(200),
  hy_bmrid  VARCHAR2(200),
  hy_hfsj   VARCHAR2(200),
  hy_cyrs   VARCHAR2(200)
)
/
-- Add comments to the columns 
comment on column M_T_HY_HF.hy_replay
  is '会议回复情况 0：已读 1报名参与，9请假不参与';
comment on column M_T_HY_HF.hy_cyrid
  is '参会人id';
comment on column M_T_HY_HF.hy_cyr
  is '参会人';
comment on column M_T_HY_HF.hy_reason
  is '会议请假内容';
comment on column M_T_HY_HF.hy_id
  is '会议id';
comment on column M_T_HY_HF.hy_bmr
  is '操作人（会议接收人）';
comment on column M_T_HY_HF.hy_bmrid
  is '操作人（会议接收人）id';
comment on column M_T_HY_HF.hy_hfsj
  is '回复时间';
comment on column M_T_HY_HF.hy_cyrs
  is '参会人数';
/




drop table M_T_HY;
drop table M_T_HY_HF;



-- Create table
create table M_T_HY
(
  hy_bt      VARCHAR2(200),
  hy_kssj    VARCHAR2(200),
  hy_jssj    VARCHAR2(200),
  hy_dd      VARCHAR2(200),
  hy_lxbm    VARCHAR2(50),
  hy_lxr     VARCHAR2(50),
  hy_lxdh    VARCHAR2(50),
  hy_cyr     VARCHAR2(4000),
  hy_content VARCHAR2(200),
  hy_sfbm    CHAR(1),
  hy_sqrid   VARCHAR2(200),
  hy_sqr     VARCHAR2(200),
  hy_sqsj    VARCHAR2(200),
  hy_sqrbmid VARCHAR2(200),
  hy_sqrbm   VARCHAR2(200),
  hy_cyrid   VARCHAR2(4000),
  hy_lxrid   VARCHAR2(200),
  hy_lxbmid  VARCHAR2(200)
)
/
-- Add comments to the columns 
comment on column M_T_HY.hy_bt
  is '会议标题';
comment on column M_T_HY.hy_kssj
  is '会议开始时间';
comment on column M_T_HY.hy_jssj
  is '会议结束时间';
comment on column M_T_HY.hy_dd
  is '会议地点';
comment on column M_T_HY.hy_lxbm
  is '会议联系部门';
comment on column M_T_HY.hy_lxr
  is '会议联系人';
comment on column M_T_HY.hy_lxdh
  is '会议联系电话';
comment on column M_T_HY.hy_cyr
  is '会议参与人';
comment on column M_T_HY.hy_content
  is '会议正文';
comment on column M_T_HY.hy_sfbm
  is '是否报名';
comment on column M_T_HY.hy_sqrid
  is '申请人id';
comment on column M_T_HY.hy_sqr
  is '申请人';
comment on column M_T_HY.hy_sqsj
  is '申请时间';
comment on column M_T_HY.hy_sqrbmid
  is '申请人部门id';
comment on column M_T_HY.hy_sqrbm
  is '申请人部门';
comment on column M_T_HY.hy_cyrid
  is '会议参与人id';
comment on column M_T_HY.hy_lxrid
  is '会议联系人id';
comment on column M_T_HY.hy_lxbmid
  is '会议联系部门id';
/


-- Create table
create table M_T_HY_HF
(
  hy_replay VARCHAR2(200),
  hy_cyrid  VARCHAR2(4000),
  hy_cyr    VARCHAR2(4000),
  hy_reason VARCHAR2(200),
  hy_id     VARCHAR2(200),
  hy_bmr    VARCHAR2(200),
  hy_bmrid  VARCHAR2(200),
  hy_hfsj   VARCHAR2(200),
  hy_cyrs   VARCHAR2(200)
)
/
-- Add comments to the columns 
comment on column M_T_HY_HF.hy_replay
  is '会议回复情况 0：已读 1报名参与，9请假不参与';
comment on column M_T_HY_HF.hy_cyrid
  is '参会人id';
comment on column M_T_HY_HF.hy_cyr
  is '参会人';
comment on column M_T_HY_HF.hy_reason
  is '会议请假内容';
comment on column M_T_HY_HF.hy_id
  is '会议id';
comment on column M_T_HY_HF.hy_bmr
  is '操作人（会议接收人）';
comment on column M_T_HY_HF.hy_bmrid
  is '操作人（会议接收人）id';
comment on column M_T_HY_HF.hy_hfsj
  is '回复时间';
comment on column M_T_HY_HF.hy_cyrs
  is '参会人数';
/

create or replace trigger M_T_HY_HF_TR_INSERT  --回复表
  after insert
ON M_T_HY_HF
  FOR EACH ROW
DECLARE
  M_RECEIVER_ID varchar2(50);
BEGIN
  select u.m_receiver_id
    into M_RECEIVER_ID
    from oa_meeting_receiver_user u
   where u.m_receiver_user_id = :new.HY_BMRID---会议接收人
     and u.m_notice_id = :new.HY_ID and rownum=1;

  IF INSERTING THEN
    update oa_meeting_receiver_user u
       set u.m_reply_time    = to_date(:new.HY_HFSJ,'yyyy-mm-dd hh24:mi:ss'),
           u.m_read_time     = to_date(:new.HY_HFSJ,'yyyy-mm-dd hh24:mi:ss'),
           u.m_is_reply      = :new.HY_REPLAY,
           u.m_is_read       = '1',
           u.m_is_reply_name = decode(:new.HY_REPLAY,
                                      '1',
                                      '参加',
                                      '9',
                                      '请假',
                                      '0'),
           u.m_reply         = :new.HY_REASON,
           u.m_attender_count  = :new.HY_CYRS,
           u.m_attender_ids = :new.HY_CYRID,
           u.m_attender_names = :new.HY_CYR
     where u.m_receiver_id = M_RECEIVER_ID;
     
     if (1=:new.HY_REPLAY) then
           delete oa_meeting_attender a where a.m_receiver_id=M_RECEIVER_ID and 1=:new.HY_REPLAY;
           insert into oa_meeting_attender (
                 M_ID,
            M_RECEIVER_ID,
            M_USER_ID,
            M_USER_NAME,
            M_UNIT_ID,
            M_UNIT_NAME
            )
            select get_uuid(),M_RECEIVER_ID, COLUMN_VALUE userid ,v.username,v.unitid,v.unitname
              from table(split(:new.HY_CYRID, ',')) t, v_user_info v
             where v.userid = COLUMN_VALUE and 1=:new.HY_REPLAY;
      end if;
  end if;
END M_T_HY_HF_TR_INSERT;
/

create or replace trigger M_T_HY_TR_INSERT
  after insert
ON M_T_HY
  FOR EACH ROW
DECLARE
  NEW_NOTICE_ID varchar2(50);
BEGIN
  select get_uuid() into NEW_NOTICE_ID from dual; --记住主键id值用于从表的插入
  IF INSERTING THEN
    insert into oa_meeting_notice
      (m_notice_id,
       m_title,
       m_begin_time,
       m_end_time,
       m_address,
       m_link_user_id,
       m_link_user_name,
       m_link_dept_id,
       m_link_dept_name,
       m_link_tel,
       m_is_need_signup, --
       m_create_user_id,
       m_create_user_name,
       m_create_time,
       m_create_dept_id,
       m_create_dept_name,
       m_create_unit_id,
       m_create_unit_name,
       m_check_flag,
       m_check_flag_name, --
       m_current_user_id,
       m_current_user_name,
       m_current_time,
       m_is_addsend,
       m_is_resend,
       m_receiver_user_ids,
       m_receiver_user_names,
       m_contents)
    values
      (NEW_NOTICE_ID,
       :new.hy_bt,
       to_date(:new.hy_kssj,'yyyy-mm-dd hh24:mi:ss'),
       to_date(:new.hy_jssj,'yyyy-mm-dd hh24:mi:ss'),
       :new.hy_dd,
       :new.hy_lxrid,
       :new.hy_lxr,
       :new.hy_lxbmid,
       :new.hy_lxbm,
       :new.hy_lxdh,
       :new.HY_SFBM,
       :new.HY_SQRID,
       :new.HY_SQR,
       to_date(:new.HY_SQSJ,'yyyy-mm-dd hh24:mi:ss'),
       :new.HY_SQRBMID,
       :new.HY_SQRBM,
       OA_USERPROPERTY(:new.HY_SQRBMID, '1'),---单位
       OA_USERPROPERTY(:new.HY_SQRBMID, '2'),---单位name
       '4',
       '已发布',
       :new.HY_SQRID,--发布人
       :new.HY_SQR,--发布人name
       to_date(:new.HY_SQSJ,'yyyy-mm-dd hh24:mi:ss'),--发布时间
       '0',
       '0',
       :new.hy_cyrid,
       :new.hy_cyr,
       :new.HY_CONTENT);

    if (:new.hy_cyrid is not null) then
      insert into oa_meeting_receiver_user u
        (m_receiver_id,
         m_notice_id,
         m_receiver_user_id,
         m_receiver_user_name,
         m_receiver_unit_id,
         m_receiver_unit_name,
         m_create_time, --接收时间 或者说 发布时间
         m_is_addrend,
         m_is_resend,
         m_is_call)
        select get_uuid(),
               NEW_NOTICE_ID,
               COLUMN_VALUE,
               (select d.user_name
                  from td_sm_user d
                 where d.user_id = COLUMN_VALUE),
               (select org.org_id
                  from td_sm_orguser org
                 where org.user_id = t.COLUMN_VALUE),
               (select t.org_name
                  from td_sm_orguser org, TD_SM_ORGANIZATION t
                 where t.org_id = org.org_id
                   and org.user_id = t.COLUMN_VALUE),
               to_date(:new.HY_SQSJ,'yyyy-mm-dd hh24:mi:ss'),
               '0',
               '0',
               '0'
          from table(split(:new.HY_CYRID, ',')) t;
    end if;
  end if;
END M_T_HY_TR_INSERT;
/


create or replace view m_v_hy_s as
select t.m_notice_id        hy_id, --会议id
       t.m_current_time     hy_fssj, --会议发送时间
       t.m_title            hy_bt, --会议标题
       t.m_check_flag       hy_zt, --会议状态 (0送审，1审核通过，2审核不通过，3暂存，4已发布，5重新发布，6已撤销)
       t.m_current_user_id  hy_fsrid, --会议发送人（key）
       u.m_receiver_user_id hy_jsrid --会议接收人
  from oa_meeting_notice t, oa_meeting_receiver_user u
 where t.m_notice_id = u.m_notice_id;
 /
 create or replace view m_v_hy_r as
select t.m_notice_id        hy_id, --会议id
       u.m_create_time      hy_fssj, --会议发送时间
       t.m_title            hy_bt, --会议标题
       t.m_check_flag       hy_zt, --会议状态 (0送审，1审核通过，2审核不通过，3暂存，4已发布，5重新发布，6已撤销)
       t.m_current_user_id  hy_fsr, --会议发送人
       u.m_receiver_user_id hy_jsrid --会议接收人（key）
  from oa_meeting_notice t, oa_meeting_receiver_user u
 where t.m_notice_id = u.m_notice_id;
 /
create or replace view m_v_hy_d as
select t.m_notice_id hy_id, --会议id
       t.m_title hy_bt, --会议标题
       t.m_address hy_dd, --会议地点
       t.m_begin_time hy_kssj, --会议开始时间
       t.m_end_time hy_jssj, --会议结束时间
       t.m_link_dept_name hy_lxbm, --联系部门
       t.m_link_user_name hy_lxr, --联系人
       t.m_link_tel hy_lxdh, --联系电话
       t.m_attender_count hy_yhrs, --与会人数
       t.m_close_time hy_bmjzsj, --报名截止时间
       t.m_djbh hy_fjid, --附件id
       t.m_contents hy_zw, --正文
       1 HY_SFYX, --是否有效
       (select wm_concat(u.user_realname)
          from oa_meeting_receiver_user r, td_sm_user u
         where t.m_notice_id = r.m_notice_id
           and r.m_receiver_user_id = u.user_id) as HY_CYR, --参与人名字
       (select count(*) from fc_attach f where trim(f.djbh) = trim(t.m_djbh)) as HY_FJSL --附件
  from oa_meeting_notice t;
 /
create or replace view m_v_hy_a as
select t.m_notice_id        HY_ID, --会议id
       t.m_receiver_user_id HY_JSR, --会议接收人
       t.m_is_reply         HY_JSZT, --会议接收状态 即回复状态 1 本人参加 2 委托人参加 3 安排人参加  9 请假  0 未报名
       t.m_attender_ids     HY_CYR, --  参与人
       t.m_reply            HY_QJYY --  请假事由
  from oa_meeting_receiver_user t;
 /
 create or replace function getCountInfo(userid varchar2) return varchar2 is
  waitsp      number;
  waitread    number;
  waitarchive number;
begin
  waitsp      := 0;
  waitread    := 0;
  waitarchive := 0;

  select count(*)
    into waitsp
    from oa_meeting_notice             t,
         oa_meeting_room               r,
         oa_meeting_room_administrator a
   where a.m_room_id = r.m_room_id
     and t.m_room_id = r.m_room_id(+)
     and (t.m_check_flag = '0')
     and a.m_user_id = userid;

  select count(*)
    into waitread
    from (select ''
            from oa_notice_baseinfo b, oa_notice_receiver_user r
           where r.n_notice_id = b.n_notice_id
             and b.n_state in (1, 2)
             and r.n_isdel != '1'
             and r.n_isview = '0'
             and r.n_receiver_userid = userid
          union all
          select t.m_title
            from oa_meeting_notice        t,
                 oa_meeting_room          r,
                 oa_meeting_receiver_user u
           where t.m_room_id = r.m_room_id(+)
             and t.m_notice_id = u.m_notice_id
             and u.m_receiver_user_id = userid
             and u.m_is_read <> '1'
             and (t.m_check_flag = '4' or t.m_check_flag = '5'));

  select count(*)
    into waitarchive
    from VIEW_OA_WORK_LIST t
   where t.username =
         (select u.user_name from td_sm_user u where u.user_id = userid);

  return(waitsp || ',' || waitread || ',' || waitarchive);
end getCountInfo;
/