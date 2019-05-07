alter table OA_SUBSYS_MANAGE
   drop primary key cascade;
alter table OA_SUBSYS_USEINFO
   drop primary key cascade;

drop table OA_SUBSYS_MANAGE cascade constraints;

drop table OA_SUBSYS_USEINFO cascade constraints;

/*==============================================================*/
/* Table: OA_SUBSYS_MANAGE                                      */
/*==============================================================*/
-- Create table
create table OA_SUBSYS_MANAGE
(
  SYS_ID       VARCHAR2(40) not null,
  SYS_NAME     VARCHAR2(200) not null,
  SYS_DESC     VARCHAR2(1000),
  SYS_URL      VARCHAR2(1000) not null,
  SYS_IMG_URL  VARCHAR2(1000),
  SYS_ISPUBLIC CHAR(1) default 'N' not null
);
-- Add comments to the table 
comment on table OA_SUBSYS_MANAGE
  is '首页子系统管理表';
-- Add comments to the columns 
comment on column OA_SUBSYS_MANAGE.SYS_ID
  is '系统主键';
comment on column OA_SUBSYS_MANAGE.SYS_NAME
  is '系统名称';
comment on column OA_SUBSYS_MANAGE.SYS_DESC
  is '系统描述';
comment on column OA_SUBSYS_MANAGE.SYS_URL
  is '系统访问路径';
comment on column OA_SUBSYS_MANAGE.SYS_IMG_URL
  is '系统对应图片路径';
comment on column OA_SUBSYS_MANAGE.SYS_ISPUBLIC
  is '是否为公共系统（Y:是，N:否）';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_SUBSYS_MANAGE
  add constraint PK_OA_SUBSYS_MANAGE primary key (SYS_ID)
;
   
   


/*==============================================================*/
/* Table: OA_SUBSYS_USEINFO                                     */
/*==============================================================*/
create table OA_SUBSYS_USEINFO 
(
   info_id              VARCHAR2(40)         not null,
   sys_id               VARCHAR2(40)         not null,
   user_id              VARCHAR2(40)         not null,
   sys_user_id          VARCHAR2(40),
   sys_user_password    VARCHAR2(40)
);

comment on table OA_SUBSYS_USEINFO is
'首页子系统用户应用情况表';

comment on column OA_SUBSYS_USEINFO.info_id is
'信息主键';

comment on column OA_SUBSYS_USEINFO.sys_id is
'子系统主键';

comment on column OA_SUBSYS_USEINFO.user_id is
'用户id';

comment on column OA_SUBSYS_USEINFO.sys_user_id is
'子系统对应用户id';

comment on column OA_SUBSYS_USEINFO.sys_user_password is
'子系统对应用户密码';

alter table OA_SUBSYS_USEINFO
   add constraint PK_OA_SUBSYS_USEINFO primary key (info_id);

