--1将字段改成存数字的
update OA_FILE_doc set F_WENHAO = regexp_replace(F_WENHAO, '[^0-9]', '');

--ADD loc
---添加 单位档案管理员 防止与其他系统脚本重复
DECLARE
HAVE_data NUMBER;
BEGIN
  select COUNT(1) INTO HAVE_data from td_sm_role where role_name='单位档案管理员';
  IF(HAVE_data>1) THEN
  	 delete td_sm_role where role_name='单位档案管理员';
     select (nvl(max(to_number(role_id)),0)+1) into HAVE_data from td_sm_role;
     insert into td_sm_role (ROLE_ID, ROLE_NAME, ROLE_TYPE, ROLE_DESC, ROLE_USAGE, REMARK1, REMARK2, REMARK3, OWNER_ID)
	   values (HAVE_data||'', '单位档案管理员', '1', '单位管理员，用于管理本单位的档案', '', '', '', '', 1);
     commit;
  END IF;
END;
/
--over
commit;