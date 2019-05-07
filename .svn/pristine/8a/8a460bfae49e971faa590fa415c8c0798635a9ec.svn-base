delete OA_DICT_DATA where DICTDATA_ID = '21';
commit;
insert into OA_DICT_DATA (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('21', '7', '0', '会议管理', '1', '会议管理', '1', 1);
delete OA_SYS_PARAM d where d.p_code IN ('linktel','topicconfig');
commit;

delete OA_SYS_PARAM d where d.p_code IN ('linktel','topicconfig');
commit;
insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('f9195663-1d63-4083-95f8-2513109f1628', '0', 'linktel', '会议通知联系人电话号码', '1', '1', to_date('30-07-2013 09:06:39', 'dd-mm-yyyy hh24:mi:ss'), '1', '21', '0 代表 user_worktel' || chr(13) || '' || chr(10) || '1 代表 user_mobiletel1' || chr(13) || '' || chr(10) || '只设置一个为有效。');
insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('2a3106f2-94d6-4d51-b7e0-1d5443d71be9', '0', 'topicconfig', '会议议题全局配置', '1', '1', to_date('30-07-2013 10:23:03', 'dd-mm-yyyy hh24:mi:ss'), '1', '21', '0 不显示' || chr(13) || '' || chr(10) || '1 显示' || chr(13) || '' || chr(10) || '' || chr(13) || '' || chr(10) || '配置会议通知申请时议题tab页面是否显示');
commit;

delete OA_DATA_RESOURCES where RESOURCES_ID= '9';
commit;
insert into OA_DATA_RESOURCES (RESOURCES_ID, RESOURCES_PARENT_ID, RESOURCES_NAME, RESOURCES_LOGO, RESOURCES_DESC, CREATOR_TIME, RESOURCES_TYPE, TREE_TYPE, IS_VIEW)
values ('9', '1', '会议单位接收人', 'meetingunitresion', '会议接收单位接收人', to_date('16-07-2013', 'dd-mm-yyyy'), '2', null, '1');
commit;