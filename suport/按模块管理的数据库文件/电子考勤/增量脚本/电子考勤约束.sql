-- Create/Recreate primary, unique and foreign key constraints 
alter table SX_TA_OA_ELECTCHECK_INFO
  add constraint UNK_SX_TA_OA_ELECTCHECK_ID unique (USERID, DATETIME);
