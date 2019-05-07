-- Add/modify columns 
alter table TA_OA_OSAPP_OBJECT add is_rk varchar2(1) default 0;
-- Add comments to the columns 
comment on column TA_OA_OSAPP_OBJECT.is_rk
  is ' «∑Ò»Îø‚£®0∑Ò1 «£©';
