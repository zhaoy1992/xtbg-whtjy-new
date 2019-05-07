-- Add/modify columns 
alter table OA_KBM_DOC add k_receive_deptid varchar2(4000);
alter table OA_KBM_DOC add k_receive_deptname varchar2(4000);
-- Add comments to the columns 
comment on column OA_KBM_DOC.k_receive_deptid
  is '适用部门ID';
comment on column OA_KBM_DOC.k_receive_deptname
  is '适用部门名称';
  
  -- Add/modify columns 
alter table OA_KBM_DOC add k_Upload_type varchar2(50);
-- Add comments to the columns 
comment on column OA_KBM_DOC.k_Upload_type
  is '上传类型';
  
  
  -- Create table
create table OA_KBM_DOCRECEIVEUSER
(
  K_RECEIVERID           VARCHAR2(50) not null,
  K_DOC_ID               VARCHAR2(40),
  K_RECEIVER_USERID      VARCHAR2(50),
  K_RECEIVER_USERNAME    VARCHAR2(200),
  K_RECEIVERUSER_ORGID   VARCHAR2(50),
  K_RECEIVERUSER_ORGNAME VARCHAR2(200),
  K_ISVIEW               VARCHAR2(1) default '0',
  K_CREATOR_TIME         DATE default SYSDATE,
  K_ISDEL                VARCHAR2(1)
);
-- Add comments to the table 
comment on table OA_KBM_DOCRECEIVEUSER
  is '体系文件发布接收人表';
-- Add comments to the columns 
comment on column OA_KBM_DOCRECEIVEUSER.K_RECEIVERID
  is '主键ID';
comment on column OA_KBM_DOCRECEIVEUSER.K_DOC_ID
  is '知识库ID';
comment on column OA_KBM_DOCRECEIVEUSER.K_RECEIVER_USERID
  is '接收人ID';
comment on column OA_KBM_DOCRECEIVEUSER.K_RECEIVER_USERNAME
  is '接收人名称';
comment on column OA_KBM_DOCRECEIVEUSER.K_RECEIVERUSER_ORGID
  is '接收人单位ID';
comment on column OA_KBM_DOCRECEIVEUSER.K_RECEIVERUSER_ORGNAME
  is '接收人单位名称';
comment on column OA_KBM_DOCRECEIVEUSER.K_ISVIEW
  is '是否已查看(1:是，0:不是)';
comment on column OA_KBM_DOCRECEIVEUSER.K_CREATOR_TIME
  is '创建时间';
comment on column OA_KBM_DOCRECEIVEUSER.K_ISDEL
  is '是否已删除(1:是，0:不是)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_KBM_DOCRECEIVEUSER
  add constraint PK_OA_KBM_DOCRECEIVEUSER_ID primary key (K_RECEIVERID);
  
  
insert into oa_data_resources (RESOURCES_ID, RESOURCES_PARENT_ID, RESOURCES_NAME, RESOURCES_LOGO, RESOURCES_DESC, CREATOR_TIME, RESOURCES_TYPE, TREE_TYPE, IS_VIEW)
values ('11', '4', '体系文件适用单位接收人', 'kbmdocreceiverson', '体系文件适用单位接收人', to_date('01-04-2014', 'dd-mm-yyyy'), '2', '', '1');
