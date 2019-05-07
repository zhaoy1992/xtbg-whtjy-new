drop table OA_PAPER_MAKE_NOTICE cascade constraints;

/*==============================================================*/
/* Table: OA_PAPER_MAKE_NOTICE                                  */
/*==============================================================*/
create table OA_PAPER_MAKE_NOTICE 
(
   p_notice_id          VARCHAR2(40)         not null,
   p_title              VARCHAR2(200)        not null,
   p_unit_id            CLOB                 not null,
   p_unit_name          CLOB                 not null,
   p_send_unit_id       VARCHAR2(40)         not null,
   p_send_unit_name     VARCHAR2(100)        not null,
   p_contents           CLOB                 not null,
   p_msg_type           VARCHAR2(100),
   p_msg_contents       VARCHAR2(500),
   p_create_user_id     VARCHAR2(40)         not null,
   p_create_user_name   VARCHAR2(40)         not null,
   p_create_time        date                 not null,
   p_update_user_id     VARCHAR2(40),
   p_update_user_name   VARCHAR2(40),
   p_update_time        date,
   p_status             CHAR(1),
   p_send_time          DATE,
   constraint PK_OA_PAPER_MAKE_NOTICE primary key (p_notice_id)
);

comment on table OA_PAPER_MAKE_NOTICE is
'信息约稿通知表';

comment on column OA_PAPER_MAKE_NOTICE.p_notice_id is
'主键id';

comment on column OA_PAPER_MAKE_NOTICE.p_title is
'约稿标题';

comment on column OA_PAPER_MAKE_NOTICE.p_unit_id is
'约稿单位id';

comment on column OA_PAPER_MAKE_NOTICE.p_unit_name is
'约稿单位name';

comment on column OA_PAPER_MAKE_NOTICE.p_send_unit_id is
'发约稿通知单位id';

comment on column OA_PAPER_MAKE_NOTICE.p_send_unit_name is
'发约稿通知单位name';

comment on column OA_PAPER_MAKE_NOTICE.p_contents is
'约稿通知内容';

comment on column OA_PAPER_MAKE_NOTICE.p_msg_type is
'提醒方式';

comment on column OA_PAPER_MAKE_NOTICE.p_msg_contents is
'提醒内容';

comment on column OA_PAPER_MAKE_NOTICE.p_create_user_id is
'创建人id';

comment on column OA_PAPER_MAKE_NOTICE.p_create_user_name is
'创建人name';

comment on column OA_PAPER_MAKE_NOTICE.p_create_time is
'创建时间';

comment on column OA_PAPER_MAKE_NOTICE.p_update_user_id is
'更新人id';

comment on column OA_PAPER_MAKE_NOTICE.p_update_user_name is
'更新人name';

comment on column OA_PAPER_MAKE_NOTICE.p_update_time is
'更新时间';

comment on column OA_PAPER_MAKE_NOTICE.p_status is
'状态';

comment on column OA_PAPER_MAKE_NOTICE.p_send_time is
'发送时间';
/

drop table oa_paper_receive_notice cascade constraints;

/*==============================================================*/
/* Table: oa_paper_receive_notice                               */
/*==============================================================*/
create table oa_paper_receive_notice 
(
   p_receive_id         VARCHAR2(40)         not null,
   p_notice_id          VARCHAR2(40)         not null,
   p_title              VARCHAR2(200),
   p_receive_unit_id    VARCHAR2(40),
   p_receive_unit_name  VARCHAR2(200),
   p_read_status        CHAR(1),
   p_read_time          DATE,
   constraint PK_OA_PAPER_RECEIVE_NOTICE primary key (p_receive_id)
);

comment on table oa_paper_receive_notice is
'约稿通知接收表';

comment on column oa_paper_receive_notice.p_receive_id is
'约稿接收主键id';

comment on column oa_paper_receive_notice.p_notice_id is
'约稿通知id';

comment on column oa_paper_receive_notice.p_title is
'约稿标题';

comment on column oa_paper_receive_notice.p_receive_unit_id is
'约稿接收单位id';

comment on column oa_paper_receive_notice.p_receive_unit_name is
'约稿接收单位name';

comment on column oa_paper_receive_notice.p_read_status is
'阅读状态(1.已阅读0.未阅读)';

comment on column oa_paper_receive_notice.p_read_time is
'阅读时间';
/


drop table OA_PAPER cascade constraints;

