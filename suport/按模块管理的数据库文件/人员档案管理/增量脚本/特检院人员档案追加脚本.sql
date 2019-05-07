---人员配置管理 配置权限 追加【人员信息查看】,【薪酬信息查看】
insert into ta_oa_resources_type (RESOURCES_TYPEID, RESOURCES_TYPENAME, RESOURCES_TYPELOGO, RESOURCES_TYPEDESC, CREATOR_TIME, IS_PUBLIC, SYS_CODE)
values ('6', '人员档案管理', '0006', '用于人员档案管理人员查看', to_date('20-02-2014', 'dd-mm-yyyy'), 'Y', '');


insert into ta_oa_resources (RESOURCES_ID, RESOURCES_TYPEID, RESOURCES_NAME, RESOURCES_LOGO, RESOURCES_DESC, CREATOR_TIME, RESOURCES_TYPE, TREE_TYPE, IS_PUBLIC, SYS_CODE)
values ('16', '6', '人员信息查看', '0016', '人员信息查看', to_date('20-02-2014', 'dd-mm-yyyy'), '1', '1', 'Y', '');

insert into ta_oa_resources (RESOURCES_ID, RESOURCES_TYPEID, RESOURCES_NAME, RESOURCES_LOGO, RESOURCES_DESC, CREATOR_TIME, RESOURCES_TYPE, TREE_TYPE, IS_PUBLIC, SYS_CODE)
values ('17', '6', '薪酬信息查看', '0017', '薪酬信息查看', to_date('20-02-2014', 'dd-mm-yyyy'), '1', '1', 'Y', '');

commit;