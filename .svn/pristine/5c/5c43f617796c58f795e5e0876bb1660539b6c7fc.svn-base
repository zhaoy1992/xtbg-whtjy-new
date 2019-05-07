delete OA_SYS_PARAMVALUE where P_CODE='meeting_msg_cancel_send' or P_CODE='meeting_msg_reply_send';

delete OA_SYS_PARAM where P_CODE='meeting_msg_cancel_send' or P_CODE='meeting_msg_reply_send';

insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('4daf10f6-88f1-4fbd-af77-a5e5f11d0627', 'meeting_msg_cancel', 'meeting_msg_cancel_send', '会议撤销消息提示模版', '会议通知：【会议名称】已经被撤销，谢谢！', '1', to_date('25-10-2013 16:50:05', 'dd-mm-yyyy hh24:mi:ss'), '1', '21', '【会议名称】将会用会议标题代替');

insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('7f615b72-c7fb-40e2-a87e-9679b243188e', 'meeting_msg_reply', 'meeting_msg_reply_send', '报名回复消息提醒模版', '【参会人员】会准时参加会议。', '1', to_date('25-10-2013 14:13:19', 'dd-mm-yyyy hh24:mi:ss'), '1', '21', '【参会人员】 将用参会人员代替');

insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('5b29b9ae-d195-4f1c-9537-a85d2e1bb236', 'meeting_msg_cancel_send', 'm_title', '会议名称', '1', to_date('25-10-2013 16:52:44', 'dd-mm-yyyy hh24:mi:ss'));

insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('af5e0691-f5fa-4b2e-973e-f9ae8ce292f0', 'meeting_msg_reply_send', 'm_attender_names', '参会人员', '1', to_date('25-10-2013 14:29:42', 'dd-mm-yyyy hh24:mi:ss'));
commit;