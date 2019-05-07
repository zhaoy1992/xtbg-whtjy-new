--先删除字典数据的数据
delete oa_dict_data where DICT_ID='74ff411c-3fec-402f-9cd7-f433ad39ec9b';
--删除字典类型的数据
delete oa_dict_type  where DICT_ID='74ff411c-3fec-402f-9cd7-f433ad39ec9b';

--添加字典类型数据
insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('74ff411c-3fec-402f-9cd7-f433ad39ec9b', '0', '公文要素信息', 'gwysxx', '公文要素信息,文种、保密期限、公文密级、紧急程度的类型', '1', null, '1');

--添加字典数据数据

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('4e87e97c-8973-412d-9bad-047de9eb7636', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '3143c241-933d-46b1-b94d-e0f4ec3bf652', '通知', '2', '文种的通知', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('fdc7f966-f078-4663-b574-01de09157b77', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '3143c241-933d-46b1-b94d-e0f4ec3bf652', '指标文', '4', '文种的指标文', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('bf5a24fc-86a5-454a-bc6a-feb1deb23931', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', 'e65df0c7-fb7a-4ce3-94f3-f7433c5737c2', '一般', 'jj_yb', '紧急程度的一般', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('0d7b3388-1db9-4817-a659-d35f9a01b4f7', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', 'e65df0c7-fb7a-4ce3-94f3-f7433c5737c2', '紧急', 'jj_jj', '紧急程度的紧急', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('53b92ddf-4c77-481f-8b5d-56e4cc0295b2', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', 'e65df0c7-fb7a-4ce3-94f3-f7433c5737c2', '无', 'jj_w', '紧急程度的无', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('e65df0c7-fb7a-4ce3-94f3-f7433c5737c2', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '0', '紧急程度', 'jjcd', '公文要素的紧急程度', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('5cdb1f38-431c-4c80-b64d-95cad81f8089', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '6b75c3f6-bb30-4251-8cff-34dcdfa6db3a', '短期', 'bm_dq', '保密期限的短期', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('fe20cb92-e6b9-4fad-8f4c-45b3fbc8ccc7', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '3143c241-933d-46b1-b94d-e0f4ec3bf652', '无', '5', '文种的无', '1', 5);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('ceb733d3-3166-492e-ab0d-cf46013540e2', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '3143c241-933d-46b1-b94d-e0f4ec3bf652', '函', '1', '文种的函', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('970915a3-7807-4868-9760-771dc3370324', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '3143c241-933d-46b1-b94d-e0f4ec3bf652', '请示', '3', '文种的请示', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('19887a85-7dc2-4e6e-94fd-d410d4eda3d6', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '6b75c3f6-bb30-4251-8cff-34dcdfa6db3a', '永久', 'bm_yj', '保密期限的永久', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('f28cc43d-a82e-41bd-8aa5-cc81791c48e0', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', 'ab1bff7d-f7c0-4b79-839f-6b481e1d3299', '无', 'gw_w', '公文密级的无', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('36f0e7a1-4f6e-43ab-90fa-19b77c604f0c', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', 'ab1bff7d-f7c0-4b79-839f-6b481e1d3299', '机密', 'gw_jm', '公文密级的机密', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('3143c241-933d-46b1-b94d-e0f4ec3bf652', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '0', '文种', 'wz', '公文要素的文种', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('6b75c3f6-bb30-4251-8cff-34dcdfa6db3a', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '0', '保密期限', 'bmqx', '公文要素的保密期限', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('ab1bff7d-f7c0-4b79-839f-6b481e1d3299', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '0', '公文密级', 'gwmj', '公文要素的公文密级', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('73556f79-c45b-4ae5-9bd1-1f70a7766284', '74ff411c-3fec-402f-9cd7-f433ad39ec9b', '6b75c3f6-bb30-4251-8cff-34dcdfa6db3a', '长期', 'bm_cq', '保密期限的长期', '1', 2);

commit;