create or replace view m_v_chuanyue_s as
select
       t.INS_ID,
       t.circularize_id,
        t.circularize_title,
        t.busi_id,
        t.busitype_code,
        (case t.busitype_code when 'uuid-1103' then 1 else 0 end) as is_ZW,
       to_char(t.entering_date,'yyyy-mm-dd hh24:mi:ss')  entering_date,
        t.receive_userid, --接收者id
        v.YH_ZWM send_username, -- 发送者名称
       is_view--是否已读
  from OA_CIRCULARIZE_FLOW t , M_V_YH v
 where t.send_userid = v.YH_ID and t.is_done = '0';
