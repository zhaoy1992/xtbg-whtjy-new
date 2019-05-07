create or replace view m_v_tz_d as
select announcement_id                     as tz_id,--公告id
       create_time                         as tz_fssj,--公告发送时间
       announcement_title                  as tz_bt,--公告标题
       username                            as tz_fsr,--当前用户名
       orgid                               as tz_fsrjg,--当前机构id
       attach_id                           as tz_fjid,--附件id
       (select count(*) from fc_attach f  where trim(f.djbh) = trim(attach_id))                                 as tz_fjsl, --附件数量
       content                             as tz_tzzw,--公告内容
       is_phone_send                       as tz_sfyx--是否移动端发送
  from ymj_oa_announcement_infos
 /**
* 描述:[移民局 通知公告的视图  通知详情]
* 参数列表:
* 1	TZ_ID	通知id
* 2	TZ_FSSJ	通知发送时间
* 3	TZ_BT	通知标题
* 4	TZ_FSR	通知发送人
* 5 TZ_FSRJG 通知发送人机构
* 6	TZ_FJID	通知附件id
* 7	TZ_FJSL	附件数量
* 8 TZ_TZZW   通知正文
* 9	TZ_SFYX	 是否有效
* 时间:2013-8-9
* 作者:qiul.ian
*/;

/

create or replace view m_v_tz_r as
select distinct (t.announcement_id) as tz_id,--通知id
                 to_char(t.create_time, 'yyyy-mm-dd hh24:mi:ss') as tz_fssj,--通知发送时间
                t.announcement_title as tz_bt,--通知标题
                t.username as tz_fsr,
                 decode(o.andit_state,'4','已查看','3','未查看') as tz_zt,
                 (select count(*) from fc_attach f  where trim(f.djbh) = trim(t.attach_id))  as tz_fjsl,   --附件数量
                o.andit_person_id as tz_jsrid,--通知接收人
                t.attach_id as tz_fjid   --附件ID
  from ymj_oa_announcement_infos t
  left join ymj_oa_announcement_userinfo o
    on o.announcement_id = t.announcement_id
  left join ymj_oa_announcement_status i
    on to_number(i.status_code) = to_number(o.andit_state)
 where 1 = 1
   and o.andit_state in (3, 4)
 order by tz_fssj desc
 /**
* 描述:[移民局 通知公告的视图  接收到的通知列表]
* 参数列表:
* 1	TZ_ID	通知id
* 2	TZ_FSSJ	通知发送时间
* 3	TZ_BT	通知标题
* 4	TZ_FSR	通知发送人
* 5	TZ_ZT	通知状态
* 6	TZ_FJSL	附件数量
* 7	TZ_JSRID	通知接收人id
*/;

/

create or replace view m_v_tz_s as
select DISTINCT (t.announcement_id) as tz_id,--公告id
                to_char(t.create_time, 'yyyy-mm-dd hh24:mi:ss')  as tz_fssj,--公告发送时间
                t.announcement_title as tz_bt,--公告标题
                t.userid as tz_fsrid,--发送人id
                '2' as tz_zt, --通知状态
                (select count(*) from fc_attach f  where trim(f.djbh) = trim(t.attach_id))  as tz_fjsl,--通知附件数量
                o.andit_person as tz_tzjsr,--接收人
                t.attach_id as tz_fjid --附件ID
  from ymj_oa_announcement_infos t
  left join ymj_oa_announcement_userinfo o
    on o.announcement_id = t.announcement_id
  left join ymj_oa_announcement_status i
    on to_number(i.status_code) = to_number(o.andit_state)
 where 1 = 1
   and o.andit_state in (2)
 order by tz_fssj desc
  /**
* 描述:[移民局 通知公告的视图  已发送的通知列表]
* 参数列表:
* 1	TZ_ID	通知id
* 2	TZ_FSSJ	通知发送时间 日期格式全部转换为字符串yyyy-mm-dd hh24:mi:ss
* 3	TZ_BT	通知标题
* 4	TZ_FSR	通知发送人
* 5	TZ_ZT	通知状态
* 6	TZ_FJSL	附件数量
* 7	TZ_TZJSR	通知接收人
* 时间:2013-8-9
* 作者:qiul.ian
*/;

/

create or replace trigger PTMX_YMJ_TZGG after insert or delete
/**
 * 通知公告  向moblie端消息表触发消息数据
 * 描述:PTMX_YMJ_TZGG:(PTMX:PC端的真实表-->MOBILE端的消息表(X))(_YMJ_TZGG:所属系统是移民局,所属功能点是通知公告)
 * 原触发器:mobile_tzgg
 * tuo.zou
 * 2013-8-13
 */
ON ymj_oa_announcement_infos
FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
BEGIN
select seq_android_wait.nextval into new_wait_id from dual;
    --新增与更新
    IF INSERTING  THEN
      insert into M_AA_WAIT(wait_id, business_id, business_type, title, content, curd_type)
      values(new_wait_id, :new.ANNOUNCEMENT_ID, 'tongzhi','',:new.announcement_title,'0');

      if(:new.accept_userid is not null) then
      insert into M_AA_UF(WAIT_ID,USER_ID)
      select new_wait_id,t.column_value
      from table(split(:new.accept_userid,',')) t;
      end if;

      if(:new.accept_orgid is not null) then
        insert into M_AA_UF(WAIT_ID,USER_ID)
      select new_wait_id,user_id from td_sm_orguser where exists (
      select column_value from table(split(:new.accept_orgid,',')) where org_id = column_value);
      end if;

      delete M_AA_UF where rowid not in (
      select max(rowid) from M_AA_UF group by user_id ,wait_id) and wait_id=new_wait_id;

    ELSIF DELETING THEN --删除
      insert into M_AA_WAIT(wait_id, business_id, business_type, title, content, curd_type)
      values(new_wait_id, :new.ANNOUNCEMENT_ID, 'tongzhi','',:new.announcement_title,'1');
    end if;
