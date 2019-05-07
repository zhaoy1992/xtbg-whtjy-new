drop table ta_oa_whtjy_gdzc cascade constraints;

/*==============================================================*/
/* Table: ta_oa_whtjy_gdzc                                    */
/*==============================================================*/
create table ta_oa_whtjy_gdzc  (
   id                 varchar2(50)                    not null,
   internal_no        varchar2(50),
   num                varchar2(50),
   name               varchar2(200),
   type_id            varchar2(50),
   type_name          varchar2(200),
   address            varchar2(200),
   area               varchar2(50),
   ownership_no       varchar2(200),
   fazheng_date       DATE,
   it                 varchar2(200),
   manufacturer       varchar2(2000),
   body_no            varchar2(200),
   bar_code           varchar2(200),
   finance_no         varchar2(200),
   original_value     varchar2(200),
   buy_time           DATE,
   user_id            varchar2(50),
   user_name          varchar2(200),
   org_id             varchar2(50),
   org_name           varchar2(200),
   use_date           DATE,
   location_place     varchar2(200),
   this_calibration_time DATE,
   next_calibration_time DATE,
   is_allocation      varchar2(1)                    default 0,
   is_lease           varchar2(1)                    default 0,
   allocation_place   varchar2(200),
   lease_place        varchar2(200),
   allocation_date    DATE,
   lease_date         DATE,
   state              varchar2(50),
   dealt              varchar2(50),
   dealt_date         DATE,
   location_id        varchar2(50),
   location_name      varchar2(200),
   location_org_id    varchar2(50),
   location_org       varchar2(200),
   classify           varchar2(1),
   constraint PK_TA_OA_WHTJY_GDZC primary key (id)
);

comment on table ta_oa_whtjy_gdzc is
'�̶��ʲ���';

comment on column ta_oa_whtjy_gdzc.id is
'����id';

comment on column ta_oa_whtjy_gdzc.internal_no is
'�ڲ����';

comment on column ta_oa_whtjy_gdzc.num is
'���';

comment on column ta_oa_whtjy_gdzc.name is
'����';

comment on column ta_oa_whtjy_gdzc.type_id is
'���id';

comment on column ta_oa_whtjy_gdzc.type_name is
'�����';

comment on column ta_oa_whtjy_gdzc.address is
'��ַ';

comment on column ta_oa_whtjy_gdzc.area is
'���';

comment on column ta_oa_whtjy_gdzc.ownership_no is
'Ȩ��֤��';

comment on column ta_oa_whtjy_gdzc.fazheng_date is
'��֤ʱ��';

comment on column ta_oa_whtjy_gdzc.it is
'�ͺŹ��';

comment on column ta_oa_whtjy_gdzc.manufacturer is
'��������';

comment on column ta_oa_whtjy_gdzc.body_no is
'�����';

comment on column ta_oa_whtjy_gdzc.bar_code is
'������';

comment on column ta_oa_whtjy_gdzc.finance_no is
'�������';

comment on column ta_oa_whtjy_gdzc.original_value is
'ԭֵ';

comment on column ta_oa_whtjy_gdzc.buy_time is
'����ʱ��';

comment on column ta_oa_whtjy_gdzc.user_id is
'������id';

comment on column ta_oa_whtjy_gdzc.user_name is
'��������';

comment on column ta_oa_whtjy_gdzc.org_id is
'���ò���id';

comment on column ta_oa_whtjy_gdzc.org_name is
'���ò���';

comment on column ta_oa_whtjy_gdzc.use_date is
'����ʱ��';

comment on column ta_oa_whtjy_gdzc.location_place is
'���õص�';

comment on column ta_oa_whtjy_gdzc.this_calibration_time is
'����У׼����';

comment on column ta_oa_whtjy_gdzc.next_calibration_time is
'�´�У׼����';

comment on column ta_oa_whtjy_gdzc.is_allocation is
'�Ƿ���� 0��1��';

comment on column ta_oa_whtjy_gdzc.is_lease is
'�Ƿ���� 0��1��';

comment on column ta_oa_whtjy_gdzc.allocation_place is
'�����ص�';

comment on column ta_oa_whtjy_gdzc.lease_place is
'����ص�';

comment on column ta_oa_whtjy_gdzc.allocation_date is
'��������';

comment on column ta_oa_whtjy_gdzc.lease_date is
'��������';

comment on column ta_oa_whtjy_gdzc.state is
'״̬';

comment on column ta_oa_whtjy_gdzc.dealt is
'���÷�ʽ';

comment on column ta_oa_whtjy_gdzc.dealt_date is
'��������';

comment on column ta_oa_whtjy_gdzc.location_id is
'���ڵ�id';

