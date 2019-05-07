delete OA_SYS_PARAMVALUE where P_CODE='task_msg_reply_send' or P_CODE='task_msg_send' or P_CODE='task_msg_end_send';

delete OA_SYS_PARAM where P_CODE='task_msg_reply_send' or P_CODE='task_msg_send' or P_CODE='task_msg_end_send';

delete OA_DICT_DATA where DICTDATA_VALUE='paper';
commit;

insert into OA_DICT_DATA (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('8a7da04e-08cd-48dd-8df7-41540e991e9d', '7', '0', '信息报送', 'paper', '信息报送的各种参数', '1', 3);

insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('33039f5b-d6e2-40af-a56e-1862f3f0a63a', 'task_msg_reply', 'task_msg_reply_send', '回复交办消息模版', '你好！任务【任务名称】有一条回复消息，发送人【发送人】', '1', to_date('10-10-2013 09:28:56', 'dd-mm-yyyy hh24:mi:ss'), '1', '4d1577fb-9fcd-4c81-88e2-250aa0b65b23', '【任务名称】 将用 该任务的名称代替
【发送人】  将用  发送消息的人名称代替');

insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('55aa28a3-db6f-473f-b8b2-f1197f8eb746', 'task_msg', 'task_msg_send', '任务交办消息提醒', '你好！你有一则任务：  任务名称：【任务名称】  发起人：【发起人】  负责人：【负责人】 。请及时处理。', '1', to_date('09-10-2013 15:36:57', 'dd-mm-yyyy hh24:mi:ss'), '1', '4d1577fb-9fcd-4c81-88e2-250aa0b65b23', '【任务名称】 将用任务交办的名称代替
【发起人】 将用任务交办的发起人代替
【负责人】 将用任务交办的负责人代替');

insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('6ce4d918-e55b-47ce-80aa-67eef9c1553c', 'task_msg_end', 'task_msg_end_send', '任务交办办结消息提醒', '你好！该任务 【任务名称】 已经办结，请及时查看。', '1', to_date('09-10-2013 16:52:34', 'dd-mm-yyyy hh24:mi:ss'), '1', '4d1577fb-9fcd-4c81-88e2-250aa0b65b23', '【任务名称】将用任务名称代替');

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('0b56afa1-c813-4d09-a831-6ceecd75b3c1', 'task_msg_send', 'input_username', '发起人', '1', to_date('09-10-2013 15:42:45', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('f648a5ab-e9c1-48cc-955c-b7baa810da4d', 'task_msg_send', 'receive_username', '负责人', '1', to_date('09-10-2013 15:44:02', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('732a7fc9-4175-4a80-97b3-d756fac501bb', 'task_msg_send', 'task_name', '任务名称', '1', to_date('09-10-2013 15:41:04', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('5617dac0-6bc8-4555-87d5-6d49358d51a4', 'task_msg_reply_send', 'task_name', '任务名称', '1', to_date('10-10-2013 09:30:49', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('0f2031b2-ffa0-4867-b0e8-1be93b597555', 'task_msg_reply_send', 'user_name', '发送人', '1', to_date('10-10-2013 09:31:19', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('27a1edfb-032c-4491-9639-6cff34728698', 'task_msg_end_send', 'task_name', '任务名称', '1', to_date('09-10-2013 16:56:15', 'dd-mm-yyyy hh24:mi:ss'));

commit;

DROP TABLE OA_TASK_MSG CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_TASK_MSG                                         */
/*==============================================================*/
CREATE TABLE OA_TASK_MSG 
(
   T_MSG_ID           VARCHAR2(50)         NOT NULL,
   ID                 VARCHAR2(50),
   T_MSG_TYPE         VARCHAR2(2),
   T_MSG_CONTENT      VARCHAR2(4000),
   CONSTRAINT PK_OA_TASK_MSG PRIMARY KEY (T_MSG_ID)
);

COMMENT ON TABLE OA_TASK_MSG IS
'任务交办消息表';

COMMENT ON COLUMN OA_TASK_MSG.T_MSG_ID IS
'主键id';

COMMENT ON COLUMN OA_TASK_MSG.ID IS
'任务id';

COMMENT ON COLUMN OA_TASK_MSG.T_MSG_TYPE IS
'消息类型(1短信，2站内消息，3及时信息，4邮件)';

COMMENT ON COLUMN OA_TASK_MSG.T_MSG_CONTENT IS
'消息内容';





-- Add/modify columns 
alter table OA_TASK_BASEINFO add t_is_sms varchar2(2);
alter table OA_TASK_BASEINFO add t_is_msg varchar2(2);
alter table OA_TASK_BASEINFO add t_is_rtx varchar2(2);
alter table OA_TASK_BASEINFO add t_is_mail varchar2(2);
-- Add comments to the columns 
comment on column OA_TASK_BASEINFO.t_is_sms
  is '是否是短信(1是0否)';
comment on column OA_TASK_BASEINFO.t_is_msg
  is '是否是站内消息(1是0否)';
comment on column OA_TASK_BASEINFO.t_is_rtx
  is '是否是及时消息(1是0否)';
comment on column OA_TASK_BASEINFO.t_is_mail
  is '是否是邮件(1是0否)';


-- Add/modify columns 
alter table OA_TASK_TASKREPORT add is_sms varchar2(2);
alter table OA_TASK_TASKREPORT add is_msg varchar2(2);
alter table OA_TASK_TASKREPORT add is_rtx varchar2(2);
alter table OA_TASK_TASKREPORT add is_mail varchar2(2);
-- Add comments to the columns 
comment on column OA_TASK_TASKREPORT.is_sms
  is '是否是短息(1是0否)';
comment on column OA_TASK_TASKREPORT.is_msg
  is '是否是站内消息(1是0否)';
comment on column OA_TASK_TASKREPORT.is_rtx
  is '是否是及时消息(1是0否)';
comment on column OA_TASK_TASKREPORT.is_mail
  is '是否是邮件(1是0否)';
