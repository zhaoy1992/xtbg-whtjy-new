-- Add/modify columns 
alter table TA_OA_OSAPPREG_OBJECT add ADD_STATE varchar2(40);
-- Add comments to the columns 
comment on column TA_OA_OSAPPREG_OBJECT.ADD_STATE
  is 'plan:�ƻ������Ʒ    control���ֶ������Ʒ';
