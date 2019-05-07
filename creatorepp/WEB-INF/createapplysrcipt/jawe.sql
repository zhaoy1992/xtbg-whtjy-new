--------平台V3.0工作流脚本开始--------
/**
 * 注意：请用&app_user登陆数据库，然后执行本SQL文件
 *
 * &app_deftablespace : 应用数据库缺省表空间
 * &app_temptablespace : 应用数据库临时表空间
 * &app_user : 应用数据库用户
 * &app_id   : 应用ID
 * &egp_user : 平台数据库用户
 */
 --start
CREATE OR REPLACE FUNCTION "SUM_STRING" (tablename IN VARCHAR2,fieldname IN VARCHAR2,wherecondistion IN VARCHAR2)
RETURN VARCHAR2 AS
tmpsql VARCHAR2(4000);
tmparray Dbms_Sql.Varchar2_Table;
retval VARCHAR2(4000) DEFAULT '';
BEGIN
tmpsql := 'select '||fieldname||' from '||tablename||' '||wherecondistion;
EXECUTE IMMEDIATE tmpsql BULK COLLECT INTO tmparray ;
IF(tmparray.Count=0) then
RETURN '';
END IF;
retval:=tmparray(1);
FOR i IN 2..tmparray.count LOOP
retval := retval||','||tmparray(i);
END LOOP;
RETURN retval;
END;
--end;

 
/*==============================================================*/
/* Table: WORKFLOW_OPERATE_LOG                                  */
/*==============================================================*/
create table WORKFLOW_OPERATE_LOG  (
   LOG_ID               VARCHAR2(50)                    not null,
   BUSINESS_ID          VARCHAR2(50),
   OPERATE_TIME         DATE,
   OPERATE_USER         VARCHAR2(50),
   OPERATE_TYPE         VARCHAR2(100),
   OPERATE_PARAMS       VARCHAR2(2000),
   OPERATE_RESULT       CHAR(1),
   PROC_DEFNAME         VARCHAR2(200),
   ACT_DEFID            VARCHAR2(90),
   PROC_INSTANCEID      VARCHAR2(100),
   ACT_INSTANCEID       VARCHAR2(100),
   MODULE_ID            VARCHAR2(100),
   APP_ID               VARCHAR2(20),
   constraint PK_WORKFLOW_OPERATE_LOG primary key (LOG_ID)
);

comment on table WORKFLOW_OPERATE_LOG is
'工作流操作日志';

comment on column WORKFLOW_OPERATE_LOG.LOG_ID is
'日志ID';

comment on column WORKFLOW_OPERATE_LOG.BUSINESS_ID is
'业务ID';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_TIME is
'操作时间';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_USER is
'操作用户';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_TYPE is
'流程操作类型';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_PARAMS is
'操作参数（JSON格式）';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_RESULT is
'流程操作结果';

comment on column WORKFLOW_OPERATE_LOG.PROC_DEFNAME is
'流程定义名称';

comment on column WORKFLOW_OPERATE_LOG.ACT_DEFID is
'活动定义ID';

comment on column WORKFLOW_OPERATE_LOG.PROC_INSTANCEID is
'流程实例ID';

comment on column WORKFLOW_OPERATE_LOG.ACT_INSTANCEID is
'活动实例ID';

comment on column WORKFLOW_OPERATE_LOG.MODULE_ID is
'事项ID';

comment on column WORKFLOW_OPERATE_LOG.APP_ID is
'所属应用ID';
   
