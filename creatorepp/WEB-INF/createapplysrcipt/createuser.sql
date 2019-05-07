--------创建用户开始--------
/**
 * &app_user : 应用数据库用户
 * &app_password : 应用数据库密码
 * &app_deftablespace : 应用数据库缺省表空间
 * &app_temptablespace : 应用数据库临时表空间
 * &app_id   : 应用ID
 * &egp_user : 平台数据库用户
 */
create user &app_user
  identified by "&app_password"
  default tablespace &app_deftablespace
  temporary tablespace &app_temptablespace
  profile DEFAULT;
  
---------创建用户结束-------- 

---------授权开始------------

grant connect to &app_user;
grant resource to &app_user;
grant dba to &app_user;

--待办列表权限 开始--
grant select on  td_proc_form_instancemap to &app_user;
grant select on  v_Worklist to &app_user;
grant select on  v_activities to &app_user;
grant select on  activitystates to &app_user;
grant select on  td_worklist_tobe to &app_user;
grant select on  activities to &app_user;
grant select on  processes to &app_user;
grant execute on sum_string to &app_user;
grant select on  tb_delegate to &app_user;
grant select on  ASSIGNMENT_RESIGN_RECORD to &app_user;
--待办列表权限 结束--

--任务表权限 开始--
grant select on assignmentstable to &app_user;
--任务表权限 结束--

---------授权结束------------