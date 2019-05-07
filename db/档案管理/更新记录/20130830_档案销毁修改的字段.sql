-------------------------------------
--  Changed table oa_file_destroy  --
-------------------------------------
-- Add/modify columns 
alter table OA_FILE_DESTROY modify f_destroy_title null;
alter table OA_FILE_DESTROY modify f_destroy_reason VARCHAR2(4000);
alter table OA_FILE_DESTROY add f_ld_ideas VARCHAR2(2000);
alter table OA_FILE_DESTROY add f_hqld_ideas VARCHAR2(4000);
--------------------------------------------
--  Changed table oa_file_destroy_detail  --
--------------------------------------------
-- Add/modify columns 
alter table OA_FILE_DESTROY_DETAIL add f_destroy_id VARCHAR2(200);
-- Add comments to the columns 
comment on column OA_FILE_DESTROY_DETAIL.f_destroy_id
  is '销毁ID';
-- Drop check constraints 
alter table OA_FILE_DESTROY_DETAIL
  drop constraint CKC_F_DESTROY_STATE_OA_FILE_;
---------------------------------
--  Changed table oa_file_doc  --
---------------------------------
-- Add/modify columns 
alter table OA_FILE_DOC add f_destroy_state VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_FILE_DOC.f_destroy_state
  is '销毁状态';
-- Create/Recreate check constraints 
alter table OA_FILE_DOC
  add constraint CKC_F_ENTITY_TYPE_OA_FILE_
  check (f_entity_type in ('1','2','3','4'));

-------------------------------------
--  Changed table oa_file_lending  --
-------------------------------------
-- Add/modify columns 
alter table OA_FILE_LENDING modify f_lending_userid null;
alter table OA_FILE_LENDING modify F_DEPT_ID null;
--下面两句在20130829借阅申请.sql中已经出现
--alter table OA_FILE_LENDING modify f_org_id null;
--alter table OA_FILE_LENDING modify f_org_name null;
-- Drop check constraints 
alter table OA_FILE_PHOTO_INFO
  drop constraint CKC_F_PHOTO_MEDIA_OA_FILE_;
-- Create/Recreate primary, unique and foreign key constraints 


-- Add/modify columns 
alter table OA_FILE_DESTROY_DETAIL add f_isagree_destroy char(1);
-- Add comments to the columns 
comment on column OA_FILE_DESTROY_DETAIL.f_isagree_destroy
  is '是否同意销毁';

-- 初始化 流程
insert into OA_FLOW_BUSITYPE (busitype_code, busitype_name, type_desc, is_valid)
values ('uuid-337', '档案销毁申请', '档案销毁申请', 'Y');
insert into OA_FLOW_FORM (form_path, form_name, form_desc, creator_time)
values ('/ccapp/oa/file/jsp/filedestroyflow.jsp', '档案销毁申请流程', '档案销毁申请流程', to_date('21-08-2013 11:07:32', 'dd-mm-yyyy hh24:mi:ss'));
commit;