--待办视图
-- modify by minghua.guo 2010-06-10 删除业务类别
CREATE OR REPLACE FORCE VIEW "V_APP_WORK_LIST" ("PKGID", "ACTNAME", "BUSITITLE", "BUSINESSID", "ACTID", "PROCID", "USERNAME", "MODULE_ID", "ACTDEFID") AS 
  select v.pkgId,
 v.actname,
 case
 when m.BUSITITLE is not null then
 m.BUSITITLE
 else
 (select max(t.BUSITITLE)
 from &egp_user.td_proc_form_instancemap t
 where v.activityrequesterprocessid = t.procinstanceid)
 end as BUSITITLE,
 case
 when m.businessid is not null then
 m.businessid
 else
 (select max(t.businessid)
 from &egp_user.td_proc_form_instancemap t
 where v.activityrequesterprocessid = t.procinstanceid)
 end as businessid,
 v.actId,
 v.procId,
 v.username,
 m.module_id,
 v.actDefId
 from &egp_user.v_Worklist v,
 (select t.businessid,
 t.BUSITITLE,
 t.module_id,
 t.app_id,
 procinstanceid
 from &egp_user.td_proc_form_instancemap t) m,
 &egp_user.activitystates
 where
  (v.procId = m.procinstanceid or
 v.activityrequesterprocessid = m.procinstanceid)
 and activitystates.oid = v.state
 and activitystates.keyvalue <> 'open.not_running.suspended'
 and m.app_id = '&app_id'
 and not exists (select '1'
 from &egp_user.td_worklist_tobe t
 where v.actId = t.act_ins_id)
 and v.limittime > (
 TO_CHAR((SYSDATE -
 TO_DATE('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') -
 (1 / 3)) * 24 * 60 * 60 * 1000,
 '999999999999999'))
 --add by luming.tang 用于过滤流程失败的记录
 and not exists(select '1' from workflow_operate_log l where l.operate_result='N' and v.username=l.operate_user and v.actId=l.act_instanceid)

;
COMMENT ON COLUMN &app_user."V_APP_WORK_LIST"."PKGID" IS '流程';
COMMENT ON COLUMN &app_user."V_APP_WORK_LIST"."ACTNAME" IS '活动';
COMMENT ON COLUMN &app_user."V_APP_WORK_LIST"."BUSITITLE" IS '表单名称';
COMMENT ON COLUMN &app_user."V_APP_WORK_LIST"."BUSINESSID" IS '业务编号';

--创建索引，提高待办视图查询效率 开始 minghua.guo
--DROP INDEX IDX_WORKFLOW_OPERATE_LOG;
CREATE INDEX IDX_WORKFLOW_OPERATE_LOG ON WORKFLOW_OPERATE_LOG
		(OPERATE_USER, OPERATE_RESULT, ACT_INSTANCEID)
		LOGGING
		TABLESPACE &app_deftablespace
		PCTFREE    10
		INITRANS   2
		MAXTRANS   255
		STORAGE    (
		            INITIAL          64K
		            MINEXTENTS       1
		            MAXEXTENTS       UNLIMITED
		            PCTINCREASE      0
		            BUFFER_POOL      DEFAULT
		           )
		NOPARALLEL;
--为待办视图创建索引，提高待办视图查询效率 结束

--流程操作日志
CREATE OR REPLACE FORCE VIEW "V_APP_WORKFLOW_OPERATE_LOG" ("LOG_ID", "BUSINESS_ID", "OPERATE_TIME", "OPERATE_USER", "OPERATE_TYPE", "OPERATE_RESULT_NAME", "OPERATE_PARAMS", "OPERATE_RESULT", "APP_ID") AS 
  select
   l.LOG_ID,
   l.BUSINESS_ID,
   l.OPERATE_TIME,
   l.OPERATE_USER,
   decode(l.OPERATE_TYPE,'start','启动流程','back','回退活动','complete','完成活动','resume','恢复流程','suspend','挂起流程','terminate','终止活动','terminateFlow','终止流程','recycle','收回活动','tempSaveForm','暂存表单') OPERATE_TYPE,
   decode(l.OPERATE_RESULT,'Y','成功','N','失败') as OPERATE_RESULT_NAME,
   l.OPERATE_PARAMS,
   l.OPERATE_RESULT,
   l.APP_ID
from
   WORKFLOW_OPERATE_LOG l;

COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."LOG_ID" IS '日志ID';
COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."BUSINESS_ID" IS '业务编号';
COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."OPERATE_TIME" IS '操作时间';
COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."OPERATE_USER" IS '操作用户';
COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."OPERATE_TYPE" IS '流程操作类型';
COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."OPERATE_RESULT_NAME" IS '流程操作结果';

