create or replace view m_v_hy_a as
select t.m_notice_id        HY_ID, --����id
       t.m_receiver_user_id HY_JSRid, --���������
       --t.M_IS_REPLY_NAME        HY_JSZT, --�������״̬ ���ظ�״̬ 1 ���˲μ� 2 ί���˲μ� 3 �����˲μ�  9 ���  0 δ����
       decode(t.m_is_reply,0,(decode(t.m_is_read,1,'���Ķ�','δ�Ķ�')),t.m_is_reply_name) HY_JSZT,
       to_char(t.m_attender_ids)     HY_CYR, --  ������
       t.m_reply            HY_QJYY,--  �������
       t.m_receiver_user_name HY_JSR--���������
  from oa_meeting_receiver_user t;

/

create or replace view m_v_hy_d as
select t.m_notice_id hy_id, --����id
       t.m_title hy_bt, --�������
       t.m_address hy_dd, --����ص�
       to_char(t.m_begin_time,'yyyy-mm-dd hh24:mi:ss') hy_kssj, --���鿪ʼʱ��
       to_char(t.m_end_time,'yyyy-mm-dd hh24:mi:ss') hy_jssj, --�������ʱ��
       t.m_link_dept_name hy_lxbm, --��ϵ����
       t.m_link_user_name hy_lxr, --��ϵ��
       t.m_link_tel hy_lxdh, --��ϵ�绰
       t.m_attender_count hy_yhrs, --�������
       to_char(t.m_close_time,'yyyy-mm-dd hh24:mi:ss') hy_bmjzsj, --������ֹʱ��
       t.m_djbh hy_fjid, --����id
       t.m_contents hy_zw, --����
       1 HY_SFYX, --�Ƿ���Ч
       (select wm_concat(u.user_realname)
          from oa_meeting_receiver_user r, td_sm_user u
         where t.m_notice_id = r.m_notice_id
           and r.m_receiver_user_id = u.user_id) as HY_CYR, --����������
       (select count(*) from fc_attach f where trim(f.djbh) = trim(t.m_djbh)) as HY_FJSL --����
  from oa_meeting_notice t;

/

create or replace view m_v_hy_r as
select t.m_notice_id        hy_id, --����id
to_char(t.m_begin_time,'yyyy-mm-dd hh24:mi:ss') hy_fssj,
       --���鷢��ʱ��
       t.m_title            hy_bt, --�������
       decode(u.m_is_reply,0,(decode(u.m_is_read,1,'���Ķ�','δ�Ķ�')),m_is_reply_name)       hy_zt, --����״̬
       u.m_is_reply       hy_zt_id, --����״̬id
       t.m_current_user_name  hy_fsr, --���鷢����
       u.m_receiver_user_id hy_jsrid --��������ˣ�key��
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
select t.m_notice_id hy_id, --����id
       to_char(t.m_begin_time, 'yyyy-mm-dd hh24:mi:ss') hy_fssj,
       t.m_title hy_bt, --�������
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

"M_TOPIC_ID" as hy_ytid,          --����id
"M_NOTICE_ID" as hy_id,         --����֪ͨid
"M_TOPIC_NAME" as hy_ytmc,         --��������
TO_CHAR("M_BEGIN_TIME", 'yyyy-mm-dd hh24:mi:ss') as hy_ytsj,   -- ��ʼʱ��
"M_USER_ID" as hy_ythbrid,         -- �㱨��id
"M_USER_NAME" as hy_ythbr,         -- �㱨��name
"M_REMARK" as hy_ytbz,         -- ��ע
"M_TOPIC_UNIT_IDS" as hy_ytdwids,         --������뵥λids
"M_TOPIC_USER_IDS" as hy_ytryids,         --���������Աids
"M_TOPIC_UNIT_NAMES"  as hy_ytdw,         --������뵥λnames
"M_TOPIC_USER_NAMES"  as hy_ytry         --���������Աnames

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
  room varchar2(200);--����s������
  room_id varchar2(200);--����ص�ID
  room_address varchar2(200);--����ص�
BEGIN
  select get_uuid() into NEW_NOTICE_ID from dual; --��ס����idֵ���ڴӱ�Ĳ���
  IF INSERTING THEN
    
    if(:new.HY_DDID is null or nvl(:new.HY_DDID,'') ='' )then
        room_id :='';--������ID
        room :='';--������
        room_address :=:new.HY_DD;--������
   else
        room_id :=:new.HY_DDID;--������id
        room :=:new.HY_DD;--������
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
       OA_USERPROPERTY(:new.HY_SQRBMID, '2'),---��λ
       OA_USERPROPERTY(:new.HY_SQRBMID, '1'),---��λname
       '4',
       '�ѷ���',
       :new.HY_SQRID,--������
       :new.HY_SQR,--������name
       to_date(:new.HY_SQSJ,'yyyy-mm-dd hh24:mi:ss'),--����ʱ��
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
         m_create_time, --����ʱ�� ����˵ ����ʱ��
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

create or replace trigger M_T_HY_HF_TR_INSERT  --�ظ���
  after insert
ON M_T_HY_HF
  FOR EACH ROW
DECLARE
  M_RECEIVER_ID varchar2(50);
BEGIN
  select u.m_receiver_id
    into M_RECEIVER_ID
    from oa_meeting_receiver_user u
   where u.m_receiver_user_id = :new.HY_BMRID ---���������
     and u.m_notice_id = :new.HY_ID
     and rownum = 1;
  IF (INSERTING and M_RECEIVER_ID is not null) THEN
    if (0 = :new.HY_REPLAY) then
      update oa_meeting_receiver_user u
         set u.m_read_time     = sysdate,
             u.m_is_reply      = '0',
             u.m_is_read       = '1',
             u.m_is_reply_name = '���Ķ�'
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
                                         '�μ�',
                                         '9',
                                         '���',
                                         '0'),
             u.m_reply          = :new.HY_REASON,
             u.m_attender_count = :new.HY_CYRS,
             u.m_attender_ids   = :new.HY_CYRID,
             u.m_attender_names = :new.HY_CYR
       where u.m_receiver_id = M_RECEIVER_ID
         and u.m_receiver_user_id = :new.HY_BMRID
         and u.m_notice_id = :new.HY_ID;
      ----�μ�ʱ�������Ĳλ��˲��롾�λ���Ա��
      if (1 = :new.HY_REPLAY) then
      
        delete from oa_meeting_attender
         where m_receiver_id = (select u.m_receiver_id
                                  from oa_meeting_receiver_user u
                                 where u.m_receiver_user_id = :new.HY_BMRID ---���������
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
* ����֪ͨ  ����ѯ���������
**/
on oa_meeting_notice
  for each row

declare
  new_wait_id varchar(50);

begin
  select seq_android_wait.nextval into new_wait_id from dual;

  --���������
  if inserting or updating then

    --�����������ݺͲɸ����ݲ�����
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

      --�û�
      if (:new.m_receiver_user_ids is not null) then
        insert into m_aa_uf
          (user_id, wait_id)
          select t.column_value, new_wait_id
            from table(split(:new.m_receiver_user_ids, ',')) t;
      end if;

      if (:new.m_receiver_unit_ids is not null) then
        --���������������������id�����ҳ��û�id
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

      --���ܴ����û��ͻ��������ڵ��û���ȥ��
      delete m_aa_uf
       where rowid not in
             (select max(rowid) from m_aa_uf group by user_id, wait_id)
         and wait_id = new_wait_id;
    end if;
  end if;

end PTMX_WC_HYTZ;

/

