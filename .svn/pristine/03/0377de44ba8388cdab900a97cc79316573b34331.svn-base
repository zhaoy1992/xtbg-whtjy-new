-- Create table
create table OA_NOTICE_REPORTAUDIT
(
  REPORT_ID       VARCHAR2(40) not null,
  NOTICE_ID       VARCHAR2(40),
  REPORT_VIEW     VARCHAR2(1000),
  REPORT_USERID   VARCHAR2(40),
  REPORT_USERNAME VARCHAR2(100),
  REPORT_UNITID   VARCHAR2(40),
  REPORT_UNITNAME VARCHAR2(100),
  REPORT_TIME     DATE default sysdate,
  REMARK1         VARCHAR2(40),
  REMARK2         VARCHAR2(100)
);
-- Add comments to the columns 
comment on column OA_NOTICE_REPORTAUDIT.REPORT_ID
  is '主键ID';
comment on column OA_NOTICE_REPORTAUDIT.NOTICE_ID
  is '通知公告主表ID';
comment on column OA_NOTICE_REPORTAUDIT.REPORT_VIEW
  is '评论意见';
comment on column OA_NOTICE_REPORTAUDIT.REPORT_USERID
  is '评论人ID';
comment on column OA_NOTICE_REPORTAUDIT.REPORT_USERNAME
  is '评论人名称';
comment on column OA_NOTICE_REPORTAUDIT.REPORT_UNITID
  is '评论人单位ID';
comment on column OA_NOTICE_REPORTAUDIT.REPORT_UNITNAME
  is '评论人单位名称';
comment on column OA_NOTICE_REPORTAUDIT.REPORT_TIME
  is '评论时间';
comment on column OA_NOTICE_REPORTAUDIT.REMARK1
  is '备注1';
comment on column OA_NOTICE_REPORTAUDIT.REMARK2
  is '备注2';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_NOTICE_REPORTAUDIT
  add constraint PK_OA_NOTICE_REPORTAUDIT_ID primary key (REPORT_ID);
