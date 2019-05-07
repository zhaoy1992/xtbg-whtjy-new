create or replace view m_v_yj_d as
select mid as YJ_ID,
       title as YJ_BT,
       to_char(to_date(createtime, 'yyyy-mm-dd hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss') as YJ_CJSJ, --邮件创建时间
       receivepname as YJ_JSR,
       receivepid as YJ_JSRID,
       sendpname as YJ_FSR,
       sendpid as YJ_FSRID,
       (select count(1) from fc_attach fa where trim(fa.djbh)=trim(attachment_id)) YJ_FJSL,
       attachment_id as YJ_FJID,
       content as YJ_ZW,
       a.state HY_SFYX
  from (select tt.mid,
               tt.attachment_id,
               tt.createtime,
               tt.dxtzjsr,
               tt.content,
               tt.title,
               t.receivepid,
               t.receivepname,
               tt.sendpid,
               tt.sendpname,
               tt.state
          from ymj_oa_jbxx_mail tt, (select mid,wmsys.wm_concat(receivepid) receivepid,wmsys.wm_concat(receivepname) receivepname from ymj_oa_user_mail group by mid) t
         where 1 = 1
           and tt.mid = t.mid) a;

           
           
create or replace view m_v_yj_g as
select distinct (mid) as YJ_ID,--邮件id
                title as YJ_BT,--邮件标题
                to_char(to_date(createtime,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss') as YJ_CJSJ,
                to_char(receivepname) as YJ_JSR,
                sendpid as YJ_FSRID--邮件发送人
                --sendpname,
  from (select mid,
               sendpid,
               sendpname,
               title,
               createtime,
               wmsys.wm_concat(receivepname) over(partition by mid) as receivepname
          from (select *
                  from (select tt.mid,
                               tt.sendpid,
                               tt.sendpname,
                               tt.title,
                               t.receivepname,
                               tt.createtime
                          from ymj_oa_jbxx_mail tt
                          left join ymj_oa_user_mail t
                            on tt.mid = t.mid
                         where tt.state = '0')))
 order by mid desc
/**
* 描述:邮件-邮件草稿列表[原视图:mobile_view_youjian_s]
* 参数列表:
* 1  YJ_ID  邮件id
* 2  YJ_BT  邮件标题
* 3  YJ_CJSJ  邮件创建时间
* 4  YJ_JSR  邮件接收人
* 5  YJ_FSRID  邮件发送人id
* 时间:2013-8-8
* 作者:tuo.zou
*/;



create or replace view m_v_yj_r as
select tt.mid as YJ_ID,
       tt.title as YJ_BT,
       decode(t.readstate, '0', '未读', '1', '已读', '') as YJ_ZT,
       to_char(to_date(tt.createtime, 'yyyy-mm-dd hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss') as YJ_CJSJ,
       tt.sendpname as YJ_FSR,
       t.receivepid as YJ_JSRID
      --tt.sendpid,
      --tt.createtime,
  from ymj_oa_user_mail t, ymj_oa_jbxx_mail tt
 where t.mid = tt.mid
   and (tt.state = '1' or tt.state = '-1')
   and t.readstate != '99'
 order by tt.createtime desc
/**
* 描述:邮件-邮件收件箱列表[原视图:mobile_view_youjian_r]
* 依赖表:
* 参数列表:
* 1  YJ_ID  邮件id
* 2  YJ_BT  邮件标题
* 3  YJ_ZT  邮件状态
* 4  YJ_CJSJ  邮件创建时间
* 5  YJ_FSR  邮件发送人
* 6  YJ_JSRID  邮件接收人id
* 时间:2013-8-8
* 作者:tuo.zou
*/;




create or replace view m_v_yj_s as
select distinct (mid) as YJ_ID,
                title as YJ_BT,
                to_char(to_date(createtime, 'yyyy-mm-dd hh24:mi:ss'),
                        'yyyy-mm-dd hh24:mi:ss') as YJ_CJSJ,
                to_char(receivepname) as YJ_JSR,
                sendpid as YJ_FSRID
                --sendpname,
  from (select mid,
               sendpid,
               sendpname,
               title,
               createtime,
               wmsys.wm_concat(receivepname) over(partition by mid) as receivepname
          from (select *
                  from (select tt.mid,
                               tt.sendpid,
                               tt.sendpname,
                               tt.title,
                               t.receivepname,
                               tt.createtime
                          from ymj_oa_jbxx_mail tt
                          left join ymj_oa_user_mail t
                            on tt.mid = t.mid
                         where tt.state = '1')))
 order by mid desc
/**
* 描述:邮件-邮件发件箱列表[原视图:mobile_view_youjian_s]
* 参数列表:
* 1  YJ_ID  邮件id
* 2  YJ_BT  邮件标题
* 3  YJ_CJSJ  邮件创建时间
* 4  YJ_JSR  邮件接收人
* 5  YJ_FSRID  邮件发送人id
* 时间:2013-8-8
* 作者:tuo.zou
*/;



CREATE OR REPLACE TRIGGER "MTP_YMJ_DZYJ"
/**
 * 描述:MTP_YMJ_DZYJ:(MTP:MOBILE端的中间表(Z)-->PC端的真实表)(_YMJ_DZYJ:所属系统是YMJ,所属功能点是DZYJ)
 * 原触发器:PC_YMJ_OA_JBXX_MAIL
 * 1、针对"mobile to pc"中间表mobile_busi_youjian"新增邮件"的触发器
 * 2、模仿MailDaoImpl.saveMailInfo()实现触发器
 * 3、未实现移民局特有的"短信提醒功能"
 * 4、实现(直接写入|修改草稿|回复|转发)*(发送|存稿)
 * tuo.zou
 * 2013-8-13
 */
 AFTER INSERT ON M_T_YJ--M_T_YJ:"邮件信息中间表"
 FOR EACH ROW
DECLARE
  OLD_ATTACHMENT_ID VARCHAR2(100);
  MAIL_ID NUMBER;--邮件ID
  SEND_MAIL_DEPT_ID VARCHAR2(50);--发件人所属部门ID
  SEND_MAIL_DEPT_NAME VARCHAR2(100);--发件人所属部门名
  REAL_CONTENT CLOB;--邮件内容
  --前一封邮件:在另一份邮件的基础上操作(回复,转发,去草稿修改)
  CURSOR OLD_MAIL_LIST IS (
    SELECT * FROM YMJ_OA_JBXX_MAIL WHERE MID = :NEW.YJ_ID
  );
  ONE_OLD_MAIL YMJ_OA_JBXX_MAIL%ROWTYPE;
  --邮件收件人集合
  CURSOR YJ_JSR_LIST IS (
    SELECT A.JSR_ID, B.JSR_NAME
      FROM (SELECT COLUMN_VALUE JSR_ID, ROWNUM ROW_ID
              FROM TABLE(SPLIT(:NEW.YJ_JSRID))) A,
           (SELECT COLUMN_VALUE JSR_NAME, ROWNUM ROW_ID
              FROM TABLE(SPLIT(:NEW.YJ_JSR))) B
     WHERE A.ROW_ID = B.ROW_ID
  );
  ONE_JSR_ID YJ_JSR_LIST%ROWTYPE;
BEGIN
  --1:insert or update YMJ_OA_JBXX_MAIL
  --1.1:过滤无效数据
  IF(:NEW.YJ_FSRID IS NULL) THEN
        RETURN;
  END IF;
  IF (:NEW.YJ_FLAG='a' or :NEW.YJ_FLAG='b' or :NEW.YJ_FLAG='d') THEN--转发 回复 读草稿箱写
    IF(:NEW.YJ_ID IS NULL) THEN
        RETURN;
    ELSE
      OPEN OLD_MAIL_LIST;
      LOOP
        FETCH OLD_MAIL_LIST INTO ONE_OLD_MAIL;
        EXIT WHEN OLD_MAIL_LIST%NOTFOUND;
      END LOOP;
      IF (ONE_OLD_MAIL.MID IS NULL) THEN
        RETURN;
      END IF;
    END IF;
  ELSIF (:NEW.YJ_FLAG<>'c') THEN
    RETURN;
  END IF;
  --1.2:整理SEND_MAIL_DEPT_ID,SEND_MAIL_DEPT_NAME
  SELECT ORG_ID INTO SEND_MAIL_DEPT_ID FROM TD_SM_ORGUSER WHERE USER_ID =:NEW.YJ_FSRID;
  IF (SEND_MAIL_DEPT_ID IS NOT NULL) THEN
    SELECT ORG_NAME INTO SEND_MAIL_DEPT_NAME FROM TD_SM_ORGANIZATION WHERE ORG_ID = SEND_MAIL_DEPT_ID;
  ELSE
    SEND_MAIL_DEPT_ID:='-';
    SEND_MAIL_DEPT_NAME:='特殊部门';
  END IF;
  --1.3:整理REAL_CONTENT,OLD_ATTACHMENT_ID
  IF (:NEW.YJ_FLAG='a' or :NEW.YJ_FLAG='b') THEN--转发 回复 读草稿箱写
    SELECT CONTENT INTO REAL_CONTENT FROM YMJ_OA_JBXX_MAIL WHERE MID = TO_NUMBER(:NEW.YJ_ID);
    REAL_CONTENT:= '主题:'||ONE_OLD_MAIL.TITLE||'<br/>'||REAL_CONTENT;
    REAL_CONTENT:= '发送时间:'||ONE_OLD_MAIL.CREATETIME||'<br/>'||REAL_CONTENT;
    REAL_CONTENT:= '发件人:'||ONE_OLD_MAIL.SENDPNAME||'<br/>'||REAL_CONTENT;
    IF (:NEW.YJ_FLAG='b') THEN--回复
       REAL_CONTENT:=:NEW.YJ_NR||'<br/>'||REAL_CONTENT;
    END IF;
    SELECT ATTACHMENT_ID INTO OLD_ATTACHMENT_ID FROM YMJ_OA_JBXX_MAIL WHERE MID = TO_NUMBER(:NEW.YJ_ID);
  ELSE
    SELECT :NEW.YJ_NR INTO REAL_CONTENT FROM DUAL;
    SELECT '' INTO OLD_ATTACHMENT_ID FROM DUAL;
  END IF;
  --1.4 INSERT OR UPDATE
  IF (:NEW.YJ_FLAG='a' or :NEW.YJ_FLAG='b' or :NEW.YJ_FLAG='c') THEN--来自收信箱 或 新增 的邮件
     SELECT SEQ_YMJ_OA_JBXX_MAIL.NEXTVAL INTO MAIL_ID FROM DUAL;
     INSERT INTO YMJ_OA_JBXX_MAIL
      (MID, --1:KEY
       TITLE, --2:TITLE
       CREATETIME, --3:创建日期、发送日期
       ATTACHMENT_ID, --:4附件id
       STATE, --5:状态
       DEPTID, --6:发送人部门ID
       DEPTNAME, --7:发送人部门名称
       SENDPID, --8:发送人ID
       SENDPNAME, --9:发送人名称
       DXTZJSR, --10:短信通知接收人
       CONTENT) --11:内容
    VALUES
      (MAIL_ID, --1
       :NEW.YJ_BT,
       TO_CHAR(:NEW.YJ_SJ,'yyyy-MM-dd HH24:mi'),
       OLD_ATTACHMENT_ID, --4
       :NEW.YJ_BS,
       SEND_MAIL_DEPT_ID,
       SEND_MAIL_DEPT_NAME,
       :NEW.YJ_FSRID,
       :NEW.YJ_FSR,
       '0', --<>1:否,=1:是
       REAL_CONTENT);
  ELSE--FROM 草稿箱的邮件
    MAIL_ID:= TO_NUMBER(:NEW.YJ_ID);
    UPDATE YMJ_OA_JBXX_MAIL
       SET TITLE = :NEW.YJ_BT
         , CONTENT = REAL_CONTENT
         , STATE = :NEW.YJ_BS
         , CREATETIME = TO_CHAR(:NEW.YJ_SJ,'yyyy-MM-dd HH24:mi')
     WHERE MID = MAIL_ID;
  END IF;

   --2:邮件收件人关系表保存
   IF (:NEW.YJ_FLAG='a' or :NEW.YJ_FLAG='b' or :NEW.YJ_FLAG='c') THEN--来自收信箱 或 新增 的邮件
     OPEN YJ_JSR_LIST;
      LOOP
        FETCH YJ_JSR_LIST INTO ONE_JSR_ID;
        EXIT WHEN YJ_JSR_LIST%NOTFOUND;
        INSERT INTO YMJ_OA_USER_MAIL
          (RECEIVEPID, RECEIVEPNAME, READSTATE, MID)
        VALUES
          (ONE_JSR_ID.JSR_ID,ONE_JSR_ID.JSR_NAME, '0', MAIL_ID);
      END LOOP;
   ELSE--FROM 草稿箱的邮件
     --2.1:delete 上一次收信人集合
     DELETE YMJ_OA_USER_MAIL WHERE MID = MAIL_ID;
     --2.2:insert 收信人集合
     OPEN YJ_JSR_LIST;
      LOOP
        FETCH YJ_JSR_LIST INTO ONE_JSR_ID;
        EXIT WHEN YJ_JSR_LIST%NOTFOUND;
        INSERT INTO YMJ_OA_USER_MAIL
          (RECEIVEPID, RECEIVEPNAME, READSTATE, MID)
        VALUES
          (ONE_JSR_ID.JSR_ID,ONE_JSR_ID.JSR_NAME, '0', MAIL_ID);
      END LOOP;
   END IF;

END MTP_YMJ_DZYJ;





CREATE OR REPLACE TRIGGER "MTP_YMJ_DZYJ_CK"
/**
 * 1、针对"mobile to pc"中间表mobile_busi_youjianzt"新增查看邮件信息"的触发器
 * tuo.zou
 * 2013-7-15
 */
 AFTER INSERT ON M_T_YJ_CK--M_T_YJ_CK:"新增查看记录"
 FOR EACH ROW
DECLARE
BEGIN
  --1:update YMJ_OA_USER_MAIL
  UPDATE YMJ_OA_USER_MAIL
     SET READSTATE = '1'
   WHERE MID = :NEW.YJ_ID
     AND RECEIVEPID = :NEW.YJ_CKRID;
END MTP_YMJ_DZYJ_CK;




create or replace trigger "PTMX_YMJ_DZYJ"
  after insert or delete or update
/**
 * 向电子邮件的消息表出发代办消息数据
 * 描述:PTMX_YMJ_DZYJ:(PTMX:PC端的真实表-->MOBILE端的消息表(X))(_YMJ_DZYJ:所属系统是YMJ,所属功能点是DZYJ)
 * 原触发器:mobile_dzyj
 * tuo.zou
 * 2013-8-13
 */
ON ymj_oa_jbxx_mail
  FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
BEGIN
  select seq_android_wait.nextval into new_wait_id from dual;
  --新增与更新
  IF INSERTING or UPDATING THEN
     IF :NEW.STATE = '1' THEN
       --1:
       insert into M_AA_WAIT
      (wait_id, business_id, business_type, title, content, curd_type)
    values
      (new_wait_id, :new.mid, 'youjian', '', :new.title, 'c');

      --2:
      insert into M_AA_UF
             select new_wait_id,t.RECEIVEPID  from  YMJ_OA_USER_MAIL t where t.mid=:NEW.MID;


     END IF;
  end if;
END PTMX_YMJ_DZYJ;




create or replace trigger "PTMX_YMJ_DZYJ_USER"
  after insert
  --or delete or update
/**
 * 原触发器:mobile_dzyj
 * tuo.zou
 * 2013-8-13
 */
ON YMJ_OA_USER_MAIL
  FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
  mainMessState VARCHAR(50);--主表MID
BEGIN

  --新增与更新
  IF INSERTING THEN
     select yojm.state into mainMessState from ymj_oa_jbxx_mail yojm where yojm.mid = :NEW.MID;
     --'1':状态=1的邮件，是已发送的邮件
     IF mainMessState = '1' THEN
      --1:获取 主消息表中的 ID
       select wait_id into new_wait_id from M_AA_WAIT where business_id = :NEW.MID;
      --2:
      insert into M_AA_UF values(new_wait_id,:NEW.RECEIVEPID);
     END IF;
  end if;
END PTMX_YMJ_DZYJ_USER;


