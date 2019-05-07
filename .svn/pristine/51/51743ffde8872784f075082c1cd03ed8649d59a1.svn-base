--角色查看不到人 （添加用户机构job关联关系）
insert into td_sm_userjoborg (USER_ID,job_id,org_id,same_job_user_sn,job_sn,job_starttime,job_fettle)
       select ou.user_id,'1', ou.org_id ,'1','999',sysdate,'' from td_sm_orguser ou where ou.user_id not in (select uj.user_id from td_sm_userjoborg uj)
       