-----在字典数据表中加入 关于知识库 类别为系统参数 数据值(即在系统配置树中显示的节点)
delete oa_dict_data where dictdata_id='174f4ebe-d74f-4b54-86c0-57233dcc6e32';
commit;
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('174f4ebe-d74f-4b54-86c0-57233dcc6e32', '7', '0', '知识库', 'kbm', '知识库管理中的各类参数配置', '1', 1);
commit;

delete OA_SYS_PARAMVALUE where  p_code = 'checkpass' or p_code='checkpass2' or p_code='deletedoc' or p_code='checkrss';
commit;
delete OA_SYS_PARAM where p_code = 'checkpass' or p_code='checkpass2' or p_code='deletedoc' or p_code='checkrss';
commit;

-----添加知识库系统参数表的值
insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('e31e6036-9360-4f1a-9d42-a2ef0c55d6f9', 'KBM_NOTE_DELETEDOC', 'deletedoc', '知识库短信模板（删除提醒）', '知识库中有一篇【用户名】上传的标题为【文档标题】的文档已经删除。谢谢！', '1', to_date('28-08-2013 11:05:11', 'dd-mm-yyyy hh24:mi:ss'), '1', '174f4ebe-d74f-4b54-86c0-57233dcc6e32', '【用户名】    将替换为 文档登记人姓名' || chr(13) || '' || chr(10) || '【文档标题】  将替换为 标题' || chr(13) || '' || chr(10) || '' || chr(13) || '' || chr(10) || '注： 管理员删除文档信息后发短信给上传人。');
insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('877aaf6f-8c96-4acb-bb56-b13a842b89f8', 'KBM_NOTE_CHECKPASS', 'checkpass2', '知识库短信模板 2（审核提醒）', '知识库中有一篇【用户名】上传的标题为【文档标题】的文档已经审核，审核意见为【审核意见】。谢谢！', '1', to_date('15-08-2013 09:18:28', 'dd-mm-yyyy hh24:mi:ss'), '1', '174f4ebe-d74f-4b54-86c0-57233dcc6e32', '【用户名】    将替换为 文档登记人姓名' || chr(13) || '' || chr(10) || '【文档标题】  将替换为 标题' || chr(13) || '' || chr(10) || '【审核结果】  将替换为 文档状态' || chr(13) || '' || chr(10) || '注： 管理员审核后发短信给上传人。');
insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('ea784f93-9949-4246-8c66-db7b8ff77d87', 'KBM_NOTE_CHECKPASS', 'checkpass', '知识库短信模板（审核提醒）', '知识库中有一篇【用户名】上传的标题为【文档标题】的文档已经审核。谢谢！', '1', to_date('09-08-2013 11:30:02', 'dd-mm-yyyy hh24:mi:ss'), '1', '174f4ebe-d74f-4b54-86c0-57233dcc6e32', '【用户名】    将替换为 文档登记人姓名' || chr(13) || '' || chr(10) || '【文档标题】  将替换为 标题' || chr(13) || '' || chr(10) || '' || chr(13) || '' || chr(10) || '注： 管理员审核后发短信给上传人。');
insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('c5f4bd75-2a83-40a5-be15-aa666a91103c', 'KBM_NOTE_CHECKRSS', 'checkrss', '知识库短信模版（文档订阅）', '标题：知识库通知' || chr(13) || '' || chr(10) || '发件人：管理员' || chr(13) || '' || chr(10) || '正文：' || chr(13) || '' || chr(10) || '新文档发布通知：' || chr(13) || '' || chr(10) || '标题：【文档标题】' || chr(13) || '' || chr(10) || '上传人：【登记人】' || chr(13) || '' || chr(10) || '上传时间：【登记时间】', '1', to_date('17-09-2013 10:29:52', 'dd-mm-yyyy hh24:mi:ss'), '1', '174f4ebe-d74f-4b54-86c0-57233dcc6e32', '【文档标题】 用 文档标题 代替' || chr(13) || '' || chr(10) || '【上传人】   用 登记人 代替' || chr(13) || '' || chr(10) || '【上传时间】 用 登记时间 代替');

commit;

----添加知识库系统参数值表的值
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('9d286303-61ca-4165-84af-2e3049cbdeb3', 'checkpass2', 'k_create_user_name', '用户名', '1', to_date('15-08-2013 09:22:58', 'dd-mm-yyyy hh24:mi:ss'));
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('663af6aa-afe0-4487-bef6-2a41a6bc3e14', 'checkpass2', 'k_title', '文档标题', '1', to_date('15-08-2013 09:24:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('c50edc4b-ef64-4ae1-be8d-bf5f21ca5e19', 'deletedoc', 'k_create_user_name', '用户名', '1', to_date('28-08-2013 11:06:51', 'dd-mm-yyyy hh24:mi:ss'));
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('92b8daf8-0086-46da-bea8-17cbad7033fe', 'checkpass', 'k_title', '文档标题', '1', to_date('09-08-2013 11:34:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('61a4de28-c186-4518-bc4c-bf579ffdfddd', 'checkpass2', 'k_flag_name', '审核结果', '1', to_date('15-08-2013 09:24:27', 'dd-mm-yyyy hh24:mi:ss'));
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('c4d78080-f9ef-4dc6-9652-6e7080781fbd', 'deletedoc', 'k_title', '文档标题', '1', to_date('28-08-2013 11:07:27', 'dd-mm-yyyy hh24:mi:ss'));
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('a7d09aff-404e-4be1-8fa3-f839b2f3e87a', 'checkpass', 'k_create_user_name', '用户名', '1', to_date('09-08-2013 11:33:20', 'dd-mm-yyyy hh24:mi:ss'));
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('bc4fc990-e4f2-49c5-a38c-49a46ec560be', 'checkrss', 'k_title', '文档标题', '1', to_date('17-09-2013 10:36:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('1ef50f69-7909-4747-b14c-6b8684587086', 'checkrss', 'k_create_time', '登记时间', '1', to_date('17-09-2013 10:37:54', 'dd-mm-yyyy hh24:mi:ss'));
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('9f704422-e291-4992-9a0c-1c00b52aa8e2', 'checkrss', 'k_create_user_name', '登记人', '1', to_date('17-09-2013 10:37:12', 'dd-mm-yyyy hh24:mi:ss'));
commit;