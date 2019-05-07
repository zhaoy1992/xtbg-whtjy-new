----任务交办视图


--我收到的任务列表视图
create or replace view M_V_RW_R as
select a.id RW_ID,
             a.task_name RW_MC,
             b.type_name RW_LX,
             to_char(a.start_time,'yyyy-mm-dd hh24:mi:ss') RW_KSSJ,
             a.input_username RW_FSR,
             a.receive_userid RW_JSRID,
             decode(a.task_status,'3','已办结','2','办理中','未办理') RW_ZT
        from oa_task_baseinfo a
        left join oa_task_type b
          on a.task_type = b.type_id;
/       
--我交办的任务列表视图
create or replace view M_V_RW_S as
select a.id RW_ID,
             a.task_name RW_MC,
             b.type_name RW_LX,
             to_char(a.start_time,'yyyy-mm-dd hh24:mi:ss') RW_KSSJ,
             a.receive_username RW_FSR,
             a.input_userid RW_JSRID,
             decode(a.task_status,'3','已办结','2','办理中','未办理') RW_ZT
        from oa_task_baseinfo a
        left join oa_task_type b
          on a.task_type = b.type_id;
/        
--任务详情视图
create or replace view M_V_RW_D as 
select a.id RW_ID,
             a.task_name RW_MC,
             b.type_name RW_LX,  
             a.receive_userid RW_JSRID,
             decode(a.DEGREE_OF_IMPORTANCE,'3','非常重要','2','重要','普通') RW_ZYCD, 
              a.input_username RW_FQR,
             a.input_orgname RW_FQRDW,
             a.task_content RW_NR,
             to_char(a.start_time,'yyyy-mm-dd hh24:mi:ss') RW_KSSJ, 
             to_char(a.end_time,'yyyy-mm-dd hh24:mi:ss') RW_WCSJ,
             decode(a.task_status,'3','已办结','2','办理中','未办理') RW_ZT,
             '是' HY_SFYX,
             ATTACH_ID RW_FJID,
             (select count(*) from oa_fc_attach f   where trim(f.djbh) = trim(a.attach_id)) as RW_FJSl--附件数量   RW_FJSl          
        from oa_task_baseinfo a
        left join oa_task_type b
        on a.task_type = b.type_id;
/

drop table M_T_RW_HF;
-- Create table
create table M_T_RW_HF
(
  RW_ID    VARCHAR2(50),
  RW_HFNR  VARCHAR2(2000),
  RW_HFRID VARCHAR2(50)
);
-- Add comments to the table 
comment on table M_T_RW_HF
  is '科创任务交办回复';
-- Add comments to the columns 
comment on column M_T_RW_HF.RW_ID
  is '任务交办主键';
comment on column M_T_RW_HF.RW_HFNR
  is '回复内容';
comment on column M_T_RW_HF.RW_HFRID
  is '回复人id';


create or replace trigger mobile_M_T_RW_HF after insert
/**
*类型:任务交办回复表添加触发器
*作者:戴连春
**/
ON M_T_RW_HF
FOR EACH ROW

declare
  v_userName varchar(50);
BEGIN

  --新增
  if (:new.RW_HFNR is null) then
    --如果插入的回复内容为空，则为办结
    update oa_task_baseinfo set TASK_STATUS = '3' where ID = :new.RW_ID;
  end if;

  if (:new.RW_HFNR is not null) then
    --更新状态为办理中
    update oa_task_baseinfo set TASK_STATUS = '2' where ID = :new.RW_ID and TASK_STATUS <>3;
    --查询出办理人姓名

    select USER_REALNAME
      into v_userName
      from td_sm_user
     where USER_ID = :new.RW_HFRID;

    insert into OA_TASK_TASKREPORT
      (id, task_id, Report_Content, Report_Time, User_Id, user_name, type)
    values
      (sys_guid(),
       :new.RW_ID,
       :new.RW_HFNR,
       sysdate,
       :new.RW_HFRID,
       v_userName,
       '0');

  end if;

END mobile_M_T_RW_HF;
/
create or replace trigger mobile_OA_TASK_BASEINFO after insert or update or delete
/**
*类型:任务交办表添加触发器
*作者:戴连春
**/
ON OA_TASK_BASEINFO
FOR EACH ROW
declare v_wait_id varchar2(50);
BEGIN
    select  sys_guid() into v_wait_id from dual;
    IF INSERTING  THEN --新增
      insert into M_AA_WAIT (wait_id, business_id, business_type, content,CREATE_TIME,  curd_type)
      values(v_wait_id ,:new.id,'renwu',:new.TASK_NAME,sysdate,'c');
      insert into M_AA_UF (WAIT_ID,USER_ID) values(v_wait_id,:new.RECEIVE_USERID);
    ELSIF UPDATING THEN --更新
      insert into M_AA_WAIT (wait_id, business_id, business_type, content, CREATE_TIME, curd_type)
      values(v_wait_id ,:new.id,'renwu',:new.TASK_NAME,sysdate,'u');
      insert into M_AA_UF (WAIT_ID,USER_ID) values(v_wait_id,:new.RECEIVE_USERID);
    ELSIF DELETING THEN --删除
      insert into M_AA_WAIT (wait_id, business_id, business_type, content, CREATE_TIME, curd_type)
      values(v_wait_id,:old.id,'renwu',:old.TASK_NAME,sysdate,'d');
      insert into M_AA_UF (WAIT_ID,USER_ID) values(v_wait_id,:old.RECEIVE_USERID);
    end if;

END mobile_OA_TASK_BASEINFO;
/