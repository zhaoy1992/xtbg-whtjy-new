CREATE OR REPLACE VIEW M_V_RW_D AS
SELECT
       p.detail_id as RW_ID,--任务id
       p.item as RW_MC,--任务名称
       u1.user_realname as RW_FQR,--任务发起人
       '' as RW_NR,--任务内容
       '' as RW_FQRDW,--任务发起人单位
       p.owner,
       u2.user_realname owner_name,
       to_char(p.start_time, 'yyyy-mm-dd')  AS RW_KSSJ ,--任务开始时间
       to_char(p.end_time, 'yyyy-mm-dd') end_time,
       decode(p.isfinish,'0','未完成','1','已完成')  as RW_ZT,--任务状态
       decode(p.isurge,'0','普通任务','1','催办任务')  as RW_LX, --任务类型
       p.solution,
       p.program,
       p.remark,
       to_char(p.updatetime, 'yyyy-mm-dd hh:mi:ss') updatetime,
       p.change_times,
       p.urge_user,
       u3.user_realname urge_user_name,
       to_char(p.urge_time, 'yyyy-mm-dd') urge_time,
       to_char(p.finish_time, 'yyyy-mm-dd') as RW_WCSJ, --任务完成时间
       '0' as RW_SFYX, --是否有效
       '' as RW_FJID,--附件id
       '' as RW_FJSl --附件数量
  from wc_plan_info p
  left join td_sm_user u1
    on p.hedaer = u1.user_id
  left join td_sm_user u2
    on p.owner = u2.user_id
  left join td_sm_user u3
    on p.urge_user = u3.user_id;

/


CREATE OR REPLACE VIEW M_V_RW_R AS
SELECT
       WPI.DETAIL_ID AS RW_ID, --任务id
       WPI.ITEM RW_MC,         --任务名称
       '一般任务' AS RW_LX ,            --任务类型
       --WPI.ISFINISH RW_ZTbs,
       TO_CHAR(WPI.START_TIME, 'yyyy-MM-dd') AS RW_KSSJ, --任务开始时间
       --TO_CHAR(WPI.END_TIME, 'yyyy-MM-dd') AS RW_JSSJ, --任务结束时间
       WPI.owner AS RW_JSRID, --任务接收人id
       (select u.user_realname from td_sm_user u where u.user_id= WPI.Hedaer) as rw_fsr,--任务发送人
       --DECODE(WPI.ISFINISH, 0, '未完成', 1, '未完成', '-') as RW_ZT --任务状态
       decode(WPI.ISFINISH,'0','办理中','已完成') as RW_ZT --任务状态
  FROM WC_PLAN_INFO WPI;

/


CREATE OR REPLACE VIEW M_V_RW_S AS
SELECT
       WPI.DETAIL_ID AS RW_ID, --任务id
       WPI.ITEM RW_MC,         --任务名称
       '一般任务' AS RW_LX ,            --任务类型
       --WPI.ISFINISH RW_ZTbs,
       TO_CHAR(WPI.START_TIME, 'yyyy-MM-dd') AS RW_KSSJ, --任务开始时间
       --TO_CHAR(WPI.END_TIME, 'yyyy-MM-dd') AS RW_JSSJ, --任务结束时间
       WPI.Urge_User AS RW_JSRID, --任务接收人id
       (select u.user_realname from td_sm_user u where u.user_id= WPI.Hedaer) as rw_fsr,--任务发送人
       --DECODE(WPI.ISFINISH, 0, '未完成', 1, '未完成', '-') as RW_ZT --任务状态
       decode(WPI.ISFINISH,'0','办理中','已完成') as RW_ZT --任务状态
  FROM WC_PLAN_INFO WPI;

/

create or replace trigger PTMX_WC_RWJB after insert or delete
/**
*任务交办
*王焕兵
**/
ON wc_plan_info
FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
BEGIN
select seq_android_wait.nextval into new_wait_id from dual;
    --新增
    IF INSERTING  THEN
      insert into M_AA_WAIT(wait_id, business_id, business_type, title, content, curd_type)
      values(new_wait_id, :new.detail_id , 'renwu','',:new.item,'0');
      --交办人
      if(:new.urge_user is not null) then
      insert into M_AA_UF(WAIT_ID,USER_ID)
      values(new_wait_id,:new.urge_user);
      end if;

      --责任人
      if(:new.owner is not null) then
      insert into M_AA_UF(WAIT_ID,USER_ID)
      values(new_wait_id,:new.owner);
      end if;

      delete M_AA_UF where rowid not in (
      select max(rowid) from M_AA_UF group by user_id ,wait_id) and wait_id=new_wait_id;
    ELSIF DELETING THEN --删除
      insert into M_AA_WAIT(wait_id, business_id, business_type, title, content, curd_type)
      values(new_wait_id, :new.detail_id , 'renwu','',:new.item,'1');
    end if;
END PTMX_WC_RWJB;

