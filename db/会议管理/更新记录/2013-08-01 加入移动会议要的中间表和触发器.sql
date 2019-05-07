CREATE OR REPLACE FUNCTION SPLIT(P_LIST VARCHAR2,

   P_SEP VARCHAR2 := ',')
RETURN OA_TYPE_SPLIT PIPELINED

 IS

   L_IDX  PLS_INTEGER;

   V_LIST  VARCHAR2(4000) := P_LIST;

BEGIN

   LOOP

      L_IDX := INSTR(V_LIST,P_SEP);

      IF L_IDX > 0 THEN

          PIPE ROW(SUBSTR(V_LIST,1,L_IDX-1));

          V_LIST := SUBSTR(V_LIST,L_IDX+LENGTH(P_SEP));

      ELSE

          PIPE ROW(V_LIST);

          EXIT;

      END IF;

   END LOOP;

   RETURN;

END SPLIT;


CREATE OR REPLACE FUNCTION get_uuid
RETURN VARCHAR
IS
guid VARCHAR (50);
BEGIN
guid := lower(RAWTOHEX(sys_guid()));
RETURN
substr(guid,1,8)||'-'||substr(guid,9,4)||'-'||substr(guid,13,4)||'-'||substr(guid,17,4)||'-'||substr(guid,21,12);
END get_uuid;


drop trigger MOBILE_BUSI_HUIYI_TR4INSERT
/

drop table MOBILE_BUSI_HUIYI cascade constraints
/

/*==============================================================*/
/* Table: MOBILE_BUSI_HUIYI                                     */
/*==============================================================*/
create table MOBILE_BUSI_HUIYI 
(
   HY_BT                VARCHAR2(200),
   HY_KSSJ              DATE,
   HY_JSSJ              DATE,
   HY_DD                VARCHAR2(200),
   HY_LXBM              VARCHAR2(50),
   HY_LXR               VARCHAR2(50),
   HY_LXDH              VARCHAR2(50),
   HY_CYR               VARCHAR2(200),
   CONTENT              VARCHAR2(200),
   M_TYPE_ID            VARCHAR2(50),
   M_TYPE_NAME          VARCHAR2(50),
   M_IS_NEED_SIGNUP     CHAR,
   M_CREATE_USER_ID     VARCHAR2(50),
   M_CREATE_USER_NAME   VARCHAR2(50),
   M_CREATE_TIME        DATE,
   M_CREATE_DEPT_ID     VARCHAR2(50),
   M_CREATE_DEPT_NAME   VARCHAR2(50),
   M_CHECK_FLAG         CHAR,
   M_CHECK_FLAG_NAME    CHAR(10),
   HY_CYRID             VARCHAR2(200),
   HY_LXRID             VARCHAR2(50),
   HY_LXBMID            VARCHAR2(50),
   M_CURRENT_USER_ID    VARCHAR2(50),
   M_CURRENT_USER_NAME  VARCHAR2(50),
   M_CURRENT_TIME       DATE
)
/

comment on table MOBILE_BUSI_HUIYI is
'移动端会议中间表'
/

comment on column MOBILE_BUSI_HUIYI.HY_BT is
'会议标题'
/

comment on column MOBILE_BUSI_HUIYI.HY_KSSJ is
'开始时间'
/

comment on column MOBILE_BUSI_HUIYI.HY_JSSJ is
'结束时间'
/

comment on column MOBILE_BUSI_HUIYI.HY_DD is
'地点'
/

comment on column MOBILE_BUSI_HUIYI.HY_LXBM is
'联系部门'
/

comment on column MOBILE_BUSI_HUIYI.HY_LXR is
'联系人'
/

comment on column MOBILE_BUSI_HUIYI.HY_LXDH is
'联系电话'
/

comment on column MOBILE_BUSI_HUIYI.HY_CYR is
'参与人'
/

comment on column MOBILE_BUSI_HUIYI.CONTENT is
'内容'
/

comment on column MOBILE_BUSI_HUIYI.M_TYPE_ID is
'会议类型id'
/

comment on column MOBILE_BUSI_HUIYI.M_TYPE_NAME is
'会议类型name'
/

comment on column MOBILE_BUSI_HUIYI.M_IS_NEED_SIGNUP is
'是否需要报名（0否1是，默认不报名）'
/

comment on column MOBILE_BUSI_HUIYI.M_CREATE_USER_ID is
'申请人id'
/

comment on column MOBILE_BUSI_HUIYI.M_CREATE_USER_NAME is
'申请人name'
/

comment on column MOBILE_BUSI_HUIYI.M_CREATE_TIME is
'申请时间'
/

comment on column MOBILE_BUSI_HUIYI.M_CREATE_DEPT_ID is
'申请人部门id'
/

comment on column MOBILE_BUSI_HUIYI.M_CREATE_DEPT_NAME is
'申请人部门name'
/

comment on column MOBILE_BUSI_HUIYI.M_CHECK_FLAG is
'会议通知状态'
/

