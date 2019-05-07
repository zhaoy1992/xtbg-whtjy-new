drop table OA_LEADERSCHEDULE cascade constraints;
-- Create table
create table OA_LEADERSCHEDULE
(
  LEADERSCHEDULE_ID VARCHAR2(50),
  THEME             VARCHAR2(1024),
  ADDRESS           VARCHAR2(200),
  IMPORTANT_LEVEL   VARCHAR2(10),
  WEATHER           VARCHAR2(10),
  STARTTIME         VARCHAR2(40),
  ENDTIME           VARCHAR2(40),
  STATION_TYPE      VARCHAR2(10),
  REMIND_FLAG       VARCHAR2(5),
  REMIND_STARTTIME  VARCHAR2(20),
  REMIND_ENDTIME    VARCHAR2(20),
  REMIND_INTERVAL   VARCHAR2(10),
  REMIND_TYPE       VARCHAR2(5),
  SCHDULE_DESCRIBE  VARCHAR2(2048),
  LEADER_NAME       VARCHAR2(2048),
  LEADER_USERID     VARCHAR2(2048),
  ORG_ID            VARCHAR2(50),
  ORG_NAME          VARCHAR2(50),
  TIME_UNIT         VARCHAR2(10),
  CREATETIME        DATE
);
-- Add comments to the table 
comment on table OA_LEADERSCHEDULE
  is '领导日程主信息表';
-- Add comments to the columns 
comment on column OA_LEADERSCHEDULE.LEADERSCHEDULE_ID
  is '日程主键ID';
comment on column OA_LEADERSCHEDULE.THEME
  is '主题';
comment on column OA_LEADERSCHEDULE.ADDRESS
  is '地址';
comment on column OA_LEADERSCHEDULE.IMPORTANT_LEVEL
  is '重要级别';
comment on column OA_LEADERSCHEDULE.WEATHER
  is '天气';
comment on column OA_LEADERSCHEDULE.STARTTIME
  is '日程开始时间';
comment on column OA_LEADERSCHEDULE.ENDTIME
  is '日程结束时间';
comment on column OA_LEADERSCHEDULE.STATION_TYPE
  is '在岗状态';
comment on column OA_LEADERSCHEDULE.REMIND_FLAG
  is '提醒标记';
comment on column OA_LEADERSCHEDULE.REMIND_STARTTIME
  is '提醒开始时间';
comment on column OA_LEADERSCHEDULE.REMIND_ENDTIME
  is '提醒结束时间';
comment on column OA_LEADERSCHEDULE.REMIND_INTERVAL
  is '提醒间隔';
comment on column OA_LEADERSCHEDULE.REMIND_TYPE
  is '提醒类型';
comment on column OA_LEADERSCHEDULE.SCHDULE_DESCRIBE
  is '日程描述';
comment on column OA_LEADERSCHEDULE.LEADER_NAME
  is '领导姓名';
comment on column OA_LEADERSCHEDULE.LEADER_USERID
  is '领导用户ID';
comment on column OA_LEADERSCHEDULE.ORG_ID
  is '当前用户的机构ID';
comment on column OA_LEADERSCHEDULE.ORG_NAME
  is '当前用户的机构名称';
comment on column OA_LEADERSCHEDULE.TIME_UNIT
  is '时间间隔单位;  如"分" "时" "天"';
comment on column OA_LEADERSCHEDULE.CREATETIME
  is '创建时间';

drop table OA_LEADERSCHEDULE_LOG cascade constraints;
-- Create table
create table OA_LEADERSCHEDULE_LOG
(
  LEADERSCHEDULE_ID VARCHAR2(50),
  THEME             VARCHAR2(1024),
  ADDRESS           VARCHAR2(200),
  IMPORTANT_LEVEL   VARCHAR2(10),
  WEATHER           VARCHAR2(10),
  STARTTIME         VARCHAR2(40),
  ENDTIME           VARCHAR2(40),
  STATION_TYPE      VARCHAR2(10),
  REMIND_FLAG       VARCHAR2(5),
  REMIND_STARTTIME  VARCHAR2(20),
  REMIND_ENDTIME    VARCHAR2(20),
  REMIND_INTERVAL   VARCHAR2(10),
  REMIND_TYPE       VARCHAR2(5),
  SCHDULE_DESCRIBE  VARCHAR2(2048),
  LEADER_NAME       VARCHAR2(2048),
  LEADER_USERID     VARCHAR2(2048),
  ORG_ID            VARCHAR2(50),
  EDIT_USER_NAME    VARCHAR2(50),
  TIME_UNIT         VARCHAR2(10),
  EDITTIME          DATE,
  EDITTYPE          VARCHAR2(40)
);
-- Add comments to the table 
comment on table OA_LEADERSCHEDULE_LOG
  is '领导日程日志表';
-- Add comments to the columns 
comment on column OA_LEADERSCHEDULE_LOG.LEADERSCHEDULE_ID
  is '日程主键ID';
comment on column OA_LEADERSCHEDULE_LOG.THEME
  is '主题';
comment on column OA_LEADERSCHEDULE_LOG.ADDRESS
  is '地址';
comment on column OA_LEADERSCHEDULE_LOG.IMPORTANT_LEVEL
  is '重要级别';
comment on column OA_LEADERSCHEDULE_LOG.WEATHER
  is '天气';
comment on column OA_LEADERSCHEDULE_LOG.STARTTIME
  is '日程开始时间';
comment on column OA_LEADERSCHEDULE_LOG.ENDTIME
  is '日程结束时间';
comment on column OA_LEADERSCHEDULE_LOG.STATION_TYPE
  is '在岗状态';
comment on column OA_LEADERSCHEDULE_LOG.REMIND_FLAG
  is '提醒标记';
comment on column OA_LEADERSCHEDULE_LOG.REMIND_STARTTIME
  is '提醒开始时间';
comment on column OA_LEADERSCHEDULE_LOG.REMIND_ENDTIME
  is '提醒结束时间';
comment on column OA_LEADERSCHEDULE_LOG.REMIND_INTERVAL
  is '提醒间隔';
comment on column OA_LEADERSCHEDULE_LOG.REMIND_TYPE
  is '提醒类型';
comment on column OA_LEADERSCHEDULE_LOG.SCHDULE_DESCRIBE
  is '日程描述';
comment on column OA_LEADERSCHEDULE_LOG.LEADER_NAME
  is '领导姓名';
comment on column OA_LEADERSCHEDULE_LOG.LEADER_USERID
  is '领导用户ID';
comment on column OA_LEADERSCHEDULE_LOG.ORG_ID
  is '当前用户的机构ID';
comment on column OA_LEADERSCHEDULE_LOG.EDIT_USER_NAME
  is '当前用户的机构名称';
comment on column OA_LEADERSCHEDULE_LOG.TIME_UNIT
  is '时间间隔单位;  如"分" "时" "天"';
comment on column OA_LEADERSCHEDULE_LOG.EDITTIME
  is '修改时间';
comment on column OA_LEADERSCHEDULE_LOG.EDITTYPE
  is '修改类型';
