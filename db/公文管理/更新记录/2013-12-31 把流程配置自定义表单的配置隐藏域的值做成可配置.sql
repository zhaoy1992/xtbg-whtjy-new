--删除数据
delete oa_dict_data where dict_id='d585aaa4-6e7c-43a0-b75d-d3efcb20231a';
--删除类型
delete oa_dict_type where dict_id='d585aaa4-6e7c-43a0-b75d-d3efcb20231a';
--添加自定义表单字典类型
insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('d585aaa4-6e7c-43a0-b75d-d3efcb20231a', '0', '自定义表单', 'zdybd', '自定义表单里面的一些配置', '1', null, '1');

--添加自定义表单字典数据
insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('ce16bcc2-e2ad-4b5b-8f4d-b81d41c77af5', 'd585aaa4-6e7c-43a0-b75d-d3efcb20231a', 'cc9b8877-f449-4c37-9ff7-15c65ea45516', '单位ID', '{unit_id}', '单位ID', '1', 5);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('1f8c3613-ff8d-40eb-9330-9e85b2b4ac22', 'd585aaa4-6e7c-43a0-b75d-d3efcb20231a', 'cc9b8877-f449-4c37-9ff7-15c65ea45516', '当前时间(yyyy-MM-dd hh-mm-ss)', '{time}', '当前时间(yyyy-MM-dd hh-mm-ss)', '1', 7);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('912cb0e2-cd7e-419f-acdd-85e19103d992', 'd585aaa4-6e7c-43a0-b75d-d3efcb20231a', 'cc9b8877-f449-4c37-9ff7-15c65ea45516', '用户ID', '{user_id}', '用户ID', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('f2275d7e-955f-406d-b919-5e36623afc21', 'd585aaa4-6e7c-43a0-b75d-d3efcb20231a', 'cc9b8877-f449-4c37-9ff7-15c65ea45516', '部门名称', '{org_name}', '部门名称', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('58112b8c-a1b8-4adf-ad41-ec75b4a95d96', 'd585aaa4-6e7c-43a0-b75d-d3efcb20231a', 'cc9b8877-f449-4c37-9ff7-15c65ea45516', '当前时间(yyyy-MM-dd)', '{date}', '当前时间(yyyy-MM-dd)', '1', 8);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('8ff1a6d6-2b90-4b23-a4fb-de7135f22251', 'd585aaa4-6e7c-43a0-b75d-d3efcb20231a', 'cc9b8877-f449-4c37-9ff7-15c65ea45516', '单位名称', '{unit_name}', '单位名称', '1', 6);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('cc9b8877-f449-4c37-9ff7-15c65ea45516', 'd585aaa4-6e7c-43a0-b75d-d3efcb20231a', '0', '配置隐藏域', 'pzycy', '配置隐藏域', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('0ce90988-4226-4d41-9773-1c2d810387f1', 'd585aaa4-6e7c-43a0-b75d-d3efcb20231a', 'cc9b8877-f449-4c37-9ff7-15c65ea45516', '部门ID', '{org_id}', '部门ID', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('86a89fb2-d96a-4c22-98c9-f82eeaba9411', 'd585aaa4-6e7c-43a0-b75d-d3efcb20231a', 'cc9b8877-f449-4c37-9ff7-15c65ea45516', '用户名称', '{user_name}', '用户名称', '1', 2);

commit;