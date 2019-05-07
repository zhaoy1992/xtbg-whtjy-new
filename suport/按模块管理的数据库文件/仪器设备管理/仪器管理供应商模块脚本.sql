-- Create table
create table TA_OA_DEVSUPPLIER
(
  DEVSUP_ID    VARCHAR2(40) not null,
  DEVSUP_MC    VARCHAR2(200),
  DEVSUP_SLSJ  DATE,
  DEVSUP_GFXZ  VARCHAR2(10),
  DEVSUP_GFLB  VARCHAR2(10),
  DEVSUP_GFDZ  VARCHAR2(200),
  DEVSUP_FDDBR VARCHAR2(100),
  DEVSUP_LXDB  VARCHAR2(50),
  DEVSUP_LXDH  VARCHAR2(20),
  DEVSUP_XYD   VARCHAR2(10),
  DEVSUP_SFYX  VARCHAR2(10),
  DEVSUP_TGCP  VARCHAR2(600)
);
-- Add comments to the columns 
comment on column TA_OA_DEVSUPPLIER.DEVSUP_ID
  is '主键ID';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_MC
  is '供应商名称';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_SLSJ
  is '收录时间';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_GFXZ
  is '供方性质';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_GFLB
  is '供方类别';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_GFDZ
  is '供方地址';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_FDDBR
  is '法定代表人';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_LXDB
  is '联系代表';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_LXDH
  is '联系电话';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_XYD
  is '信誉度';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_SFYX
  is '是否有效';
comment on column TA_OA_DEVSUPPLIER.DEVSUP_TGCP
  is '提供产品';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_DEVSUPPLIER
  add constraint PK_TA_OA_DEVSUPPLIER_ID primary key (DEVSUP_ID);