--暂存视图
-- modify by minghua.guo 2010-06-10 删除业务类别
CREATE OR REPLACE FORCE VIEW "V_APP_TOBEWORK_LIST" ("ACT_NAME", "BUSITITLE", "CREATETIME", "BUSINESSID", "ACTINSID", "MGRNAME", "ID", "USERNAME", "DYNAMICPERFORMER", "NEXT_ACT", "ANDSPLITUSERS", "MODULE_ID") AS 
  select t.act_name,
 t.busititle,
 to_char(t.createtime, 'yyyy-mm-dd hh24:mi') createtime,
 t.businessid,
 t.act_ins_id actInsId,
 t.mgrname,
 t.id,t.username,
 t.DYNAMICPERFORMER,
 t.next_act,
 t.andsplitusers,
 t.module_id
 from &egp_user.td_worklist_tobe t, &egp_user.assignmentstable a
 where
 t.app_id = '&app_id'
 and a.activityid=t.act_ins_id
 and a.resourceid=t.username
;
COMMENT ON COLUMN &app_user."V_APP_TOBEWORK_LIST"."ACT_NAME" IS '当前环节';
COMMENT ON COLUMN &app_user."V_APP_TOBEWORK_LIST"."BUSITITLE" IS '业务标题';
COMMENT ON COLUMN &app_user."V_APP_TOBEWORK_LIST"."CREATETIME" IS '暂存时间';
COMMENT ON COLUMN &app_user."V_APP_TOBEWORK_LIST"."BUSINESSID" IS '业务id';

--挂起视图
-- modify by minghua.guo 2010-06-10 删除业务类别
CREATE OR REPLACE FORCE VIEW "V_APP_SUSPENDWORK_LIST" ("PKGID", "ACTNAME", "LASTSTATETIME", "BUSINESSID", "BUSITITLE", "ACTID", "ACTDEFID", "MGRNAME", "PROCDEFID", "PROCID", "PROCNAME", "VERSION", "CREATIONTIME", "USERNAME", "LIMITTIME", "MODULE_ID") AS 
  select v.pkgId,
       v.actname,
       (to_char(to_date('1970-01-01 08:00:00', 'yyyy-mm-dd hh24:mi:ss') + laststatetime/ 24 / 60 / 60/1000,'yyyy-mm-dd hh24:mi:ss')) laststatetime,
       case
         when m.businessid is not null then
          m.businessid
         else
          (select max(t.businessid)
             from &egp_user.td_proc_form_instancemap t
            where v.activityrequesterprocessid = t.procinstanceid)
       end as businessid,
       case
         when m.BUSITITLE is not null then
          m.BUSITITLE
         else
          (select max(t.BUSITITLE)
             from &egp_user.td_proc_form_instancemap t
            where v.activityrequesterprocessid = t.procinstanceid)
       end as BUSITITLE,
       v.actId,
       v.actDefId,
       v.mgrName,
       v.procDefId,
       v.procId,
       v.procName,
       v.version,
       v.creationTime,
       v.username,
       v.limittime,
       m.module_id
  from &egp_user.v_Worklist v,
       (select t.businessid,
               t.BUSITITLE,
               t.app_id,
               t.module_id,
               procinstanceid
          from &egp_user.td_proc_form_instancemap t
        ) m,
       &egp_user.activitystates
 where (v.procId = m.procinstanceid or
       v.activityrequesterprocessid = m.procinstanceid)
   and activitystates.oid = v.state
   and m.app_id = '&app_id'
   and activitystates.keyvalue = 'open.not_running.suspended'
   and not exists (select '1'
          from &egp_user.td_worklist_tobe t
         where v.actId = t.act_ins_id)
;
COMMENT ON COLUMN &app_user."V_APP_SUSPENDWORK_LIST"."PKGID" IS '流程';
COMMENT ON COLUMN &app_user."V_APP_SUSPENDWORK_LIST"."ACTNAME" IS '活动';
COMMENT ON COLUMN &app_user."V_APP_SUSPENDWORK_LIST"."LASTSTATETIME" IS '挂起时间';
COMMENT ON COLUMN &app_user."V_APP_SUSPENDWORK_LIST"."BUSINESSID" IS '业务id';
COMMENT ON COLUMN &app_user."V_APP_SUSPENDWORK_LIST"."BUSITITLE" IS '业务标题';

