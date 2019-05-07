drop function getCountInfo
/

drop function oa_getorgalluser
/

drop table OA_ONLINETOP cascade constraints
/

drop table OA_USER_LOGININFO cascade constraints
/

/*==============================================================*/
/* Table: OA_ONLINETOP                                          */
/*==============================================================*/
create table OA_ONLINETOP 
(
   ID                   VARCHAR2(50)         not null,
   PERSONNUM            number,
   RECODE_TIME          DATE,
   constraint PK_OA_ONLINETOP primary key (ID)
)
/

comment on table OA_ONLINETOP is
'最高在线人数记录表'
/

/*==============================================================*/
/* Table: OA_USER_LOGININFO                                     */
/*==============================================================*/
create table OA_USER_LOGININFO 
(
   USERID               VARCHAR2(50)         not null,
   USERNAME             VARCHAR2(50),
   LOGINNUMBER          number,
   LASTLOGIN            DATE,
   LASTOUT              DATE,
   LASTLOGINIP          VARCHAR2(50),
   REMARK               VARCHAR2(50),
   constraint PK_OA_USER_LOGININFO primary key (USERID)
)
/

comment on table OA_USER_LOGININFO is
'用户登录信息表'
/

comment on column OA_USER_LOGININFO.USERID is
'用户id'
/

comment on column OA_USER_LOGININFO.USERNAME is
'用户名'
/

comment on column OA_USER_LOGININFO.LOGINNUMBER is
'登录次数'
/

comment on column OA_USER_LOGININFO.LASTLOGIN is
'最后登录时间'
/

comment on column OA_USER_LOGININFO.LASTOUT is
'最后退出时间'
/

comment on column OA_USER_LOGININFO.LASTLOGINIP is
'最后登录ip'
/

comment on column OA_USER_LOGININFO.REMARK is
'备用'
/


create or replace function getCountInfo(userid varchar2)
return varchar2 is
  waitsp      number;
  waitread    number;
  waitarchive number;
begin
  waitsp      := 0;
  waitread    := 0;
  waitarchive := 0;
  
  select count(*) 
  into waitsp
  from oa_meeting_notice             t,
       oa_meeting_room               r,
       oa_meeting_room_administrator a
 where a.m_room_id = r.m_room_id
   and t.m_room_id = r.m_room_id(+)
   and (t.m_check_flag = '0' OR t.m_check_flag = '2')
   and a.m_user_id = userid;
  
  select count(*)
  into waitread
  from oa_notice_baseinfo b, oa_notice_receiver_user r
 where r.n_notice_id = b.n_notice_id
   and b.n_state in (1, 2)
   and r.n_isdel != '1'
   and r.n_isview='0'
   and r.n_receiver_userid = userid;
   
   select count(*)
   into waitarchive
  from VIEW_OA_WORK_LIST t
 where t.username =
       (select u.user_name from td_sm_user u where u.user_id = userid);
       
  return(waitsp || ',' || waitread || ',' || waitarchive);
end getCountInfo;
/


create or replace function oa_getorgalluser(v_orgid varchar2)
return varchar2 is
  rs varchar2(4000);
  begin
   select wmsys.wm_concat(ou.user_id) into rs
   from td_sm_orguser ou
  where EXISTS
  (select org_id from (select o.org_id
           from td_sm_organization o
          start with o.org_id = v_orgid
         connect by prior o.org_id = o.parent_id) t where
                 t.org_id = ou.org_id);
  return(rs);
end;
/
