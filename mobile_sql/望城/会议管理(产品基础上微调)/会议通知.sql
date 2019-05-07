create or replace view m_v_hy_a as
select t.m_notice_id        HY_ID, --会议id
       t.m_receiver_user_id HY_JSRid, --会议接收人
       --t.M_IS_REPLY_NAME        HY_JSZT, --会议接收状态 即回复状态 1 本人参加 2 委托人参加 3 安排人参加  9 请假  0 未报名
       decode(t.m_is_reply,0,(decode(t.m_is_read,1,'已阅读','未阅读')),t.m_is_reply_name) HY_JSZT,
       to_char(t.m_attender_ids)     HY_CYR, --  参与人
       t.m_reply            HY_QJYY,--  请假事由
       t.m_receiver_user_name HY_JSR--会议接收人
  from oa_meeting_receiver_user t;

/

create or replace view m_v_hy_d as
select t.m_notice_id hy_id, --会议id
       t.m_title hy_bt, --会议标题
       t.m_address hy_dd, --会议地点
       to_char(t.m_begin_time,'yyyy-mm-dd hh24:mi:ss') hy_kssj, --会议开始时间
       to_char(t.m_end_time,'yyyy-mm-dd hh24:mi:ss') hy_jssj, --会议结束时间
       t.m_link_dept_name hy_lxbm, --联系部门
       t.m_link_user_name hy_lxr, --联系人
       t.m_link_tel hy_lxdh, --联系电话
       t.m_attender_count hy_yhrs, --与会人数
       to_char(t.m_close_time,'yyyy-mm-dd hh24:mi:ss') hy_bmjzsj, --报名截止时间
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

create or replace view m_v_hy_r as
select t.m_notice_id        hy_id, --会议id
to_char(t.m_begin_time,'yyyy-mm-dd hh24:mi:ss') hy_fssj,
       --会议发送时间
       t.m_title            hy_bt, --会议标题
       decode(u.m_is_reply,0,(decode(u.m_is_read,1,'已阅读','未阅读')),m_is_reply_name)       hy_zt, --会议状态
       u.m_is_reply       hy_zt_id, --会议状态id
       t.m_current_user_name  hy_fsr, --会议发送人
       u.m_receiver_user_id hy_jsrid --会议接收人（key）
  from oa_meeting_notice t, oa_meeting_receiver_user u
 where t.m_notice_id = u.m_notice_id;

/

create or replace view m_v_hy_room as
select
"M_ROOM_ID"  as hy_roomid,
"M_ROOM_CODE",
"M_ROOM_NAME"as hy_roomname,
"M_UNIT_ID",
"M_ADDRESS",
"M_PEOPLE_NUM",
"M_DEPT_ID",
"M_IS_NEED_CHECK",
"M_REG_USER_ID",
"M_REG_USER_NAME",
"M_REG_TIME",
"M_REMARK",
"M_UNIT_NAME",
"M_IS_USE_FLAG",
"ADMINISTRATOR_IDS",
"ADMINISTRATOR_NAMES",
"M_DEPT_NAME"
 from OA_MEETING_ROOM;

/

create or replace view m_v_hy_s as
select t.m_notice_id hy_id, --会议id
       to_char(t.m_begin_time, 'yyyy-mm-dd hh24:mi:ss') hy_fssj,
       t.m_title hy_bt, --会议标题
       t.m_check_flag_name hy_zt,
       t.m_current_user_id hy_fsrid,
       (select wm_concat(u.user_realname)
          from oa_meeting_receiver_user r, td_sm_user u
         where t.m_notice_id = r.m_notice_id
           and r.m_receiver_user_id = u.user_id) as HY_CYR
  from oa_meeting_notice t where t.m_check_flag='4' or t.m_check_flag='5';

/

create or replace view m_v_hy_yt as
select

"M_TOPIC_ID" as hy_ytid,          --议题id
"M_NOTICE_ID" as hy_id,         --会议通知id
"M_TOPIC_NAME" as hy_ytmc,         --议题名称
TO_CHAR("M_BEGIN_TIME", 'yyyy-mm-dd hh24:mi:ss') as hy_ytsj,   -- 开始时间
"M_USER_ID" as hy_ythbrid,         -- 汇报人id
"M_USER_NAME" as hy_ythbr,         -- 汇报人name
"M_REMARK" as hy_ytbz,         -- 备注
"M_TOPIC_UNIT_IDS" as hy_ytdwids,         --议题参与单位ids
"M_TOPIC_USER_IDS" as hy_ytryids,         --议题参与人员ids
"M_TOPIC_UNIT_NAMES"  as hy_ytdw,         --议题参与单位names
"M_TOPIC_USER_NAMES"  as hy_ytry         --议题参与人员names

