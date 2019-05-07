DECLARE
HAVE_data NUMBER;
BEGIN
  select COUNT(1) INTO HAVE_data from oa_flow_busitype_type where busitype_type_code ='dang_an';
  IF(HAVE_data=0) THEN
    insert into oa_flow_busitype_type (BUSITYPE_TYPE_CODE, BUSITYPE_TYPE_NAME, TYPE_DESC, IS_VALID, IS_FLOW, ORDER_NO)
	values ('dang_an', '档案', '档案', '1', '1', 4);
     commit;
  END IF;
END;
/
/**
 * 档案销毁-建表sql脚本
 * 1：表结构
 * 2：业务类型 记录
 * 3：流程表单路径 记录
 * 4: 流程配置-所属表格(数据库管理数据)
 * 5: 需要手工创建 流程管理-流程配置记录 (流程名称:档案借阅申请流程)
 * 6: 需要手工绑定流程包
 * zoutuo
 */

----1
DECLARE
HAVE_TABLE NUMBER;
BEGIN
  SELECT COUNT(1) INTO HAVE_TABLE FROM ALL_TABLES WHERE  TABLE_NAME = 'OA_FILE_DESTROY_DETAIL' AND OWNER=SYS.LOGIN_USER;
  IF(HAVE_TABLE>0) THEN
      EXECUTE IMMEDIATE 'DROP TABLE OA_FILE_DESTROY_DETAIL';
  END IF;
  
  SELECT COUNT(1) INTO HAVE_TABLE FROM ALL_TABLES WHERE  TABLE_NAME = 'OA_FILE_DESTROY' AND OWNER=SYS.LOGIN_USER;
  IF(HAVE_TABLE>0) THEN
      EXECUTE IMMEDIATE 'DROP TABLE OA_FILE_DESTROY';
  END IF;
END;
/
create table OA_FILE_DESTROY
(
  F_DESTROY_ID      VARCHAR2(50) not null,
  F_DESTROY_TITLE   VARCHAR2(200),
  F_DESTROY_REASON  VARCHAR2(4000) not null,
  F_ORG_ID          VARCHAR2(50) not null,
  F_ORG_NAME        VARCHAR2(100) not null,
  F_DEPT_ID         VARCHAR2(50) not null,
  F_DEPT_NAME       VARCHAR2(100) not null,
  F_APPLY_USERID    VARCHAR2(50) not null,
  F_APPLY_USERNAME  VARCHAR2(100) not null,
  F_APPLY_TIME      DATE not null,
  F_CHECKMSG        CLOB,
  F_ATTACH_ID       VARCHAR2(50),
  F_CHECK_USERNAME  VARCHAR2(100),
  F_ISAGREE_DESTROY CHAR(1),
  F_LD_IDEAS        VARCHAR2(2000),
  F_HQLD_IDEAS      VARCHAR2(4000)
);
comment on table OA_FILE_DESTROY
  is '档案销毁主表';
comment on column OA_FILE_DESTROY.F_DESTROY_ID
  is '销毁ID';
comment on column OA_FILE_DESTROY.F_DESTROY_TITLE
  is '标题';
comment on column OA_FILE_DESTROY.F_DESTROY_REASON
  is '销毁理由';
comment on column OA_FILE_DESTROY.F_ORG_ID
  is '所属的单位ID';
comment on column OA_FILE_DESTROY.F_ORG_NAME
  is '所属单位名称';
comment on column OA_FILE_DESTROY.F_DEPT_ID
  is '所属部门ID';
comment on column OA_FILE_DESTROY.F_DEPT_NAME
  is '所属部门名';
comment on column OA_FILE_DESTROY.F_APPLY_USERID
  is '申请人ID';
comment on column OA_FILE_DESTROY.F_APPLY_USERNAME
  is '申请人名称';
comment on column OA_FILE_DESTROY.F_APPLY_TIME
  is '申请日期';
comment on column OA_FILE_DESTROY.F_CHECKMSG
  is '审批意见';
comment on column OA_FILE_DESTROY.F_ATTACH_ID
  is '附件ID';
comment on column OA_FILE_DESTROY.F_CHECK_USERNAME
  is '批准人姓名';
comment on column OA_FILE_DESTROY.F_ISAGREE_DESTROY
  is '是否同意销毁';
alter table OA_FILE_DESTROY
  add constraint PK_OA_FILE_DESTROY primary key (F_DESTROY_ID);
alter table OA_FILE_DESTROY
  add constraint CKC_F_ISAGREE_DESTROY_OA_FILE_
  check (f_isagree_destroy is null or (f_isagree_destroy in ('1','0')));

