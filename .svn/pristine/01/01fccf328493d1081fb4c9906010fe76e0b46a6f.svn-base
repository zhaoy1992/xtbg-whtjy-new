/*==============================================================*/
/* Table: TA_OA_CANOSAPPLANITEM  食堂物品用品申购计划物品表             */
/*==============================================================*/
create table TA_OA_CANOSAPPLANITEM
(
  it_id             VARCHAR2(40) not null,
  it_planid         VARCHAR2(50),
  it_osusetype_id   VARCHAR2(40),
  it_osusetype_name VARCHAR2(200),
  it_osustitem_id   VARCHAR2(40),
  it_osustitem_name VARCHAR2(200),
  it_count          NUMBER,
  it_remark         VARCHAR2(400),
  constraint PK_TA_OA_CANOSAPPLANITEM_ID primary key (IT_ID)
);
comment on table TA_OA_CANOSAPPLANITEM
  is '食堂物品用品申购计划物品表';
-- Add comments to the columns 
comment on column TA_OA_CANOSAPPLANITEM.it_id
  is '主键ID';
comment on column TA_OA_CANOSAPPLANITEM.it_planid
  is '申购计划ID';
comment on column TA_OA_CANOSAPPLANITEM.it_osusetype_id
  is '常用物品ID';
comment on column TA_OA_CANOSAPPLANITEM.it_osusetype_name
  is '常用物品名称';
comment on column TA_OA_CANOSAPPLANITEM.it_osustitem_id
  is '规格型号ID';
comment on column TA_OA_CANOSAPPLANITEM.it_osustitem_name
  is '规格型号名称';
comment on column TA_OA_CANOSAPPLANITEM.it_count
  is '数量';
comment on column TA_OA_CANOSAPPLANITEM.it_remark
  is '备注';
  
/*==============================================================*/
/* Table: TA_OA_CANOSAPP_OBJECT  食堂物品用品申购计划物品表             */
/*==============================================================*/
create table TA_OA_CANOSAPP_OBJECT
(
  t_os_ob_id    VARCHAR2(50) not null,
  t_id          VARCHAR2(50),
  t_org_id      VARCHAR2(50),
  t_org_name    VARCHAR2(200),
  ofustype_id   VARCHAR2(50),
  ofustype_name VARCHAR2(400),
  it_id         VARCHAR2(50),
  it_name       VARCHAR2(400),
  t_os_ob_no    VARCHAR2(20),
  t_os_ob_bz    VARCHAR2(400),
  constraint PK_TA_OA_CANOSAPP_OBJECT primary key (T_OS_OB_ID)
);
-- Add comments to the table 
comment on table TA_OA_CANOSAPP_OBJECT
  is '食堂物品用品申购计划物品表';
-- Add comments to the columns 
comment on column TA_OA_CANOSAPP_OBJECT.t_os_ob_id
  is '主键ID';
comment on column TA_OA_CANOSAPP_OBJECT.t_id
  is '申购计划ID';
comment on column TA_OA_CANOSAPP_OBJECT.t_org_id
  is '申购部门ID';
comment on column TA_OA_CANOSAPP_OBJECT.t_org_name
  is '申购部门名称';
comment on column TA_OA_CANOSAPP_OBJECT.ofustype_id
  is '物品ID';
comment on column TA_OA_CANOSAPP_OBJECT.ofustype_name
  is '物品名称';
comment on column TA_OA_CANOSAPP_OBJECT.it_id
  is '物品规格ID';
comment on column TA_OA_CANOSAPP_OBJECT.it_name
  is '物品规格';
comment on column TA_OA_CANOSAPP_OBJECT.t_os_ob_no
  is '物品数量';
comment on column TA_OA_CANOSAPP_OBJECT.t_os_ob_bz
  is '物品备注';

