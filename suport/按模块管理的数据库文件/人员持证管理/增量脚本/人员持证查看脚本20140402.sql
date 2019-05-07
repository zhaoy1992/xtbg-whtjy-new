insert into ta_oa_resources (RESOURCES_ID, RESOURCES_TYPEID, RESOURCES_NAME, RESOURCES_LOGO, RESOURCES_DESC, CREATOR_TIME, RESOURCES_TYPE, TREE_TYPE, IS_PUBLIC, SYS_CODE)
values ('18', '6', '人员持证查看', '0018', '人员持证查看', to_date('31-03-2014', 'dd-mm-yyyy'), '1', '1', 'Y', '');



insert into TD_SM_ROLE (ROLE_ID, ROLE_NAME, ROLE_TYPE, ROLE_DESC, ROLE_USAGE, REMARK1, REMARK2, REMARK3, OWNER_ID)
values (SEQ_TD_SM_ROLE.NEXTVAL, '持证管理员角色', '1', '持证管理员角色', '', '', '', '', 1);

commit;