--流程监控视图
-- modify by minghua.guo 2010-06-10 删除业务类别
CREATE OR REPLACE FORCE VIEW "V_APP_PROCESS_MONITOR_LIST" ("BUSITITLE", "BUSINESSID", "RUN_ACTNAME", "PROCINSID", "MODULE_ID") AS 
  select
 m.busititle busititle,
 m.businessid businessid,
 (sum_string('&egp_user.v_activities a, &egp_user.activitystates s','a.name','where a.process = ' || p.oid || '
 and a.state = s.oid
 and s.keyvalue like ''open%''')) run_actname,
 p.id procinsid,
 m.module_id
 from &egp_user.processes p,
 (select t.businessid,
 t.BUSITITLE,
 t.app_id,
 t.module_id,
 procinstanceid
 from &egp_user.td_proc_form_instancemap t) m
 where p.id = m.procinstanceid
 and m.app_id = '&app_id'
;
COMMENT ON COLUMN &app_user."V_APP_PROCESS_MONITOR_LIST"."BUSITITLE" IS '业务标题';
COMMENT ON COLUMN &app_user."V_APP_PROCESS_MONITOR_LIST"."BUSINESSID" IS '业务id';
COMMENT ON COLUMN &app_user."V_APP_PROCESS_MONITOR_LIST"."RUN_ACTNAME" IS '当前活动';

--过期视图
-- modify by minghua.guo 2010-06-10 删除业务类别
CREATE OR REPLACE FORCE VIEW "V_APP_OVERTIME_WORK_LIST" ("ACTNAME", "PROCNAME", "BUSITITLE", "BUSINESSID", "CREATIONTIME", "LIMITTIME", "ACTID", "PROCID", "ACTDEFID", "USERNAME", "MODULE_ID") AS 
  select
       v.actName actName,
       v.procName procName,
       m.BUSITITLE BUSITITLE,
       m.businessid businessid,
       (to_char(to_date('1970-01-01 08:00:00', 'yyyy-mm-dd hh24:mi:ss') + v.creationTime/ 24 / 60 / 60/1000,'yyyy-mm-dd hh24:mi:ss')) creationTime,
       (to_char(to_date('1970-01-01 08:00:00', 'yyyy-mm-dd hh24:mi:ss') + v.limittime/ 24 / 60 / 60/1000,'yyyy-mm-dd hh24:mi:ss')) limittime,
       v.actId actid,
       v.procId procId,
       v.actDefId actDefId,
       v.username username,
       m.module_id
from &egp_user.v_Worklist v,
     &egp_user.activitystates ss,
       (select t.businessid,
       t.BUSITITLE,
       t.app_id,
       t.module_id,
       procinstanceid
       from &egp_user.td_proc_form_instancemap t
       ) m
 where v.limittime <= (
                      TO_CHAR((SYSDATE -
               TO_DATE('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') -
               (1 / 3)) * 24 * 60 * 60 * 1000,
               '999999999999999')
  )
   and v.state = ss.oid
   and ss.keyvalue like '%open%'
   and (v.procId = m.procinstanceid or v.activityrequesterprocessid = m.procinstanceid)
   and m.app_id = '&app_id'
;
COMMENT ON COLUMN &app_user."V_APP_OVERTIME_WORK_LIST"."ACTNAME" IS '活动';
COMMENT ON COLUMN &app_user."V_APP_OVERTIME_WORK_LIST"."PROCNAME" IS '流程';
COMMENT ON COLUMN &app_user."V_APP_OVERTIME_WORK_LIST"."BUSITITLE" IS '业务标题';
COMMENT ON COLUMN &app_user."V_APP_OVERTIME_WORK_LIST"."BUSINESSID" IS '业务ID';

--已办视图
-- modify by minghua.guo 2010-06-10 删除业务类别
CREATE OR REPLACE FORCE VIEW "V_APP_DONEWORK_LIST" ("ACT_NAME", "RUN_ACTNAME", "BUSITITLE", "BUSINESSID", "ACTINSID", "PROCINSID", "RUN_ACTINSID", "MGRNAME", "USERNAME", "MODULE_ID") AS 
  select a.name act_name,
 (select max(act.name)
 from &egp_user.activities act, &egp_user.activitystates state
 where act.state = state.oid
 and state.keyvalue like 'open%'
 and act.process = p.oid) as run_actname,
 m.busititle,
 m.businessid,
 a.id actInsId,
 p.id procInsId,
 (select max(act.id)
 from &egp_user.activities act, &egp_user.activitystates state
 where act.state = state.oid
 and state.keyvalue like 'open%'
 and act.process = p.oid) as run_actinsid,
 p.pdefname mgrname,
 a.resourceid username,
 m.module_id
 from &egp_user.activities a,
 &egp_user.processes p,
 &egp_user.activitystates sa,
 (select t.businessid,
 t.BUSITITLE,
 t.module_id,
 t.app_id,
 procinstanceid
 from &egp_user.td_proc_form_instancemap t) m
 where a.state = sa.oid
 and sa.keyvalue = 'closed.completed'
 and m.procinstanceid = p.id
 and m.app_id = '&app_id'
 and a.process = p.oid
;
COMMENT ON COLUMN &app_user."V_APP_DONEWORK_LIST"."ACT_NAME" IS '本人执行活动';
COMMENT ON COLUMN &app_user."V_APP_DONEWORK_LIST"."RUN_ACTNAME" IS '当前运行活动';
COMMENT ON COLUMN &app_user."V_APP_DONEWORK_LIST"."BUSITITLE" IS '业务标题';
COMMENT ON COLUMN &app_user."V_APP_DONEWORK_LIST"."BUSINESSID" IS '业务id';

--委派流程实例视图
CREATE OR REPLACE FORCE VIEW "V_APP_PROCESS_ASSIGN_LIST" ("BUSITITLE", "BUSINESSID", "RUN_ACTNAME", "DESIGNATOR", "DESIGNEE_NAME", "DESIGNATOR_ID", "DESIGNEE_ID", "PROCINSID", "CREATEDATE", "DELEGATE_TIME", "DELEGATE_END_TIME", "MODULE_ID") AS 
  select distinct
 m.busititle busititle,
 m.businessid businessid,
 (&egp_user.sum_string('&egp_user.v_activities a, &egp_user.activitystates s','a.name','where a.process = ' || p.oid || '
 and a.state = s.oid
 and s.keyvalue like ''open%''')) run_actname,
 d.designator designator,
 d.designee_name designee_name,
 d.designator_id designator_id,
 d.designee_id designee_id,
 p.id procinsid,
 m.createdate,
 d.delegate_time,
 d.delegate_end_time,
 m.module_id
 from &egp_user.processes p,
 &egp_user.td_proc_form_instancemap m,
 &egp_user.ASSIGNMENT_RESIGN_RECORD assr,
 &egp_user.tb_delegate d
 where p.id = m.procinstanceid and
 --有效时间段
 p.laststatetime>=(d.delegate_time- to_date('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) * 86400000 and
 p.laststatetime<=(d.delegate_end_time- to_date('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) * 86400000 and
 --p.laststatetime>=(d.confirm_time- to_date('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) * 86400000 and
 --有效委派
 (d.delegate_stat='2') and
 --委派人
 --p.resourcerequesterid = d.designee_id and
 d.delegate_id=assr.delegate_id and 
 assr.procinsid=p.id and 
 --流程名字
 m.procdefid=p.pdefname and
 --模块(事项)ID
 (d.ec_type='app' or (d.ec_type='class' and
 (instr(d.ec_id,m.module_id||',')=1 or
 instr(d.ec_id,','||m.module_id||',')>0 or
 instr(d.ec_id,','||m.module_id)+lengthb(m.module_id)=lengthb(d.ec_id))
  or d.ec_id=m.module_id))
 and m.app_id = '&app_id'
;
 
   COMMENT ON COLUMN &app_user."V_APP_PROCESS_ASSIGN_LIST"."BUSITITLE" IS '业务标题';
 
   COMMENT ON COLUMN &app_user."V_APP_PROCESS_ASSIGN_LIST"."BUSINESSID" IS '业务id';
 
   COMMENT ON COLUMN &app_user."V_APP_PROCESS_ASSIGN_LIST"."RUN_ACTNAME" IS '当前活动';
 
   COMMENT ON COLUMN &app_user."V_APP_PROCESS_ASSIGN_LIST"."DESIGNATOR" IS '委派人';
 
   COMMENT ON COLUMN &app_user."V_APP_PROCESS_ASSIGN_LIST"."DESIGNEE_NAME" IS '被委派人';
--------平台V3.0工作流脚本结束--------