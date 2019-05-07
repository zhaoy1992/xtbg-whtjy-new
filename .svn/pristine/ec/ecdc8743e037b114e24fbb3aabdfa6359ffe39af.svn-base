-- Create table
create table TA_OA_DEVAPPITEM
(
  ITEM_ID      VARCHAR2(40) not null,
  ITEM_PLAINID VARCHAR2(40),
  ITEM_NAME    VARCHAR2(200),
  ITEM_TYPE    VARCHAR2(200),
  ITEM_JSCS    VARCHAR2(200),
  ITEM_TJZCCJ  VARCHAR2(200),
  ITEM_SL      VARCHAR2(100),
  ITEM_GZLY    VARCHAR2(200),
  ITEM_YSFY    VARCHAR2(100),
  ITEM_NO      VARCHAR2(100),
  ITEM_PZRID   VARCHAR2(50),
  ITEM_PZRMC   VARCHAR2(50),
  ITEM_SFYZ    VARCHAR2(10)
);
-- Add comments to the columns 
comment on column TA_OA_DEVAPPITEM.ITEM_ID
  is '物品ID';
comment on column TA_OA_DEVAPPITEM.ITEM_PLAINID
  is '申购ID';
comment on column TA_OA_DEVAPPITEM.ITEM_NAME
  is '物品名称';
comment on column TA_OA_DEVAPPITEM.ITEM_TYPE
  is '型号规格';
comment on column TA_OA_DEVAPPITEM.ITEM_JSCS
  is '技术参数';
comment on column TA_OA_DEVAPPITEM.ITEM_TJZCCJ
  is '推荐制造厂家';
comment on column TA_OA_DEVAPPITEM.ITEM_SL
  is '数量';
comment on column TA_OA_DEVAPPITEM.ITEM_GZLY
  is '购置理由';
comment on column TA_OA_DEVAPPITEM.ITEM_YSFY
  is '预算费用';
comment on column TA_OA_DEVAPPITEM.ITEM_NO
  is '排序号';
comment on column TA_OA_DEVAPPITEM.ITEM_PZRID
  is '批准人ID';
comment on column TA_OA_DEVAPPITEM.ITEM_PZRMC
  is '批准人名称';
comment on column TA_OA_DEVAPPITEM.ITEM_SFYZ
  is '是否被设备验证采用';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_DEVAPPITEM
  add constraint PK_TA_OA_DEVAPPITEM_ID primary key (ITEM_ID);
