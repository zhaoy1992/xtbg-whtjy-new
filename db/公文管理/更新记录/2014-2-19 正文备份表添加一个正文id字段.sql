-- Add/modify columns 
alter table OA_FLOW_DOCUMENT_FILE add recordid VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_FLOW_DOCUMENT_FILE.recordid
  is '正文id';