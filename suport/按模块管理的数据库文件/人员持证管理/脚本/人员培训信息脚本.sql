-- Create table
create table TA_OA_TRAIN
(
  TR_ID      VARCHAR2(40) not null,
  TR_LEVEL   VARCHAR2(100),
  TR_TITLE   VARCHAR2(200),
  TR_CONTENT VARCHAR2(2000),
  TR_TIME    DATE,
  TR_HOUR    NUMBER,
  TR_ADDRESS VARCHAR2(200),
  TR_MONEY   NUMBER,
  TR_USERSN  VARCHAR2(40)
);
-- Add comments to the columns 
comment on column TA_OA_TRAIN.TR_ID
  is '主键ID';
comment on column TA_OA_TRAIN.TR_LEVEL
  is '培训级别';
comment on column TA_OA_TRAIN.TR_TITLE
  is '培训主题';
comment on column TA_OA_TRAIN.TR_CONTENT
  is '培训内容';
comment on column TA_OA_TRAIN.TR_TIME
  is '培训时间';
comment on column TA_OA_TRAIN.TR_HOUR
  is '培训课时';
comment on column TA_OA_TRAIN.TR_ADDRESS
  is '地点';
comment on column TA_OA_TRAIN.TR_MONEY
  is '培训费用';
comment on column TA_OA_TRAIN.TR_USERSN
  is '用户id';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_TRAIN
  add constraint PK_TA_OA_TRAIN_ID primary key (TR_ID);
