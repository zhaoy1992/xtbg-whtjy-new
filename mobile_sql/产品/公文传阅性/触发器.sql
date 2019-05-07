create or replace trigger M_OA_CIRCULARIZE_FLOWINFO after insert or update or delete
/**
*类型:公文传阅性表添加触发器
*作者:QIULIAN
**/
ON oa_circularize_flow
FOR EACH ROW
declare v_wait_id varchar2(50);

BEGIN
    select  sys_guid() into v_wait_id from dual;
    IF INSERTING  THEN --新增
      insert into M_AA_WAIT (wait_id, business_id, business_type, content,  curd_type)
      values(v_wait_id ,:new.CIRCULARIZE_ID,'chuanyue',:new.CIRCULARIZE_TITLE,'c');
      insert into M_AA_UF (WAIT_ID,USER_ID) values(v_wait_id,:new.RECEIVE_USERID);
    ELSIF UPDATING THEN --更新
        insert into M_AA_WAIT (wait_id, business_id, business_type, content,  curd_type)
        values(v_wait_id ,:new.CIRCULARIZE_ID,'chuanyue',:new.CIRCULARIZE_TITLE,'c');
          insert into M_AA_UF (WAIT_ID,USER_ID) values(v_wait_id,:new.RECEIVE_USERID) ;
    end if;

END M_OA_CIRCULARIZE_FLOWINFO;
