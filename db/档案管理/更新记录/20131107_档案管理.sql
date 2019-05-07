-- Add/modify columns 
alter table OA_FILE_FILES add F_ORDER number;
-- Add comments to the columns 
comment on column OA_FILE_FILES.F_ORDER
  is '排序列';
  
  
--update oa_file_files set f_order = f_filesNo;

update oa_file_files set f_order = f_filesNo where regexp_like(f_filesNo,'^\d*$');

update oa_file_files set f_order = 0 where f_order is null;

commit;
