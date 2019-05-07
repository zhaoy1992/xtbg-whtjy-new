-- Add/modify columns 
alter table YMJ_OA_CARMANAGE_CAR add fuelcard_num varchar2(50);
alter table YMJ_OA_CARMANAGE_CAR add fuelcard_sum number;
-- Add comments to the columns 
comment on column YMJ_OA_CARMANAGE_CAR.fuelcard_num
  is '油卡卡号';
comment on column YMJ_OA_CARMANAGE_CAR.fuelcard_sum
  is '油卡余额';
  

  
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
  is '车辆油卡登记充值使用记录表';
-- Add comments to the columns 
comment on column TA_OA_CARDFUELHISTORY.FUELCARD_ID
  is '主键ID';
comment on column TA_OA_CARDFUELHISTORY.FUELCARD_MONEY
  is '加油\充值金额';
comment on column TA_OA_CARDFUELHISTORY.FUELCARD_TYPE
  is '记录类型 0:加油 1:充值 2:初始金额';
comment on column TA_OA_CARDFUELHISTORY.FUELCARD_TIME
  is '登记时间';
comment on column TA_OA_CARDFUELHISTORY.CARD_ID
  is '车辆ID';
comment on column TA_OA_CARDFUELHISTORY.FUELCARD_REMARK
  is '备注';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_CARDFUELHISTORY
  add constraint PK_TA_OA_CARDFUELHISTORY_ID primary key (FUELCARD_ID);
