
-- Create table
create  table  M_BB_ADBOOK
(
  ID        VARCHAR2(50),
  TYPE      VARCHAR2(50),
  OPERATION VARCHAR2(50),
  VERSION   VARCHAR2(50)
);
-- Add comments to the columns 
comment on column M_BB_ADBOOK.ID
  is '用户id/机构id';
comment on column M_BB_ADBOOK.TYPE
  is '用户或者机构 O:机构；U:用户';
comment on column M_BB_ADBOOK.OPERATION
  is '增删改 C:新增；U:修改；D:删除';
comment on column M_BB_ADBOOK.VERSION
  is '版本序号 每次加1';
  
 create or replace view m_v_yh as
 select u.USER_ID YH_ID,
        u.USER_NAME YH_DLM,
        u.user_password YH_MM,
        u.user_realname YH_ZWM,
        u.USER_MOBILETEL1 YH_DH,
        u.USER_HOMETEL YH_ZZDH,
        u.USER_EMAIL YH_YJ,
        u.user_sn YH_PXH,
        o.org_id YH_JG
   from td_sm_user u, td_sm_orguser o
  where u.user_id = o.user_id;

create or replace view M_V_JG as
select  o.org_id JG_ID, 
        o.org_name JG_MC, 
        o.PARENT_ID JG_FJGID, 
        o.ORG_XZQM JG_QYBM, 
        o.ORG_SN JG_PXH
  from td_sm_organization o;
  
create or replace trigger mobile_td_sm_user after insert or delete or update
/**
*类型:用户表添加触发器
*作者:戴连春
**/
ON td_sm_user
FOR EACH ROW
DECLARE
  new_version VARCHAR(50);
BEGIN
    select decode(max(to_number(version) + 1), null,1,max(to_number(version) + 1))
     into new_version  from M_BB_ADBOOK;

    IF INSERTING  THEN --新增
      insert into m_bb_adbook(id, type, operation, version)
      values(:new.user_id ,'U','C',new_version);
    ELSIF UPDATING THEN --更新
      insert into m_bb_adbook(id, type, operation, version)
      values(:new.user_id ,'U','U',new_version);
    ELSIF DELETING THEN --删除
      insert into m_bb_adbook(id, type, operation, version)
      values(:old.user_id ,'U','D',new_version);
    end if;
END mobile_td_sm_user;

create or replace trigger mobile_td_sm_organization after insert or delete or update
/**
*类型:机构表添加触发器
*作者:戴连春
**/
ON td_sm_organization
FOR EACH ROW
DECLARE
  new_version VARCHAR(50);
BEGIN
    select decode(max(to_number(version) + 1),null,1,max(to_number(version) + 1))
     into new_version from M_BB_ADBOOK;

    IF INSERTING  THEN --新增
      insert into m_bb_adbook(id, type, operation, version)
      values(:new.org_id ,'O','C',new_version);
    ELSIF UPDATING THEN --更新
      insert into m_bb_adbook(id, type, operation, version)
      values(:new.org_id ,'O','U',new_version);
    ELSIF DELETING THEN --删除
      insert into m_bb_adbook(id, type, operation, version)
      values(:old.org_id ,'O','D',new_version);
    end if;
END mobile_td_sm_organization;
