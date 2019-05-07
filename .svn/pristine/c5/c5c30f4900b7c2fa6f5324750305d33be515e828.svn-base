delete from OA_MEETING_FLAG_TYPE;
commit;

insert into OA_MEETING_FLAG_TYPE (m_type_id, M_TYPE_code, m_type_name)
values ('3', 'STATUS_DRAFT', '暂存');
insert into OA_MEETING_FLAG_TYPE (m_type_id, M_TYPE_code, m_type_name)
values ('0', 'STATUS_PENDING', '送审');
insert into OA_MEETING_FLAG_TYPE (m_type_id, M_TYPE_code, m_type_name)
values ('1', 'STATUS_CHECKPASS', '审核通过');
insert into OA_MEETING_FLAG_TYPE (m_type_id, M_TYPE_code, m_type_name)
values ('2', 'STATUS_UNCHECKPASS', '审核不通过');
insert into OA_MEETING_FLAG_TYPE (m_type_id, M_TYPE_code, m_type_name)
values ('3', 'STATUS_UNPUBLISHED', '未发布');
insert into OA_MEETING_FLAG_TYPE (m_type_id, M_TYPE_code, m_type_name)
values ('4', 'STATUS_PUBLISHED', '已发布');
insert into OA_MEETING_FLAG_TYPE (m_type_id, M_TYPE_code, m_type_name)
values ('5', 'STATUS_REPUBLISHED', '重新发布');
insert into OA_MEETING_FLAG_TYPE (m_type_id, M_TYPE_code, m_type_name)
values ('6', 'STATUS_UNDONE', '撤消');
commit;
delete OA_DICT_DATA where DICTDATA_ID = '21';
commit;
insert into OA_DICT_DATA (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('21', '7', '0', '会议管理', '1', '会议管理', '1', 1);
delete OA_SYS_PARAM d where d.p_code IN ('linktel','topicconfig');
commit;

insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('f9195663-1d63-4083-95f8-2513109f1628', '0', 'linktel', '会议通知联系人电话号码', '1', '1', to_date('30-07-2013 09:06:39', 'dd-mm-yyyy hh24:mi:ss'), '1', '21', '0 代表 user_worktel' || chr(13) || '' || chr(10) || '1 代表 user_mobiletel1' || chr(13) || '' || chr(10) || '只设置一个为有效。');
insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('2a3106f2-94d6-4d51-b7e0-1d5443d71be9', '0', 'topicconfig', '会议议题全局配置', '1', '1', to_date('30-07-2013 10:23:03', 'dd-mm-yyyy hh24:mi:ss'), '1', '21', '0 不显示' || chr(13) || '' || chr(10) || '1 显示' || chr(13) || '' || chr(10) || '' || chr(13) || '' || chr(10) || '配置会议通知申请时议题tab页面是否显示');
commit;

delete OA_DATA_RESOURCES where RESOURCES_ID= '9';
commit;
insert into OA_DATA_RESOURCES (RESOURCES_ID, RESOURCES_PARENT_ID, RESOURCES_NAME, RESOURCES_LOGO, RESOURCES_DESC, CREATOR_TIME, RESOURCES_TYPE, TREE_TYPE, IS_VIEW)
values ('9', '1', '会议单位接收人', 'meetingunitresion', '会议接收单位接收人', to_date('16-07-2013', 'dd-mm-yyyy'), '2', null, '1');
commit;

delete from OA_DICT_DATA where dict_id='11' ;
commit;
delete from OA_DICT_TYPE where dict_id='11' ;
commit;
insert into OA_DICT_TYPE (dict_id, dict_parent_id, dict_name, dict_code, dict_remark, dict_is_valid, dict_order, dict_type)
values ('11', '0', '报名情况', 'bmqk', '报名情况', '1', 12, '0');
commit;

insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1103', '11', '0', '委托人参加', '2', null, '1', 3);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1101', '11', '0', '未回复', '0', null, '1', 1);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1102', '11', '0', '本人参加', '1', null, '1', 2);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1104', '11', '0', '安排人参加', '3', null, '1', 4);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1105', '11', '0', '请假', '9', null, '1', 5);
commit;


insert into TD_SM_ROLE
  (role_id,
   role_name,
   role_type,
   role_desc,
   role_usage,
   remark1,
   remark2,
   remark3,
   owner_id)
  select SEQ_TD_SM_ROLE.NEXTVAL,
         '会议系统管理员',
         '1',
         '会议系统管理员：只有会议系统管理员才能删除会议',
         null,
         null,
         null,
         null,
         1
    from dual t
   where not EXISTS
   (select '' from TD_SM_ROLE where role_name = '会议系统管理员');
   commit;


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