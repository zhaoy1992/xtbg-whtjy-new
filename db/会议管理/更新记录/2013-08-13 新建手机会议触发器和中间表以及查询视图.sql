----支持的相关方法和视图
create or replace view v_user_info as
select uu.user_id userid,
        uu.user_realname username,
        t.org_id deptid,--部门
        t.org_name deptname
        ,OA_USERPROPERTY(t.org_id, '2') unitid--单位
        ,OA_USERPROPERTY(t.org_id, '1') unitname
   from td_sm_user uu, td_sm_orguser org, TD_SM_ORGANIZATION t
  where uu.user_id = org.user_id
    and org.org_id = t.org_id;
/

CREATE OR REPLACE FUNCTION SPLIT(P_LIST VARCHAR2,
                                 
                                 P_SEP VARCHAR2 := ',')
  RETURN OA_TYPE_SPLIT
  PIPELINED

 IS

  L_IDX PLS_INTEGER;

  V_LIST VARCHAR2(4000) := P_LIST;

BEGIN

  LOOP
  
    L_IDX := INSTR(V_LIST, P_SEP);
  
    IF L_IDX > 0 THEN
    
      PIPE ROW(SUBSTR(V_LIST, 1, L_IDX - 1));
    
      V_LIST := SUBSTR(V_LIST, L_IDX + LENGTH(P_SEP));
    
    ELSE
    
      PIPE ROW(V_LIST);
    
      EXIT;
    
    END IF;
  
  END LOOP;

  RETURN;

END SPLIT;
/
CREATE OR REPLACE FUNCTION get_uuid RETURN VARCHAR IS
guid VARCHAR(50);
BEGIN
guid := lower(RAWTOHEX(sys_guid())); RETURN substr(guid, 1, 8) || '-' || substr(guid, 9, 4) || '-' || substr(guid, 13, 4) || '-' || substr(guid, 17, 4) || '-' || substr(guid, 21, 12);
END get_uuid;
/



drop table M_T_HY;
/
drop table M_T_HY_HF;
/


-- Create table
create table M_T_HY
(
  hy_bt      VARCHAR2(200),
  hy_kssj    VARCHAR2(200),
  hy_jssj    VARCHAR2(200),
  hy_dd      VARCHAR2(200),
  hy_lxbm    VARCHAR2(50),
  hy_lxr     VARCHAR2(50),
  hy_lxdh    VARCHAR2(50),
  hy_cyr     VARCHAR2(4000),
  hy_content VARCHAR2(200),
  hy_sfbm    CHAR(1),
  hy_sqrid   VARCHAR2(200),
  hy_sqr     VARCHAR2(200),
  hy_sqsj    VARCHAR2(200),
  hy_sqrbmid VARCHAR2(200),
  hy_sqrbm   VARCHAR2(200),
  hy_cyrid   VARCHAR2(4000),
  hy_lxrid   VARCHAR2(200),
  hy_lxbmid  VARCHAR2(200)
)
/
-- Add comments to the columns 
comment on column M_T_HY.hy_bt
  is '会议标题';
comment on column M_T_HY.hy_kssj
  is '会议开始时间';
comment on column M_T_HY.hy_jssj
  is '会议结束时间';
comment on column M_T_HY.hy_dd
  is '会议地点';
comment on column M_T_HY.hy_lxbm
  is '会议联系部门';
comment on column M_T_HY.hy_lxr
  is '会议联系人';
comment on column M_T_HY.hy_lxdh
  is '会议联系电话';
comment on column M_T_HY.hy_cyr
  is '会议参与人';
comment on column M_T_HY.hy_content
  is '会议正文';
comment on column M_T_HY.hy_sfbm
  is '是否报名';
comment on column M_T_HY.hy_sqrid
  is '申请人id';
comment on column M_T_HY.hy_sqr
  is '申请人';
comment on column M_T_HY.hy_sqsj
  is '申请时间';
comment on column M_T_HY.hy_sqrbmid
  is '申请人部门id';
comment on column M_T_HY.hy_sqrbm
  is '申请人部门';
comment on column M_T_HY.hy_cyrid
  is '会议参与人id';
comment on column M_T_HY.hy_lxrid
  is '会议联系人id';
comment on column M_T_HY.hy_lxbmid
  is '会议联系部门id';
