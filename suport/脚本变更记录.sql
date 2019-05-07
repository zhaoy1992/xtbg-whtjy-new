/**************************************add by jiao.chen 2015-11-18 start**********************************/
delete from TA_OA_WHTJY_YONGCHE;
commit;

-- Alter table 
alter table TA_OA_WHTJY_YONGCHE
  storage
  (
    next 1
  )
;
-- Add/modify columns 
alter table TA_OA_WHTJY_YONGCHE modify car_start_time date;
alter table TA_OA_WHTJY_YONGCHE modify car_end_time date;


-- Alter table 
alter table TA_OA_PERSONHOLDER
  storage
  (
    next 1
  )
;
-- Add/modify columns 
alter table TA_OA_PERSONHOLDER add attachment_id varchar2(50);
-- Add comments to the columns 
comment on column TA_OA_PERSONHOLDER.attachment_id
  is '附件id';
 /**************************************add by jiao.chen 2015-11-18 end**********************************/ 
 
 /**************************************添加邮箱容量基础数据 add by jiao.chen 2015-11-19 start**********************************/ 
 insert into oa_mail_memoryconfig (ID, USER_ID, MEMORY)
values ('6279ee4b-f9c1-448a-8ab8-49974d5fdab1', '1', 100);
commit;
 /**************************************添加邮箱容量基础数据 add by jiao.chen 2015-11-19 end**********************************/ 
 
/**************************************新增土地房屋基本信息表 add by jiao.chen 2015-11-24 start*******************************/ 
 -- Create table
create table TA_OA_LANDHOUSEITEM
(
  lh_id            VARCHAR2(50) not null,
  lh_number        VARCHAR2(100),
  lh_name          VARCHAR2(200),
  lh_area          VARCHAR2(50),
  lh_location      VARCHAR2(200),
  lh_identify_code VARCHAR2(100),
  lh_date          DATE default sysdate,
  lh_money         VARCHAR2(100),
  lh_create_time   DATE default sysdate,
  lh_update_time   DATE default sysdate,
  lh_remarks       VARCHAR2(250)
);
-- Add comments to the table 
comment on table TA_OA_LANDHOUSEITEM
  is '土地房屋基本信息表';
-- Add comments to the columns 
comment on column TA_OA_LANDHOUSEITEM.lh_id
  is '主键';
comment on column TA_OA_LANDHOUSEITEM.lh_number
  is '编号';
comment on column TA_OA_LANDHOUSEITEM.lh_name
  is '名称';
comment on column TA_OA_LANDHOUSEITEM.lh_area
  is '面积';
comment on column TA_OA_LANDHOUSEITEM.lh_location
  is '地点';
comment on column TA_OA_LANDHOUSEITEM.lh_identify_code
  is '证号';
comment on column TA_OA_LANDHOUSEITEM.lh_date
  is '日期';
comment on column TA_OA_LANDHOUSEITEM.lh_money
  is '金额';
comment on column TA_OA_LANDHOUSEITEM.lh_create_time
  is '新建时间';
comment on column TA_OA_LANDHOUSEITEM.lh_update_time
  is '修改时间';
comment on column TA_OA_LANDHOUSEITEM.lh_remarks
  is '备注';
 /**************************************新增土地房屋基本信息表 add by jiao.chen 2015-11-24 end*******************************/ 
 
 /**************************************修改设备信息主表中的库存状态(新增3:出租) add by jiao.chen 2015-11-24 start*******************************/ 
 -- Add comments to the columns 
comment on column TA_OA_DEVACCOUNT.dev_stockflag
  is '设备库存状态  1:在库 2:借出 3:出租';
 /**************************************修改设备信息主表中的库存状态(新增3:出租) add by jiao.chen 2015-11-24 end*******************************/ 
 
 /**************************************办公用品业务表中添加所属单位名称与所属单位id add by jiao.chen 2016-03-02 start*******************************/ 
 -- Add/modify columns 
alter table TA_OA_OSUPPLIETYPE add unit_id varchar2(50);
alter table TA_OA_OSUPPLIETYPE add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_OSUPPLIETYPE.unit_id
  is '所属单位ID';
comment on column TA_OA_OSUPPLIETYPE.unit_name
  is '所属单位名称';

  -- Add/modify columns 
alter table TA_OA_OSUPPLIEUSETYPE add unit_name varchar2(100);
alter table TA_OA_OSUPPLIEUSETYPE add unit_id varchar2(50);
-- Add comments to the columns 
comment on column TA_OA_OSUPPLIEUSETYPE.unit_name
  is '所属单位名称';
