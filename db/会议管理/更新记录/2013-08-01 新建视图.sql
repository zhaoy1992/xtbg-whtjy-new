drop view V_USER_ORG_INFO;

/*==============================================================*/
/* View: V_USER_ORG_INFO                                        */
/*==============================================================*/
create or replace view V_USER_ORG_INFO as
select  a.user_id,u.user_name,u.user_realname, a.org_id, b.org_name,u.user_worktel,u.user_mobiletel1
  from (select a.user_id, min(a.job_sn), a.org_id
          from td_sm_userjoborg a
         group by a.user_id, a.org_id) a
 inner join td_sm_ORGANIZATION b on a.org_id = b.org_id
 inner join td_sm_user u       on u.user_id = a.user_id;
 
 /*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013/8/1 17:07:47                            */
/*==============================================================*/


drop view MOBILE_VIEW_HUIYI;

drop view MOBILE_VIEW_HUIYI_R;

drop view MOBILE_VIEW_HUIYI_S;

drop view XTBGBASE.V_USER_ORG_INFO;

/*==============================================================*/
/* View: MOBILE_VIEW_HUIYI                                      */
/*==============================================================*/
create or replace view MOBILE_VIEW_HUIYI(HY_ID, HY_BT, HY_DD, HY_KSSJ, HY_JSSJ, HY_LXBM, HY_LXR, HY_LXDH, HY_YHRS, HY_BMJZSJ, HY_FJID, HY_ZW, HY_CYR) as
select
t.m_notice_id hy_id, --会议id
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
t.m_receiver_user_names hy_cyr --参与人
from oa_meeting_notice t;

comment on column MOBILE_VIEW_HUIYI.HY_ID is
'会议通知id';

comment on column MOBILE_VIEW_HUIYI.HY_BT is
'标题';

comment on column MOBILE_VIEW_HUIYI.HY_DD is
'地点(默认显示会议室地点)';

comment on column MOBILE_VIEW_HUIYI.HY_KSSJ is
'会议开始时间';

comment on column MOBILE_VIEW_HUIYI.HY_JSSJ is
'会议结束时间';

comment on column MOBILE_VIEW_HUIYI.HY_LXBM is
'联系部门name';

comment on column MOBILE_VIEW_HUIYI.HY_LXR is
'联系人name';

comment on column MOBILE_VIEW_HUIYI.HY_LXDH is
'联系电话';

comment on column MOBILE_VIEW_HUIYI.HY_YHRS is
'与会人数';

comment on column MOBILE_VIEW_HUIYI.HY_BMJZSJ is
'报名截止日期';

comment on column MOBILE_VIEW_HUIYI.HY_FJID is
'附件id';

comment on column MOBILE_VIEW_HUIYI.HY_ZW is
'会议正文';

comment on column MOBILE_VIEW_HUIYI.HY_CYR is
'参会人员names';

/*==============================================================*/
/* View: MOBILE_VIEW_HUIYI_R                                    */
/*==============================================================*/
create or replace view MOBILE_VIEW_HUIYI_R(HY_ID, HY_FSSJ, HY_BT, HY_ZT, HY_JSR) as
select
t.m_notice_id hy_id, --会议id
u.m_create_time hy_fssj, --会议发送时间
t.m_title hy_bt, --会议标题
t.m_check_flag hy_zt, --会议状态 (0送审，1审核通过，2审核不通过，3暂存，4已发布，5重新发布，6已撤销)
u.m_receiver_user_id hy_jsr --会议接收人（key）
from oa_meeting_notice t,oa_meeting_receiver_user u
where t.m_notice_id=u.m_notice_id;

comment on column MOBILE_VIEW_HUIYI_R.HY_ID is
'会议通知id';

comment on column MOBILE_VIEW_HUIYI_R.HY_FSSJ is
'接收时间(记录产生时间,默认插入)';

comment on column MOBILE_VIEW_HUIYI_R.HY_BT is
'标题';

comment on column MOBILE_VIEW_HUIYI_R.HY_ZT is
'会议通知状态(见后台静态常量)';

comment on column MOBILE_VIEW_HUIYI_R.HY_JSR is
'接收人id';

/*==============================================================*/
/* View: MOBILE_VIEW_HUIYI_S                                    */
/*==============================================================*/
create or replace view MOBILE_VIEW_HUIYI_S(HY_ID, HY_BT, HY_FSSJ, HY_FSR) as
select
t.m_notice_id hy_id, --会议id
t.m_title hy_bt, --会议标题
t.m_current_time  hy_fssj, --会议发送时间
t.m_current_user_name hy_fsr--会议发送人（key）
from oa_meeting_notice t;