comment on column ta_oa_whtjy_gdzc.location_name is
'���ڵ���';

comment on column ta_oa_whtjy_gdzc.location_org_id is
'���ڲ���id';

comment on column ta_oa_whtjy_gdzc.location_org is
'���ڲ���';

comment on column ta_oa_whtjy_gdzc.classify is
'����1.�칫�豸��2.�����豸��3.���ط��ݡ�4.������5.�������ʡ�6.�Ҿߡ�7.����';



---------------------------------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_WHTJY_GDZC add state_id varchar2(50);
-- Add comments to the columns 
comment on column TA_OA_WHTJY_GDZC.state_id
  is '״̬id';
----------------------------------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_WHTJY_GDZC add color varchar2(50);
alter table TA_OA_WHTJY_GDZC add vin_number varchar2(200);
alter table TA_OA_WHTJY_GDZC add engine_number varchar2(200);
alter table TA_OA_WHTJY_GDZC add car_number varchar2(50);
alter table TA_OA_WHTJY_GDZC add displacement varchar2(50);
-- Add comments to the columns 
comment on column TA_OA_WHTJY_GDZC.color
  is '��ɫ';
comment on column TA_OA_WHTJY_GDZC.vin_number
  is '���ܺ�';
comment on column TA_OA_WHTJY_GDZC.engine_number
  is '��������';
comment on column TA_OA_WHTJY_GDZC.car_number
  is '���ƺ�';
comment on column TA_OA_WHTJY_GDZC.displacement
  is '����';
  
----------------------------------------------------------------------------------------------
drop table ta_oa_whtjy_gdzc_history cascade constraints;

/*==============================================================*/
/* Table: ta_oa_whtjy_gdzc_history                            */
/*==============================================================*/
create table ta_oa_whtjy_gdzc_history  (
   id                 varchar2(50)                    not null,
   gdzc_id            varchar2(50),
   gdzc_name          varchar2(200),
   user_id            varchar2(50),
   user_name          varchar2(200),
   org_id             varchar2(50),
   org_name           varchar2(200),
   use_type           varchar2(200),
   user_date          DATE,
   constraint PK_TA_OA_WHTJY_GDZC_HISTORY primary key (id)
);

comment on table ta_oa_whtjy_gdzc_history is
'�̶��ʲ���ʷʹ�ü�¼';

comment on column ta_oa_whtjy_gdzc_history.id is
'����id';

comment on column ta_oa_whtjy_gdzc_history.gdzc_id is
'�̶��ʲ�id';

comment on column ta_oa_whtjy_gdzc_history.gdzc_name is
'�̶��ʲ���Ʒ��';

comment on column ta_oa_whtjy_gdzc_history.user_id is
'ʹ����id';

comment on column ta_oa_whtjy_gdzc_history.user_name is
'ʹ������';

comment on column ta_oa_whtjy_gdzc_history.org_id is
'ʹ�ò���id';

comment on column ta_oa_whtjy_gdzc_history.org_name is
'ʹ�ò�����';

comment on column ta_oa_whtjy_gdzc_history.use_type is
'ʹ������(����/����/�黹��)';

comment on column ta_oa_whtjy_gdzc_history.user_date is
'ʹ��ʱ��';
----------------------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_WHTJY_GDZC_HISTORY add ghdj_id varchar2(50);
-- Add comments to the columns 
comment on column TA_OA_WHTJY_GDZC_HISTORY.ghdj_id
  is '�黹�ǼǱ�id';
-------------------------------------------------------------------------------------
drop table ta_oa_whtjy_gdzc_manager cascade constraints;

/*==============================================================*/
/* Table: ta_oa_whtjy_gdzc_manager                            */
/*==============================================================*/
create table ta_oa_whtjy_gdzc_manager  (
   m_id               varchar2(50)                    not null,
   m_type             varchar2(200),
   use_date           DATE,
   user_id            varchar2(50),
   user_name          varchar2(200),
   org_id             varchar2(50),
   org_name           varchar2(200),
   register_user_id   varchar2(50),
   register_user_name varchar2(200),
   register_date      DATE,
   constraint PK_TA_OA_WHTJY_GDZC_MANAGER primary key (m_id)
);

comment on table ta_oa_whtjy_gdzc_manager is
'�̶��ʲ�ʹ�ù����';

comment on column ta_oa_whtjy_gdzc_manager.m_id is
'����id';

comment on column ta_oa_whtjy_gdzc_manager.m_type is
'��������(����/���ù黹��)';

comment on column ta_oa_whtjy_gdzc_manager.use_date is
'ʹ��ʱ��';

