drop table oa_msg_todo_recv cascade constraints;

drop table oa_msg_todo_send cascade constraints;

/*==============================================================*/
/* Table: oa_msg_todo_send                                      */
/*==============================================================*/
create table OA_MSG_TODO_SEND
(
  MSG_ID        VARCHAR2(50) not null,
  MSG_TITLE     VARCHAR2(2000) not null,
  MSG_TYPE      VARCHAR2(20),
  MSG_URL       VARCHAR2(2000) not null,
  SEND_USERID   VARCHAR2(50) not null,
  SEND_USERNAME VARCHAR2(50) not null,
  SEND_ORGID    VARCHAR2(50),
  SEND_ORGNAME  VARCHAR2(50),
  SEND_DATE     DATE not null,
  BUS_ID        VARCHAR2(50)
);
-- Add comments to the table 
comment on table OA_MSG_TODO_SEND
  is '统一待办发送表';
-- Add comments to the columns 
comment on column OA_MSG_TODO_SEND.MSG_ID
  is '主键ID';
comment on column OA_MSG_TODO_SEND.MSG_TITLE
  is '标题';
comment on column OA_MSG_TODO_SEND.MSG_TYPE
  is '类型';
comment on column OA_MSG_TODO_SEND.MSG_URL
  is '链接地址';
comment on column OA_MSG_TODO_SEND.SEND_USERID
  is '发送人ID';
comment on column OA_MSG_TODO_SEND.SEND_USERNAME
  is '发送人名称';
comment on column OA_MSG_TODO_SEND.SEND_ORGID
  is '发送人机构ID';
comment on column OA_MSG_TODO_SEND.SEND_ORGNAME
  is '发送人机构名称';
comment on column OA_MSG_TODO_SEND.SEND_DATE
  is '发送时间';
comment on column OA_MSG_TODO_SEND.BUS_ID
  is '业务ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_MSG_TODO_SEND
  add constraint PK_OA_MSG_TODO_SEND primary key (MSG_ID);

/*==============================================================*/
/* Table: oa_msg_todo_recv                                      */
/*==============================================================*/
create table oa_msg_todo_recv 
(
   recv_id              varchar2(50)                   not null,
   msg_id               varchar2(50)                   not null,
   recv_userid          varchar2(50)                   null,
   recv_username        varchar2(50)                   null,
   recv_orgid           varchar2(50)                   null,
   recv_orgname         varchar2(50)                   null,
   type                 char(1)                        not null
      constraint CKC_TYPE_OA_MSG_T check (type in ('1','2')),
   status               varchar2(50)                   null,
   remark               varchar2(50)                   null,
   constraint PK_OA_MSG_TODO_RECV primary key (recv_id)
);

comment on table oa_msg_todo_recv is 
'统一待办接收表';

comment on column oa_msg_todo_recv.recv_id is 
'接收ID(主键)';

comment on column oa_msg_todo_recv.msg_id is 
'待办ID(对应待办发送表主键)';

comment on column oa_msg_todo_recv.recv_userid is 
'接收人ID';

comment on column oa_msg_todo_recv.recv_username is 
'接收人名称';

comment on column oa_msg_todo_recv.recv_orgid is 
'接收人单位ID';

comment on column oa_msg_todo_recv.recv_orgname is 
'接收人单位名称';

comment on column oa_msg_todo_recv.type is 
'类型(1个人/2单位)';

comment on column oa_msg_todo_recv.status is 
'状态(备用)';

comment on column oa_msg_todo_recv.remark is 
'备注(备用字段)';