/*==============================================================*/
/* Table: TA_OA_CANOSAPPREG_OBJECT  食堂物品易耗品申领物品表           */
/*==============================================================*/
create table TA_OA_CANOSAPPREG_OBJECT
(
  t_osappreg_ob_id VARCHAR2(50) not null,
  t_appregyhp_id   VARCHAR2(50),
  oftype_id        VARCHAR2(50),
  oftype_name      VARCHAR2(200),
  ofustype_id      VARCHAR2(50),
  ofustype_name    VARCHAR2(200),
  it_id            VARCHAR2(50),
  it_name          VARCHAR2(200),
  t_osappreg_ob_no VARCHAR2(20),
  t_osappreg_ob_bz VARCHAR2(400),
  add_state        VARCHAR2(40),
  constraint PK_TA_OA_CANOSAPPREG_OBJECT primary key (T_OSAPPREG_OB_ID)
);
-- Add comments to the table 
comment on table TA_OA_CANOSAPPREG_OBJECT
  is '食堂物品易耗品申领物品表';
-- Add comments to the columns 
comment on column TA_OA_CANOSAPPREG_OBJECT.t_osappreg_ob_id
  is '主键ID';
comment on column TA_OA_CANOSAPPREG_OBJECT.t_appregyhp_id
  is '易耗品登记表ID';
comment on column TA_OA_CANOSAPPREG_OBJECT.oftype_id
  is '物品类型ID';
comment on column TA_OA_CANOSAPPREG_OBJECT.oftype_name
  is '物品类型NAME';
comment on column TA_OA_CANOSAPPREG_OBJECT.ofustype_id
  is '物品ID';
comment on column TA_OA_CANOSAPPREG_OBJECT.ofustype_name
  is '物品NAME';
comment on column TA_OA_CANOSAPPREG_OBJECT.it_id
  is '物品规格ID';
comment on column TA_OA_CANOSAPPREG_OBJECT.it_name
  is '物品规格NAME';
comment on column TA_OA_CANOSAPPREG_OBJECT.t_osappreg_ob_no
  is '数量';
comment on column TA_OA_CANOSAPPREG_OBJECT.t_osappreg_ob_bz
  is '备注';
comment on column TA_OA_CANOSAPPREG_OBJECT.add_state
  is 'plan:计划表的物品    control：手动添加物品';

/*==============================================================*/
/* Table: TA_OA_CANOSEXA_OBJECT  食堂物品申购审批物品表	        */
/*==============================================================*/
create table TA_OA_CANOSEXA_OBJECT
(
  t_osexa_ob_id        VARCHAR2(50) not null,
  t_osexa_id           VARCHAR2(50),
  t_osexa_ob_org_ids   CLOB,
  t_osexa_ob_org_names CLOB,
  ofustype_id          VARCHAR2(50),
  ofustype_name        VARCHAR2(200),
  it_id                VARCHAR2(50),
  it_name              VARCHAR2(200),
  t_osexa_ob_no        VARCHAR2(20),
  t_osexa_ob_dj        VARCHAR2(20),
  t_osexa_ob_bz        VARCHAR2(400),
  t_osexa_obrk_no      VARCHAR2(20),
  t_os_ob_ids          CLOB,
  constraint PK_TA_OA_CANOSEXA_OBJECT primary key (T_OSEXA_OB_ID)
);
-- Add comments to the table 
comment on table TA_OA_CANOSEXA_OBJECT
  is '食堂物品申购审批物品表';
-- Add comments to the columns 
comment on column TA_OA_CANOSEXA_OBJECT.t_osexa_ob_id
  is '主键ID';
comment on column TA_OA_CANOSEXA_OBJECT.t_osexa_id
  is '申购审批ID';
comment on column TA_OA_CANOSEXA_OBJECT.t_osexa_ob_org_ids
  is '申购部门IDS';
comment on column TA_OA_CANOSEXA_OBJECT.t_osexa_ob_org_names
  is '申购部门名称';
comment on column TA_OA_CANOSEXA_OBJECT.ofustype_id
  is '物品ID';
comment on column TA_OA_CANOSEXA_OBJECT.ofustype_name
  is '物品名称';
comment on column TA_OA_CANOSEXA_OBJECT.it_id
  is '物品规格ID';
comment on column TA_OA_CANOSEXA_OBJECT.it_name
  is '物品规格';
comment on column TA_OA_CANOSEXA_OBJECT.t_osexa_ob_no
  is '物品数量';