/*==============================================================*/
/* Table: OA_PAPER                                              */
/*==============================================================*/
create table OA_PAPER 
(
   p_manage_id          VARCHAR2(40)         not null,
   p_is_use             CHAR(1),
   p_leader             VARCHAR2(100),
   p_editor             VARCHAR2(100),
   p_rep_title          VARCHAR2(200),
   p_rep_type_id        VARCHAR2(40),
   p_rep_type_name      VARCHAR2(100),
   p_rep_keyword        VARCHAR2(200),
   p_rep_contents       CLOB,
   p_rep_attach_id      VARCHAR2(40),
   p_rep_user_id        VARCHAR2(40),
   p_rep_user_name      VARCHAR2(40),
   p_rep_time           date,
   p_rep_unit_id        VARCHAR2(40),
   p_rep_unit_name      VARCHAR2(40),
   p_flag_id            VARCHAR2(40),
   p_flag_name          VARCHAR2(40),
   p_acc_unit_ids       CLOB,
   p_acc_unit_names     CLOB,
   p_acc_user_id        VARCHAR2(40),
   p_acc_user_name      VARCHAR2(40),
   p_acc_time           date,
   p_sub_user_ids       CLOB,
   p_sub_user_names     CLOB,
   p_sub_time           date,
   p_contents           CLOB,
   p_pub_user_id        VARCHAR2(40),
   p_pub_user_name      VARCHAR2(40),
   p_pub_time           date,
   p_pub_unit_id        VARCHAR2(40),
   p_pub_unit_name      VARCHAR2(100),
   p_rep_flag_id        VARCHAR2(40),
   p_rep_flag_name      VARCHAR2(40),
   P_UNDONE_USER_ID     VARCHAR2(40),
   P_UNDONE_USER_NAME   VARCHAR2(40),
   P_UNDONE_TIME        date,
   P_LEADER_REMARK      CLOB,
   P_UNDONE_REMARK      CLOB,
   P_UNACC_USER_ID      VARCHAR2(40),
   P_UNACC_USER_NAME    VARCHAR2(40),
   P_UNACC_TIME         date,
   P_UNACC_REMARK       CLOB,
   P_ACC_TITLE          VARCHAR2(200),
   constraint PK_OA_PAPER primary key (p_manage_id)
);

comment on column OA_PAPER.p_manage_id is
'主键id';

comment on column OA_PAPER.p_is_use is
'0为删除，1可用';

comment on column OA_PAPER.p_leader is
'签发领导（文本）';

comment on column OA_PAPER.p_editor is
'责任编辑（文本）';

comment on column OA_PAPER.p_rep_title is
'信息标题';

comment on column OA_PAPER.p_rep_type_id is
'信息类型id';

comment on column OA_PAPER.p_rep_type_name is
'信息类型name';

comment on column OA_PAPER.p_rep_keyword is
'关键字';

comment on column OA_PAPER.p_rep_contents is
'信息内容';

comment on column OA_PAPER.p_rep_attach_id is
'附件';

comment on column OA_PAPER.p_rep_user_id is
'上报人id';

comment on column OA_PAPER.p_rep_user_name is
'上报人name';

comment on column OA_PAPER.p_rep_time is
'上报时间';

comment on column OA_PAPER.p_rep_unit_id is
'上报单位id';

comment on column OA_PAPER.p_rep_unit_name is
'上报单位name';

comment on column OA_PAPER.p_flag_id is
'稿件状态id';

comment on column OA_PAPER.p_flag_name is
'稿件状态name';

comment on column OA_PAPER.p_acc_unit_ids is
'接收单位（有多个）ids';

comment on column OA_PAPER.p_acc_unit_names is
'接收单位（有多个）names';

comment on column OA_PAPER.p_acc_user_id is
'采编人id（也是送审人）';

comment on column OA_PAPER.p_acc_user_name is
'采编人name';

comment on column OA_PAPER.p_acc_time is
'采编时间';

comment on column OA_PAPER.p_sub_user_ids is
'审核人（有多个）ids 提交后确定的审核人';

comment on column OA_PAPER.p_sub_user_names is
'审核人（有多个）names 提交后确定的审核人';

comment on column OA_PAPER.p_sub_time is
'送审时间';

comment on column OA_PAPER.p_contents is
'内容';

comment on column OA_PAPER.p_pub_user_id is
'发布人id';

comment on column OA_PAPER.p_pub_user_name is
'发布人name';

comment on column OA_PAPER.p_pub_time is
'发布时间';

