delete OA_DICT_DATA where DICTDATA_ID = '21';
insert into OA_DICT_DATA (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('21', '7', '0', '会议管理', '1', '会议管理', '1', 1);
commit;
delete OA_SYS_PARAMVALUE where P_CODE='meeting_msg_send';

delete OA_SYS_PARAM where P_CODE='meeting_msg_send';
commit;

insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('c1326cbf-900c-4bcb-a380-c2eb086da54f', 'meeting_msg', 'meeting_msg_send', '会议消息模版', '会议通知：会议名称：【会议名称】  会议地点：【会议地点】  会议时间：【开始时间】至【结束时间】', '1', to_date('11-10-2013 14:07:00', 'dd-mm-yyyy hh24:mi:ss'), '1', '21', '参数内容中【】里的内容将会用会议相应内容代替');

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('98d25c42-40a4-4ba4-ad6f-ab3540126533', 'meeting_msg_send', 'm_address', '会议地点', '1', to_date('11-10-2013 14:09:58', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('08d333be-172f-4f43-8678-f9e218ba20de', 'meeting_msg_send', 'm_begin_time', '开始时间', '1', to_date('11-10-2013 14:10:26', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('0bdccf42-1ab1-4d36-8d1a-b68a7c272bac', 'meeting_msg_send', 'm_end_time', '结束时间', '1', to_date('11-10-2013 14:10:52', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('3600bb98-e07e-44ea-86fa-0f7bd5878a07', 'meeting_msg_send', 'm_title', '会议名称', '1', to_date('11-10-2013 14:09:32', 'dd-mm-yyyy hh24:mi:ss'));
commit;

--脚本的字段添加
-- Add/modify columns 
alter table OA_MEETING_NOTICE add is_sms varchar2(2);
alter table OA_MEETING_NOTICE add is_msg varchar2(2);
alter table OA_MEETING_NOTICE add is_rtx varchar2(2);
alter table OA_MEETING_NOTICE add is_mail varchar2(2);
-- Add comments to the columns 
comment on column OA_MEETING_NOTICE.is_sms
  is '是否短信(1是,0否)';
comment on column OA_MEETING_NOTICE.is_msg
  is '是否站内消息(1是,0否)';
comment on column OA_MEETING_NOTICE.is_rtx
  is '是否及时消息(1是,0否)';
comment on column OA_MEETING_NOTICE.is_mail
  is '是否邮件(1是,0否)';
