--------平台V3.0系统消息脚本开始--------
-- Create table 个人未发送邮件表
create table TD_MSG_PERSONAL_NOSEND
(
  ID            VARCHAR2(100) not null,
  TITLE         VARCHAR2(500),
  CONTENT       CLOB,
  SENDER_ID     VARCHAR2(100),
  SENDER_NAME   VARCHAR2(100),
  RECEIVER_ID   VARCHAR2(1000),
  RECEIVER_NAME VARCHAR2(1000),
  SEND_TIME     VARCHAR2(100),
  SAVE_TIME     VARCHAR2(100)
);
-- Add comments to the table 
comment on table TD_MSG_PERSONAL_NOSEND is '个人未发送邮件表';
-- Add comments to the columns 
comment on column TD_MSG_PERSONAL_NOSEND.ID is '记录编号';
comment on column TD_MSG_PERSONAL_NOSEND.TITLE is '邮件标题';
comment on column TD_MSG_PERSONAL_NOSEND.CONTENT is '邮件内容';
comment on column TD_MSG_PERSONAL_NOSEND.SENDER_ID is '发送者ID';
comment on column TD_MSG_PERSONAL_NOSEND.SENDER_NAME is '发送者姓名';
comment on column TD_MSG_PERSONAL_NOSEND.RECEIVER_ID is '接收者ID';
comment on column TD_MSG_PERSONAL_NOSEND.RECEIVER_NAME is '接收者姓名';
comment on column TD_MSG_PERSONAL_NOSEND.SEND_TIME is '发送时间';
comment on column TD_MSG_PERSONAL_NOSEND.SAVE_TIME is '保存时间';
commit;

-- Create table 个人接收邮件表
create table TD_MSG_PERSONAL_RECEIVE
(
  ID            VARCHAR2(100) not null,
  TITLE         VARCHAR2(500),
  CONTENT       CLOB,
  SENDER_ID     VARCHAR2(100),
  SENDER_NAME   VARCHAR2(100),
  RECEIVER_ID   VARCHAR2(100),
  RECEIVER_NAME VARCHAR2(100),
  SEND_TIME     VARCHAR2(100),
  ISREAD        VARCHAR2(10),
  ISDELETE      VARCHAR2(10)
);
-- Add comments to the table 
comment on table TD_MSG_PERSONAL_RECEIVE is '个人接收邮件表';
-- Add comments to the columns 
comment on column TD_MSG_PERSONAL_RECEIVE.ID is '记录编号';
comment on column TD_MSG_PERSONAL_RECEIVE.TITLE is '邮件标题';
comment on column TD_MSG_PERSONAL_RECEIVE.CONTENT is '邮件内容';
comment on column TD_MSG_PERSONAL_RECEIVE.SENDER_ID is '发送者ID';
comment on column TD_MSG_PERSONAL_RECEIVE.SENDER_NAME is '发送者姓名';
comment on column TD_MSG_PERSONAL_RECEIVE.RECEIVER_ID is '接收者ID';
comment on column TD_MSG_PERSONAL_RECEIVE.RECEIVER_NAME is '接收者姓名';
comment on column TD_MSG_PERSONAL_RECEIVE.SEND_TIME is '发送时间';
comment on column TD_MSG_PERSONAL_RECEIVE.ISREAD is '是否已读';
comment on column TD_MSG_PERSONAL_RECEIVE.ISDELETE is '是否删除';
commit;

-- Create table 个人发送邮件表
create table TD_MSG_PERSONAL_SEND
(
  ID            VARCHAR2(100) not null,
  TITLE         VARCHAR2(500),
  CONTENT       CLOB,
  SENDER_ID     VARCHAR2(100),
  SENDER_NAME   VARCHAR2(100),
  RECEIVER_ID   VARCHAR2(1000),
  RECEIVER_NAME VARCHAR2(1000),
  SEND_TIME     VARCHAR2(100)
);
-- Add comments to the table 
comment on table TD_MSG_PERSONAL_SEND is '个人发送邮件表';
-- Add comments to the columns 
comment on column TD_MSG_PERSONAL_SEND.ID is '记录编号';
comment on column TD_MSG_PERSONAL_SEND.TITLE is '邮件标题';
comment on column TD_MSG_PERSONAL_SEND.CONTENT is '邮件内容';
comment on column TD_MSG_PERSONAL_SEND.SENDER_ID is '发送者ID';
comment on column TD_MSG_PERSONAL_SEND.SENDER_NAME is '发送者姓名';
comment on column TD_MSG_PERSONAL_SEND.RECEIVER_ID is '接收者ID';
comment on column TD_MSG_PERSONAL_SEND.RECEIVER_NAME is '接收者姓名';
comment on column TD_MSG_PERSONAL_SEND.SEND_TIME is '发送时间';
commit;


