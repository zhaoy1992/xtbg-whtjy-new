--OA_FILE_PAN_EXT：声像档案扩展表  配置字段少一列
--select * from oa_md_columns where table_id = 'wj_detail'
--修复3544
delete oa_md_columns where COLUMN_ID = 'wj_detail_008';
insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('wj_detail_008', 'wj_detail', 'F_SAVE_FORMAT', '存储格式', 9, '0');

--增加角色
delete td_sm_role where role_id = '104';
insert into td_sm_role (ROLE_ID, ROLE_NAME, ROLE_TYPE, ROLE_DESC, ROLE_USAGE, REMARK1, REMARK2, REMARK3, OWNER_ID)
values ('104', '单位档案管理员', '1', '单位管理员，用于管理本单位的档案', '', '', '', '', 1);

--删除多余配置
delete from oa_form_busitype where busitype_name = 'wj-001';

--在数据字典表中添加阅读权限数据
delete OA_DICT_DATA where DICTDATA_ID in ('120001','120002');

delete oa_dict_type where DICT_ID in ('12');

insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('12', '0', '阅读权限', 'ydqx', '阅读权限', '1', 12, '0');

insert into OA_DICT_DATA (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('120001', '12', '0', '只阅读', '1', '只阅读', '1', 1);

insert into OA_DICT_DATA (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('120002', '12', '0', '可下载', '2', '可下载', '1', 2);
--submit;
commit;