comment on column TA_OA_CANOSEXA_OBJECT.t_osexa_ob_dj
  is '单价';
comment on column TA_OA_CANOSEXA_OBJECT.t_osexa_ob_bz
  is '备注';
comment on column TA_OA_CANOSEXA_OBJECT.t_osexa_obrk_no
  is '已入库数量';
comment on column TA_OA_CANOSEXA_OBJECT.t_os_ob_ids
  is '计划物品表IDS';

/*==============================================================*/
/* Table: TA_OA_CANLINGYONG_OBJECT  食堂物品物品领用表	        */
/*==============================================================*/
create table TA_OA_CANLINGYONG_OBJECT
(
  t_ly_id        VARCHAR2(50) not null,
  oftype_id      VARCHAR2(50),
  oftype_name    VARCHAR2(200),
  ofustype_id    VARCHAR2(50),
  ofustype_name  VARCHAR2(200),
  it_id          VARCHAR2(50),
  it_name        VARCHAR2(200),
  t_ha_sbno      VARCHAR2(200),
  t_ly_date      DATE,
  t_ly_no        VARCHAR2(20),
  t_ly_org_id    VARCHAR2(50),
  t_ly_org_name  VARCHAR2(200),
  t_ly_user_id   VARCHAR2(50),
  t_ly_user_name VARCHAR2(200),
  t_lydj_id      VARCHAR2(50),
  t_ha_id        VARCHAR2(50),
  constraint PK_TA_OA_CANLINGYONG_OBJECT primary key (T_LY_ID)
);
-- Add comments to the table 
comment on table TA_OA_CANLINGYONG_OBJECT
  is '食堂物品物品领用表';
-- Add comments to the columns 
comment on column TA_OA_CANLINGYONG_OBJECT.t_ly_id
  is '主键ID';
comment on column TA_OA_CANLINGYONG_OBJECT.oftype_id
  is '物品类型ID';
comment on column TA_OA_CANLINGYONG_OBJECT.oftype_name
  is '物品类型NAME';
comment on column TA_OA_CANLINGYONG_OBJECT.ofustype_id
  is '物品ID';
comment on column TA_OA_CANLINGYONG_OBJECT.ofustype_name
  is '物品NAME';
comment on column TA_OA_CANLINGYONG_OBJECT.it_id
  is '物品规格ID';
comment on column TA_OA_CANLINGYONG_OBJECT.it_name
  is '物品规格NAME';
comment on column TA_OA_CANLINGYONG_OBJECT.t_ha_sbno
  is '设备编号';
comment on column TA_OA_CANLINGYONG_OBJECT.t_ly_date
  is '领用日期';
comment on column TA_OA_CANLINGYONG_OBJECT.t_ly_no
  is '数量';
comment on column TA_OA_CANLINGYONG_OBJECT.t_ly_org_id
  is '领用部门ID';
comment on column TA_OA_CANLINGYONG_OBJECT.t_ly_org_name
  is '领用部门NAME';
comment on column TA_OA_CANLINGYONG_OBJECT.t_ly_user_id
  is '领用人ID';
comment on column TA_OA_CANLINGYONG_OBJECT.t_ly_user_name
  is '领用人NAME';
comment on column TA_OA_CANLINGYONG_OBJECT.t_lydj_id
  is '相关领用表ID';
comment on column TA_OA_CANLINGYONG_OBJECT.t_ha_id
  is '物品库存ID';
  
/*==============================================================*/
/* Table: TA_OA_CANHAVA_OBJECT  食堂物品物品库存表       	        */
/*==============================================================*/
create table TA_OA_CANHAVA_OBJECT
(
  t_ha_id          VARCHAR2(50) not null,
  oftype_id        VARCHAR2(50),
  oftype_name      VARCHAR2(200),
  ofustype_id      VARCHAR2(50),
  ofustype_name    VARCHAR2(200),
  it_id            VARCHAR2(50),
  it_name          VARCHAR2(200),
  t_ha_sbno        VARCHAR2(200),
  t_ha_buydate     DATE,
  t_ha_ghman       VARCHAR2(200),
  t_ha_overtel     VARCHAR2(20),
  t_ha_dj          VARCHAR2(20),
  t_ha_no          VARCHAR2(20),
  t_ha_sbstate     VARCHAR2(30),
  t_ha_ghuser      VARCHAR2(100),
  t_ha_bz          VARCHAR2(400),
  t_ha_rkuser_id   VARCHAR2(50),
  t_ha_rkuser_name VARCHAR2(200),
  t_ha_org_id      VARCHAR2(50),
  t_ha_org_name    VARCHAR2(200),
  constraint PK_TA_OA_CANHAVA_OBJECT primary key (T_HA_ID)
);
-- Add comments to the table 
comment on table TA_OA_CANHAVA_OBJECT
  is '食堂物品物品库存表';
