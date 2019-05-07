--接收到的通知列表
create or replace view M_V_TZ_R as
select b.n_notice_id as TZ_ID,
       b.n_title as TZ_BT,
       b.n_release_username as TZ_FSR,
       to_char(b.n_release_time, 'yyyy-mm-dd hh24:mi:ss') TZ_FSSJ,
       r.n_receiver_userid as TZ_JSRID,
       decode(r.n_isview, '0', '未查看', '1', '已查看', '2', '撤销') as TZ_ZT, 
       (select count(*) from oa_fc_attach f where f.djbh = b.n_attach_id) as TZ_FJSL
  from oa_notice_baseinfo b, oa_notice_receiver_user r
 where r.n_notice_id = b.n_notice_id
   and b.n_state in (1, 2)
   and r.n_isdel != '1'
 order by n_release_time desc;


--已发送的通知列表
create or replace view M_V_TZ_S as
select b.n_notice_id as TZ_ID,
       b.n_title as TZ_BT,
       b.n_release_userid as TZ_FSRID,
       to_char(b.n_release_time, 'yyyy-mm-dd hh24:mi:ss') as TZ_FSSJ,
      '已发布' as TZ_ZT,
      (select count(*) from oa_fc_attach f where f.djbh = b.n_attach_id) as TZ_FJSL,
      b.n_receiver_username as TZ_TZJSR
  from oa_notice_baseinfo b
 where b.n_state = '1'
 order by n_release_time desc;

--通知详情
create or replace view M_V_TZ_D as
select b.n_notice_id as TZ_ID,
       b.n_title as TZ_BT,
       b.n_content as TZ_TZZW,
       b.n_creator_userid,
       b.n_creator_username,
       b.n_creator_time,
       b.n_release_username as TZ_FSR,
       to_char(b.n_release_time, 'yyyy-mm-dd hh24:mi:ss') as TZ_FSSJ,
       b.n_attach_id as TZ_FJID,
       b.n_unit_name as TZ_FSRJG,
       '是' as TZ_SFYX,
       (select count(*) from oa_fc_attach f where f.djbh = b.n_attach_id) as TZ_FJSL
  from oa_notice_baseinfo b;


-- 通知公告新增
create table M_T_TZ
(
  TZ_BT      VARCHAR2(200),
  TZ_JSR     VARCHAR2(4000),
  TZ_JSRID   VARCHAR2(4000),
  TZ_CONTENT VARCHAR2(4000),
  TZ_FSRID   VARCHAR2(200),
  TZ_FSRMZ   VARCHAR2(200),
  TZ_FSRBMMZ VARCHAR2(200),
  TZ_FSRBMID VARCHAR2(200)
);
comment on table M_T_TZ
  is '通知公告新增';
comment on column M_T_TZ.TZ_BT
  is '通知标题';
comment on column M_T_TZ.TZ_JSR
  is '通知接收人';
comment on column M_T_TZ.TZ_JSRID
  is '通知接收人ids';
comment on column M_T_TZ.TZ_CONTENT
  is '通知内容';
comment on column M_T_TZ.TZ_FSRID
  is '通知发送人id';
comment on column M_T_TZ.TZ_FSRMZ
  is '通知发送人名称';
comment on column M_T_TZ.TZ_FSRBMMZ
  is '发送人部门';
comment on column M_T_TZ.TZ_FSRBMID
  is '发送人部门id';

  
create or replace trigger M_T_TZ_INSERT
  after insert ON M_T_TZ
  FOR EACH ROW
DECLARE
  new_n_notice_id varchar2(50);
BEGIN
  select get_uuid() into new_n_notice_id from dual; --记住主键id值用于从表的插入
  IF INSERTING THEN
    insert into oa_notice_baseinfo
      (n_notice_id, --公告ID
       n_title, --公告标题
       n_content, --公告内容
       n_creator_userid, --创建人ID
       n_creator_username, --创建人名称
       n_creator_time, --创建时间
       n_release_userid, --发布人id
       n_release_username, --发布人名称
       n_release_time, --发布时间
       n_state, --公告状态(0暂存，1已发布)
       n_orgid, --部门ID
       n_orgname, --部门名称
       n_unit_id, --单位ID
       n_unit_name, --单位名称
       n_unit_or_personal, --单位或个人 (1:单位 0:个人)
       n_isphone, --否是手机端发送(1:是，0:不是)
       n_receiver_userid, --接收人员ID
       n_receiver_username --接收人员名称
       )
    values
      (new_n_notice_id, --公告ID
       :new.TZ_BT, --公告标题
       :new.TZ_CONTENT, --公告内容
       :new.TZ_FSRid, --创建人ID
       :new.TZ_FSRMZ, --创建人名称
       sysdate, --创建时间
       :new.TZ_FSRid, --发布人id
       :new.TZ_FSRMZ, --发布人名称
       sysdate, --发布时间
       '1', --公告状态(0暂存，1已发布)
       :new.TZ_FSRBMID, --部门ID
       :new.TZ_FSRBMMZ, --部门名称
       OA_USERPROPERTY(:new.TZ_FSRid, '1'), --单位ID
       OA_USERPROPERTY(:new.TZ_FSRid, '2'), --单位名称
       '0', --单位或个人 (1:单位 0:个人)
       '1', --否是手机端发送(1:是，0:不是)
       :new.TZ_JSRID, --接收人员ID
       :new.TZ_JSR --接收人员名称
       );

    if (:new.TZ_JSRID is not null) then
      insert into oa_notice_receiver_user u
        (n_receiverid, --主键ID
         n_notice_id, --公告ID
         n_receiver_userid, --接收人ID
         n_receiver_username, --接收人名称
         n_receiveruser_orgid, --接收人单位ID
         n_receiveruser_orgname, --接收人单位名称
         n_isview, --是否已查看(1:是，0:不是)
         n_creator_time, --创建时间
         n_isdel --是否已删除(1:是，0:不是)
         )
        select get_uuid(), --主键ID
               new_n_notice_id, --公告ID
               COLUMN_VALUE, --接收人ID
               (select d.user_name
                  from td_sm_user d
                 where d.user_id = COLUMN_VALUE), --接收人名称
               (select OA_USERPROPERTY(org.org_id, '2')
                  from td_sm_orguser org
                 where org.user_id = t.COLUMN_VALUE),--接收人单位ID
              (select OA_USERPROPERTY(org.org_id, '1')
                  from td_sm_orguser org
                 where org.user_id = t.COLUMN_VALUE),--接收人单位名称
               '0',
               sysdate,
               '0'
          from table(split(:new.TZ_JSRID, ',')) t;
    end if;
  end if;