comment on column ta_oa_whtjy_gdzc_manager.user_id is
'ʹ����id';

comment on column ta_oa_whtjy_gdzc_manager.user_name is
'ʹ������';

comment on column ta_oa_whtjy_gdzc_manager.org_id is
'ʹ�ò���id';

comment on column ta_oa_whtjy_gdzc_manager.org_name is
'ʹ�ò���';

comment on column ta_oa_whtjy_gdzc_manager.register_user_id is
'�Ǽ���id';

comment on column ta_oa_whtjy_gdzc_manager.register_user_name is
'�Ǽ�����';

comment on column ta_oa_whtjy_gdzc_manager.register_date is
'�Ǽ�ʱ��';
------------------------------------------------------------------------------------
drop table ta_oa_whtjy_gdzc_details cascade constraints;

/*==============================================================*/
/* Table: ta_oa_whtjy_gdzc_details                              */
/*==============================================================*/
create table ta_oa_whtjy_gdzc_details  (
   id                 varchar2(50)                    not null,
   m_id               varchar2(50),
   internal_no        varchar2(200),
   gdzc_num           varchar2(200),
   gdzc_id            varchar2(50),
   gdzc_name          varchar2(200),
   bar_code           varchar2(200),
   body_no            varchar2(200),
   state              varchar2(200),
   constraint PK_TA_OA_WHTJY_GDZC_DETAILS primary key (id)
);

comment on table ta_oa_whtjy_gdzc_details is
'�̶��ʲ������嵥��
';

comment on column ta_oa_whtjy_gdzc_details.id is
'����id';

comment on column ta_oa_whtjy_gdzc_details.m_id is
'�����id';

comment on column ta_oa_whtjy_gdzc_details.internal_no is
'�ڲ����';

comment on column ta_oa_whtjy_gdzc_details.gdzc_num is
'���';

comment on column ta_oa_whtjy_gdzc_details.gdzc_id is
'�̶��ʲ�id';

comment on column ta_oa_whtjy_gdzc_details.gdzc_name is
'�̶��ʲ���';

comment on column ta_oa_whtjy_gdzc_details.bar_code is
'������';

comment on column ta_oa_whtjy_gdzc_details.body_no is
'�����';

comment on column ta_oa_whtjy_gdzc_details.state is
'״̬';
--------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_WHTJY_GDZC_MANAGER add gdzc_classify varchar2(50);
-- Add comments to the columns 
comment on column TA_OA_WHTJY_GDZC_MANAGER.gdzc_classify
  is '�ʲ����';
  
------------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_DEVISSUEDPLAN add plan_internal_no varchar2(50);
alter table TA_OA_DEVISSUEDPLAN add plan_title varchar2(200);
-- Add comments to the columns 
comment on column TA_OA_DEVISSUEDPLAN.plan_internal_no
  is '�ڲ����';
comment on column TA_OA_DEVISSUEDPLAN.plan_title
  is '�ƻ�����';
---------------------------------------------------------------------------
-- Create table
create table ta_oa_devissuedplan_detail
(
  id        varchar2(50) not null,
  plan_id   varchar2(50),
  sb_id     varchar2(50),
  last_date date
)
;
-- Add comments to the table 
comment on table ta_oa_devissuedplan_detail
  is '�����豸�嵥��';
-- Add comments to the columns 
comment on column ta_oa_devissuedplan_detail.id
  is '����id';
comment on column ta_oa_devissuedplan_detail.plan_id
  is '�����id';
comment on column ta_oa_devissuedplan_detail.sb_id
  is '�豸id';
comment on column ta_oa_devissuedplan_detail.last_date
  is '�ϴμ춨����';
--------------------------------------------------------------------------------
-- Add/modify columns 
alter table TA_OA_DEVAPPRAISAL add appr_method_id varchar2(50);
alter table TA_OA_DEVAPPRAISAL add appr_method varchar2(200);
alter table TA_OA_DEVAPPRAISAL add appr_result varchar2(50);
alter table TA_OA_DEVAPPRAISAL add next_appr_time date;
-- Add comments to the columns 
comment on column TA_OA_DEVAPPRAISAL.appr_method_id
  is '�춨��ʽid';
comment on column TA_OA_DEVAPPRAISAL.appr_method
  is '�춨��ʽ';
comment on column TA_OA_DEVAPPRAISAL.appr_result
  is '�춨���';
comment on column TA_OA_DEVAPPRAISAL.next_appr_time
  is '�´μ춨����';
----------------------------------------------------------------------------------
--��ձ�
delete from TA_OA_DEVSCRAP;

delete from ta_oa_devissuedplan;

delete from ta_oa_devappraisal;

delete from ta_oa_devtakcare;


