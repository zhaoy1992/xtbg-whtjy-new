-- Add/modify columns 
alter table OA_NOTICE_BASEINFO add N_TYPE varchar2(1);
-- Add comments to the columns 
comment on column OA_NOTICE_BASEINFO.N_TYPE
  is '�������ͣ�Ĭ��nullΪ��ͨ����,1Ժ����Ѷ��2Ա�����棩';
