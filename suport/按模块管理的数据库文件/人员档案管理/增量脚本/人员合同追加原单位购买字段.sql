-- Add/modify columns 
alter table OA_HETONG add hetong_isydwgm CHAR(2);
-- Add comments to the columns 
comment on column OA_HETONG.hetong_isydwgm
  is '�Ƿ�ԭ��λ���� ���� "1":�� , "0":��';