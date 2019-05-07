create or replace function getCountInfo(userid varchar2) return varchar2 is
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
   and (t.m_check_flag = '0')
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