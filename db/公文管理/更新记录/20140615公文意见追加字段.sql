-- Add/modify columns 
alter table OA_FLOW_INSVIEWLIST add ACTION_INS_ID VARCHAR2(100);
-- Add comments to the columns 
comment on column OA_FLOW_INSVIEWLIST.ACTION_INS_ID
  is '»·½ÚÊµÀýID';