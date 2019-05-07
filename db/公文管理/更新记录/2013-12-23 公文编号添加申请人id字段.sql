-- Add/modify columns 
alter table OA_WORD_NUMBER add archive_userid VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_WORD_NUMBER.archive_userid
  is '…Í«Î»Àid';