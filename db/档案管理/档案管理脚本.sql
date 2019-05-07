delete from oa_dict_data where DICT_ID in ('1','2','3','4','5','6','7','8','9','10');
delete from oa_dict_type where DICT_ID in ('1','2','3','4','5','6','7','8','9','10');
insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('1', '0', '档案密级', 'damj', '档案管理的档案密级', '1', 1, '0');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('9', '0', '数量单位', 'sldw', '数量单位', '1', 9, '1');
insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('8', '0', '信息类型', 'xxlx', '信息类型', '1', 8, '0');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('6', '0', '年份', 'nianfen', '年份', '1', 6, '0');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('7', '0', '系统参数', 'xtcs', '系统参数设置', '1', 7, '1');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('2', '0', '归档状态', 'gdzt', '归档状态', '1', 2, '0');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('3', '0', '介质类型', 'jzlx', '介质类型', '1', 3, '0');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('4', '0', '实物类型', 'swlx', '实物类型', '1', 4, '1');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('10', '0', '备考表模板参数', 'bkbmbcs', '备考表模板参数', '1', 10, '0');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('5', '0', '保管期限', 'bgqx', '档案保管的期限', '1', 5, '1');

------------data表插入数据-----------

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('1', '1', '0', '绝密', '1', '绝密级别', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('2', '1', '0', '机密', '2', '机密级别', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('3', '1', '0', '秘密', '3', '秘密级别', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('4', '1', '0', '普通', '4', '普通级别', '1', 4);


insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('27', '9', '0', '件', '1', '电子文件：件', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('28', '9', '0', '张', '2', '数码照片：张', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('29', '9', '0', '小时', '3', '数字录音、数字录像：小时', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('30', '9', '0', '幅', '4', '图纸：幅', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('31', '9', '0', '盘', '5', '光盘：盘', '1', 5);



insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('23', '8', '0', '文本', '1', '文本', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('24', '8', '0', '图像', '2', '图像', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('25', '8', '0', '影像', '3', '影像', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('26', '8', '0', '声音', '4', '声音', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('5', '2', '0', '待归档', '0', '待归档', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('6', '2', '0', '不需归档', '1', '不需归档', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('7', '2', '0', '已归档', '2', '已归档', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('8', '2', '0', '已移交', '8', '已移交', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('9', '2', '0', '已销毁', '9', '已销毁', '1', 5);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('10', '3', '0', '电子和实物', '0', '电子和实物', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('11', '3', '0', '电子', '1', '电子', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('12', '3', '0', '实物', '2', '实物', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('13', '4', '0', '纸质', '1', '纸质', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('14', '4', '0', '照片', '2', '照片', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('15', '4', '0', '光盘', '3', '光盘', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('81485cf3-f572-4bec-a9c2-e8a45db4ab20', '4', '0', '影像', '4', '非测试数据', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('100001', '10', '0', '单位名称', 'ORG_NAME', '【单位名称】', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('100002', '10', '0', '处室名称', 'OFFICES_NAME', '【处室名称】', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('100003', '10', '0', '期限', 'TIME_LIMIT', '【期限】', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('100004', '10', '0', '目录号', 'CATALOG_NUMBER', '【目录号】', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('100005', '10', '0', '件数', 'COUNTT', '【件数】', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('6fcc1002-0718-4f5a-bc18-4ae25cd30e76', '7', '0', '档案管理', '4', '档案管理', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('16', '5', '0', '长期', '1', '长期', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('17', '5', '0', '中期', '2', '中期', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('18', '5', '0', '短期', '3', '短期', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('19', '6', '0', '2012', '2012', '2012', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('20', '6', '0', '2013', '2013', '2013', '1', 2);

--2013.08.19新增
delete from oa_dict_data where dict_id in('885bf4c5-e064-451e-ac84-f86bf7e277b0','a17c0bde-c4e7-4a98-a82c-43fc2173dfca','10','905810c3-9725-48c5-9068-da82a09ab88e');
delete from oa_dict_type where dict_id in('885bf4c5-e064-451e-ac84-f86bf7e277b0','a17c0bde-c4e7-4a98-a82c-43fc2173dfca','10','905810c3-9725-48c5-9068-da82a09ab88e');
insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('10', '0', '备考表模板参数', 'bkbmbcs', '备考表模板参数', '1', 10, '0');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('885bf4c5-e064-451e-ac84-f86bf7e277b0', '0', '档案档号模板参数', 'dadhmbcs', '档案档号模板参数', '1', 15, '0');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('905810c3-9725-48c5-9068-da82a09ab88e', '0', '档案添加界面', 'datjjm', '档案管理，添加档案的界面', '1', 503, '0');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('a17c0bde-c4e7-4a98-a82c-43fc2173dfca', '0', '档案查询界面', 'dacxjm', '档案查询界面', '1', 504, '0');
insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('53e98d9c-866a-463d-b63e-d7a56d0500c9', '10', '0', '所属单位', 'f_org_name', '【所属单位】', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('cbc0e66c-b8b5-4b48-ac5c-36f025253f09', '10', '0', '汇帐凭证终止号', 'f_file_endno', '会计凭证档案的汇帐凭证终止号', '1', 10);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('969dc4c6-58f4-405c-beee-5e075328ed22', '10', '0', '汇帐凭证起始号', 'f_file_startno', '会计凭证档案的，汇帐凭证起始号', '1', 9);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('11d2e21b-fe43-47bf-8909-2df9f0253fc5', '10', '0', '所属部门', 'f_dept_name', '【所属部门】', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('c4a6ddc8-11fd-43d1-a989-cae8f16aadd3', '10', '0', '密级', 'f_secrecy_name', '【密级】', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('5bb59d93-a478-40c4-afa9-f2c3cc13d5c1', '10', '0', '件数（张数，盘数）', 'f_files_num', '【件数（张数，盘数）】', '1', 5);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('71701d98-772c-4403-a488-0a1ac5a814c4', '10', '0', '保管期限', 'f_doc_deadline_name', '', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('72e92124-72e5-4d9d-90d1-a94ac2720c73', '10', '0', '目录号', 'f_listno', '【目录号】', '1', 8);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('3d15e617-f13b-43ed-a6c4-7bbb625e12fd', '885bf4c5-e064-451e-ac84-f86bf7e277b0', '0', '全宗号', 'f_fondsno', '', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('6634709e-94b6-4a26-8db0-bd70f99f3f8a', '885bf4c5-e064-451e-ac84-f86bf7e277b0', '0', '档案年份', 'f_doc_year', '', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('73da6f43-fae3-458b-befe-541deab6102a', '885bf4c5-e064-451e-ac84-f86bf7e277b0', '0', '档案分类号', 'f_typeno', '', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('7eaaf407-28f8-45f5-8097-19e3fef04687', '885bf4c5-e064-451e-ac84-f86bf7e277b0', '0', '密级', 'F_SECRECY_NAME', '', '1', 7);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('c134a3e7-76be-4d8a-b9ee-ea1eb6a6eb0b', '885bf4c5-e064-451e-ac84-f86bf7e277b0', '0', '案卷号', 'f_filesno', '', '1', 5);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('e3cc4fb8-bc43-4f70-b69b-3ad9a119aa2f', '885bf4c5-e064-451e-ac84-f86bf7e277b0', '0', '所属部门', 'f_dept_name', '', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('ffda56e8-405d-47f7-b5c0-a1120e7dbe68', '905810c3-9725-48c5-9068-da82a09ab88e', '0', '照片档案添加界面', 'filefilesdetail4pic.jsp', '照片档案添加界面', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('05e33c47-d2b5-4359-ad95-323cfecd5462', '905810c3-9725-48c5-9068-da82a09ab88e', '0', '会计档案添加界面_凭证', 'filefilesdetail4acc.jsp', '会计档案添加界面_凭证', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('9d0687ec-814f-4e8e-a2bb-eb96daaf7d4b', '905810c3-9725-48c5-9068-da82a09ab88e', '0', '会计档案添加界面_账本', 'filefilesdetail4abook.jsp', '会计档案添加界面_账本', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('e5ccff20-c180-4f01-bde4-126145b9e14d', '905810c3-9725-48c5-9068-da82a09ab88e', '0', '视频档案添加界面', 'filefilesdetail4video.jsp', '视频档案添加界面', '1', 6);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('bfe59097-b536-43e4-acd9-b1fb561a4e54', '905810c3-9725-48c5-9068-da82a09ab88e', '0', '文书档案添加界面', 'filefilesdetail.jsp', '文书档案添加界面', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('bed3fec0-6b71-4042-a3e9-a4852d48b63f', '905810c3-9725-48c5-9068-da82a09ab88e', '0', '光盘档案添加界面', 'filefilesdetail4disk.jsp', '光盘档案添加界面', '1', 5);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('23bbbc51-7baa-44b3-be86-0e10b9626150', 'a17c0bde-c4e7-4a98-a82c-43fc2173dfca', '0', '照片档案列表界面', 'filefileslist4pic.jsp', '', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('c1e991f4-4f39-40e6-aa44-68011b50d7b4', 'a17c0bde-c4e7-4a98-a82c-43fc2173dfca', '0', '文书档案列表界面', 'filefileslist.jsp', '', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('725a41ad-2cde-4318-9032-c5751a8e3b76', 'a17c0bde-c4e7-4a98-a82c-43fc2173dfca', '0', '会计档案列表界面_凭证', 'filefileslist4acc.jsp', '', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('2b33e521-5cc5-4362-83d7-3e6dd46ba46d', 'a17c0bde-c4e7-4a98-a82c-43fc2173dfca', '0', '光盘档案列表界面', 'filefileslist4disk.jsp', '', '1', 5);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('09a78300-bd15-4866-a408-baea341b0394', 'a17c0bde-c4e7-4a98-a82c-43fc2173dfca', '0', '会计档案列表界面_账本', 'filefileslist4abook.jsp', '会计档案列表界面_账本', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('ece475ea-efca-4285-95bc-ca576e40d3e3', 'a17c0bde-c4e7-4a98-a82c-43fc2173dfca', '0', '视频档案列表界面', 'filefileslist4video.jsp', '视频档案列表界面', '1', 6);


--添加程序界面数据
delete from oa_file_program_page ;
insert into oa_file_program_page (F_PROGRAM_ID, F_PROGRAM_PAGE, F_FILE_LIST, F_FILE_DETAIL, F_FILES_LIST, F_FILES_DETAIL, F_ORDER, F_REMARK)
values ('d1b9d5a6-074d-4df6-b72b-3b1be5caba95', '档案管理-会计档案_账本', 'filefileslist4abook.jsp', 'filefilesdetail4abook.jsp', 'filefileslist4abook.jsp', 'filefilesdetail4abook.jsp', 5, '');

insert into oa_file_program_page (F_PROGRAM_ID, F_PROGRAM_PAGE, F_FILE_LIST, F_FILE_DETAIL, F_FILES_LIST, F_FILES_DETAIL, F_ORDER, F_REMARK)
values ('e7fd4c88-f404-4141-94bb-589867810a91', '档案管理-会计档案_凭证', 'filefileslist4acc.jsp', 'filefilesdetail4acc.jsp', 'filefileslist4acc.jsp', 'filefilesdetail4acc.jsp', 6, '');

insert into oa_file_program_page (F_PROGRAM_ID, F_PROGRAM_PAGE, F_FILE_LIST, F_FILE_DETAIL, F_FILES_LIST, F_FILES_DETAIL, F_ORDER, F_REMARK)
values ('ed635d24-fced-4353-81f9-86b18e378ef6', '档案管理-照片文件(照片组)', 'filedoclist4photo.jsp', 'filedocdetail4photo.jsp', 'filefileslist4pic.jsp', 'filefilesdetail4pic.jsp', 2, '');

insert into oa_file_program_page (F_PROGRAM_ID, F_PROGRAM_PAGE, F_FILE_LIST, F_FILE_DETAIL, F_FILES_LIST, F_FILES_DETAIL, F_ORDER, F_REMARK)
values ('fff6a4a1-5943-46dd-bc6c-07591e5c6ebd', '档案管理-光盘文件', 'filedoclist4disk.jsp', 'filedocdetail4disk.jsp', 'filefileslist4disk.jsp', 'filefilesdetail4disk.jsp', 3, '');

insert into oa_file_program_page (F_PROGRAM_ID, F_PROGRAM_PAGE, F_FILE_LIST, F_FILE_DETAIL, F_FILES_LIST, F_FILES_DETAIL, F_ORDER, F_REMARK)
values ('fc74cac7-8256-4d0f-902d-0316e7fb2b7e', '档案管理-视频文件', 'filedoclist4video.jsp', 'filedocdetail4video.jsp', 'filefileslist4video.jsp', 'filefilesdetail4video.jsp', 4, '');

insert into oa_file_program_page (F_PROGRAM_ID, F_PROGRAM_PAGE, F_FILE_LIST, F_FILE_DETAIL, F_FILES_LIST, F_FILES_DETAIL, F_ORDER, F_REMARK)
values ('f0fe0a05-e472-45da-a5e9-94dbbffe6e6c', '档案管理-文书文件', 'filedoclist.jsp', 'filedocdetail.jsp', 'filefileslist.jsp', 'filefilesdetail.jsp', 1, '');

--档案管理所用表的配置脚本
delete from oa_md_columns where table_id in ('c9e9bc94-08e0-4428-9b54-c4e26a6a5810','fb518938-39e6-47b6-bd57-09d72353f24c');
delete from oa_col_stauts_contorl where action_id in (select action_id from OA_FORM_ACTION where busitype_code in
     (select busitype_code from oa_form_busitype where table_id in
     ('c9e9bc94-08e0-4428-9b54-c4e26a6a5810','fb518938-39e6-47b6-bd57-09d72353f24c',
'7437135b-8b21-4bd0-b4f8-ee1c2a96561d','wj_detail','wj','cfa24116-4813-4e62-b1ea-8ac4ea15f519')));
delete from OA_FORM_ACTION where busitype_code in
     (select busitype_code from oa_form_busitype where table_id in
     ('c9e9bc94-08e0-4428-9b54-c4e26a6a5810','fb518938-39e6-47b6-bd57-09d72353f24c',
'7437135b-8b21-4bd0-b4f8-ee1c2a96561d','wj_detail','wj','cfa24116-4813-4e62-b1ea-8ac4ea15f519'));
delete from oa_form_busitype where table_id in ('c9e9bc94-08e0-4428-9b54-c4e26a6a5810','fb518938-39e6-47b6-bd57-09d72353f24c',
'7437135b-8b21-4bd0-b4f8-ee1c2a96561d','wj_detail','wj','cfa24116-4813-4e62-b1ea-8ac4ea15f519');
delete from oa_md_table where table_id in ('c9e9bc94-08e0-4428-9b54-c4e26a6a5810','fb518938-39e6-47b6-bd57-09d72353f24c');
insert into oa_md_table (TABLE_ID, TABLE_CODE, TABLE_NAME, TABLE_PK, PARENT_TABLE_ID, TABLE_SN)
values ('c9e9bc94-08e0-4428-9b54-c4e26a6a5810', 'OA_FILE_FILES_ACC', '会计档案扩展表', 'f_acc_id', 'fb518938-39e6-47b6-bd57-09d72353f24c', 18);

insert into oa_md_table (TABLE_ID, TABLE_CODE, TABLE_NAME, TABLE_PK, PARENT_TABLE_ID, TABLE_SN)
values ('fb518938-39e6-47b6-bd57-09d72353f24c', 'OA_FILE_FILES', '档案管理表', 'F_FILES_ID', '', 16);

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('14cfe473-08ed-48f9-afa7-0dd94fa2016b', 'c9e9bc94-08e0-4428-9b54-c4e26a6a5810', 'F_FILE_ENDNO', '记账凭证终止号码', 5, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('3184434b-c9bf-4ce8-ae11-d903cf1c5380', 'c9e9bc94-08e0-4428-9b54-c4e26a6a5810', 'F_FILE_STARTNO', '记账凭证起始号码', 4, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('fbe448fe-8851-4dc1-8d15-86407a9a07c8', 'c9e9bc94-08e0-4428-9b54-c4e26a6a5810', 'F_FILE_MONTHBOOKINDEX', '月份内册数序号', 3, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('244b638f-bb80-43dc-8e5d-b6b85c413825', 'c9e9bc94-08e0-4428-9b54-c4e26a6a5810', 'F_FILE_MONTHBOOKTOTAL', '月份内总册数', 2, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('f4c27fca-16e9-49b0-96db-6597df91c182', 'c9e9bc94-08e0-4428-9b54-c4e26a6a5810', 'F_FILE_MONTH', '档案年月', 1, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('b8be36b3-886f-407e-960a-f3406a9e55b6', 'c9e9bc94-08e0-4428-9b54-c4e26a6a5810', 'F_ACC_ID', '主键ID', 0, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('cecc4509-91fe-413e-bace-486702dd9292', 'c9e9bc94-08e0-4428-9b54-c4e26a6a5810', 'F_FILES_ID', '档案ID', 8, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('cdec4990-4870-4fcb-ba9c-259b1db67e00', 'c9e9bc94-08e0-4428-9b54-c4e26a6a5810', 'F_ATTACH_ID', '附件ID', 6, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('d65effc6-583b-46bd-a102-f88a17ff6456', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILE_USERNAME', '归档人姓名', 24, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('4a632d54-f992-4a22-a8b4-de1c2511b23c', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILE_TIME', '归档日期（档案的最早正式归档日期）', 25, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('7380947c-bcec-4bbe-8186-5bec3988406a', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_LISTNO', '目录号', 26, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('73f908b7-5608-43d7-a8db-5ea81523b75d', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_DOC_DEADLINE_NAME', 'F_DOC_DEADLINE_NAME', 27, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('24c9cb4c-981d-4257-9f4d-b2cdd322a22a', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_ENTITY_TYPE_NAME', '实物类型NAME', 27, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('71eb9728-c42f-401c-8dfc-590f5768bb2f', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_ENTITY_TYPE', '实物类型', 28, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('46b6dfcb-27cf-4a7c-b45b-a8c78b5b0eda', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILES_STATE_NAME', '案卷状态名', 29, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('dad1db89-de44-488c-b845-7f762e1f9c62', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_START_TIME', '起始日期（档案的最早形成日期）', 30, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('299bd3e2-a105-493a-8245-65bce752fa40', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_END_TIME', '终止日期（档案的最后修改日期）', 31, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('b1578193-e34d-4af5-adc7-0b63106fa72d', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_DOC_BLID', '责任者ID', 32, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('f73f8282-e84c-444a-a52a-09c709ded6df', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_TYPE_ID', 'F_TYPE_ID', 33, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('5c8d9091-dadc-44d3-a0d1-dd24b1c370a8', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_TYPENO', '分类号', 5, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('21a3dd8a-71c6-4e66-be40-e4791b017426', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FONDSNO', '全宗号', 6, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('d08de7a7-3483-47a5-b910-7470d03f69da', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILESNO', '案卷号', 7, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('72d9ab56-c306-4345-b382-d4a726fc3c92', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILES_ID', '主键ID', 0, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('c5b799dd-5e1c-4426-af11-24aa5c4f9711', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_STORAGE_FULLNAME', '存放位置', 8, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('8b8cc576-a9e4-4fbf-8a85-07327d853c1d', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_DOC_YEAR', '档案年份', 9, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('c6505ecf-11e4-4a9d-9483-a34df0a5fe51', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_SECRECY_ID', '密级ID', 10, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('41daaeb4-dc10-4941-98a4-5004716a17fd', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_SECRECY_NAME', '密级名称', 11, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('c4625ad0-980c-4df0-af18-3ab145f7ec24', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_DOC_DEADLINE', '保管期限', 12, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('94e24044-7c87-4b26-8828-b449ac234604', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_DOC_DEADLINE_NAME', '保管期限名', 13, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('e6f95e50-9426-4ca2-9492-45ca7d0908eb', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_ORG_ID', '所属的单位ID', 14, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('e9a658a7-f584-4da1-a4f3-41562dafe146', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_ORG_NAME', '所属单位名称', 15, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('c58b5a87-b53b-40e7-ad9e-7fbac12a1d9f', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_DEPT_ID', '所属部门ID', 16, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('73b4f683-7cde-4a2a-84b2-6c35f7769d12', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_DEPT_NAME', '所属部门名', 17, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('3a0fa721-b6d4-4e18-8d2b-36cb135d16e8', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILE_USERID', '归档人ID', 23, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('67d66d8a-e21c-4ded-9700-574229de7f58', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILES_STATE', '案卷状态(0：待归档    1、已归档（正常状态）   8、已移交（移交到档案局）   9. 已销毁)', 22, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('cc36db67-a0d2-45ac-9ed5-c6678af79d60', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILES_CONTENT', '内容', 21, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('6870ba02-09bc-4c3c-9c1e-d177903cecbf', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILES_NUM', '卷内件数', 20, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('2133ca8e-c888-4f91-8ca4-530f5494e2bc', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_TYPE_ID', '所属分类ID', 3, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('be871de4-405f-42ca-b72a-821b2e597eb8', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILES_TITLE', '案卷标题', 1, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('2d34fb7c-3e20-4513-86e7-46cd0c8b6a26', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_DOC_BLNAME', '责任者', 18, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('fa6a0847-c2e0-42e5-a697-0da00fb61119', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_TYPE_NAME', '所属分类名称(全称)', 3, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('ad64447e-1344-4404-9331-f7b4783a4758', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FILES_NO', '档号', 4, '0');

-- 业务数据
insert into oa_form_busitype (BUSITYPE_CODE, BUSITYPE_NAME, TYPE_DESC, IS_VALID, TABLE_ID)
values ('5fac4637-6f03-4e72-be9b-586144ca811f', 'file_002', '档案管理的主表', 'Y', 'fb518938-39e6-47b6-bd57-09d72353f24c') ;

commit;

delete from oa_dict_data where dict_id='5';
insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('d180e180-b231-44ee-a098-dcd5a00ce8d1', '5', '0', '10年', '5', '10年', '1', 5);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('881c5c9c-bc27-4c77-9869-9a638b38844a', '5', '0', '15年', '4', '15年', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('16', '5', '0', '永久', '1', '永久', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('17', '5', '0', '30年', '2', '30年', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('18', '5', '0', '25年', '3', '25年', '1', 3);

commit;


----档案管理--文件管理(wjgl)
----wjgl.1:文档添加页面 
DELETE oa_dict_data WHERE DICT_ID = 'e2e08f39-1507-25cf-e043-0100007fe5b4';

DELETE oa_dict_TYPE WHERE DICT_ID = 'e2e08f39-1507-25cf-e043-0100007fe5b4';

insert into oa_dict_TYPE (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('e2e08f39-1507-25cf-e043-0100007fe5b4', '0', '文档添加界面', 'wdmxjm', '文档添加界面', '1', 501, '0');

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('ba2ebbb9-3942-4836-ae12-9f2de576bfca', 'e2e08f39-1507-25cf-e043-0100007fe5b4', '0', '视频添加页面', 'filedocdetail4video.jsp', '非测试数据', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('4370e09c-02b2-495e-9ede-490ba3fbc918', 'e2e08f39-1507-25cf-e043-0100007fe5b4', '0', '文书添加页面', 'filedocdetail.jsp', '非测试数据', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('30cc4bc3-f843-49b9-a5a9-82534b2b8e6d', 'e2e08f39-1507-25cf-e043-0100007fe5b4', '0', '光盘添加页面', 'filedocdetail4disk.jsp', '非测试数据', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('7b48a425-4641-4fc4-b918-28e14201999a', 'e2e08f39-1507-25cf-e043-0100007fe5b4', '0', '照片文件添加页面', 'filedocdetail4photo.jsp', '非测试数据(照片文件=照片组)', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('32ac500f-ab38-4784-a660-453514c25e0b', 'e2e08f39-1507-25cf-e043-0100007fe5b4', '0', '会计档案添加界面_凭证', 'filefilesdetail4acc.jsp', '', '1', 5);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('d1d20d4f-2cce-438b-821d-7fe9d4292d09', 'e2e08f39-1507-25cf-e043-0100007fe5b4', '0', '会计档案添加界面_账本', 'filefilesdetail4abook.jsp', '', '1', 6);
commit;
----wjgl.2:文档列表页面
DELETE oa_dict_data WHERE DICT_ID = '2e00791f-d268-4cd9-b57c-021f782c8ca7';

DELETE oa_dict_TYPE WHERE DICT_ID = '2e00791f-d268-4cd9-b57c-021f782c8ca7';

insert into oa_dict_TYPE (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('2e00791f-d268-4cd9-b57c-021f782c8ca7', '0', '文档查询界面', 'filePageNo', '非测试数据', '1', 502, '0');

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('32ccbd8d-2c10-4e32-bfd7-0a3e13c3b685', '2e00791f-d268-4cd9-b57c-021f782c8ca7', '0', '照片列表界面', 'filedoclist4photo.jsp', '非测试数据', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('f6d02deb-ebf9-4235-b4ad-c3878443739a', '2e00791f-d268-4cd9-b57c-021f782c8ca7', '0', '视频列表页面', 'filedoclist4video.jsp', '非测试数据', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('9896893a-dfdc-43d9-a235-f34d0612bf54', '2e00791f-d268-4cd9-b57c-021f782c8ca7', '0', '会计档案列表界面_凭证', 'filefileslist4acc.jsp', '', '1', 5);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('ffcbb2fb-54ca-4224-804c-37a3c1ac82ce', '2e00791f-d268-4cd9-b57c-021f782c8ca7', '0', '会计档案列表界面_账本', 'filefileslist4abook.jsp', '', '1', 6);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('5831886f-b282-4e6d-8a8a-79a0a20121ba', '2e00791f-d268-4cd9-b57c-021f782c8ca7', '0', '光盘列表页面', 'filedoclist4disk.jsp', '非测试数据', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('4403be58-32ad-4364-b5b5-d58273fe9af7', '2e00791f-d268-4cd9-b57c-021f782c8ca7', '0', '文书列表页面', 'filedoclist.jsp', '非测试数据', '1', 1);
commit;


----wjgl.3:OA标签维护数据，相关配置 (oa_md_table,oa_md_columns,oa_form_busitype)
--wjgl.3.1
delete oa_md_columns where table_id in (
select table_id from oa_md_table where table_code='OA_FILE_DOC' or table_code = 'OA_FILE_PAN_EXT' or table_code = 'OA_FILE_LENDING'
or table_code = 'OA_FILE_PHOTO_INFO'
);
delete from OA_FORM_ACTION where busitype_code in
     (select busitype_code from oa_form_busitype where table_id in
     (select table_id from oa_md_table where table_code='OA_FILE_DOC' or table_code = 'OA_FILE_PAN_EXT' or table_code = 'OA_FILE_LENDING'
or table_code = 'OA_FILE_PHOTO_INFO'));
--wjgl.3.2
delete oa_form_busitype where busitype_name in ('wj-001','wj-002');
delete oa_md_table where  table_code = 'OA_FILE_PAN_EXT';
delete oa_md_table where table_code='OA_FILE_DOC'  or table_code = 'OA_FILE_LENDING' or table_code = 'OA_FILE_PHOTO_INFO';
--wjgl.3.3
insert into oa_md_table (TABLE_ID, TABLE_CODE, TABLE_NAME, TABLE_PK, PARENT_TABLE_ID, TABLE_SN)
values ('cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'OA_FILE_LENDING', '档案借阅主表', 'F_LENDING_ID', '', 15);

insert into oa_md_table (TABLE_ID, TABLE_CODE, TABLE_NAME, TABLE_PK, PARENT_TABLE_ID, TABLE_SN)
values ('wj', 'OA_FILE_DOC', '文件管理表', 'F_DOC_ID', '', 1);

insert into oa_md_table (TABLE_ID, TABLE_CODE, TABLE_NAME, TABLE_PK, PARENT_TABLE_ID, TABLE_SN)
values ('wj_detail', 'OA_FILE_PAN_EXT', '声像档案扩展表', 'F_PAN_ID', 'wj', 14);

insert into oa_md_table (TABLE_ID, TABLE_CODE, TABLE_NAME, TABLE_PK, PARENT_TABLE_ID, TABLE_SN)
values ('7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'OA_FILE_PHOTO_INFO', '文件管理-照片文件中照片文件表', 'f_id', '', 20);

--wjgl.3.4
insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('f2e76c6e-35b4-48ae-b1a1-bd4643aa4949', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'F_EXPLAIN', '文字说明', 7, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('776a0e0e-7ea3-4898-b640-83c806a09f04', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'F_ATTACH_ID', '附件ID', 8, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('bbcb3cd3-5167-48b1-8f69-56029b409aa8', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'F_DANG_NO', '档号', 9, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('b1170716-b15e-4d12-8833-cc14d5523283', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'F_LOCATION', '存放位置', 10, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('14311701-4f23-4de0-8904-7faf2a9f47f5', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'F_TITLE', '题名', 5, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('addc5ce1-aec2-4ebe-aecb-9560eacd98e3', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'F_PHOTO_MEDIA', '介质类型', 5, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('493f6b0d-ffec-4f25-9f9c-6124c789cb13', 'wj_detail', 'F_PERSON', '人物', 7, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('f59ce605-a6d0-4770-92a8-11cc44b530a7', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_LENDING_ID', '借阅ID', 0, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('878d6f57-128f-4cf5-8960-d2ec945b1eaa', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_LENDING_REASON', '借阅理由', 1, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('115f81ad-0de6-4c05-8743-e600d35f8e9e', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_LENDING_USERID', '借阅人ID', 2, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('6d2a404f-7e2e-4c76-8dea-adbb1ce5c680', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_LENDING_USERNAME', '借阅人姓名', 3, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('1edc0e60-7140-48c4-8320-2706d8ef0a8e', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_ORG_ID', '所属的单位ID', 4, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('a58a73df-1aca-4fcf-a1cc-a35c9af63ab8', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_ORG_NAME', '所属单位名称', 5, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('1776ebe2-60ea-4f0d-9aca-ecfe1a57e413', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_DEPT_ID', '所属部门ID', 6, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('789604c4-dd0e-49ef-a909-7f10b676b755', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_DEPT_NAME', '所属部门名', 7, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('5c2c6ead-647a-46d5-8fef-ce093c6293d6', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_TEL', '联系电话', 8, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('a6f33f20-517a-45cb-8572-7bcf41a2c3af', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_CREATOR_TIME', '申请日期', 10, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('ea284edd-cd04-4a54-bea0-b6d1359ab20a', 'cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'F_CHECKMSG', '审批意见', 10, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('002', 'wj', 'F_DOC_NAME', '文件标题', 40, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('003', 'wj', 'F_DOC_FONTSIZE', '文件字号', 1, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('wj_detail_001', 'wj_detail', 'F_PAN_ID', '文件扩充属性ID', 1, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('wj_detail_002', 'wj_detail', 'F_DOC_ID', '文件ID', 2, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('004', 'wj', 'F_TYPE_ID', '档案分类ID', 2, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('wj_detail_004', 'wj_detail', 'F_SPECIFICATION', '规格', 4, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('wj_detail_005', 'wj_detail', 'F_SHOOTING_USER', '拍摄人', 5, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('1120dca6-a611-4e97-8187-e57787d5136f', 'wj_detail', 'F_ADD', '地点', 6, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('001', 'wj', 'F_DOC_ID', '文件ID', 39, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('005', 'wj', 'F_TYPE_NAME', '档案分类名称', 3, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('006', 'wj', 'F_DOC_KEYWORDS', '主题词', 4, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('007', 'wj', 'F_DOC_YEAR', '档案年份', 5, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('008', 'wj', 'F_SECRECY_ID', '密级ID', 6, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('009', 'wj', 'F_SECRECY_NAME', '密级名称', 7, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('010', 'wj', 'F_ORG_ID', '所属的单位ID', 8, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('011', 'wj', 'F_ORG_NAME', '所属单位名称', 9, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('012', 'wj', 'F_DEPT_ID', '所属部门ID', 10, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('013', 'wj', 'F_DEPT_NAME', '所属部门名', 11, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('014', 'wj', 'F_DOC_CHECKUSER', '审批人', 12, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('015', 'wj', 'F_DOC_BLNAME', '责任者', 13, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('016', 'wj', 'F_FILE_FORMTIME', '文件形成日期', 14, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('017', 'wj', 'F_FILE_QUANTITY', '数量', 15, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('018', 'wj', 'F_TYPE_REMARK', '备注', 16, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('019', 'wj', 'F_USER_ID', '登记人ID', 17, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('020', 'wj', 'F_USER_NAME', '登记姓名', 18, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('021', 'wj', 'F_CREATOR_TIME', '登记时间', 19, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('022', 'wj', 'F_DOC_CONTENT', '内容', 20, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('023', 'wj', 'F_ATTACH_ID', '附件ID', 21, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('024', 'wj', 'F_DOC_STATE', '归档状态', 22, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('025', 'wj', 'F_DOC_STATE_NAME', '归档状态name', 23, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('026', 'wj', 'F_FILE_NO', '档号(全综号_档案分类号_保管期限_案卷号_件号)', 24, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('027', 'wj', 'F_TYPENO', '档案分类号', 25, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('028', 'wj', 'F_DOC_NUM', '件号', 26, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('029', 'wj', 'F_INFO_NUM', '参见号', 27, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('030', 'wj', 'F_DOC_MEDIA', '介质类型', 28, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('031', 'wj', 'F_DOC_MEDIA_NAME', '介质类型name', 29, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('032', 'wj', 'F_ENTITY_TYPE', '实物类型', 30, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('033', 'wj', 'F_ENTITY_TYPE_NAME', '实物类型name', 31, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('034', 'wj', 'F_BURN_USER_ID', '刻录人id', 32, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('035', 'wj', 'F_BURN_USER_NAME', '刻录人name', 33, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('036', 'wj', 'F_FILE_NUM', '归档数量', 34, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('037', 'wj', 'F_DOC_DEADLINE', '保管期限', 35, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('038', 'wj', 'F_FILE_USERID', '归档人ID', 36, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('039', 'wj', 'F_FILE_USERNAME', '归档人姓名', 37, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('040', 'wj', 'F_FILE_TIME', '归档日期', 38, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('91fe8aa4-7fe5-4768-a3c2-5f6a27522140', 'wj', 'F_INFO_TYPE_NAME', '信息类型NAME', 42, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('6bba06f0-34bb-41cf-9779-0ff8901a6276', 'wj', 'F_INFO_TYPE', '信息类型', 41, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('cd973441-78e1-433a-aeed-0326ab89e26c', 'wj', 'F_FILE_NUM_UNIT', '数量单位', 43, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('c7b34ccf-90ab-4a33-b408-9ca57404b9c2', 'wj', 'F_DOC_DEADLINE_NAME', '保管期限NAME', 45, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('dd973441-78e1-433a-aeed-0326ab89e26d', 'wj', 'F_FILE_NUM_UNIT_NAME', '数量单位NAME', 44, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('d26b53b7-8fb7-4e46-9620-4b1808dc28a1', 'wj_detail', 'F_BACKGROUND', '背景', 8, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('3fd15cc4-e96f-4da4-ad6e-a6c6e38f6224', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'F_NO', '照片/底片号', 2, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('561a3523-aba5-4501-b480-e3103e366f8c', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'F_ID', '照片信息ID', 0, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('7222fb8b-5bf2-4af4-be72-fb1e010a5c73', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'F_FILE_ID', '所属照片文件ID', 1, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('8dc0a9a0-d645-49b2-9d6b-f4198745aa4d', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d', 'F_CJ_NO', '参见号', 3, '0');

--wjgl.3.6
insert into oa_form_busitype (BUSITYPE_CODE, BUSITYPE_NAME, TYPE_DESC, IS_VALID, TABLE_ID)
values ('d35083ad-12e2-400f-85fd-42036e9b12e6', 'wj-001', '<font color="red">这不是测试数据,别删了</font>', 'Y', 'wj');

insert into oa_form_busitype (BUSITYPE_CODE, BUSITYPE_NAME, TYPE_DESC, IS_VALID, TABLE_ID)
values ('7a5afee0-328e-4fcc-89b7-f075c58e7592', 'wj-002', '<font color="red">这不是测试数据,别删了</font> ', 'Y', '7437135b-8b21-4bd0-b4f8-ee1c2a96561d');

--wjgl3.7


delete from oa_dict_data where DICTDATA_ID in ('09cade6d-61fc-486b-976e-e262d6b37fb1','0d76cdbd-7104-4f55-841d-799a4f3f9d2f');

delete from oa_dict_type where DICT_ID ='ec12b8d5-3fd4-41c3-9549-874de3556d8f';

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('ec12b8d5-3fd4-41c3-9549-874de3556d8f', '0', '存储格式', 'ccgs', '存储格式', '1', 1, '0');

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('09cade6d-61fc-486b-976e-e262d6b37fb1', 'ec12b8d5-3fd4-41c3-9549-874de3556d8f', '0', 'MPEG', '1', '', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('0d76cdbd-7104-4f55-841d-799a4f3f9d2f', 'ec12b8d5-3fd4-41c3-9549-874de3556d8f', '0', 'AVI', '2', '', '1', 2);
commit;
