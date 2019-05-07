-- Add/modify columns 
alter table OA_FILE_DOC add F_GONGWEN_ID VARCHAR2(50);
alter table OA_FILE_DOC add F_FLOW_STATE CHAR(1);
alter table OA_FILE_DOC add F_ROLLBACK_IDEA VARCHAR2(2000);
alter table OA_FILE_DOC add F_SUBMIT_USER_ID	VARCHAR2(50);
alter table OA_FILE_DOC add F_SUBMIT_USER_NAME VARCHAR2(500);
alter table OA_FILE_DOC add F_SUBMIT_TIME date;
-- Add comments to the columns
comment on column OA_FILE_DOC.F_GONGWEN_ID
  is '"关联的公文待归档信息的ID"'; 
comment on column OA_FILE_DOC.F_FLOW_STATE
  is '"提交状态（默认为0：未提交  1：退回  2：已提交  3、已接收）"';
comment on column OA_FILE_DOC.F_ROLLBACK_IDEA
  is '"退回意见"';
comment on column OA_FILE_DOC.F_SUBMIT_USER_ID	VARCHAR2(50)
  is '"提交人ID(	公文拟稿人)"';
comment on column OA_FILE_DOC.F_SUBMIT_USER_NAME
  is '"提交人名称(公文拟稿人)"';
comment on column OA_FILE_DOC.F_SUBMIT_TIME
  is '"提交事件(公文拟稿人--部门综合岗)"';
  
  
  
insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('041', 'wj', 'F_GONGWEN_ID', '关联的公文待归档信息的ID', 102, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('042', 'wj', 'F_FLOW_STATE', '提交状态', 103, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('043', 'wj', 'F_ROLLBACK_IDEA', '退回意见', 104, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('044', 'wj', 'F_SUBMIT_USER_ID', '提交人ID(	公文拟稿人)', 105, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('045', 'wj', 'F_SUBMIT_USER_NAME', '提交人名称(	公文拟稿人)', 106, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('046', 'wj', 'F_SUBMIT_TIME', '提交时间(公文拟稿人--部门综合岗)', 107, '0');



-- Add/modify columns 
alter table OA_FILE_FILES add F_FLOW_STATE CHAR(1);
alter table OA_FILE_FILES add F_ROLLBACK_IDEA VARCHAR2(2000);
alter table OA_FILE_FILES add F_SUBMIT_USER_ID VARCHAR2(50);
alter table OA_FILE_FILES add F_SUBMIT_USER_NAME VARCHAR2(500);
alter table OA_FILE_FILES add F_SUBMIT_TIME date;
-- Add comments to the columns 
comment on column OA_FILE_FILES.F_ORDER
  is '排序';
comment on column OA_FILE_FILES.F_FLOW_STATE
  is '提交状态（默认为0：未提交  1：退回  2：已提交  3、已接收）';
comment on column OA_FILE_FILES.F_ROLLBACK_IDEA
  is '退回意见';
comment on column OA_FILE_FILES.F_SUBMIT_USER_ID
  is '提交人ID(	公文拟稿人)';
comment on column OA_FILE_FILES.F_SUBMIT_USER_NAME
  is '提交人名称(公文拟稿人)';
comment on column OA_FILE_FILES.F_SUBMIT_TIME
  is '提交时间';


  
insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('72d9ab56-c306-4345-b382-d4a726fc3c9201', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_FLOW_STATE', '提交状态（默认为0：未提交  1：退回  2：已提交  3、已接收）', 35, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('72d9ab56-c306-4345-b382-d4a726fc3c9202', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_ROLLBACK_IDEA', '退回意见', 36, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('72d9ab56-c306-4345-b382-d4a726fc3c9203', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_SUBMIT_USER_ID', '提交人ID(	公文拟稿人)', 37, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('72d9ab56-c306-4345-b382-d4a726fc3c9204', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_SUBMIT_USER_NAME', '提交人名称(公文拟稿人)', 38, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('72d9ab56-c306-4345-b382-d4a726fc3c9205', 'fb518938-39e6-47b6-bd57-09d72353f24c', 'F_SUBMIT_TIME', '提交时间', 39, '0');

commit;