from oa_meeting_topic

/**
* huanbing.wang
* 2013-9-10
*/;

/


create or replace trigger M_T_HY_TR_INSERT
  after insert
ON M_T_HY
  FOR EACH ROW
DECLARE
  NEW_NOTICE_ID varchar2(50);
  room varchar2(200);--会议s室名称
  room_id varchar2(200);--会议地点ID
  room_address varchar2(200);--会议地点
BEGIN
  select get_uuid() into NEW_NOTICE_ID from dual; --记住主键id值用于从表的插入
  IF INSERTING THEN
    
    if(:new.HY_DDID is null or nvl(:new.HY_DDID,'') ='' )then
        room_id :='';--会议室ID
        room :='';--会议室
        room_address :=:new.HY_DD;--会议室
   else
        room_id :=:new.HY_DDID;--会议室id
        room :=:new.HY_DD;--会议室
        select M_ADDRESS into room_address from OA_MEETING_ROOM where M_ROOM_ID = room_id;
   end if;
   
    insert into oa_meeting_notice
      (m_notice_id,
       M_ROOM_ID,
       M_ROOM_NAME,
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
       room_id,
       room,
       :new.hy_bt,
       to_date(:new.hy_kssj,'yyyy-mm-dd hh24:mi:ss'),
       to_date(:new.hy_jssj,'yyyy-mm-dd hh24:mi:ss'),
       room_address,
       :new.hy_lxrid,
       :new.hy_lxr,
       :new.hy_lxbmid,
       :new.hy_lxbm,
       :new.hy_lxdh,
       :new.HY_SFBM,
       :new.HY_SQRID,
       :new.HY_SQR,
       to_date(:new.HY_SQSJ,'yyyy-mm-dd hh24:mi:ss'),
       :new.HY_SQRBMID,
       :new.HY_SQRBM,
       OA_USERPROPERTY(:new.HY_SQRBMID, '2'),---单位
       OA_USERPROPERTY(:new.HY_SQRBMID, '1'),---单位name
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
         M_IS_REPLY_NAME,
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
               '',
               '0',
               '0',
               '0'
          from table(split(:new.HY_CYRID, ',')) t;
    end if;
  end if;
END M_T_HY_TR_INSERT;

/

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

create or replace trigger PTMX_WC_HYTZ
  after insert or delete or update
/**
* 会议通知  向轮询表里加数据
**/
on oa_meeting_notice
  for each row

declare
  new_wait_id varchar(50);

begin
  select seq_android_wait.nextval into new_wait_id from dual;

  --新增与更新
  if inserting or updating then

    --会议待审的数据和采稿数据不推送
    if (:new.m_check_flag = '4' or :new.m_check_flag = '5') then
      insert into m_aa_wait
        (wait_id,
         business_id,
         business_type,
         title,
         content,
         create_time,
         curd_type)
      values
        (new_wait_id,
         :new.m_notice_id,
         'huiyi',
         '',
         :new.m_title,
         sysdate,
         'c');

      --用户
      if (:new.m_receiver_user_ids is not null) then
        insert into m_aa_uf
          (user_id, wait_id)
          select t.column_value, new_wait_id
            from table(split(:new.m_receiver_user_ids, ',')) t;
      end if;

      if (:new.m_receiver_unit_ids is not null) then
        --如果发给机构，解析机构id并查找出用户id
        insert into m_aa_uf
          (user_id, wait_id)
          select distinct user_id, ''
            from td_sm_user
           where exists
           (select column_value
                    from table(split((select WM_CONCAT(c.config_ids)
                                       from oa_dataresources_config c,
                                            oa_data_resources       r
                                      where c.resources_id = r.resources_id
                                        and r.resources_logo =
                                            'meetingunitresion'
                                        and exists
                                      (select column_value
                                               from table(split(:new.m_receiver_unit_ids,
                                                                ','))
                                              where config_typeid =
                                                    column_value)

                                     ),
                                     ','))
                   where user_id = column_value);
      end if;

      --可能存在用户和机构都存在的用户，去重
      delete m_aa_uf
       where rowid not in
             (select max(rowid) from m_aa_uf group by user_id, wait_id)
         and wait_id = new_wait_id;
    end if;
  end if;

end PTMX_WC_HYTZ;

/

