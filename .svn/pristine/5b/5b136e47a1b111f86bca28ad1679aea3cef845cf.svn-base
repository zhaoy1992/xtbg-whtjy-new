/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-7-17 16:37:30                           */
/*==============================================================*/


alter table oa_dict_data
   drop constraint FK_OA_DICT__REFERENCE_OA_DICT_;

alter table oa_dict_data
   drop primary key cascade;

drop table oa_dict_data cascade constraints;

alter table oa_dict_type
   drop primary key cascade;

drop table oa_dict_type cascade constraints;

/*==============================================================*/
/* Table: oa_dict_data                                          */
/*==============================================================*/
create table oa_dict_data 
(
   dictdata_id          VARCHAR2(50)         not null,
   dict_id              VARCHAR2(50),
   dictdata_parent_id   VARCHAR2(50),
   dictdata_name        VARCHAR2(100)        not null,
   dictdata_value      VARCHAR2(100)        not null,
   dictdata_remark      VARCHAR2(1000),
   dictdata_is_valid    char(1)              default '1' not null,
   dictdata_order       NUMBER
);

comment on table oa_dict_data is
'字典数据表';

comment on column oa_dict_data.dictdata_id is
'字典数据主键ID';

comment on column oa_dict_data.dict_id is
'字典主键ID';

comment on column oa_dict_data.dictdata_parent_id is
'字典数据父ID';

comment on column oa_dict_data.dictdata_name is
'字典数据名称';

comment on column oa_dict_data.dictdata_value is
'字典数据编号';

comment on column oa_dict_data.dictdata_remark is
'字典数据备注';

comment on column oa_dict_data.dictdata_is_valid is
'字典数据是否有效';

comment on column oa_dict_data.dictdata_order is
'字典数据排序';

alter table oa_dict_data
   add constraint CKC_DICTDATA_IS_VALID_OA_DICT_ check (dictdata_is_valid in ('1','0'));

alter table oa_dict_data
   add constraint PK_OA_DICT_DATA primary key (dictdata_id);

/*==============================================================*/
/* Table: oa_dict_type                                          */
/*==============================================================*/
create table oa_dict_type 
(
   dict_id              VARCHAR2(50)         not null,
   dict_parent_id       VARCHAR2(50),
   dict_name            VARCHAR2(100)        not null,
   dict_code            VARCHAR2(100)        not null,
   dict_remark          VARCHAR2(1000),
   dict_is_valid        char(1)              default '1' not null,
   dict_order           NUMBER,
   dict_type            char(1)              not null
);

comment on table oa_dict_type is
'字典类型表';

comment on column oa_dict_type.dict_id is
'字典主键ID';

comment on column oa_dict_type.dict_parent_id is
'字典父ID';

comment on column oa_dict_type.dict_name is
'字典名称';

comment on column oa_dict_type.dict_code is
'字典编号';

comment on column oa_dict_type.dict_remark is
'字典备注';

comment on column oa_dict_type.dict_is_valid is
'字典是否有效';

comment on column oa_dict_type.dict_order is
'字典排序';

comment on column oa_dict_type.dict_type is
'字典类型';

alter table oa_dict_type
   add constraint CKC_DICT_IS_VALID_OA_DICT_ check (dict_is_valid in ('1','0'));

alter table oa_dict_type
   add constraint CKC_DICT_TYPE_OA_DICT_ check (dict_type in ('0','1'));

alter table oa_dict_type
   add constraint PK_OA_DICT_TYPE primary key (dict_id);

alter table oa_dict_data
   add constraint FK_OA_DICT__REFERENCE_OA_DICT_ foreign key (dict_id)
      references oa_dict_type (dict_id);

