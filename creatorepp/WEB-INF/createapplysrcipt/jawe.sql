--------ƽ̨V3.0�������ű���ʼ--------
/**
 * ע�⣺����&app_user��½���ݿ⣬Ȼ��ִ�б�SQL�ļ�
 *
 * &app_deftablespace : Ӧ�����ݿ�ȱʡ��ռ�
 * &app_temptablespace : Ӧ�����ݿ���ʱ��ռ�
 * &app_user : Ӧ�����ݿ��û�
 * &app_id   : Ӧ��ID
 * &egp_user : ƽ̨���ݿ��û�
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
'������������־';

comment on column WORKFLOW_OPERATE_LOG.LOG_ID is
'��־ID';

comment on column WORKFLOW_OPERATE_LOG.BUSINESS_ID is
'ҵ��ID';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_TIME is
'����ʱ��';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_USER is
'�����û�';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_TYPE is
'���̲�������';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_PARAMS is
'����������JSON��ʽ��';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_RESULT is
'���̲������';

comment on column WORKFLOW_OPERATE_LOG.PROC_DEFNAME is
'���̶�������';

comment on column WORKFLOW_OPERATE_LOG.ACT_DEFID is
'�����ID';

comment on column WORKFLOW_OPERATE_LOG.PROC_INSTANCEID is
'����ʵ��ID';

comment on column WORKFLOW_OPERATE_LOG.ACT_INSTANCEID is
'�ʵ��ID';

comment on column WORKFLOW_OPERATE_LOG.MODULE_ID is
'����ID';

comment on column WORKFLOW_OPERATE_LOG.APP_ID is
'����Ӧ��ID';
   
--������ͼ
-- modify by minghua.guo 2010-06-10 ɾ��ҵ�����
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
 --add by luming.tang ���ڹ�������ʧ�ܵļ�¼
 and not exists(select '1' from workflow_operate_log l where l.operate_result='N' and v.username=l.operate_user and v.actId=l.act_instanceid)

;
COMMENT ON COLUMN &app_user."V_APP_WORK_LIST"."PKGID" IS '����';
COMMENT ON COLUMN &app_user."V_APP_WORK_LIST"."ACTNAME" IS '�';
COMMENT ON COLUMN &app_user."V_APP_WORK_LIST"."BUSITITLE" IS '������';
COMMENT ON COLUMN &app_user."V_APP_WORK_LIST"."BUSINESSID" IS 'ҵ����';

--������������ߴ�����ͼ��ѯЧ�� ��ʼ minghua.guo
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
--Ϊ������ͼ������������ߴ�����ͼ��ѯЧ�� ����

--���̲�����־
CREATE OR REPLACE FORCE VIEW "V_APP_WORKFLOW_OPERATE_LOG" ("LOG_ID", "BUSINESS_ID", "OPERATE_TIME", "OPERATE_USER", "OPERATE_TYPE", "OPERATE_RESULT_NAME", "OPERATE_PARAMS", "OPERATE_RESULT", "APP_ID") AS 
  select
   l.LOG_ID,
   l.BUSINESS_ID,
   l.OPERATE_TIME,
   l.OPERATE_USER,
   decode(l.OPERATE_TYPE,'start','��������','back','���˻','complete','��ɻ','resume','�ָ�����','suspend','��������','terminate','��ֹ�','terminateFlow','��ֹ����','recycle','�ջػ','tempSaveForm','�ݴ��') OPERATE_TYPE,
   decode(l.OPERATE_RESULT,'Y','�ɹ�','N','ʧ��') as OPERATE_RESULT_NAME,
   l.OPERATE_PARAMS,
   l.OPERATE_RESULT,
   l.APP_ID
from
   WORKFLOW_OPERATE_LOG l;

COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."LOG_ID" IS '��־ID';
COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."BUSINESS_ID" IS 'ҵ����';
COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."OPERATE_TIME" IS '����ʱ��';
COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."OPERATE_USER" IS '�����û�';
COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."OPERATE_TYPE" IS '���̲�������';
COMMENT ON COLUMN &app_user."V_APP_WORKFLOW_OPERATE_LOG"."OPERATE_RESULT_NAME" IS '���̲������';

--�ݴ���ͼ
-- modify by minghua.guo 2010-06-10 ɾ��ҵ�����
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
COMMENT ON COLUMN &app_user."V_APP_TOBEWORK_LIST"."ACT_NAME" IS '��ǰ����';
COMMENT ON COLUMN &app_user."V_APP_TOBEWORK_LIST"."BUSITITLE" IS 'ҵ�����';
COMMENT ON COLUMN &app_user."V_APP_TOBEWORK_LIST"."CREATETIME" IS '�ݴ�ʱ��';
COMMENT ON COLUMN &app_user."V_APP_TOBEWORK_LIST"."BUSINESSID" IS 'ҵ��id';

--������ͼ
-- modify by minghua.guo 2010-06-10 ɾ��ҵ�����
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
COMMENT ON COLUMN &app_user."V_APP_SUSPENDWORK_LIST"."PKGID" IS '����';
COMMENT ON COLUMN &app_user."V_APP_SUSPENDWORK_LIST"."ACTNAME" IS '�';
COMMENT ON COLUMN &app_user."V_APP_SUSPENDWORK_LIST"."LASTSTATETIME" IS '����ʱ��';
COMMENT ON COLUMN &app_user."V_APP_SUSPENDWORK_LIST"."BUSINESSID" IS 'ҵ��id';
COMMENT ON COLUMN &app_user."V_APP_SUSPENDWORK_LIST"."BUSITITLE" IS 'ҵ�����';

--���̼����ͼ
-- modify by minghua.guo 2010-06-10 ɾ��ҵ�����
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
COMMENT ON COLUMN &app_user."V_APP_PROCESS_MONITOR_LIST"."BUSITITLE" IS 'ҵ�����';
COMMENT ON COLUMN &app_user."V_APP_PROCESS_MONITOR_LIST"."BUSINESSID" IS 'ҵ��id';
COMMENT ON COLUMN &app_user."V_APP_PROCESS_MONITOR_LIST"."RUN_ACTNAME" IS '��ǰ�';

--������ͼ
-- modify by minghua.guo 2010-06-10 ɾ��ҵ�����
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
COMMENT ON COLUMN &app_user."V_APP_OVERTIME_WORK_LIST"."ACTNAME" IS '�';
COMMENT ON COLUMN &app_user."V_APP_OVERTIME_WORK_LIST"."PROCNAME" IS '����';
COMMENT ON COLUMN &app_user."V_APP_OVERTIME_WORK_LIST"."BUSITITLE" IS 'ҵ�����';
COMMENT ON COLUMN &app_user."V_APP_OVERTIME_WORK_LIST"."BUSINESSID" IS 'ҵ��ID';

--�Ѱ���ͼ
-- modify by minghua.guo 2010-06-10 ɾ��ҵ�����
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
COMMENT ON COLUMN &app_user."V_APP_DONEWORK_LIST"."ACT_NAME" IS '����ִ�л';
COMMENT ON COLUMN &app_user."V_APP_DONEWORK_LIST"."RUN_ACTNAME" IS '��ǰ���л';
COMMENT ON COLUMN &app_user."V_APP_DONEWORK_LIST"."BUSITITLE" IS 'ҵ�����';
COMMENT ON COLUMN &app_user."V_APP_DONEWORK_LIST"."BUSINESSID" IS 'ҵ��id';

--ί������ʵ����ͼ
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
 --��Чʱ���
 p.laststatetime>=(d.delegate_time- to_date('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) * 86400000 and
 p.laststatetime<=(d.delegate_end_time- to_date('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) * 86400000 and
 --p.laststatetime>=(d.confirm_time- to_date('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) * 86400000 and
 --��Чί��
 (d.delegate_stat='2') and
 --ί����
 --p.resourcerequesterid = d.designee_id and
 d.delegate_id=assr.delegate_id and 
 assr.procinsid=p.id and 
 --��������
 m.procdefid=p.pdefname and
 --ģ��(����)ID
 (d.ec_type='app' or (d.ec_type='class' and
 (instr(d.ec_id,m.module_id||',')=1 or
 instr(d.ec_id,','||m.module_id||',')>0 or
 instr(d.ec_id,','||m.module_id)+lengthb(m.module_id)=lengthb(d.ec_id))
  or d.ec_id=m.module_id))
 and m.app_id = '&app_id'
;
 
   COMMENT ON COLUMN &app_user."V_APP_PROCESS_ASSIGN_LIST"."BUSITITLE" IS 'ҵ�����';
 
   COMMENT ON COLUMN &app_user."V_APP_PROCESS_ASSIGN_LIST"."BUSINESSID" IS 'ҵ��id';
 
   COMMENT ON COLUMN &app_user."V_APP_PROCESS_ASSIGN_LIST"."RUN_ACTNAME" IS '��ǰ�';
 
   COMMENT ON COLUMN &app_user."V_APP_PROCESS_ASSIGN_LIST"."DESIGNATOR" IS 'ί����';
 
   COMMENT ON COLUMN &app_user."V_APP_PROCESS_ASSIGN_LIST"."DESIGNEE_NAME" IS '��ί����';
--------ƽ̨V3.0�������ű�����--------