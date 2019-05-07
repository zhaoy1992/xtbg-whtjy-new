/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-7-2 14:46:01                            */
/*==============================================================*/

drop table oa_msg_recv cascade constraints;

drop table oa_msg_send cascade constraints;
-- Create table
create table OA_MSG_SEND
(
  MSG_ID      VARCHAR2(50) not null,
  MSG_CONTENT VARCHAR2(2000) not null,
  MSG_TYPE    VARCHAR2(20) not null,
  MSG_URL     VARCHAR2(2000),
  SEND_USERID NUMBER not null,
  SEND_ORGID  VARCHAR2(50),
  SEND_DATE   DATE not null
);
-- Add comments to the table 
comment on table OA_MSG_SEND
  is '站内消息发送';
-- Add comments to the columns 
comment on column OA_MSG_SEND.MSG_ID
  is '消息id';
comment on column OA_MSG_SEND.MSG_CONTENT
  is '消息内容';
comment on column OA_MSG_SEND.MSG_TYPE
  is '消息类型';
comment on column OA_MSG_SEND.MSG_URL
  is '链接地址';
comment on column OA_MSG_SEND.SEND_USERID
  is '发送人';
comment on column OA_MSG_SEND.SEND_ORGID
  is '发送人机构id';
comment on column OA_MSG_SEND.SEND_DATE
  is '发送时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_MSG_SEND
  add constraint PK_OA_MSG_SEND primary key (MSG_ID);


-- Create table
create table OA_MSG_RECV
(
  RECV_ID     VARCHAR2(50) not null,
  MSG_ID      VARCHAR2(50) not null,
  RECV_USERID varchar2(50) not null,
  RECV_ORGID  VARCHAR2(50),
  ISREAD      CHAR(1) default '0' not null,
  READ_DATE   DATE,
  ISHIDDEN    CHAR(1) default '0' not null
);
-- Add comments to the table 
comment on table OA_MSG_RECV
  is '站内消息接收表';
-- Add comments to the columns 
comment on column OA_MSG_RECV.RECV_ID
  is '接收id';
comment on column OA_MSG_RECV.MSG_ID
  is '消息id';
comment on column OA_MSG_RECV.RECV_USERID
  is '接收人id';
comment on column OA_MSG_RECV.RECV_ORGID
  is '接收人单位id';
comment on column OA_MSG_RECV.ISREAD
  is '是否已阅';
comment on column OA_MSG_RECV.READ_DATE
  is '阅读时间';
comment on column OA_MSG_RECV.ISHIDDEN
  is '是否隐藏';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_MSG_RECV
  add constraint PK_OA_MSG_RECV primary key (RECV_ID);
-- Create/Recreate check constraints 
alter table OA_MSG_RECV
  add constraint CKC_ISHIDDEN_OA_MSG_R
  check (ishidden in ('0','1'));
alter table OA_MSG_RECV
  add constraint CKC_ISREAD_OA_MSG_R
  check (isread in ('0','1'));