-- Add comments to the columns 
comment on column TA_OA_CANHAVA_OBJECT.t_ha_id
  is '主键ID';
comment on column TA_OA_CANHAVA_OBJECT.oftype_id
  is '物品类型ID';
comment on column TA_OA_CANHAVA_OBJECT.oftype_name
  is '物品类型NAME';
comment on column TA_OA_CANHAVA_OBJECT.ofustype_id
  is '物品ID';
comment on column TA_OA_CANHAVA_OBJECT.ofustype_name
  is '物品NAME';
comment on column TA_OA_CANHAVA_OBJECT.it_id
  is '物品规格ID';
comment on column TA_OA_CANHAVA_OBJECT.it_name
  is '物品规格NAME';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_sbno
  is '设备编号';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_buydate
  is '购买日期';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_ghman
  is '供货厂商';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_overtel
  is '售后电话';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_dj
  is '单价';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_no
  is '数量';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_sbstate
  is '状态';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_ghuser
  is '供货人';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_bz
  is '备注';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_rkuser_id
  is '入库人ID';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_rkuser_name
  is '入库人NAME';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_org_id
  is '所属部门ID';
comment on column TA_OA_CANHAVA_OBJECT.t_ha_org_name
  is '所属部门名称';
  
/*==============================================================*/
/* Table: TA_OA_CANNOMOVE_OBJECT  食堂物品固定资产申领物品表           */
/*==============================================================*/
create table TA_OA_CANNOMOVE_OBJECT
(
  t_nomove_ob_id VARCHAR2(50) not null,
  t_osnom_id     VARCHAR2(50),
  oftype_id      VARCHAR2(50),
  oftype_name    VARCHAR2(200),
  ofustype_name  VARCHAR2(200),
  it_name        VARCHAR2(200),
  t_nomove_ob_bz VARCHAR2(400),
  t_ha_id        VARCHAR2(50),
  constraint PK_TA_OA_CANNOMOVE_OBJECT primary key (T_NOMOVE_OB_ID)
);
-- Add comments to the table 
comment on table TA_OA_CANNOMOVE_OBJECT
  is '食堂物品固定资产申领物品表';
-- Add comments to the columns 
comment on column TA_OA_CANNOMOVE_OBJECT.t_nomove_ob_id
  is '主键ID';
comment on column TA_OA_CANNOMOVE_OBJECT.t_osnom_id
  is '固定资产登记表ID';
comment on column TA_OA_CANNOMOVE_OBJECT.oftype_id
  is '物品类别ID';
comment on column TA_OA_CANNOMOVE_OBJECT.oftype_name
  is '物品类别名称';
comment on column TA_OA_CANNOMOVE_OBJECT.ofustype_name
  is '物品名称';
comment on column TA_OA_CANNOMOVE_OBJECT.it_name
  is '规格名称';
comment on column TA_OA_CANNOMOVE_OBJECT.t_nomove_ob_bz
  is '备注';
comment on column TA_OA_CANNOMOVE_OBJECT.t_ha_id
  is '库存物品ID';