create table OA_FILE_DESTROY_DETAIL
(
  F_DETAIL_ID       VARCHAR2(50) not null,
  F_DOC_ID          VARCHAR2(50),
  F_USER_ID         VARCHAR2(50),
  F_USER_NAME       VARCHAR2(100),
  F_DESTROY_TIME    DATE,
  F_DESTROY_STATE   CHAR(1),
  F_DESTROY_ID      VARCHAR2(200),
  F_ISAGREE_DESTROY CHAR(1)
);
comment on table OA_FILE_DESTROY_DETAIL
  is '档案销毁文件明细表';
comment on column OA_FILE_DESTROY_DETAIL.F_DETAIL_ID
  is '销毁文件ID';
comment on column OA_FILE_DESTROY_DETAIL.F_DOC_ID
  is '文件ID';
comment on column OA_FILE_DESTROY_DETAIL.F_USER_ID
  is '销毁经手人ID';
comment on column OA_FILE_DESTROY_DETAIL.F_USER_NAME
  is '销毁经手人姓名';
comment on column OA_FILE_DESTROY_DETAIL.F_DESTROY_TIME
  is '销毁日期';
comment on column OA_FILE_DESTROY_DETAIL.F_DESTROY_STATE
  is '销毁状态';
comment on column OA_FILE_DESTROY_DETAIL.F_DESTROY_ID
  is '销毁ID';
comment on column OA_FILE_DESTROY_DETAIL.F_ISAGREE_DESTROY
  is '是否同意销毁';
alter table OA_FILE_DESTROY_DETAIL
  add constraint PK_OA_FILE_DESTROY_DETAIL primary key (F_DETAIL_ID);

----2
delete oa_flow_busitype where busitype_code = 'uuid-337';
insert into oa_flow_busitype (BUSITYPE_CODE, BUSITYPE_NAME, TYPE_DESC, IS_VALID, BUSITYPE_TYPE_CODE)
values ('uuid-337', '档案销毁申请1', '档案销毁申请', 'Y', 'dang_an');
----3
delete oa_flow_form where form_path = '/ccapp/oa/file/jsp/filedestroyflow.jsp';
insert into oa_flow_form (FORM_PATH, FORM_NAME, FORM_DESC, CREATOR_TIME)
values ('/ccapp/oa/file/jsp/filedestroyflow.jsp', '档案销毁申请流程', '档案销毁申请流程', to_date('21-08-2013 11:07:32', 'dd-mm-yyyy hh24:mi:ss'));
----4
delete from oa_md_columns where TABLE_ID = '7a4b4d0d-cb83-402f-9d5a-d866b770c087';
delete from oa_md_table where TABLE_ID = '7a4b4d0d-cb83-402f-9d5a-d866b770c087';

insert into oa_md_table (TABLE_ID, TABLE_CODE, TABLE_NAME, TABLE_PK, PARENT_TABLE_ID, TABLE_SN)
values ('7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'OA_FILE_DESTROY', '档案销毁主表', 'f_destroy_id', '', 21);

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('dcea64de-c605-4bf9-9312-6f215b28b4a5', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_LD_IDEAS', '领导批示意见', 5, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('832a351d-0312-4e83-98db-739320635394', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_HQLD_IDEAS', '会签单位意见', 6, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('d7c5fce7-e2eb-4e87-8327-f844147de146', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_DESTROY_ID', '销毁ID', 1, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('5da66d3b-05c2-4403-805b-f9591b81b908', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_DESTROY_TITLE', '标题', 2, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('8ba4f557-9382-491c-956a-4448b6a766fa', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_DESTROY_REASON', '销毁理由', 3, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('9d929637-a12d-49bf-a8ef-f53f90fc12d7', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_ORG_ID', '所属的单位ID', 4, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('8fba7916-4020-436a-a8cc-ca8a2c3624d3', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_ORG_NAME', '所属单位名称', 5, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('173d3891-3bcd-402f-a412-cef6df61ac03', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_DEPT_ID', '所属部门ID', 6, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('d3416c70-1080-4e8e-b306-2d6706439b62', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_DEPT_NAME', '所属部门名', 7, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('57f7c1ac-4bdc-4150-85bd-61cfd5c81a9a', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_APPLY_USERID', '申请人ID', 8, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('0260a6c1-0815-4815-ac89-23260c37a751', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_APPLY_USERNAME', '申请人名称', 9, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('e2585981-eeeb-4568-9105-2983eca1655c', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_APPLY_TIME', '申请日期', 10, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('d07b1cdd-ad28-4832-860f-cfc57a2a533e', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_CHECKMSG', '审批意见', 11, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('a3d31c43-252e-4c70-bb49-b653a5bf3cad', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_ATTACH_ID', '附件ID', 12, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('09e85e7b-9a38-45fc-a0a9-20dc5be4b220', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_CHECK_USERNAME', '批准人姓名', 13, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('9c053177-d54e-4db7-aaa5-69b64d1cfbe8', '7a4b4d0d-cb83-402f-9d5a-d866b770c087', 'F_ISAGREE_DESTROY', '是否同意销毁', 14, '0');

commit;
