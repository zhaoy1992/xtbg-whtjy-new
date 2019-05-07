create or replace function getCountInfo(userid varchar2) return varchar2 is
  waitsp      number;
  waitread    number;
  waitarchive number;
begin
  waitsp      := 0;
  waitread    := 0;
  waitarchive := 0;
  --等待审批
  select count(*)
    into waitsp
      from(
      select *
          from (select pri_id,
                       info_type,
                       work_name,
                       input_user,
                       start_time,
                       m_check_flag_name,
                       m_check_flag,
                       m_reg_user_id,
                       m_reg_user_name
                  from (select t1.m_notice_id as pri_id,
                               '会议审批' info_type,
                               t1.m_title work_name,
                               t1.m_create_user_name input_user,
                               t1.m_check_flag_name as m_check_flag_name,
                               t1.m_check_flag as m_check_flag,
                               r.m_reg_user_name as m_reg_user_name,
                               to_char(t1.m_begin_time, 'yyyy-mm-dd hh24:mi') start_time,
                               r.m_reg_user_id,
                               r.administrator_names
                          from oa_meeting_notice t1, oa_meeting_room r
                         where t1.m_room_id = r.m_room_id(+)
                           and ',' || r.administrator_ids || ',' like '%,'||userid||',%'
                           and (t1.m_check_flag = '0')
                         order by t1.m_title desc))
        union all
        select pri_id,
               info_type,
               work_name,
               input_user,
               start_time,
               '' m_check_flag_name,
               '' m_check_flag,
               '' m_reg_user_id,
               '' m_reg_user_name
          from (select distinct (t.submittedinfo_id) pri_id,
                                t.submittedinfo_title work_name,
                                to_char(t.input_date, 'yyyy-mm-dd hh24:mi:ss') start_time,
                                t.inputuser_name input_user,
                                u.andit_state info_state,
                                '信息审批' as info_type,
                                '' as notice_state,
                                1 as rsn,
                                '' as status
                  from ta_oa_infre_submitted_info t
                 inner join ta_oa_infre_audit u on u.submittedinfo_id =
                                                   t.submittedinfo_id
                 inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode =
                                                                to_number(u.andit_state)
                 inner join td_sm_organization o on o.org_id = t.department_id
                 where u.andit_person_id = userid
                   and u.andit_state in ('3', '11', '12', '14'))
        union all
        select pri_id,
               info_type,
               work_name,
               input_user,
               start_time,
               '' m_check_flag_name,
               '' m_check_flag,
               '' m_reg_user_id,
               '' m_reg_user_name
          from (select f.use_name,
                       f.use_id,
                       u.user_realname input_user,
                       '派车审批' info_type,
                       f.apply_id pri_id,
                       f.use_reason work_name,
                       f.use_starttime,
                       f.use_endtime,
                       to_char(f.sqrq, 'yyyy-mm-dd HH24:mi') start_time,
                       f.car_id,
                       (select r.car_num
                          from YMJ_OA_CARMANAGE_CAR r
                         where f.car_id = r.car_id) car_num,
                       decode(f.state,
                              1,
                              '等待分配',
                              2,
                              '审批通过',
                              3,
                              '审批未通过',
                              4,
                              '等待审批',
                              5,
                              '派车结束') state
                  from YMJ_OA_CARMANAGE_APPLYINFO f
                  left join td_sm_user u on f.apply_personid = u.user_id
                 where state = '4'
                   and (select count(user_id)
                          from td_sm_userrole r
                          left join td_sm_role t on r.role_id = t.role_id
                         where r.user_id = userid
                           and t.role_name in ('车辆审批角色')) > 0
                 order by start_time desc) tt
         where tt.pri_id is not null

     ) wait;

  select count(*)
    into waitread
    from (
          select *
        from (select pri_id,
                     info_type,
                     work_name,
                     input_user,
                     start_time,
                     fk_id,
                     m_check_flag_name,
                     m_check_flag,
                     m_reg_user_id,
                     m_reg_user_name,
                     m_close_time,
                     m_is_need_signup
                from (select t.m_notice_id pri_id,
                             '会议通知查看' info_type,
                             to_char(t.m_begin_time, 'yyyy-mm-dd hh24:mi') start_time,
                             t.m_title work_name,
                             t.m_create_user_name input_user,
                             t.m_check_flag m_check_flag,
                             t.m_check_flag_name m_check_flag_name,
                             t.m_is_need_signup m_is_need_signup,
                             u.m_receiver_id fk_id,
                             u.m_is_read,
                             to_char(t.m_close_time, 'yyyy/mm/dd hh24:mi:ss') m_close_time,
                             r.m_reg_user_id m_reg_user_id,
                             r.m_reg_user_name m_reg_user_name,
                             r.administrator_ids,
                             r.administrator_names
                        from oa_meeting_notice        t,
                             oa_meeting_room          r,
                             oa_meeting_receiver_user u
                       where t.m_room_id = r.m_room_id(+)
                         and t.m_notice_id = u.m_notice_id
                         and u.m_receiver_user_id = userid
                         and to_date(to_char(t.m_begin_time,
                                             'yyyy/mm/dd hh24:mi:ss'),
                                     'yyyy/mm/dd hh24:mi:ss') >=
                             to_date('2013-09-24 00:00:01', 'yyyy/mm/dd hh24:mi:ss')
                         and (t.m_check_flag = '4' or t.m_check_flag = '5')
                         and u.m_is_read = '0'
                       order by m_title desc)
              union all
              select pri_id,
                     info_type,
                     work_name,
                     input_user,
                     start_time,
                     fk_id,
                     m_check_flag_name,
                     m_check_flag,
                     m_reg_user_id,
                     m_reg_user_name,
                     m_close_time,
                     m_is_need_signup
                from (select b.n_notice_id pri_id,
                             '公告查看' info_type,
                             b.n_title work_name,
                             b.n_release_username input_user,
                             to_char(b.n_release_time, 'yyyy-mm-dd hh24:mi') start_time,
                             b.n_orgname,
                             b.n_release_userid,
                             r.n_receiverid,
                             r.n_receiverid fk_id,
                             '' m_check_flag_name,
                             '' m_check_flag,
                             '' m_reg_user_id,
                             '' m_reg_user_name,
                             '' m_close_time,
                             '' m_is_need_signup,
                             decode(r.n_isview,
                                    '0',
                                    '未查看',
                                    '1',
                                    '已查看',
                                    '2',
                                    '撤销') as n_state
                        from oa_notice_baseinfo b, oa_notice_receiver_user r
                       where r.n_notice_id = b.n_notice_id
                         and b.n_state in (1, 2)
                         and r.n_isdel != '1'
                         and r.n_isview = '0'
                         and r.n_receiver_userid = userid
                       order by n_release_time desc)
              union all
              select pri_id,
                     info_type,
                     work_name,
                     input_user,
                     start_time,
                     '' fk_id,
                     '' m_check_flag_name,
                     '' m_check_flag,
                     '' m_reg_user_id,
                     '' m_reg_user_name,
                     '' m_close_time,
                     '' m_is_need_signup
                from (select distinct (t.submittedinfo_id) pri_id,
                                      t.submittedinfo_title work_name,
                                      to_char(t.input_date, 'yyyy-mm-dd hh24:mi') start_time,
                                      '信息报送' info_type,
                                      t.inputuser_id,
                                      t.inputuser_name input_user,
                                      t.department_id,
                                      o.org_name,
                                      t.is_recommend,
                                      u.andit_state,
                                      b.submittedinfo_typename,
                                      (select max(a.andit_time)
                                         from ta_oa_infre_audit a
                                        where a.submittedinfo_id =
                                              t.submittedinfo_id
                                          and a.andit_state = '6'
                                        group by a.submittedinfo_id) release_time,
                                      t.infotype_id
                        from ta_oa_infre_submitted_info t
                       inner join ta_oa_infre_audit u on u.submittedinfo_id =
                                                         t.submittedinfo_id
                       inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode =
                                                                      to_number(u.andit_state)
                       inner join td_sm_organization o on o.org_id =
                                                          t.department_id
                       where u.andit_person_id = userid
                         and u.andit_state in ('7', '8', '9')) tt
               where submittedinfo_typename = '未查看'
               order by start_time desc)
      union all
      select pri_id,
             info_type,
             work_name,
             input_user,
             start_time,
             '' fk_id,
             '' m_check_flag_name,
             '' m_check_flag,
             '' m_reg_user_id,
             '' m_reg_user_name,
             '' m_close_time,
             '' m_is_need_signup
        from (select to_char(tt.mid) as pri_id,
                     tt.sendpid,
                     tt.sendpname as input_user,
                     tt.title as work_name,
                     decode(t.readstate, '0', '未读', '1', '已读', '') as readstate,
                     tt.createtime as start_time,
                     '电子邮件' as info_type
                from ymj_oa_user_mail t, ymj_oa_jbxx_mail tt
               where 1 = 1
                 and t.mid = tt.mid
                 and t.receivepid = userid
                 and (tt.state = '1' or tt.state = '-1')
                 and t.readstate = '0'
               order by createtime desc) tt
       where tt.pri_id is not null

    );

  select count(*)
    into waitarchive
    from VIEW_OA_WORK_LIST t
   where t.username =
         (select u.user_name from td_sm_user u where u.user_id = userid)
         and t.BUSITYPE_CODE in(select TT.BUSITYPE_CODE
          from OA_FLOW_BUSITYPE tt
         where tt.BUSITYPE_TYPE_CODE in
               (select TTT.BUSITYPE_TYPE_CODE
                  from OA_FLOW_BUSITYPE_TYPE TTT
                 WHERE TTT.IS_VALID = '1'));
  return(waitsp || ',' || waitread || ',' || waitarchive);
end getCountInfo;
