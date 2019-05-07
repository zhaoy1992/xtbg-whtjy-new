
---一、参加改为本人参加；二、按开始时间排序
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
                                         '本人参加',
                                         '9',
                                         '请假',
                                         '0'),
             u.m_reply          = :new.HY_REASON,
             u.m_attender_count = :new.HY_CYRS,
             u.m_link_user_id = decode(:new.HY_REPLAY,
                                         '1',
                                         u.m_receiver_user_id,
                                         null),
             u.m_link_user_name = decode(:new.HY_REPLAY,
                                         '1',
                                          u.m_receiver_user_name,
                                         null),
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
create or replace view m_v_hy_r as
select "HY_ID","HY_FSSJ","HY_BT","HY_ZT","HY_ZT_ID","HY_FSR","HY_JSRID","HY_SFBM","HY_KSSJ","M_CHECK_FLAG" from (select t.m_notice_id        hy_id, --会议id
to_char( u.m_create_time ,'yyyy-mm-dd hh24:mi:ss') hy_fssj,
       --会议发送时间
       t.m_title            hy_bt, --会议标题 
       decode(u.m_is_reply,0,(decode(u.m_is_read,1,'已阅读','未阅读')),m_is_reply_name)       hy_zt, --会议状态
       u.m_is_reply       hy_zt_id, --会议状态id
       decode(t.m_send_name,'0',t.m_create_unit_name, t.m_current_user_name) hy_fsr, --会议发送人
       ---单位名义发送的就显示单位名称
       u.m_receiver_user_id hy_jsrid, --会议接收人（key）
       decode(t.M_IS_NEED_SIGNUP,'0','否','是') hy_sfbm,
       to_char(t.m_begin_time ,'yyyy-mm-dd hh24:mi:ss') hy_kssj,
       m_check_flag
  from oa_meeting_notice t, oa_meeting_receiver_user u
 where t.m_notice_id = u.m_notice_id ) a
 where  a.m_check_flag='4' or a.m_check_flag='5'
 order by a.hy_fssj;
