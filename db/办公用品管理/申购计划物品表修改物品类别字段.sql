-- Add/modify columns 
alter table TA_OA_OSAPP_OBJECT add p_type_id varchar2(50);
alter table TA_OA_OSAPP_OBJECT add p_type varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_OSAPP_OBJECT.type_id
  is '�����id';
comment on column TA_OA_OSAPP_OBJECT.type
  is '�����';
comment on column TA_OA_OSAPP_OBJECT.p_type_id
  is '��Ʒ���id';
comment on column TA_OA_OSAPP_OBJECT.p_type
  is '��Ʒ���';
