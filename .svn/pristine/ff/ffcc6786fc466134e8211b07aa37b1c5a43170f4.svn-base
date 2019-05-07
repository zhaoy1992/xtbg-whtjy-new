create or replace view m_v_rc_b as
select leaderschedule_id RC_ID,
       theme RC_ZT,
       address RC_DZ,
       important_level RC_ZYJB,
       starttime RC_KSSJ,
       endtime RC_JSSJ,
       remind_type STATION_TYPE,
       schdule_describe RC_ZW,
       leader_userid RC_LDID,
       TO_CHAR(createtime, 'yyyy-mm-dd hh24:mi:ss') RC_CJSJ
  from ta_oa_leaderschedule
/**
* 描述:日程-当取日程数据[原视图:]
* 参数列表:
* 1  RC_ID  日程id
* 2  RC_ZT  日程主题
* 3  RC_DZ  日程地址
* 4  RC_ZYJB  日程重要级别
* 5  RC_CJSJ  日程创建时间
* 6  RC_KSSJ  日程开始时间
* 7  RC_JSSJ  日程结束时间
* 8  RC_LDID  日程领导id
* 9  RC_ZW  正文
* 10  RC_SFYX  是否有效
* 时间:2013-8-8
* 作者:tuo.zou
*/;




CREATE OR REPLACE VIEW M_V_RC_U AS
SELECT A.USER_ID                YH_ID,
       A.USER_REALNAME          YH_M,
       TSON.ORG_NAME            YH_JGM,
       A.RESOURCES_CONFIGTYPEID YH_DQYHID
  FROM (SELECT DISTINCT A.RESOURCES_CONFIGTYPEID,
                        TSU.USER_ID,
                        TSU.USER_REALNAME
          FROM (SELECT TORC.RESOURCES_CONFIGTYPEID, IDS
                  FROM TA_OA_RESOURCES_CONFIG TORC
                 WHERE TORC.RESOURCES_ID = '21'
                    OR TORC.RESOURCES_ID = '22') A,
               TD_SM_USER TSU
         WHERE ',' || A.IDS || ',' LIKE '%,' || TSU.USER_ID || ',%') A,
       TD_SM_ORGUSER TSO,
       TD_SM_ORGANIZATION TSON
 WHERE A.USER_ID = TSO.USER_ID
   AND TSO.ORG_ID = TSON.ORG_ID
/**
* 描述:日程-当前用户可查看的人员列表[原视图:]

* 参数列表:
* 1  YH_ID  用户id
* 2  YH_M  用户名
* 3  YH_JGM  用户机构名
* 4  YH_DQYHID  当前用户ID
* 时间:2013-8-9
* 作者:tuo.zou
*/;


create or replace trigger "PTMX_PUBLIC_LDRC" after insert or delete
/**
 * 向moblie端领导日程消息表出发代办消息数据
 * 描述:PTMX_PUBLIC_LDRC:(PTMX:PC端的真实表-->MOBILE端的消息表(X))(_PUBLIC_LDRC:所属系统是YMJ,所属功能点是领导日程)
 * 原触发器:mobile_ldrc
 * tuo.zou
 * 2013-8-13
 */
ON ta_oa_leaderschedule
FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
BEGIN
select seq_android_wait.nextval into new_wait_id from dual;
    IF INSERTING  THEN
      insert into M_AA_WAIT(wait_id, business_id, business_type, title, content, curd_type)
      values(new_wait_id, :new.leaderschedule_id, 'richeng','',:new.theme,'0');
      if(:new.leader_userid is not null) then
      insert into M_AA_UF(WAIT_ID,USER_ID)
      select new_wait_id,t.column_value
      from table(split(:new.leader_userid,',')) t;
      end if;

      delete M_AA_UF where rowid not in (
      select max(rowid) from M_AA_UF group by user_id ,wait_id) and wait_id=new_wait_id;

    ELSIF DELETING THEN
      insert into M_AA_WAIT(wait_id, business_id, business_type, title, content, curd_type)
      values(new_wait_id, :new.leaderschedule_id, 'richeng','',:new.theme,'1');
    end if;
END PTMX_PUBLIC_LDRC;