/*==============================================================*/
/* Table: TA_OA_CANOFFICEACCOUNT  食堂物品固定资产台帐表	        */
/*==============================================================*/
create table TA_OA_CANOFFICEACCOUNT
(
  id               VARCHAR2(40) not null,
  code             VARCHAR2(200),
  name             VARCHAR2(200),
  type             VARCHAR2(200),
  money            NUMBER,
  receive_day      DATE,
  receive_username VARCHAR2(200),
  blame_username   VARCHAR2(200),
  deposit_place    VARCHAR2(500),
  assetsuse        VARCHAR2(500),
  wastedisposal    VARCHAR2(500),
  remarks          VARCHAR2(500),
  org_id           VARCHAR2(50),
  org_name         VARCHAR2(100),
  unit_id          VARCHAR2(50),
  unit_name        VARCHAR2(100),
  oftype_name      VARCHAR2(200),
  oftype_id        VARCHAR2(50),
  receive_user_id  VARCHAR2(50),
  blame_user_id    VARCHAR2(50),
  constraint PK_TA_OA_CANOFFICEACCOUNT primary key (ID)
);
-- Add comments to the table 
comment on table TA_OA_CANOFFICEACCOUNT
  is '食堂物品固定资产台帐表';
-- Add comments to the columns 
comment on column TA_OA_CANOFFICEACCOUNT.id
  is '主键ID';
comment on column TA_OA_CANOFFICEACCOUNT.code
  is '标识卡编号';
comment on column TA_OA_CANOFFICEACCOUNT.name
  is '名称';
comment on column TA_OA_CANOFFICEACCOUNT.type
  is '规格\型号';
comment on column TA_OA_CANOFFICEACCOUNT.money
  is '金额';
comment on column TA_OA_CANOFFICEACCOUNT.receive_day
  is '领取时间';
comment on column TA_OA_CANOFFICEACCOUNT.receive_username
  is '领用人';
comment on column TA_OA_CANOFFICEACCOUNT.blame_username
  is '责任人';
comment on column TA_OA_CANOFFICEACCOUNT.deposit_place
  is '存放位置';
comment on column TA_OA_CANOFFICEACCOUNT.assetsuse
  is '资产用途';
comment on column TA_OA_CANOFFICEACCOUNT.wastedisposal
  is '报废处置情况';
comment on column TA_OA_CANOFFICEACCOUNT.remarks
  is '备注';
comment on column TA_OA_CANOFFICEACCOUNT.org_id
  is '机构ID';
comment on column TA_OA_CANOFFICEACCOUNT.org_name
  is '机构名称';
comment on column TA_OA_CANOFFICEACCOUNT.unit_id
  is '单位ID';
comment on column TA_OA_CANOFFICEACCOUNT.unit_name
  is '单位名称';
comment on column TA_OA_CANOFFICEACCOUNT.oftype_name
  is '类型名称';
comment on column TA_OA_CANOFFICEACCOUNT.oftype_id
  is '类型ID';
comment on column TA_OA_CANOFFICEACCOUNT.receive_user_id
  is '领用人ID';
comment on column TA_OA_CANOFFICEACCOUNT.blame_user_id
  is '责任人ID';
  
/*==============================================================*/
/* Table: TA_OA_CANOSAPREPAIR  食堂物品维修登记			        */
/*==============================================================*/
create table TA_OA_CANOSAPREPAIR
(
  repair_id       VARCHAR2(50) not null,
  report_time     DATE,
  repair_time     DATE,
  place_info      VARCHAR2(1000),
  repair_unit     VARCHAR2(100),
  deal_result     VARCHAR2(1000),
  replace_parts   VARCHAR2(1000),
  deal_status     VARCHAR2(20),
  repair_type     VARCHAR2(20),
  replace_partids VARCHAR2(1000),
  repair_unitname VARCHAR2(200),
  constraint PK_TA_OA_CANOSAPREPAIR primary key (REPAIR_ID)
);
-- Add comments to the table 
comment on table TA_OA_CANOSAPREPAIR
  is '食堂物品维修登记';
-- Add comments to the columns 
comment on column TA_OA_CANOSAPREPAIR.repair_id
  is '主键';
comment on column TA_OA_CANOSAPREPAIR.report_time
  is '报修时间';
comment on column TA_OA_CANOSAPREPAIR.repair_time
  is '修理时间';
comment on column TA_OA_CANOSAPREPAIR.place_info
  is '故障位置及情况';
comment on column TA_OA_CANOSAPREPAIR.repair_unit
  is '维修单位';