comment on column MOBILE_BUSI_HUIYI.M_CHECK_FLAG_NAME is
'会议通知状态name'
/

comment on column MOBILE_BUSI_HUIYI.HY_CYRID is
'参与人id'
/

comment on column MOBILE_BUSI_HUIYI.HY_LXRID is
'联系人id'
/

comment on column MOBILE_BUSI_HUIYI.HY_LXBMID is
'联系部门id'
/

comment on column MOBILE_BUSI_HUIYI.M_CURRENT_USER_ID is
'发布人'
/

comment on column MOBILE_BUSI_HUIYI.M_CURRENT_USER_NAME is
'发布name'
/

comment on column MOBILE_BUSI_HUIYI.M_CURRENT_TIME is
'发布时间'
/


create or replace trigger MOBILE_BUSI_HUIYI_TR4INSERT
  after insert
ON mobile_busi_huiyi
  FOR EACH ROW
DECLARE
  NEW_NOTICE_ID varchar2(50);
BEGIN
  select get_uuid() into NEW_NOTICE_ID from dual; --记住主键id值用于从表的插入
  IF INSERTING THEN
    insert into oa_meeting_notice
      (m_notice_id,
       m_title,
       m_type_id,
       m_type_name,
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
       :new.m_type_id,
       :new.m_type_name,
       :new.hy_kssj,
       :new.hy_jssj,
       :new.hy_dd,
       :new.hy_lxrid,
       :new.hy_lxr,
       :new.hy_lxbmid,
       :new.hy_lxbm,
       :new.hy_lxdh,
       :new.m_is_need_signup,
       :new.m_create_user_id,
       :new.m_create_user_name,
       :new.m_create_time,
       :new.m_create_dept_id,
       :new.m_create_dept_name,
       :new.m_check_flag,
       :new.m_check_flag_name,
       :new.m_current_user_id,
       :new.m_current_user_name,
       :new.m_current_time,
       '0',
       '0',
       :new.hy_cyrid,
       :new.hy_cyr,
       :new.content);
  
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
               :new.m_current_time,
               '0',
               '0',
               '0'
          from table(split(:new.HY_CYRID, ',')) t;
    end if;
  end if;
END MOBILE_BUSI_HUIYI_TR4INSERT;
/

drop trigger mobile_busi_huiyihf_TR4INSERT
/

drop table MOBILE_BUSI_HUIYIHF cascade constraints
/

/*==============================================================*/
/* Table: MOBILE_BUSI_HUIYIHF                                   */
/*==============================================================*/
create table MOBILE_BUSI_HUIYIHF 
(
   HY_REPLAY            VARCHAR2(200),
   HY_CYR               VARCHAR2(50),
   HY_REASON            VARCHAR2(200),
   HY_ID                VARCHAR2(200),
   M_CREATE_TIME        DATE,
   M_IS_READ            CHAR,
   M_REPLY_TIME         DATE,
   HY_CYRID             VARCHAR2(50),
   HY_CYRBMID           VARCHAR2(50),
   HY_CYRBM             VARCHAR2(50)
)
/

comment on table MOBILE_BUSI_HUIYIHF is
'移动端会议回复中间表'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_REPLAY is
'回复状态(1参加,0未报名,2请假)'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_CYR is
'参与人'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_REASON is
'请假内容'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_ID is
'会议id'
/

comment on column MOBILE_BUSI_HUIYIHF.M_CREATE_TIME is
'接收时间(会议通知发送的时间 即记录产生时间,默认插入)'
/

comment on column MOBILE_BUSI_HUIYIHF.M_IS_READ is
'是否已读(1是,0否,默认0)'
/

comment on column MOBILE_BUSI_HUIYIHF.M_REPLY_TIME is
'回复时间 (与会人员确认回复时间)'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_CYRID is
'参与人id'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_CYRBMID is
'参与人部门id'
/

comment on column MOBILE_BUSI_HUIYIHF.HY_CYRBM is
'参与人部门'
/


create or replace trigger mobile_busi_huiyihf_TR4INSERT
  after insert
ON mobile_busi_huiyihf
  FOR EACH ROW
DECLARE
  M_RECEIVER_ID varchar2(50);
BEGIN
  select u.m_receiver_id
    into M_RECEIVER_ID
    from oa_meeting_receiver_user u
   where u.m_receiver_user_id = :new.HY_CYRID
     and u.m_notice_id = :new.HY_ID;

  IF INSERTING THEN
    update oa_meeting_receiver_user u
       set u.m_reply_time    = :new.M_CREATE_TIME,
           u.m_read_time     = :new.M_CREATE_TIME,
           u.m_is_reply      = :new.HY_REPLAY,
           u.m_is_read       = '1',
           u.m_is_reply_name = decode(:new.HY_REPLAY,
                                      '1',
                                      '参加',
                                      '2',
                                      '请假',
                                      '0'),
           u.m_reply         = :new.HY_REASON 
     where u.m_receiver_id = M_RECEIVER_ID;
  end if;
END mobile_busi_huiyihf_TR4INSERT;
/