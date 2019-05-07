insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('cfb0fe25-8c87-42d1-88bb-4e13af9dfc7c', '7', '0', '公文模块', 'archive', '公文模块', '1', null);

insert into oa_sys_param (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('855efc2e-9c3c-404a-a37f-d24479581788', 'archive_msg', 'archive_msg_send', '公文发送全局短信内容配置', '【发送人】给您发送一份标题为：【流程实例名称】 的公文，请注意查收', '1', to_date('18-02-2014 09:32:37', 'dd-mm-yyyy hh24:mi:ss'), '1', 'cfb0fe25-8c87-42d1-88bb-4e13af9dfc7c', '公文发送全局短信内容配置');

insert into oa_sys_param (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('ffd7a0fe-bc75-401f-b364-2af2f7e68aa9', 'is_send_check', 'is_send_check', '短信默认发送配置', '1', '1', to_date('18-02-2014 10:07:22', 'dd-mm-yyyy hh24:mi:ss'), '1', 'cfb0fe25-8c87-42d1-88bb-4e13af9dfc7c', '0 默认发送短信不勾选
1 默认发送短信勾选

配置公文传输流程时短信通知是否勾选');

insert into oa_sys_paramvalue (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('c190d668-2399-4d59-a87f-8a375a7756b3', 'archive_msg_send', 'ins_name', '流程实例名称', '1', to_date('18-02-2014 10:45:59', 'dd-mm-yyyy hh24:mi:ss'));

insert into oa_sys_paramvalue (P_VALUE_ID, P_CODE, P_VALUE_CODE, P_VALUE_NAME, P_VALUE_VALID, P_CREATOR_TIME)
values ('448fc832-0756-4cba-9941-6ce5c25c6b10', 'archive_msg_send', 'send_user_name', '发送人', '1', to_date('18-02-2014 10:46:28', 'dd-mm-yyyy hh24:mi:ss'));

commit;