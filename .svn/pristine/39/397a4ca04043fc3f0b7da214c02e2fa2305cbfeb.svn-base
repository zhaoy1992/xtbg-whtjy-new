--专家库管理Create table 
create table TA_OA_REVIEW_USER
(
  RU_ID          VARCHAR2(40) not null,
  RU_NAME        VARCHAR2(100),
  RU_TYPE        VARCHAR2(200),
  RU_PROFESS     VARCHAR2(100),
  RU_USERID      VARCHAR2(100),
  RU_CREATORTIME DATE
);
-- Add comments to the columns 
comment on column TA_OA_REVIEW_USER.RU_ID
  is '主键ID';
comment on column TA_OA_REVIEW_USER.RU_NAME
  is '专家名称';
comment on column TA_OA_REVIEW_USER.RU_TYPE
  is '专业类别';
comment on column TA_OA_REVIEW_USER.RU_PROFESS
  is '职称级别';
comment on column TA_OA_REVIEW_USER.RU_USERID
  is '专家ID';
comment on column TA_OA_REVIEW_USER.RU_CREATORTIME
  is '创建时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_REVIEW_USER
  add constraint PK_TA_OA_REVIEW_USER_ID primary key (RU_ID);
  
  
--评审记录管理Create table
create table TA_OA_REVIEWINFO
(
  R_ID          VARCHAR2(40) not null,
  R_CREATORTIME DATE,
  R_REVIEWTIME  DATE,
  R_ORGNAME     VARCHAR2(200),
  R_CONTENT     VARCHAR2(1000),
  R_USERID      VARCHAR2(1000),
  R_USERNAME    VARCHAR2(1000)
);
-- Add comments to the columns 
comment on column TA_OA_REVIEWINFO.R_ID
  is '主键ID';
comment on column TA_OA_REVIEWINFO.R_CREATORTIME
  is '添加时间';
comment on column TA_OA_REVIEWINFO.R_REVIEWTIME
  is '评审时间';
comment on column TA_OA_REVIEWINFO.R_ORGNAME
  is '评审单位名称';
comment on column TA_OA_REVIEWINFO.R_CONTENT
  is '评审内容';
comment on column TA_OA_REVIEWINFO.R_USERID
  is '参评专家ID';
comment on column TA_OA_REVIEWINFO.R_USERNAME
  is '参评专家名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_REVIEWINFO
  add constraint PK_TA_OA_REVIEWINFO_ID primary key (R_ID);

