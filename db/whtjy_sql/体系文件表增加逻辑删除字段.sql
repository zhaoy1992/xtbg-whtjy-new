-- Add/modify columns 
alter table OA_KBM_DOC add k_luojishanchu varchar2(1) default 0;
-- Add comments to the columns 
comment on column OA_KBM_DOC.k_luojishanchu
  is '�߼�ɾ��(���Ƹ���֪ͨɾ��)';
