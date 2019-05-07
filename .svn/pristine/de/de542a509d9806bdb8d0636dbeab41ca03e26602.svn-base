create or replace view m_v_hy_d as
select t.m_notice_id hy_id, --会议id
       t.m_title hy_bt, --会议标题
       t.m_address hy_dd, --会议地点
       t.m_begin_time hy_kssj, --会议开始时间
       t.m_end_time hy_jssj, --会议结束时间
       t.m_link_dept_name hy_lxbm, --联系部门
       t.m_link_user_name hy_lxr, --联系人
       t.m_link_tel hy_lxdh, --联系电话
       t.m_attender_count hy_yhrs, --与会人数
       t.m_close_time hy_bmjzsj, --报名截止时间
       t.m_djbh hy_fjid, --附件id
       t.m_contents hy_zw, --正文
       1 HY_SFYX, --是否有效
       (select wm_concat(u.user_realname)
          from oa_meeting_receiver_user r, td_sm_user u
         where t.m_notice_id = r.m_notice_id
           and r.m_receiver_user_id = u.user_id) as HY_CYR, --参与人名字
       (select count(*) from fc_attach f where trim(f.djbh) = trim(t.m_djbh)) as HY_FJSL --附件
  from oa_meeting_notice t;
/

create or replace view m_v_hy_s as
select t.m_notice_id hy_id, --会议id
       to_char(t.m_current_time, 'yyyy-mm-dd hh24:mi:ss') hy_fssj,
       t.m_title hy_bt, --会议标题
       t.m_check_flag_name hy_zt,
       t.m_current_user_id hy_fsrid,
       (select wm_concat(u.user_realname)
          from oa_meeting_receiver_user r, td_sm_user u
         where t.m_notice_id = r.m_notice_id
           and r.m_receiver_user_id = u.user_id) as HY_CYR
  from oa_meeting_notice t where t.m_check_flag='4' or t.m_check_flag='5';
  /
  
  create or replace view m_v_hy_r as
select t.m_notice_id        hy_id, --会议id
       u.m_create_time      hy_fssj, --会议发送时间
       t.m_title            hy_bt, --会议标题
       u.m_is_reply_name       hy_zt, --会议状态 
       u.m_is_reply       hy_zt_id, --会议状态id
       t.m_current_user_id  hy_fsr, --会议发送人
       u.m_receiver_user_id hy_jsrid --会议接收人（key）   
  from oa_meeting_notice t, oa_meeting_receiver_user u
 where t.m_notice_id = u.m_notice_id;
 /