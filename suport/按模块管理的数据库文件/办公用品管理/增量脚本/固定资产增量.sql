alter table TA_OA_HAVA_OBJECT add T_HA_ORG_ID VARCHAR2(50);
comment on column TA_OA_HAVA_OBJECT.T_HA_ORG_ID is '所属部门ID';

alter table TA_OA_HAVA_OBJECT add T_HA_ORG_NAME VARCHAR2(200);
comment on column TA_OA_HAVA_OBJECT.T_HA_ORG_NAME is '所属部门名称';

insert into TD_SM_ROLE (ROLE_ID, ROLE_NAME, ROLE_TYPE, ROLE_DESC, ROLE_USAGE, REMARK1, REMARK2, REMARK3, OWNER_ID)
values (SEQ_TD_SM_ROLE.NEXTVAL, '入库人员', '1', '入库人员', '', '', '', '', 1);
