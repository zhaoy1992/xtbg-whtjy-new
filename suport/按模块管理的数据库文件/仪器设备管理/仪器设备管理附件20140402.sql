-- Add/modify columns 
alter table TA_OA_DEVACCOUNT add dev_attach_id VARCHAR2(50);
-- Add comments to the columns 
comment on column TA_OA_DEVACCOUNT.dev_attach_id
  is '����ID';
  
  
  
  -- Add/modify columns 
alter table TA_OA_DEVACCOUNT add user_unit varchar2(50);
alter table TA_OA_DEVACCOUNT add user_unitname varchar2(200);
-- Add comments to the columns 
comment on column TA_OA_DEVACCOUNT.user_unit
  is '���ܲ��ŵ�λID';
comment on column TA_OA_DEVACCOUNT.user_unitname
  is '���ܲ��ŵ�λ����';