drop table oa_email_base cascade constraints;

/*==============================================================*/
/* Table: oa_email_base                                       */
/*==============================================================*/
create table oa_email_base 
(
   m_id               VARCHAR2(40)         not null,
   m_title            VARCHAR2(300),
   m_createtime       VARCHAR2(100),
   m_attachment_id    VARCHAR2(100),
   m_deptid           VARCHAR2(100),
   m_deptname         VARCHAR2(100),
   m_sendpid          VARCHAR2(100),
   m_sendpname        VARCHAR2(100),
   m_dxtzjsr          VARCHAR2(4),
   m_state            VARCHAR2(4),
   m_content          CLOB,
   constraint JBXX_MAIL_PK primary key (m_id)
);

comment on table oa_email_base is
'邮件信息基本表';

comment on column oa_email_base.m_id is
'主键';

comment on column oa_email_base.m_title is
'标题';

comment on column oa_email_base.m_createtime is
'创建日期、发送日期';

comment on column oa_email_base.m_attachment_id is
'附件id';

comment on column oa_email_base.m_deptid is
'发送人部门ID';

comment on column oa_email_base.m_deptname is
'发送人部门名称';

comment on column oa_email_base.m_sendpid is
'发送人ID';

comment on column oa_email_base.m_sendpname is
'发送人名称';

comment on column oa_email_base.m_dxtzjsr is
'短信通知接收人';

comment on column oa_email_base.m_state is
'状态';

comment on column oa_email_base.m_content is
'内容';


drop table oa_email_user cascade constraints;

/*==============================================================*/
/* Table: oa_email_user                                       */
/*==============================================================*/
create table oa_email_user 
(
   receivepid         VARCHAR2(40),
   receivepname       VARCHAR2(200),
   readstate          VARCHAR2(4),
   m_id               VARCHAR2(40),
   states             VARCHAR2(4),
   sorts              VARCHAR2(100)
);

comment on table oa_email_user is
'邮件用户接收表';

comment on column oa_email_user.receivepname is
'接收人名字';

comment on column oa_email_user.readstate is
'阅读状态';

comment on column oa_email_user.m_id is
'邮件id';

comment on column oa_email_user.sorts is
'排序';


drop table oa_mail_memoryconfig cascade constraints;

/*==============================================================*/
/* Table: oa_mail_memoryconfig                                */
/*==============================================================*/
create table oa_mail_memoryconfig 
(
   id                 VARCHAR2(40)         not null,
   user_id            VARCHAR2(40),
   memory             INTEGER,
   constraint PK_OA_MAIL_MEMORYCONFIG primary key (id)
);

comment on table oa_mail_memoryconfig is
'邮箱配置表';

comment on column oa_mail_memoryconfig.id is
'主键';

comment on column oa_mail_memoryconfig.user_id is
'用户id';

comment on column oa_mail_memoryconfig.memory is
'邮箱容量';


drop table oa_mail_menu cascade constraints;

/*==============================================================*/
/* Table: oa_mail_menu                                        */
/*==============================================================*/
create table oa_mail_menu 
(
   menu_id            varchar2(40)         not null,
   menu_name          varchar2(100)        not null,
   menu_remark        varchar2(200),
   menu_parentid      varchar2(40),
   remark1            varchar2(100),
   remark2            varchar2(100),
   constraint PK_OA_MAIL_MENU primary key (menu_id)
);

comment on table oa_mail_menu is
'邮件菜单标题表';

comment on column oa_mail_menu.menu_id is
'菜单标题主键';

comment on column oa_mail_menu.menu_name is
'菜单标题名称';

comment on column oa_mail_menu.menu_remark is
'说明';

comment on column oa_mail_menu.menu_parentid is
'菜单标题父类id';

comment on column oa_mail_menu.remark1 is
'备用字段1';

comment on column oa_mail_menu.remark2 is
'备用字段2';