-- 数据初始化
DELETE TABLEINFO WHERE TABLE_NAME='td_msg_personal_nosend';
commit;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_msg_personal_nosend', 'id', 1, 0, NULL, 'string', NULL);
commit;

DELETE TABLEINFO WHERE TABLE_NAME='TD_MSG_PERSONAL_SEND';
commit;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TD_MSG_PERSONAL_SEND', 'ID', 1, 0, NULL, 'string', NULL);
commit;

DELETE TABLEINFO WHERE TABLE_NAME='td_msg_personal_receive';
commit;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_msg_personal_receive', 'id', 1, 0, NULL, 'string', NULL);
commit;

-- Create table 消息资源表
create table TD_MSG_RESOURCE
(
  R_ID       NUMBER,
  R_NAME     VARCHAR2(50),
  R_DESC     VARCHAR2(50),
  R_MSG_TYPE VARCHAR2(128)
);
-- Add comments to the table 
comment on table TD_MSG_RESOURCE is '消息资源表';
-- Add comments to the columns 
comment on column TD_MSG_RESOURCE.R_ID is '流水号';
comment on column TD_MSG_RESOURCE.R_NAME is '资源名称';
comment on column TD_MSG_RESOURCE.R_DESC is '资源描述';
comment on column TD_MSG_RESOURCE.R_MSG_TYPE is '消息类型';
commit;

-- Create table
create table TD_USER_MSG_RESOURCE
(
  USER_ID    NUMBER,
  R_ID       VARCHAR2(20),
  R_MSG_TYPE VARCHAR2(128)
);
-- Add comments to the table 
comment on table TD_USER_MSG_RESOURCE is '用户与消息资源映射表';
-- Add comments to the columns 
comment on column TD_USER_MSG_RESOURCE.USER_ID is '用户id';
comment on column TD_USER_MSG_RESOURCE.R_ID is '消息资源id';
comment on column TD_USER_MSG_RESOURCE.R_MSG_TYPE is '用户自定义消息类型';
commit;