comment on column OA_PAPER.p_pub_unit_id is
'发布单位id';

comment on column OA_PAPER.p_pub_unit_name is
'发布单位name';

comment on column OA_PAPER.p_rep_flag_id is
'上报稿件状态id';

comment on column OA_PAPER.p_rep_flag_name is
'上报稿件状态name';

comment on column OA_PAPER.P_UNDONE_USER_ID is
'退回人';

comment on column OA_PAPER.P_UNDONE_USER_NAME is
'退回人name';

comment on column OA_PAPER.P_UNDONE_TIME is
'退回时间';

comment on column OA_PAPER.P_LEADER_REMARK is
'领导批示';

comment on column OA_PAPER.P_UNDONE_REMARK is
'退回原因';

comment on column OA_PAPER.P_UNACC_USER_ID is
'退稿人';

comment on column OA_PAPER.P_UNACC_USER_NAME is
'退稿人name';

comment on column OA_PAPER.P_UNACC_TIME is
'退稿时间';

comment on column OA_PAPER.P_UNACC_REMARK is
'退稿原因';

comment on column OA_PAPER.P_ACC_TITLE is
'采编/发布信息标题';
/

drop table OA_PAPER_Template cascade constraints;

/*==============================================================*/
/* Table: OA_PAPER_Template                                     */
/*==============================================================*/
create table OA_PAPER_Template 
(
   p_template_id        VARCHAR2(40)         not null,
   p_template_name      VARCHAR2(400)        not null,
   p_template_typeid    VARCHAR2(40)         not null,
   p_template_unitid    VARCHAR2(40)         not null,
   p_template_unit      VARCHAR2(200)        not null,
   create_time          date                 not null,
   create_userid        VARCHAR2(40)         not null,
   create_username      VARCHAR2(40)         not null,
   p_template_typename  VARCHAR2(200),
   constraint PK_OA_PAPER_TEMPLATE primary key (p_template_id)
);

comment on table OA_PAPER_Template is
'信息报送模块管理';

comment on column OA_PAPER_Template.p_template_id is
'主键ID';

comment on column OA_PAPER_Template.p_template_name is
'模板名称';

comment on column OA_PAPER_Template.p_template_typeid is
'模板类型id';

comment on column OA_PAPER_Template.p_template_unitid is
'使用单位ID';

comment on column OA_PAPER_Template.p_template_unit is
'使用单位';

comment on column OA_PAPER_Template.create_time is
'创建时间';

comment on column OA_PAPER_Template.create_userid is
'创建人id';

comment on column OA_PAPER_Template.create_username is
'创建人';
/

drop table oa_paper_receive_info cascade constraints;

/*==============================================================*/
/* Table: oa_paper_receive_info                                 */
/*==============================================================*/
create table oa_paper_receive_info 
(
   p_receive_id         VARCHAR2(40)         not null,
   p_manage_id          VARCHAR2(40)         not null,
   p_title              VARCHAR2(200),
   p_receive_unit_id    VARCHAR2(40),
   p_receive_unit_name  VARCHAR2(200),
   p_read_status        CHAR(1),
   p_read_time          DATE,
   p_receive_user_id    VARCHAR2(40),
   p_receive_user_name  VARCHAR2(200),
   p_type_id            VARCHAR2(40),
   p_type_name          VARCHAR2(40),
   constraint PK_OA_PAPER_RECEIVE_INFO primary key (p_receive_id)
);

comment on table oa_paper_receive_info is
'发送信息接收表';

comment on column oa_paper_receive_info.p_receive_id is
'发布信息接收主键id';

comment on column oa_paper_receive_info.p_manage_id is
'信息id';

comment on column oa_paper_receive_info.p_title is
'发布信息标题';

comment on column oa_paper_receive_info.p_receive_unit_id is
'发布信息接收单位id';

comment on column oa_paper_receive_info.p_receive_unit_name is
'发布信息接收单位name';

comment on column oa_paper_receive_info.p_read_status is
'阅读状态(1.已阅读0.未阅读)';

comment on column oa_paper_receive_info.p_read_time is
'阅读时间';

comment on column oa_paper_receive_info.p_receive_user_id is
'发布信息接收人员id';

comment on column oa_paper_receive_info.p_receive_user_name is
'发布信息接收人员name';

comment on column oa_paper_receive_info.p_type_id is
'发布类型id';

comment on column oa_paper_receive_info.p_type_name is
'发布类型name';