END M_T_TZ_INSERT;
/

-- 通知公告(未查看->已查看)
create table M_T_TZ_CK
(
  TZ_ID      VARCHAR2(200),
  TZ_CKRID     VARCHAR2(200),
  TZ_ZT   VARCHAR2(200)
);
comment on table M_T_TZ_CK
  is '通知公告(未查看->已查看)';
comment on column M_T_TZ_CK.TZ_ID
  is '通知id';
comment on column M_T_TZ_CK.TZ_CKRID
  is '通知查看人id';
comment on column M_T_TZ_CK.TZ_ZT
  is '通知状态';
  
create or replace trigger M_T_TZ_CK_UPDATE --查看表
  after insert ON M_T_TZ_CK
  FOR EACH ROW
DECLARE
  v_n_receiverid varchar2(50);
BEGIN
  select u.n_receiverid
    into v_n_receiverid
    from oa_notice_receiver_user u
   where u.n_receiver_userid = :new.TZ_CKRID --通知查看人id
     and u.n_notice_id = :new.TZ_ID
     and rownum = 1;

  IF INSERTING THEN
    update oa_notice_receiver_user
       set n_isview = decode(:new.TZ_ZT, '已查看', '1')
     where n_receiverid = v_n_receiverid;
  end if;
END M_T_TZ_CK_UPDATE;
/

create or replace trigger m_oa_notice_baseinfo after insert or update
ON oa_notice_baseinfo
FOR EACH ROW
declare v_wait_id varchar2(50);

BEGIN
    select  sys_guid() into v_wait_id from dual;
    IF INSERTING  THEN --新增
      if (:new.n_state = '1') then
	      insert into M_AA_WAIT (wait_id, business_id, business_type, content,  curd_type)
	      values(v_wait_id ,:new.n_notice_id,'tongzhi',:new.n_title,'c');
      end if;
    ELSIF UPDATING THEN --更新
      if (:new.n_state = '1') then
	      insert into M_AA_WAIT (wait_id, business_id, business_type, content,  curd_type)
	      values(v_wait_id ,:new.n_notice_id,'tongzhi',:new.n_title,'u');
      end if;
    end if;
END m_oa_notice_baseinfo;
/


create or replace trigger m_oa_notice_receiver_user after insert or update
ON oa_notice_receiver_user
FOR EACH ROW
declare v_wait_id varchar2(50);
 v_n_state varchar2(50);
BEGIN
    select  max(wait_id) into v_wait_id from M_AA_WAIT where BUSINESS_ID = :new.n_notice_id;
    select  n_state into v_n_state from oa_notice_baseinfo where n_notice_id = :new.n_notice_id;
    IF INSERTING  THEN --新增
      if (v_wait_id is not null) then
	       insert into M_AA_UF (WAIT_ID,USER_ID) values(v_wait_id,:new.n_receiver_userid);
      end if;
    ELSIF UPDATING THEN --更新
      if (v_n_state is not null and v_n_state = '1') then
	       insert into M_AA_UF (WAIT_ID,USER_ID) values(v_wait_id,:new.n_receiver_userid);
      end if;
    end if;
END m_oa_notice_receiver_user;
/

--测试脚本
/*
insert into M_T_TZ
  (TZ_BT,
   TZ_JSR,
   TZ_JSRID,
   TZ_CONTENT,
   TZ_FSRID,
   TZ_FSRMZ,
   TZ_FSRBMMZ,
   TZ_FSRBMID)
values
  ('手机test001',
   '张三,黄艺平',
   '23,14',
   '手机test001',
   '23',
   '张三',
   '政府行业事业部',
   'e758632d-7520-46dc-8bac-ed16d4fa4f28')
   
   insert into M_T_TZ_CK
  (TZ_ID,
   TZ_CKRID,
   TZ_ZT)
values
  ('e58ac7e9-4066-315c-e043-0100007fa538',
   '23',
   '已查看'
   )*/