/


-- Create table
create table M_T_HY_HF
(
  hy_replay VARCHAR2(200),
  hy_cyrid  VARCHAR2(4000),
  hy_cyr    VARCHAR2(4000),
  hy_reason VARCHAR2(200),
  hy_id     VARCHAR2(200),
  hy_bmr    VARCHAR2(200),
  hy_bmrid  VARCHAR2(200),
  hy_hfsj   VARCHAR2(200),
  hy_cyrs   VARCHAR2(200)
)
/
-- Add comments to the columns 
comment on column M_T_HY_HF.hy_replay
  is '会议回复情况 0：已读 1报名参与，9请假不参与';
comment on column M_T_HY_HF.hy_cyrid
  is '参会人id';
comment on column M_T_HY_HF.hy_cyr
  is '参会人';
comment on column M_T_HY_HF.hy_reason
  is '会议请假内容';
comment on column M_T_HY_HF.hy_id
  is '会议id';
comment on column M_T_HY_HF.hy_bmr
  is '操作人（会议接收人）';
comment on column M_T_HY_HF.hy_bmrid
  is '操作人（会议接收人）id';
comment on column M_T_HY_HF.hy_hfsj
  is '回复时间';
comment on column M_T_HY_HF.hy_cyrs
  is '参会人数';
/




drop table M_T_HY;
drop table M_T_HY_HF;



-- Create table
create table M_T_HY
(
  hy_bt      VARCHAR2(200),
  hy_kssj    VARCHAR2(200),
  hy_jssj    VARCHAR2(200),
  hy_dd      VARCHAR2(200),
  hy_lxbm    VARCHAR2(50),
  hy_lxr     VARCHAR2(50),
  hy_lxdh    VARCHAR2(50),
  hy_cyr     VARCHAR2(4000),
  hy_content VARCHAR2(200),
  hy_sfbm    CHAR(1),
  hy_sqrid   VARCHAR2(200),
  hy_sqr     VARCHAR2(200),
  hy_sqsj    VARCHAR2(200),
  hy_sqrbmid VARCHAR2(200),
  hy_sqrbm   VARCHAR2(200),
  hy_cyrid   VARCHAR2(4000),
  hy_lxrid   VARCHAR2(200),
  hy_lxbmid  VARCHAR2(200)
)
/
-- Add comments to the columns 
comment on column M_T_HY.hy_bt
  is '会议标题';
comment on column M_T_HY.hy_kssj
  is '会议开始时间';
comment on column M_T_HY.hy_jssj
  is '会议结束时间';
comment on column M_T_HY.hy_dd
  is '会议地点';
comment on column M_T_HY.hy_lxbm
  is '会议联系部门';
comment on column M_T_HY.hy_lxr
  is '会议联系人';
comment on column M_T_HY.hy_lxdh
  is '会议联系电话';
comment on column M_T_HY.hy_cyr
  is '会议参与人';
comment on column M_T_HY.hy_content
  is '会议正文';
comment on column M_T_HY.hy_sfbm
  is '是否报名';
comment on column M_T_HY.hy_sqrid
  is '申请人id';
comment on column M_T_HY.hy_sqr
  is '申请人';
comment on column M_T_HY.hy_sqsj
  is '申请时间';
comment on column M_T_HY.hy_sqrbmid
  is '申请人部门id';
comment on column M_T_HY.hy_sqrbm
  is '申请人部门';
comment on column M_T_HY.hy_cyrid
  is '会议参与人id';
comment on column M_T_HY.hy_lxrid
  is '会议联系人id';
comment on column M_T_HY.hy_lxbmid
  is '会议联系部门id';
/


-- Create table
create table M_T_HY_HF
(
  hy_replay VARCHAR2(200),
  hy_cyrid  VARCHAR2(4000),
  hy_cyr    VARCHAR2(4000),
  hy_reason VARCHAR2(200),
  hy_id     VARCHAR2(200),
  hy_bmr    VARCHAR2(200),
  hy_bmrid  VARCHAR2(200),
  hy_hfsj   VARCHAR2(200),
  hy_cyrs   VARCHAR2(200)
)
/
-- Add comments to the columns 
comment on column M_T_HY_HF.hy_replay
  is '会议回复情况 0：已读 1报名参与，9请假不参与';
