-- Add/modify columns 
alter table OA_ARCHIVE_DISPATCH add is_gz VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_ARCHIVE_DISPATCH.is_gz
  is '是否盖章成功';