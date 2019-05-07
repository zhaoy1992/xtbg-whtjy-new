create or replace trigger M_T_HY_HF_TR_INSERT  --回复表
  after insert
ON M_T_HY_HF
  FOR EACH ROW
DECLARE
  M_RECEIVER_ID varchar2(50);
BEGIN
  select u.m_receiver_id
    into M_RECEIVER_ID
    from oa_meeting_receiver_user u
   where u.m_receiver_user_id = :new.HY_BMRID ---会议接收人
     and u.m_notice_id = :new.HY_ID
     and rownum = 1;
  IF (INSERTING and M_RECEIVER_ID is not null) THEN
    if (0 = :new.HY_REPLAY) then
      update oa_meeting_receiver_user u
         set u.m_read_time     = sysdate,
             u.m_is_reply      = '0',
             u.m_is_read       = '1',
             u.m_is_reply_name = '已阅读'
       where u.m_receiver_id = M_RECEIVER_ID
         and u.m_receiver_user_id = :new.HY_BMRID
         and u.m_notice_id = :new.HY_ID
         and u.m_read_time is null;
    end if;
    if (1 = :new.HY_REPLAY or 9 = :new.hy_replay) then
      update oa_meeting_receiver_user u
         set u.m_reply_time     = sysdate,
             u.m_is_reply       = :new.HY_REPLAY,
             u.m_is_read        = '1',
             u.m_is_reply_name  = decode(:new.HY_REPLAY,
                                         '1',
                                         '参加',
                                         '9',
                                         '请假',
                                         '0'),
             u.m_reply          = :new.HY_REASON,
             u.m_attender_count = :new.HY_CYRS,
             u.m_attender_ids   = :new.HY_CYRID,
             u.m_attender_names = :new.HY_CYR
       where u.m_receiver_id = M_RECEIVER_ID
         and u.m_receiver_user_id = :new.HY_BMRID
         and u.m_notice_id = :new.HY_ID;
      ----参加时把真正的参会人插入【参会人员表】
      if (1 = :new.HY_REPLAY) then
      
        delete from oa_meeting_attender
         where m_receiver_id = (select u.m_receiver_id
                                  from oa_meeting_receiver_user u
                                 where u.m_receiver_user_id = :new.HY_BMRID ---会议接收人
                                   and u.m_notice_id = :new.HY_ID
                                   and rownum = 1);
      
        insert into oa_meeting_attender
          (M_ID,
           M_RECEIVER_ID,
           M_USER_ID,
           M_USER_NAME,
           M_UNIT_ID,
           M_UNIT_NAME)
          select get_uuid(),
                 M_RECEIVER_ID,
                 COLUMN_VALUE userid,
                 v.username,
                 v.unitid,
                 v.unitname
            from table(split(:new.HY_CYRID, ',')) t, v_user_info v
           where v.userid = COLUMN_VALUE;
      end if;
    end if;
  end if;
END M_T_HY_HF_TR_INSERT;
/


create or replace trigger M_T_HY_TR_INSERT
  after insert
ON M_T_HY
  FOR EACH ROW
DECLARE
  NEW_NOTICE_ID varchar2(50);
BEGIN
  select get_uuid() into NEW_NOTICE_ID from dual; --记住主键id值用于从表的插入
  IF INSERTING THEN
    insert into oa_meeting_notice
      (m_notice_id,
       m_title,
       m_begin_time,
       m_end_time,
       m_address,
       m_link_user_id,
       m_link_user_name,
       m_link_dept_id,
       m_link_dept_name,
       m_link_tel,
       m_is_need_signup, --
       m_create_user_id,
       m_create_user_name,
       m_create_time,
       m_create_dept_id,
       m_create_dept_name,
       m_create_unit_id,
       m_create_unit_name,
       m_check_flag,
       m_check_flag_name, --
       m_current_user_id,
       m_current_user_name,
       m_current_time,
       m_is_addsend,
       m_is_resend,
       m_receiver_user_ids,
       m_receiver_user_names,
       m_contents)
    values
      (NEW_NOTICE_ID,
       :new.hy_bt,
       to_date(:new.hy_kssj,'yyyy-mm-dd hh24:mi:ss'),
       to_date(:new.hy_jssj,'yyyy-mm-dd hh24:mi:ss'),
       :new.hy_dd,
       :new.hy_lxrid,
       :new.hy_lxr,
       :new.hy_lxbmid,
       :new.hy_lxbm,
       :new.hy_lxdh,
       :new.HY_SFBM,
       :new.HY_SQRID,
       :new.HY_SQR,
       to_date(:new.HY_SQSJ,'yyyy-mm-dd hh24:mi:ss'),
       (select o.org_id from td_sm_organization o left join td_sm_orguser ou on o.org_id=ou.org_id where ou.user_id=:new.hy_lxrid),--:new.HY_SQRBMID,
       (select o.org_name from td_sm_organization o left join td_sm_orguser ou on o.org_id=ou.org_id where ou.user_id=:new.hy_lxrid),--:new.HY_SQRBM,
       OA_USERPROPERTY(:new.HY_SQRBMID, '1'),---单位
       OA_USERPROPERTY(:new.HY_SQRBMID, '2'),---单位name
       '4',
       '已发布',
       :new.HY_SQRID,--发布人
       :new.HY_SQR,--发布人name
       to_date(:new.HY_SQSJ,'yyyy-mm-dd hh24:mi:ss'),--发布时间
       '0',
       '0',
       :new.hy_cyrid,
       :new.hy_cyr,
       :new.HY_CONTENT);

    if (:new.hy_cyrid is not null) then
      insert into oa_meeting_receiver_user u
        (m_receiver_id,
         m_notice_id,
         m_receiver_user_id,
         m_receiver_user_name,
         m_receiver_unit_id,
         m_receiver_unit_name,
         m_create_time, --接收时间 或者说 发布时间
         m_is_addrend,
         m_is_resend,
         m_is_call)
        select get_uuid(),
               NEW_NOTICE_ID,
               COLUMN_VALUE,
               (select d.user_realname
                  from td_sm_user d
                 where d.user_id = COLUMN_VALUE),
               (select org.org_id
                  from td_sm_orguser org
                 where org.user_id = t.COLUMN_VALUE),
               (select t.org_name
                  from td_sm_orguser org, TD_SM_ORGANIZATION t
                 where t.org_id = org.org_id
                   and org.user_id = t.COLUMN_VALUE),
               to_date(:new.HY_SQSJ,'yyyy-mm-dd hh24:mi:ss'),
               '0',
               '0',
               '0'
          from table(split(:new.HY_CYRID, ',')) t;
    end if;
  end if;
END M_T_HY_TR_INSERT;
/
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
    from (select ''
            from oa_notice_baseinfo b, oa_notice_receiver_user r
           where r.n_notice_id = b.n_notice_id
             and b.n_state in (1, 2)
             and r.n_isdel != '1'
             and r.n_isview = '0'
             and r.n_receiver_userid = userid
          union all
          select t.m_title
            from oa_meeting_notice        t,
                 oa_meeting_room          r,
                 oa_meeting_receiver_user u
           where t.m_room_id = r.m_room_id(+)
             and t.m_notice_id = u.m_notice_id
             and u.m_receiver_user_id = userid
             and u.m_is_read <> '1'
             and (t.m_check_flag = '4' or t.m_check_flag = '5'));

  select count(*)
    into waitarchive
    from VIEW_OA_WORK_LIST t
   where t.username =
         (select u.user_name from td_sm_user u where u.user_id = userid);

  return(waitsp || ',' || waitread || ',' || waitarchive);
end getCountInfo;
/