comment on column M_T_HY_HF.hy_cyrid
  is '参会人id';
comment on column M_T_HY_HF.hy_cyr
  is '参会人';
comment on column M_T_HY_HF.hy_reason
  is '会议请假内容';
comment on column M_T_HY_HF.hy_id
  is '会议id';
comment on column M_T_HY_HF.hy_bmr
  is '操作人（会议接收人）';
comment on column M_T_HY_HF.hy_bmrid
  is '操作人（会议接收人）id';
comment on column M_T_HY_HF.hy_hfsj
  is '回复时间';
comment on column M_T_HY_HF.hy_cyrs
  is '参会人数';
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
   where u.m_receiver_user_id = :new.HY_BMRID---会议接收人
     and u.m_notice_id = :new.HY_ID and rownum=1;

  IF INSERTING THEN
    update oa_meeting_receiver_user u
       set u.m_reply_time    = to_date(:new.HY_HFSJ,'yyyy-mm-dd hh24:mi:ss'),
           u.m_read_time     = to_date(:new.HY_HFSJ,'yyyy-mm-dd hh24:mi:ss'),
           u.m_is_reply      = :new.HY_REPLAY,
           u.m_is_read       = '1',
           u.m_is_reply_name = decode(:new.HY_REPLAY,
                                      '1',
                                      '参加',
                                      '9',
                                      '请假',
                                      '0'),
           u.m_reply         = :new.HY_REASON,
           u.m_attender_count  = :new.HY_CYRS,
           u.m_attender_ids = :new.HY_CYRID,
           u.m_attender_names = :new.HY_CYR
     where u.m_receiver_id = M_RECEIVER_ID;
     
     if (1=:new.HY_REPLAY) then
           delete oa_meeting_attender a where a.m_receiver_id=M_RECEIVER_ID and 1=:new.HY_REPLAY;
           insert into oa_meeting_attender (
                 M_ID,
            M_RECEIVER_ID,
            M_USER_ID,
            M_USER_NAME,
            M_UNIT_ID,
            M_UNIT_NAME
            )
            select get_uuid(),M_RECEIVER_ID, COLUMN_VALUE userid ,v.username,v.unitid,v.unitname
              from table(split(:new.HY_CYRID, ',')) t, v_user_info v
             where v.userid = COLUMN_VALUE and 1=:new.HY_REPLAY;
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
       :new.HY_SQRBMID,
       :new.HY_SQRBM,
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
               (select d.user_name
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


create or replace view m_v_hy_s as
select t.m_notice_id        hy_id, --会议id
       t.m_current_time     hy_fssj, --会议发送时间
       t.m_title            hy_bt, --会议标题
       t.m_check_flag       hy_zt, --会议状态 (0送审，1审核通过，2审核不通过，3暂存，4已发布，5重新发布，6已撤销)
       t.m_current_user_id  hy_fsrid, --会议发送人（key）
       u.m_receiver_user_id hy_jsrid --会议接收人
  from oa_meeting_notice t, oa_meeting_receiver_user u
 where t.m_notice_id = u.m_notice_id;
 /
 create or replace view m_v_hy_r as
select t.m_notice_id        hy_id, --会议id
       u.m_create_time      hy_fssj, --会议发送时间
       t.m_title            hy_bt, --会议标题
       t.m_check_flag       hy_zt, --会议状态 (0送审，1审核通过，2审核不通过，3暂存，4已发布，5重新发布，6已撤销)
       t.m_current_user_id  hy_fsr, --会议发送人
       u.m_receiver_user_id hy_jsrid --会议接收人（key）
  from oa_meeting_notice t, oa_meeting_receiver_user u
 where t.m_notice_id = u.m_notice_id;
 /
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
create or replace view m_v_hy_a as
select t.m_notice_id        HY_ID, --会议id
       t.m_receiver_user_id HY_JSR, --会议接收人
       t.m_is_reply         HY_JSZT, --会议接收状态 即回复状态 1 本人参加 2 委托人参加 3 安排人参加  9 请假  0 未报名
       t.m_attender_ids     HY_CYR, --  参与人
       t.m_reply            HY_QJYY --  请假事由
  from oa_meeting_receiver_user t;
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