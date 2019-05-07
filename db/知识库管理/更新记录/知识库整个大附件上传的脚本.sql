-- Create table
create table OA_FILEUPLOAD_KBM
(
  file_id         VARCHAR2(40) not null,
  file_name       VARCHAR2(150),
  file_type       VARCHAR2(30),
  serverfile_name VARCHAR2(200),
  file_extra      VARCHAR2(30),
  serverfile_path VARCHAR2(100),
  file_size       VARCHAR2(30),
  parentfile_id   VARCHAR2(30),
  user_id         VARCHAR2(30),
  depart_id       VARCHAR2(100),
  upload_time     DATE,
  is_share        VARCHAR2(30),
  is_systemcreate VARCHAR2(30),
  creatortime     DATE,
  attach_id       VARCHAR2(200)
)
-- Add comments to the columns 
comment on column OA_FILEUPLOAD_KBM.file_id
  is '附件id';
comment on column OA_FILEUPLOAD_KBM.file_name
  is '附件名称';
comment on column OA_FILEUPLOAD_KBM.file_type
  is '附件类型';
comment on column OA_FILEUPLOAD_KBM.file_extra
  is '附件扩展名称';
comment on column OA_FILEUPLOAD_KBM.file_size
  is '附件大小';
comment on column OA_FILEUPLOAD_KBM.creatortime
  is '创建时间';
comment on column OA_FILEUPLOAD_KBM.attach_id
  is '关联附件ID';
-- Add/modify columns 
alter table OA_FILEUPLOAD_KBM add yearfolder VARCHAR2(4);
alter table OA_FILEUPLOAD_KBM add monthfolder VARCHAR2(2);
-- Add comments to the columns 
comment on column OA_FILEUPLOAD_KBM.yearfolder
  is '年度';
comment on column OA_FILEUPLOAD_KBM.monthfolder
  is '月份';