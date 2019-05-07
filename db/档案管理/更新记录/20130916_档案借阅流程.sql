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
 * 档案借阅-建表sql脚本
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
  SELECT COUNT(1) INTO HAVE_TABLE FROM ALL_TABLES WHERE  TABLE_NAME = 'OA_FILE_LENDING_DETAIL' AND OWNER=SYS.LOGIN_USER;
  IF(HAVE_TABLE>0) THEN
      EXECUTE IMMEDIATE 'DROP TABLE OA_FILE_LENDING_DETAIL';
  END IF;
  
  SELECT COUNT(1) INTO HAVE_TABLE FROM ALL_TABLES WHERE  TABLE_NAME = 'OA_FILE_LENDING' AND OWNER=SYS.LOGIN_USER;
  IF(HAVE_TABLE>0) THEN
      EXECUTE IMMEDIATE 'DROP TABLE OA_FILE_LENDING';
  END IF;
END;
/

create table OA_FILE_LENDING_DETAIL
(
  F_DETAIL_ID      VARCHAR2(50) not null,
  F_DOC_ID         VARCHAR2(50),
  F_LENDING_TYPE   CHAR(1),
  F_ISAGREE        CHAR(1),
  F_ISLENDING      CHAR(1),
  F_LENDING_TIME   DATE,
  F_LENDING_DAY    NUMBER,
  F_USER_ID        VARCHAR2(50),
  F_USER_NAME      VARCHAR2(100),
  F_ISBACK         CHAR(1),
  F_REBACK_TIME    DATE,
  F_BACK_USERID    VARCHAR2(50),
  F_BACK_USERNAME  VARCHAR2(100),
  F_READ_PURVIEW   CHAR(1),
  F_READ_APPROVE   CHAR(1),
  F_LENDING_USERID VARCHAR2(50) not null,
  F_LENDING_ID     VARCHAR2(50),
  F_BACK_TIME      DATE
)
tablespace XTBGBASE
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table OA_FILE_LENDING_DETAIL
  is '档案借阅主表';
comment on column OA_FILE_LENDING_DETAIL.F_DETAIL_ID
  is '借阅文件详细 ID';
comment on column OA_FILE_LENDING_DETAIL.F_DOC_ID
  is '文件ID';
comment on column OA_FILE_LENDING_DETAIL.F_LENDING_TYPE
  is '借阅类型';
comment on column OA_FILE_LENDING_DETAIL.F_ISAGREE
  is '是否同意借阅';
comment on column OA_FILE_LENDING_DETAIL.F_ISLENDING
  is '是否已借阅';
comment on column OA_FILE_LENDING_DETAIL.F_LENDING_TIME
  is '借阅日期';
comment on column OA_FILE_LENDING_DETAIL.F_LENDING_DAY
  is '借阅天数';
comment on column OA_FILE_LENDING_DETAIL.F_USER_ID
  is '借出经手人ID';
comment on column OA_FILE_LENDING_DETAIL.F_USER_NAME
  is '借出经手人姓名';
comment on column OA_FILE_LENDING_DETAIL.F_ISBACK
  is '是否已归还';
comment on column OA_FILE_LENDING_DETAIL.F_REBACK_TIME
  is '计划归还日期';
comment on column OA_FILE_LENDING_DETAIL.F_BACK_USERID
  is '归还经手人ID';
comment on column OA_FILE_LENDING_DETAIL.F_BACK_USERNAME
  is '归还经手人姓名';
comment on column OA_FILE_LENDING_DETAIL.F_READ_PURVIEW
  is '申请的阅读权限';
comment on column OA_FILE_LENDING_DETAIL.F_READ_APPROVE
  is '批准的阅读权限';
comment on column OA_FILE_LENDING_DETAIL.F_LENDING_USERID
  is '借阅人ID';
comment on column OA_FILE_LENDING_DETAIL.F_LENDING_ID
  is '借阅ID';
comment on column OA_FILE_LENDING_DETAIL.F_BACK_TIME
  is '归还日期';
alter table OA_FILE_LENDING_DETAIL
  add constraint PK_OA_FILE_LENDING_DETAIL primary key (F_DETAIL_ID);
alter table OA_FILE_LENDING_DETAIL
  add constraint CKC_F_ISAGREE_OA_FILE_
  check (f_isagree is null or (f_isagree in ('1','0')));
