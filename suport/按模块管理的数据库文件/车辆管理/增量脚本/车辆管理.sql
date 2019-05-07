-- Add/modify columns 
alter table YMJ_OA_CARMANAGE_CAR add fuelcard_num varchar2(50);
alter table YMJ_OA_CARMANAGE_CAR add fuelcard_sum number;
-- Add comments to the columns 
comment on column YMJ_OA_CARMANAGE_CAR.fuelcard_num
  is '�Ϳ�����';
comment on column YMJ_OA_CARMANAGE_CAR.fuelcard_sum
  is '�Ϳ����';
  

  
  -- Create table
create table TA_OA_CARDFUELHISTORY
(
  FUELCARD_ID     VARCHAR2(40) not null,
  FUELCARD_MONEY  NUMBER,
  FUELCARD_TYPE   VARCHAR2(10),
  FUELCARD_TIME   DATE,
  CARD_ID         VARCHAR2(40),
  FUELCARD_REMARK VARCHAR2(500)
);
-- Add comments to the table 
comment on table TA_OA_CARDFUELHISTORY
  is '�����Ϳ��Ǽǳ�ֵʹ�ü�¼��';
-- Add comments to the columns 
comment on column TA_OA_CARDFUELHISTORY.FUELCARD_ID
  is '����ID';
comment on column TA_OA_CARDFUELHISTORY.FUELCARD_MONEY
  is '����\��ֵ���';
comment on column TA_OA_CARDFUELHISTORY.FUELCARD_TYPE
  is '��¼���� 0:���� 1:��ֵ 2:��ʼ���';
comment on column TA_OA_CARDFUELHISTORY.FUELCARD_TIME
  is '�Ǽ�ʱ��';
comment on column TA_OA_CARDFUELHISTORY.CARD_ID
  is '����ID';
comment on column TA_OA_CARDFUELHISTORY.FUELCARD_REMARK
  is '��ע';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_CARDFUELHISTORY
  add constraint PK_TA_OA_CARDFUELHISTORY_ID primary key (FUELCARD_ID);
