-- Add/modify columns 
alter table TD_SM_ORGANIZATION add DEPT_ORG VARCHAR2(10);
-- Add comments to the columns 
comment on column TD_SM_ORGANIZATION.DEPT_ORG
  is '所属分类';
  
-- Add/modify columns 
alter table OA_ARCHIVE_DISPATCH add UNION_ARCHIVE_ADDR VARCHAR2(4000);
alter table OA_ARCHIVE_DISPATCH add UNION_ARCHIVE_MSG VARCHAR2(500);
-- Add comments to the columns 
comment on column OA_ARCHIVE_DISPATCH.UNION_ARCHIVE_ADDR
  is '联合发文地址';
comment on column OA_ARCHIVE_DISPATCH.UNION_ARCHIVE_MSG
  is '联合发文短信内容';  