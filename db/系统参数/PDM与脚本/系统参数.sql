/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-7-22 10:52:48                           */
/*==============================================================*/


alter table oa_sys_param
   drop primary key cascade;

drop table oa_sys_param cascade constraints;

alter table oa_sys_paramvalue
   drop primary key cascade;

drop table oa_sys_paramvalue cascade constraints;

/*==============================================================*/
/* Table: oa_sys_param                                          */
/*==============================================================*/
create table oa_sys_param 
(
   p_id                 VARCHAR2(50)         not null,
   p_type            	VARCHAR2(50),
   p_code               VARCHAR2(100)        not null,
   p_name               VARCHAR2(100),
   p_content            VARCHAR2(1000)       not null,
   p_valid              char(1),
   p_creator_time       DATE,
   p_isupdate           char(1),
   dictdata_id          VARCHAR2(50)         not null,
   p_remark             VARCHAR2(1000)
);

comment on table oa_sys_param is
'系统参数表';

comment on column oa_sys_param.p_id is
'参数主键ID';

comment on column oa_sys_param.p_type is
'参数类型';

comment on column oa_sys_param.p_code is
'参数编号';

comment on column oa_sys_param.p_name is
'参数名称';

comment on column oa_sys_param.p_content is
'参数内容';

comment on column oa_sys_param.p_valid is
'是否有效';

comment on column oa_sys_param.p_creator_time is
'创建时间';

comment on column oa_sys_param.p_isupdate is
'是否可修改';

comment on column oa_sys_param.dictdata_id is
'字典数据ID';

comment on column oa_sys_param.p_remark is
'参数描述';

alter table oa_sys_param
   add constraint CKC_P_VALID_OA_SYS_P check (p_valid is null or (p_valid in ('1','0')));

alter table oa_sys_param
   add constraint CKC_P_ISUPDATE_OA_SYS_P check (p_isupdate is null or (p_isupdate in ('1','0')));

alter table oa_sys_param
   add constraint PK_OA_SYS_PARAM primary key (p_id);

/*==============================================================*/
/* Table: oa_sys_paramvalue                                     */
/*==============================================================*/
create table oa_sys_paramvalue 
(
   p_value_id           VARCHAR2(50)         not null,
   p_code               VARCHAR2(100)        not null,
   p_value_code         VARCHAR2(100)        not null,
   p_value_name         VARCHAR2(100),
   p_value_valid        char(1),
   p_creator_time       DATE
);

comment on table oa_sys_paramvalue is
'动态参数值';

comment on column oa_sys_paramvalue.p_value_id is
'参数值主键ID';

comment on column oa_sys_paramvalue.p_code is
'参数编号';

comment on column oa_sys_paramvalue.p_value_code is
'参数值编号';

comment on column oa_sys_paramvalue.p_value_name is
'参数值名称';

comment on column oa_sys_paramvalue.p_value_valid is
'参数值是否有效';

comment on column oa_sys_paramvalue.p_creator_time is
'创建时间';

alter table oa_sys_paramvalue
   add constraint CKC_P_VALUE_VALID_OA_SYS_P check (p_value_valid is null or (p_value_valid in ('1','0')));

alter table oa_sys_paramvalue
   add constraint PK_OA_SYS_PARAMVALUE primary key (p_value_id);