comment on column TA_OA_OSUPPLIEUSETYPE.unit_id
  is '所属单位ID';

  -- Add/modify columns 
alter table TA_OA_OSUSERTYPEITEM add unit_id varchar2(50);
alter table TA_OA_OSUSERTYPEITEM add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_OSUSERTYPEITEM.unit_id
  is '所属单位ID';
comment on column TA_OA_OSUSERTYPEITEM.unit_name
  is '所属单位名称';

  -- Add/modify columns 
alter table TA_OA_OSAPREPAIR add unit_id varchar2(50);
alter table TA_OA_OSAPREPAIR add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_OSAPREPAIR.unit_id
  is '所属单位ID';
comment on column TA_OA_OSAPREPAIR.unit_name
  is '所属单位名称';

  -- Add/modify columns 
alter table TA_OA_HAVA_OBJECT add unit_id varchar2(50);
alter table TA_OA_HAVA_OBJECT add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_HAVA_OBJECT.unit_id
  is '所属单位ID';
comment on column TA_OA_HAVA_OBJECT.unit_name
  is '所属单位名称';

  -- Add/modify columns 
alter table TA_OA_OSEXA_OBJECT add unit_id varchar2(50);
alter table TA_OA_OSEXA_OBJECT add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_OSEXA_OBJECT.unit_id
  is '所属单位ID';
comment on column TA_OA_OSEXA_OBJECT.unit_name
  is '所属单位名称';
  
  -- Add/modify columns 
alter table TA_OA_OSAPP_OBJECT add unit_id varchar2(50);
alter table TA_OA_OSAPP_OBJECT add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_OSAPP_OBJECT.unit_id
  is '所属单位ID';
comment on column TA_OA_OSAPP_OBJECT.unit_name
  is '所属单位名称';
 /**************************************办公用品业务表中添加所属单位名称与所属单位id add by jiao.chen 2016-03-02 end  *******************************/ 
 
 /**************************************检测耗材业务表中添加所属单位名称与所属单位id add by jiao.chen 2016-03-03 start*******************************/ 
-- Add/modify columns 
alter table TA_OA_DETOSUPPLIETYPE add unit_id varchar2(50);
alter table TA_OA_DETOSUPPLIETYPE add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_DETOSUPPLIETYPE.unit_id
  is '所属单位ID';
comment on column TA_OA_DETOSUPPLIETYPE.unit_name
  is '所属单位名称';

  -- Add/modify columns 
alter table TA_OA_DETOSUPPLIEUSETYPE add unit_id varchar2(50);
alter table TA_OA_DETOSUPPLIEUSETYPE add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_DETOSUPPLIEUSETYPE.unit_id
  is '所属单位ID';
comment on column TA_OA_DETOSUPPLIEUSETYPE.unit_name
  is '所属单位名称';

  -- Add/modify columns 
alter table TA_OA_DETOSUSERTYPEITEM add unit_id varchar2(50);
alter table TA_OA_DETOSUSERTYPEITEM add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_DETOSUSERTYPEITEM.unit_id
  is '所属单位ID';
comment on column TA_OA_DETOSUSERTYPEITEM.unit_name
  is '所属单位名称';

  -- Add/modify columns 
alter table TA_OA_DETOSAPP_OBJECT add unit_id varchar2(50);
alter table TA_OA_DETOSAPP_OBJECT add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_DETOSAPP_OBJECT.unit_id
  is '所属单位ID';
comment on column TA_OA_DETOSAPP_OBJECT.unit_name
  is '所属单位名称';

    -- Add/modify columns 
alter table TA_OA_DETOSAPREPAIR add unit_id varchar2(50);
alter table TA_OA_DETOSAPREPAIR add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_DETOSAPREPAIR.unit_id
  is '所属单位ID';
comment on column TA_OA_DETOSAPREPAIR.unit_name
  is '所属单位名称';

   -- Add/modify columns 
alter table TA_OA_DETOSEXA_OBJECT add unit_id varchar2(50);
alter table TA_OA_DETOSEXA_OBJECT add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_DETOSEXA_OBJECT.unit_id
  is '所属单位ID';
comment on column TA_OA_DETOSEXA_OBJECT.unit_name
  is '所属单位名称';

     -- Add/modify columns 
alter table TA_OA_DETHAVA_OBJECT add unit_id varchar2(50);
alter table TA_OA_DETHAVA_OBJECT add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_DETHAVA_OBJECT.unit_id
  is '所属单位ID';