-- Create table 消息主表
create table TD_MESSAGE_MAIN
(
  MSG_MAIN_ID          VARCHAR2(32)  primary key,
  MSG_MAIN_TITLE       VARCHAR2(500),
  MSG_MAIN_CONTENT     VARCHAR2(2000),
  MSG_MAIN_SENDER      VARCHAR2(200),
  MSG_MAIN_RECEIVES    VARCHAR2(1000),
  MSG_MAIN_SEND_TYPE   VARCHAR2(100),
  MSG_MAIN_SEND_TIME   DATE,
  MSG_MAIN_BUSINESS_ID VARCHAR2(50)
);
-- Add comments to the table 
comment on table TD_MESSAGE_MAIN is '消息资源主表';
-- Add comments to the columns 
comment on column TD_MESSAGE_MAIN.MSG_MAIN_ID is '主表ID';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_TITLE is '消息标题';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_CONTENT is '消息内容';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_SENDER is '发送人用户名';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_RECEIVES is '接受人用户名';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_SEND_TYPE is '消息发送类型';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_SEND_TIME is '发送时间';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_BUSINESS_ID is '业务ID';
commit;
-- Create table 消息资源字典表
create table TD_MSG_DICT
(
  DICT_MSG_NO             VARCHAR2(10) primary key,
  DICT_MSG_NAME		  VARCHAR2(100),
  DICT_MSG_SEND_BEAN_ID   VARCHAR2(100),
  DICT_MSG_SAVE_BEAN_ID   VARCHAR2(100),
  DICT_MSG_RESEND_BEAN_ID VARCHAR2(100),
  DICT_MSG_REMARK         VARCHAR2(100)
);
-- Add comments to the table 
comment on table TD_MSG_DICT is '消息资源字典表';
-- Add comments to the columns 
comment on column TD_MSG_DICT.DICT_MSG_NO is '字典ID';
comment on column TD_MSG_DICT.DICT_MSG_NAME is '消息类型名称';
comment on column TD_MSG_DICT.DICT_MSG_SEND_BEAN_ID is '发送beanId';
comment on column TD_MSG_DICT.DICT_MSG_SAVE_BEAN_ID is '保存beanId';
comment on column TD_MSG_DICT.DICT_MSG_RESEND_BEAN_ID is '重发beanId';
comment on column TD_MSG_DICT.DICT_MSG_REMARK is '备注字段';
commit;
-- Create table 消息发送表
create table TD_MSG_SENDING
(
  MSG_LOG_ID        NUMBER PRIMARY KEY,
  MSG_MAIN_ID       VARCHAR2(32) references TD_MESSAGE_MAIN (MSG_MAIN_ID),
  MSG_LOG_STATE     CHAR(1),
  MSG_LOG_RECEIVER  VARCHAR2(200),
  MSG_LOG_SEND_TYPE VARCHAR2(50),
  MSG_LOG_DATE      DATE,
  MSG_LOG_REMARK_A  VARCHAR2(100),
  MSG_LOG_REMARK_B  VARCHAR2(100)
);
-- Add comments to the table 
comment on table TD_MSG_SENDING is '消息发送表';
-- Add comments to the columns 
comment on column TD_MSG_SENDING.MSG_LOG_ID is '发送记录ID';
comment on column TD_MSG_SENDING.MSG_MAIN_ID is '消息主表ID';
comment on column TD_MSG_SENDING.MSG_LOG_STATE is '发送状态';
comment on column TD_MSG_SENDING.MSG_LOG_RECEIVER is '接受人';
comment on column TD_MSG_SENDING.MSG_LOG_SEND_TYPE is '发送消息类型';
comment on column TD_MSG_SENDING.MSG_LOG_DATE is '发送时期';
comment on column TD_MSG_SENDING.MSG_LOG_REMARK_A is '备注A';
comment on column TD_MSG_SENDING.MSG_LOG_REMARK_B is '备注B';
commit;
--创建序列
create sequence SEQ_TD_MSG_SENDING
minvalue 1
maxvalue 99999999999999999999
start with 421
increment by 1
nocache;
--更新数据
update td_user_msg_resource t set t.r_msg_type = 'rtx,sms,sys';
update td_msg_resource t set t.r_msg_type='rtx,sms,sys';
--应用下不需此语句 update tb_application_info i set i.functionlist='rtx,sms,sys';
commit;
--添加数据
insert into TD_MSG_DICT (DICT_MSG_NO, DICT_MSG_NAME, DICT_MSG_SEND_BEAN_ID, DICT_MSG_SAVE_BEAN_ID, DICT_MSG_RESEND_BEAN_ID, DICT_MSG_REMARK)
values ('rtx', 'RTX', 'RtxSendImpl', 'RtxSaveImpl', 'RtxReSendImpl', null);
insert into TD_MSG_DICT (DICT_MSG_NO, DICT_MSG_NAME, DICT_MSG_SEND_BEAN_ID, DICT_MSG_SAVE_BEAN_ID, DICT_MSG_RESEND_BEAN_ID, DICT_MSG_REMARK)
values ('sms', '短信', 'SmsSendImpl', 'SmsSaveImpl', 'SmsReSendImpl', null);
insert into TD_MSG_DICT (DICT_MSG_NO, DICT_MSG_NAME, DICT_MSG_SEND_BEAN_ID, DICT_MSG_SAVE_BEAN_ID, DICT_MSG_RESEND_BEAN_ID, DICT_MSG_REMARK)
values ('sys', '邮件', 'SysSendImpl', null, null, null);
commit;
--------平台V3.0消息脚本结束--------
