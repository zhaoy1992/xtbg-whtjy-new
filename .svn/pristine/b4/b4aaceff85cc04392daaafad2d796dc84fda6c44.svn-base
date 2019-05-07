/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-8-23 10:19:09                           */
/*==============================================================*/


drop table oa_data_data cascade constraints;

drop table oa_data_type cascade constraints;

/*==============================================================*/
/* Table: oa_data_data                                          */
/*==============================================================*/
create table oa_data_data 
(
   d_data_id            VARCHAR2(40)         not null,
   d_data_name          VARCHAR2(200)        not null,
   d_data_code          VARCHAR2(40)         not null,
   d_type_id            VARCHAR2(40)         not null,
   d_type_name          VARCHAR2(200)        not null,
   d_data_secrecy_id    VARCHAR2(40),
   d_data_unit_id       VARCHAR2(40),
   d_data_unit_name     VARCHAR2(200),
   d_data_dept_id       VARCHAR2(40),
   d_data_dept_name     VARCHAR2(200),
   d_data_content       clob,
   d_data_create_time   DATE,
   d_data_user_id       VARCHAR2(40),
   d_data_user_name     VARCHAR2(40),
   d_data_attach        VARCHAR2(100),
   d_data_put_time      DATE,
   constraint PK_OA_DATA_DATA primary key (d_data_id)
);

comment on table oa_data_data is
'���������Ϣ��';

comment on column oa_data_data.d_data_id is
'����id';

comment on column oa_data_data.d_data_name is
'���ϱ���';

comment on column oa_data_data.d_data_code is
'���ϱ��';

comment on column oa_data_data.d_type_id is
'�������id';

comment on column oa_data_data.d_type_name is
'����������';

comment on column oa_data_data.d_data_secrecy_id is
'�ܼ�id';

comment on column oa_data_data.d_data_unit_id is
'����λid';

comment on column oa_data_data.d_data_unit_name is
'����λ���';

comment on column oa_data_data.d_data_dept_id is
'������id';

comment on column oa_data_data.d_data_dept_name is
'���������';

comment on column oa_data_data.d_data_content is
'��������';

comment on column oa_data_data.d_data_create_time is
'�Ǽ�����';

comment on column oa_data_data.d_data_user_id is
'�Ǽ���id';

comment on column oa_data_data.d_data_user_name is
'�Ǽ������';

comment on column oa_data_data.d_data_attach is
'����id';

comment on column oa_data_data.d_data_put_time is
'�ļ��γ�����';

/*==============================================================*/
/* Table: oa_data_type                                          */
/*==============================================================*/
create table oa_data_type 
(
   d_type_id            VARCHAR2(40)         not null,
   d_type_name          VARCHAR2(200)        not null,
   d_type_unit_id       VARCHAR2(40),
   d_type_unit_name     VARCHAR2(200),
   d_type_parent_id     VARCHAR2(40),
   d_type_level         NUMBER               not null,
   d_type_order         NUMBER,
   d_type_remark        VARCHAR2(1000),
   d_type_user_id       VARCHAR2(40),
   d_type_user_name     VARCHAR2(40),
   d_type_create_time   DATE,
   constraint PK_OA_DATA_TYPE primary key (d_type_id)
);

comment on table oa_data_type is
'���Ϸ������';

comment on column oa_data_type.d_type_id is
'���Ϸ���ID';

comment on column oa_data_type.d_type_name is
'�������';

comment on column oa_data_type.d_type_unit_id is
'����λID';

comment on column oa_data_type.d_type_unit_name is
'����λ���';

comment on column oa_data_type.d_type_parent_id is
'�����ϼ�����';

comment on column oa_data_type.d_type_level is
'������';

comment on column oa_data_type.d_type_order is
'�����';

comment on column oa_data_type.d_type_remark is
'��ע';

comment on column oa_data_type.d_type_user_id is
'�Ǽ���id';

comment on column oa_data_type.d_type_user_name is
'�Ǽ�������';

comment on column oa_data_type.d_type_create_time is
'�Ǽ�ʱ��';

alter table OA_DATA_TYPE modify d_type_remark VARCHAR2(2000);

alter table OA_DATA_DATA modify d_data_code null;