END PTMX_YMJ_TZGG;

/


create or replace trigger ph2pc_ymj_announcement
  after insert
/**
* 手机端到移动端的触发器
* 移民局通知公告
**/
on M_T_TZ
  for each row
declare
  new_wait_id number;
begin
  select seq_ymj_announcement.nextval into new_wait_id from dual;
  --新增与更新
  if INSERTING then
    --通知公告主表信息
    insert into ymj_oa_announcement_infos
      (announcement_id,
       announcement_title,
       userid,
       username,
       orgid,
       create_time,
       orgname,
       content,
       accept_orgname,
       accept_orgid,
       isorg,
       attach_id,
       accept_userid,
       dept_id,
       dept_name,
       accept_username,
       remind_mode)
    values
      (new_wait_id,
       :new.tz_bt,
       :new.tz_fsrid,
       :new.tz_fsrmz,
       :new.tz_fsrbmid,
       sysdate,
       :new.tz_fsrbmmz,
       :new.tz_content,
       '',
       '',
       'y',
       to_char(sysdate,'YYYY-MM-DD HH24:MI:SS'),
       :new.tz_jsrid,
       :new.tz_fsrbmid,
       :new.tz_fsrbmmz,
       :new.tz_jsr,
       'N');

    ---删除公告信息为撤销状态的信息
    delete from ymj_oa_announcement_userinfo
     where announcement_id in (new_wait_id) and andit_state = '5';

    ---删除接收用户信息
    delete ymj_oa_announcement_userinfo  where andit_state = '1'  and announcement_id = new_wait_id  and ANDIT_PERSON_ID = :new.tz_jsrid;

    ---发起人的修改自己的状态为已发送状态
    insert into ymj_oa_announcement_userinfo
      (audit_id,
       announcement_id,
       andit_person,
       andit_state,
       andit_time,
       orgid,
       orgname,
       dept_id,
       dept_name,
       andit_person_id)
    values
      (seq_ymj_announcement.nextval,
       new_wait_id,
       :new.tz_fsrmz,
       '2',
       sysdate,
       :new.tz_fsrbmid,
       :new.tz_fsrbmmz,
       :new.tz_fsrbmid,
       :new.tz_fsrbmmz,
       :new.tz_fsrid);

    ---保存接收用户信息
    if(:new.tz_jsrid is not null) then

       delete from ymj_oa_announcement_userinfo where announcement_id in (new_wait_id) and andit_state = '1';

       insert into ymj_oa_announcement_userinfo
        (audit_id,announcement_id,andit_person,andit_state,andit_time,orgid,orgname,dept_id,dept_name,andit_person_id)
        select seq_ymj_announcement.nextval,new_wait_id,
               (select tabs.user_realname from td_sm_user tabs where tabs.user_id = t.column_value) as user_realname,
               '3', sysdate,:new.tz_fsrbmid,:new.tz_fsrbmmz,:new.tz_fsrbmid,:new.tz_fsrbmmz,t.column_value
          from table(split(:new.tz_jsrid, ',')) t;
  end if;

end if;
end pc_ymj_oa_announcement;


/

create or replace trigger ph2pc_ymj_announcement_view
  after insert
/**
* 移民局通知公告 查看通知公告
**/
on M_T_TZ_CK
  for each row
declare
  new_wait_id number;
begin
  select seq_ymj_announcement.nextval into new_wait_id from dual;
  --新增
  if INSERTING then
    --通知公告主表信息
    update ymj_oa_announcement_infos set isorg = 'y', remind_mode = 'N'  where announcement_id = :new.tz_id;

    ---删除公告信息为撤销状态的信息
     delete from ymj_oa_announcement_userinfo where announcement_id in (:new.tz_id) and andit_state = '5';

    ---先清空当前信息该状态的意见记录
     delete ymj_oa_announcement_userinfo where andit_state = '3' and announcement_id = :new.tz_id and andit_person_id = :new.tz_ckrid;

    ---删除用户人信息
     delete from ymj_oa_announcement_userinfo where announcement_id in (:new.tz_id) and andit_state = '1' ;

    ---发起人的修改自己的状态为已阅读状态
     insert into ymj_oa_announcement_userinfo(audit_id,
                                        announcement_id,
                                        andit_person,
                                        andit_state,
                                        andit_time,
                                        orgid,
                                        orgname,
                                        dept_id,
                                        dept_name,
                                        andit_person_id)
     values(seq_ymj_announcement.nextval,
                  :new.tz_id,
                  (select t.user_realname
                     from td_sm_user t
                    where t.user_id = :new.tz_ckrid),
                  '4',
                  sysdate,
                  (select org.org_id
                     from td_sm_orguser org
                    where org.user_id = :new.tz_ckrid),
                  (select orgname.org_name
                     from td_sm_orguser org, td_sm_organization orgname
                    where org.user_id = :new.tz_ckrid
                      and org.org_id = orgname.org_id),
                  (select org.org_id
                     from td_sm_orguser org
                    where org.user_id = :new.tz_ckrid),
                  (select orgname.org_name
                     from td_sm_orguser org, td_sm_organization orgname
                    where org.user_id = :new.tz_ckrid
                      and org.org_id = orgname.org_id),
                  :new.tz_ckrid);

  end if;
end pc_ymj_oa_announcement_view;