alter table OA_FILE_LENDING_DETAIL
  add constraint CKC_F_ISBACK_OA_FILE_
  check (f_isback is null or (f_isback in ('0','1','3')));
alter table OA_FILE_LENDING_DETAIL
  add constraint CKC_F_ISLENDING_OA_FILE_
  check (f_islending is null or (f_islending in ('0','1')));
alter table OA_FILE_LENDING_DETAIL
  add constraint CKC_F_LENDING_TYPE_OA_FILE_
  check (f_lending_type is null or (f_lending_type in ('0','1','2')));
alter table OA_FILE_LENDING_DETAIL
  add constraint CKC_F_READ_APPROVE_OA_FILE_
  check (f_read_approve is null or (f_read_approve in ('0','1','2')));
alter table OA_FILE_LENDING_DETAIL
  add constraint CKC_F_READ_PURVIEW_OA_FILE_
  check (f_read_purview is null or (f_read_purview in ('1','2','0')));

create table OA_FILE_LENDING
(
  F_LENDING_ID       VARCHAR2(50) not null,
  F_LENDING_REASON   VARCHAR2(500) not null,
  F_LENDING_USERID   VARCHAR2(50),
  F_LENDING_USERNAME VARCHAR2(100) not null,
  F_ORG_ID           VARCHAR2(50),
  F_ORG_NAME         VARCHAR2(100),
  F_DEPT_ID          VARCHAR2(50),
  F_DEPT_NAME        VARCHAR2(100) not null,
  F_TEL              VARCHAR2(40),
  F_CREATOR_TIME     DATE not null,
  F_CHECKMSG         CLOB
);
comment on table OA_FILE_LENDING
  is '档案借阅主表';
comment on column OA_FILE_LENDING.F_LENDING_ID
  is '借阅ID';
comment on column OA_FILE_LENDING.F_LENDING_REASON
  is '借阅理由';
comment on column OA_FILE_LENDING.F_LENDING_USERID
  is '借阅人ID';
comment on column OA_FILE_LENDING.F_LENDING_USERNAME
  is '借阅人姓名';
comment on column OA_FILE_LENDING.F_ORG_ID
  is '所属的单位ID';
comment on column OA_FILE_LENDING.F_ORG_NAME
  is '所属单位名称';
comment on column OA_FILE_LENDING.F_DEPT_ID
  is '所属部门ID';
comment on column OA_FILE_LENDING.F_DEPT_NAME
  is '所属部门名';
comment on column OA_FILE_LENDING.F_TEL
  is '联系电话';
comment on column OA_FILE_LENDING.F_CREATOR_TIME
  is '申请日期';
comment on column OA_FILE_LENDING.F_CHECKMSG
  is '审批意见';
alter table OA_FILE_LENDING
  add constraint PK_OA_FILE_LENDING primary key (F_LENDING_ID);
----2
delete oa_flow_busitype where busitype_code = 'uuid-336';
insert into oa_flow_busitype (BUSITYPE_CODE, BUSITYPE_NAME, TYPE_DESC, IS_VALID, BUSITYPE_TYPE_CODE)
values ('uuid-336', '档案借阅申请', '档案借阅申请', 'Y', 'dang_an');
----3
delete oa_flow_form where form_path = '/ccapp/oa/file/jsp/filelendingflow.jsp';
insert into oa_flow_form (FORM_PATH, FORM_NAME, FORM_DESC, CREATOR_TIME)
values ('/ccapp/oa/file/jsp/filelendingflow.jsp', '档案借阅申请流程表单', '档案借阅申请流程表单', to_date('01-08-2013 14:21:12', 'dd-mm-yyyy hh24:mi:ss'));
----4
delete  oa_md_columns where TABLE_ID = 'cfa24116-4813-4e62-b1ea-8ac4ea15f519';
delete  oa_md_table where TABLE_ID = 'cfa24116-4813-4e62-b1ea-8ac4ea15f519';
insert into oa_md_table (TABLE_ID, TABLE_CODE, TABLE_NAME, TABLE_PK, PARENT_TABLE_ID, TABLE_SN)
values ('cfa24116-4813-4e62-b1ea-8ac4ea15f519', 'OA_FILE_LENDING', '档案借阅主表', 'F_LENDING_ID', '', 15);

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


commit;