comment on column TA_OA_DETHAVA_OBJECT.unit_name
  is '所属单位名称';
 /**************************************检测耗材业务表中添加所属单位名称与所属单位id add by jiao.chen 2016-03-03 end  *******************************/
 
 /**************************************食堂物品业务表中添加所属单位名称与所属单位id add by jiao.chen 2016-03-03 start*******************************/ 
-- Add/modify columns 
alter table TA_OA_CANOSUPPLIETYPE add unit_id varchar2(50);
alter table TA_OA_CANOSUPPLIETYPE add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_CANOSUPPLIETYPE.unit_id
  is '所属单位ID';
comment on column TA_OA_CANOSUPPLIETYPE.unit_name
  is '所属单位名称';

  -- Add/modify columns 
alter table TA_OA_CANOSUPPLIEUSETYPE add unit_id varchar2(50);
alter table TA_OA_CANOSUPPLIEUSETYPE add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_CANOSUPPLIEUSETYPE.unit_id
  is '所属单位ID';
comment on column TA_OA_CANOSUPPLIEUSETYPE.unit_name
  is '所属单位名称';

  -- Add/modify columns 
alter table TA_OA_CANOSUSERTYPEITEM add unit_id varchar2(50);
alter table TA_OA_CANOSUSERTYPEITEM add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_CANOSUSERTYPEITEM.unit_id
  is '所属单位ID';
comment on column TA_OA_CANOSUSERTYPEITEM.unit_name
  is '所属单位名称';

  -- Add/modify columns 
alter table TA_OA_CANOSAPP_OBJECT add unit_id varchar2(50);
alter table TA_OA_CANOSAPP_OBJECT add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_CANOSAPP_OBJECT.unit_id
  is '所属单位ID';
comment on column TA_OA_CANOSAPP_OBJECT.unit_name
  is '所属单位名称';

    -- Add/modify columns 
alter table TA_OA_CANOSAPREPAIR add unit_id varchar2(50);
alter table TA_OA_CANOSAPREPAIR add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_CANOSAPREPAIR.unit_id
  is '所属单位ID';
comment on column TA_OA_CANOSAPREPAIR.unit_name
  is '所属单位名称';

   -- Add/modify columns 
alter table TA_OA_CANOSEXA_OBJECT add unit_id varchar2(50);
alter table TA_OA_CANOSEXA_OBJECT add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_CANOSEXA_OBJECT.unit_id
  is '所属单位ID';
comment on column TA_OA_CANOSEXA_OBJECT.unit_name
  is '所属单位名称';

     -- Add/modify columns 
alter table TA_OA_CANHAVA_OBJECT add unit_id varchar2(50);
alter table TA_OA_CANHAVA_OBJECT add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_CANHAVA_OBJECT.unit_id
  is '所属单位ID';
comment on column TA_OA_CANHAVA_OBJECT.unit_name
  is '所属单位名称';
  
  -- Add/modify columns 
alter table TA_OA_LANDHOUSEITEM add unit_id varchar2(50);
alter table TA_OA_LANDHOUSEITEM add unit_name varchar2(100);
-- Add comments to the columns 
comment on column TA_OA_LANDHOUSEITEM.unit_id
  is '所属单位ID';
comment on column TA_OA_LANDHOUSEITEM.unit_name
  is '所属单位名称';
 /**************************************食堂物品业务表中添加所属单位名称与所属单位id add by jiao.chen 2016-03-03 end  *******************************/ 
 
 /**************************************图书管理表与车俩管理中添加所属单位名称与所属单位id add by jiao.chen 2016-03-07 start  *******************************/
 -- Add/modify columns 
alter table CZT_IBRARYTREE add unit_id varchar2(50);
alter table CZT_IBRARYTREE add unit_name varchar2(100);
-- Add comments to the columns 
comment on column CZT_IBRARYTREE.unit_id
  is '所属单位ID';
comment on column CZT_IBRARYTREE.unit_name
  is '所属单位名称'; 
  
    -- Add/modify columns 
alter table YMJ_OA_CARMANAGE_CAR add unit_id varchar2(50);
alter table YMJ_OA_CARMANAGE_CAR add unit_name varchar2(100);
-- Add comments to the columns 
comment on column YMJ_OA_CARMANAGE_CAR.unit_id
  is '所属单位ID';
comment on column YMJ_OA_CARMANAGE_CAR.unit_name
  is '所属单位名称';
 /**************************************图书管理表与车俩管理中添加所属单位名称与所属单位id add by jiao.chen 2016-03-07   end  *******************************/ 
 