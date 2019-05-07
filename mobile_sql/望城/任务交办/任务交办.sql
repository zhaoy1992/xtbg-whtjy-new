CREATE OR REPLACE VIEW M_V_RW_D AS
SELECT
       p.detail_id as RW_ID,--����id
       p.item as RW_MC,--��������
       u1.user_realname as RW_FQR,--��������
       '' as RW_NR,--��������
       '' as RW_FQRDW,--�������˵�λ
       p.owner,
       u2.user_realname owner_name,
       to_char(p.start_time, 'yyyy-mm-dd')  AS RW_KSSJ ,--����ʼʱ��
       to_char(p.end_time, 'yyyy-mm-dd') end_time,
       decode(p.isfinish,'0','δ���','1','�����')  as RW_ZT,--����״̬
       decode(p.isurge,'0','��ͨ����','1','�߰�����')  as RW_LX, --��������
       p.solution,
       p.program,
       p.remark,
       to_char(p.updatetime, 'yyyy-mm-dd hh:mi:ss') updatetime,
       p.change_times,
       p.urge_user,
       u3.user_realname urge_user_name,
       to_char(p.urge_time, 'yyyy-mm-dd') urge_time,
       to_char(p.finish_time, 'yyyy-mm-dd') as RW_WCSJ, --�������ʱ��
       '0' as RW_SFYX, --�Ƿ���Ч
       '' as RW_FJID,--����id
       '' as RW_FJSl --��������
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
       WPI.DETAIL_ID AS RW_ID, --����id
       WPI.ITEM RW_MC,         --��������
       'һ������' AS RW_LX ,            --��������
       --WPI.ISFINISH RW_ZTbs,
       TO_CHAR(WPI.START_TIME, 'yyyy-MM-dd') AS RW_KSSJ, --����ʼʱ��
       --TO_CHAR(WPI.END_TIME, 'yyyy-MM-dd') AS RW_JSSJ, --�������ʱ��
       WPI.owner AS RW_JSRID, --���������id
       (select u.user_realname from td_sm_user u where u.user_id= WPI.Hedaer) as rw_fsr,--��������
       --DECODE(WPI.ISFINISH, 0, 'δ���', 1, 'δ���', '-') as RW_ZT --����״̬
       decode(WPI.ISFINISH,'0','������','�����') as RW_ZT --����״̬
  FROM WC_PLAN_INFO WPI;

/


CREATE OR REPLACE VIEW M_V_RW_S AS
SELECT
       WPI.DETAIL_ID AS RW_ID, --����id
       WPI.ITEM RW_MC,         --��������
       'һ������' AS RW_LX ,            --��������
       --WPI.ISFINISH RW_ZTbs,
       TO_CHAR(WPI.START_TIME, 'yyyy-MM-dd') AS RW_KSSJ, --����ʼʱ��
       --TO_CHAR(WPI.END_TIME, 'yyyy-MM-dd') AS RW_JSSJ, --�������ʱ��
       WPI.Urge_User AS RW_JSRID, --���������id
       (select u.user_realname from td_sm_user u where u.user_id= WPI.Hedaer) as rw_fsr,--��������
       --DECODE(WPI.ISFINISH, 0, 'δ���', 1, 'δ���', '-') as RW_ZT --����״̬
       decode(WPI.ISFINISH,'0','������','�����') as RW_ZT --����״̬
  FROM WC_PLAN_INFO WPI;

/

create or replace trigger PTMX_WC_RWJB after insert or delete
/**
*���񽻰�
*������
**/
ON wc_plan_info
FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
BEGIN
select seq_android_wait.nextval into new_wait_id from dual;
    --����
    IF INSERTING  THEN
      insert into M_AA_WAIT(wait_id, business_id, business_type, title, content, curd_type)
      values(new_wait_id, :new.detail_id , 'renwu','',:new.item,'0');
      --������
      if(:new.urge_user is not null) then
      insert into M_AA_UF(WAIT_ID,USER_ID)
      values(new_wait_id,:new.urge_user);
      end if;

      --������
      if(:new.owner is not null) then
      insert into M_AA_UF(WAIT_ID,USER_ID)
      values(new_wait_id,:new.owner);
      end if;

      delete M_AA_UF where rowid not in (
      select max(rowid) from M_AA_UF group by user_id ,wait_id) and wait_id=new_wait_id;
    ELSIF DELETING THEN --ɾ��
      insert into M_AA_WAIT(wait_id, business_id, business_type, title, content, curd_type)
      values(new_wait_id, :new.detail_id , 'renwu','',:new.item,'1');
    end if;
END PTMX_WC_RWJB;