comment on column TA_OA_CANOSAPREPAIR.deal_result
  is '处理结果';
comment on column TA_OA_CANOSAPREPAIR.replace_parts
  is '更换的配件';
comment on column TA_OA_CANOSAPREPAIR.deal_status
  is '处理状态(doing:未处理,done:已办结)';
comment on column TA_OA_CANOSAPREPAIR.repair_type
  is '维修类别(assets:固定资产,floor：楼道设施)';
comment on column TA_OA_CANOSAPREPAIR.replace_partids
  is '维修的设备IDS';
comment on column TA_OA_CANOSAPREPAIR.repair_unitname
  is '单位名称';
  
/*==============================================================*/
/* Table: TA_OA_CANOSUPPLIETYPE  食堂物品用品类型表		        */
/*==============================================================*/
create table TA_OA_CANOSUPPLIETYPE
(
  oftype_id     VARCHAR2(40),
  oftype_name   VARCHAR2(400),
  oftype_remark VARCHAR2(400),
  oftype_no     NUMBER,
  oftype_flag   VARCHAR2(1)
);
-- Add comments to the table 
comment on table TA_OA_CANOSUPPLIETYPE
  is '食堂物品用品类型表';
-- Add comments to the columns 
comment on column TA_OA_CANOSUPPLIETYPE.oftype_id
  is '类型序号';
comment on column TA_OA_CANOSUPPLIETYPE.oftype_name
  is '类型名称';
comment on column TA_OA_CANOSUPPLIETYPE.oftype_remark
  is '说明';
comment on column TA_OA_CANOSUPPLIETYPE.oftype_no
  is '排序号';
comment on column TA_OA_CANOSUPPLIETYPE.oftype_flag
  is '状态 1:表示设备 2.表示易耗品';
  
/*==============================================================*/
/* Table: TA_OA_CANOSUPPLIEUSETYPE  食堂物品常用物品表	        */
/*==============================================================*/
create table TA_OA_CANOSUPPLIEUSETYPE
(
  ofustype_id   VARCHAR2(40) not null,
  ofustype_name VARCHAR2(200),
  ofustype_no   NUMBER,
  oftype_id     VARCHAR2(50),
  constraint PK_TA_OA_CANOSUPPLIEUSETYPE_ID primary key (OFUSTYPE_ID)
);
-- Add comments to the table 
comment on table TA_OA_CANOSUPPLIEUSETYPE
  is '食堂物品常用物品表';
-- Add comments to the columns 
comment on column TA_OA_CANOSUPPLIEUSETYPE.ofustype_id
  is '物品名称ID';
comment on column TA_OA_CANOSUPPLIEUSETYPE.ofustype_name
  is '物品名称';
comment on column TA_OA_CANOSUPPLIEUSETYPE.ofustype_no
  is '排序号';
comment on column TA_OA_CANOSUPPLIEUSETYPE.oftype_id
  is '物品所属分类ID';


/*==============================================================*/
/* Table: TA_OA_CANOSUSERTYPEITEM  食堂物品常用物品规格表	        */
/*==============================================================*/
create table TA_OA_CANOSUSERTYPEITEM
(
  it_id     VARCHAR2(40) not null,
  it_name   VARCHAR2(400),
  it_no     NUMBER,
  it_remark VARCHAR2(400),
  it_typeid VARCHAR2(40),
  constraint PK_TA_OA_CANOSUSERTYPEITEM_ID primary key (IT_ID)
);
-- Add comments to the table 
comment on table TA_OA_CANOSUSERTYPEITEM
  is '食堂物品常用物品规格表';
-- Add comments to the columns 
comment on column TA_OA_CANOSUSERTYPEITEM.it_id
  is '主键ID';
comment on column TA_OA_CANOSUSERTYPEITEM.it_name
  is '物品规格名称';
comment on column TA_OA_CANOSUSERTYPEITEM.it_no
  is '排序号';
comment on column TA_OA_CANOSUSERTYPEITEM.it_remark
  is '备注';
comment on column TA_OA_CANOSUSERTYPEITEM.it_typeid
  is '物品id';