/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-8-22 11:04:08                           */
/*==============================================================*/


alter table oa_persondata_base
   drop primary key cascade;

drop table oa_persondata_base cascade constraints;

alter table oa_persondata_type
   drop primary key cascade;

drop table oa_persondata_type cascade constraints;

/*==============================================================*/
/* Table: oa_persondata_base                                    */
/*==============================================================*/
create table oa_persondata_base 
(
   p_data_id            varchar2(40)         not null,
   p_data_title         varchar2(200)        not null,
   p_data_code          varchar2(40),
   p_type_id            varchar2(40)         not null,
   p_unit_d             varchar2(40)         not null,
   p_unit_name          varchar2(200)        not null,
   p_remark             varchar2(4000),
   p_creater_time       date                 not null,
   p_creater_userid     varchar2(40)         not null,
   p_creater_username   varchar2(40)         not null,
   p_creater_orgid      varchar2(40)         not null,
   p_creater_orgname    varchar2(200)        not null,
   p_attach_id          varchar2(1000),
   P_FILE_TIME          DATE
);

comment on table oa_persondata_base is
'�������ϻ���Ϣ��';

comment on column oa_persondata_base.p_data_id is
'����ID';

comment on column oa_persondata_base.p_data_title is
'����';

comment on column oa_persondata_base.p_data_code is
'���';

comment on column oa_persondata_base.p_type_id is
'�������ID';

comment on column oa_persondata_base.p_unit_d is
'����λID';

comment on column oa_persondata_base.p_unit_name is
'����λ���';

comment on column oa_persondata_base.p_remark is
'��ע';

comment on column oa_persondata_base.p_creater_time is
'�Ǽ�����';

comment on column oa_persondata_base.p_creater_userid is
'�Ǽ���ID';

comment on column oa_persondata_base.p_creater_username is
'�Ǽ�������';

comment on column oa_persondata_base.p_creater_orgid is
'�Ǽ���������ID';

comment on column oa_persondata_base.p_creater_orgname is
'�Ǽ������������';

comment on column oa_persondata_base.p_attach_id is
'����ID';

alter table oa_persondata_base
   add constraint PK_OA_PERSONDATA_BASE primary key (p_data_id);

/*==============================================================*/
/* Table: oa_persondata_type                                    */
/*==============================================================*/
create table oa_persondata_type 
(
   p_type_id            varchar2(40)         not null,
   p_type_name          varchar2(200)        not null,
   p_type_unit          varchar2(40)         not null,
   p_type_parentid      varchar2(40),
   p_type_order         INTEGER              not null,
   p_remark             varchar2(1000),
   p_creater_Userid     varchar2(40)         not null,
   p_creater_Username   varchar2(40)         not null,
   p_creater_time       date                 not null
);

comment on table oa_persondata_type is
'���Ϸ���';

comment on column oa_persondata_type.p_type_id is
'����ID';

comment on column oa_persondata_type.p_type_name is
'�������';

comment on column oa_persondata_type.p_type_unit is
'��������ĵ�λID';

comment on column oa_persondata_type.p_type_parentid is
'�����ϼ�����';

comment on column oa_persondata_type.p_type_order is
'�����';

comment on column oa_persondata_type.p_remark is
'��ע';

comment on column oa_persondata_type.p_creater_Userid is
'�Ǽ���ID';

comment on column oa_persondata_type.p_creater_Username is
'�Ǽ�����';

comment on column oa_persondata_type.p_creater_time is
'�Ǽ�ʱ��';

alter table oa_persondata_type
   add constraint PK_OA_PERSONDATA_TYPE primary key (p_type_id);

-- Add/modify columns 
alter table OA_PERSONDATA_BASE add P_DOCMENT_ID VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_PERSONDATA_BASE.P_DOCMENT_ID
  is '正文ID';