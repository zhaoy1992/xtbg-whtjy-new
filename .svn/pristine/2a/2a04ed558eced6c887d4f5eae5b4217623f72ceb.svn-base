/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-9-17 19:20:55                           */
/*==============================================================*/


drop table OA_RECENTLY_USER cascade constraints;

/*==============================================================*/
/* Table: OA_RECENTLY_USER                                      */
/*==============================================================*/
create table OA_RECENTLY_USER 
(
   ru_id                VARCHAR2(50)         not null,
   ru_logn              VARCHAR2(200)        not null,
   ru_type              VARCHAR2(2)          not null,
   ru_data              VARCHAR2(500),
   USER_ID              VARCHAR2(50),
   CREATER_TIME         DATE                 default sysdate,
   constraint PK_OA_RECENTLY_USER primary key (ru_id)
);

comment on table OA_RECENTLY_USER is
'最近处理人';

comment on column OA_RECENTLY_USER.ru_id is
'主键ID';

comment on column OA_RECENTLY_USER.ru_logn is
'操作标识';

comment on column OA_RECENTLY_USER.ru_type is
'数据类型(1人，2机构)';

comment on column OA_RECENTLY_USER.ru_data is
'数据';

comment on column OA_RECENTLY_USER.USER_ID is
'用户ID';

comment on column OA_RECENTLY_USER.CREATER_TIME is
'创建时间';

