delete OA_SYS_PARAMVALUE  where P_CODE='notice_msg_send';

delete OA_SYS_PARAM where P_CODE='notice_msg_send';

delete OA_DICT_DATA where DICTDATA_VALUE='notice';
commit;
--参数类型
insert into OA_DICT_DATA (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('568cb209-97c7-47d4-b532-2ca0b30717a7', '7', '0', '通知公告', 'notice', '通知公告中的参数类型', '1', 5);

--参数类型下的参数数据
insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('c0d37121-88b0-4f19-8d11-837d3e365bc1', 'notice_msg', 'notice_msg_send', '通知公告消息提醒模版', '你好！你有一则通知公告：标题：【标题】 创建人：【创建人】 发布时间：【发布时间】。请及时查看！', '1', to_date('08-10-2013 16:58:02', 'dd-mm-yyyy hh24:mi:ss'), '1', '568cb209-97c7-47d4-b532-2ca0b30717a7', '【标题】  将用 通知公告标题代替
【创建人】 将用  通知公告创建人代替
【发布时间】 将用 通知公告发布时间代替');

--参数的值表数据
insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('bddfbeb0-57d7-41ef-b369-4e7529832bcf', 'notice_msg_send', 'n_title', '标题', '1', to_date('08-10-2013 17:08:39', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('43c571cb-5a30-4d6c-a6b8-606f560a3bd4', 'notice_msg_send', 'n_creator_username', '创建人', '1', to_date('08-10-2013 17:09:08', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('c1e221d4-9934-496b-8599-a2c4acdc39ca', 'notice_msg_send', 'n_release_time', '发布时间', '1', to_date('08-10-2013 17:09:44', 'dd-mm-yyyy hh24:mi:ss'));
commit;

--字段添加
-- Add/modify columns 
alter table OA_NOTICE_BASEINFO add n_is_sms VARCHAR2(1);
alter table OA_NOTICE_BASEINFO add n_is_msg VARCHAR2(1);
alter table OA_NOTICE_BASEINFO add n_is_mail varchar2(1);
alter table OA_NOTICE_BASEINFO add n_is_rtx varchar2(1);
-- Add comments to the columns 
comment on column OA_NOTICE_BASEINFO.n_is_sms
  is '是否是短信(1.是0.否)';
comment on column OA_NOTICE_BASEINFO.n_is_msg
  is '是否是站内(1.是0.否)';
comment on column OA_NOTICE_BASEINFO.n_is_mail
  is '是否是邮件(1.是0.否)';
comment on column OA_NOTICE_BASEINFO.n_is_rtx
  is '是否是j及时(1.是0.否)';


-- Add comments to the columns 
comment on column OA_NOTICE_MSG.n_megtype
  is '消息类型(1短信，2站内消息，3及时信息，4邮件)';
