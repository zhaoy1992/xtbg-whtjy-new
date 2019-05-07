---添加 单位档案管理员 防止与其他系统脚本重复
DECLARE
HAVE_data NUMBER;
BEGIN
  select COUNT(1) INTO HAVE_data from td_sm_role where role_name='单位档案管理员';
  IF(HAVE_data=0) THEN
     select (nvl(max(to_number(role_id)),0)+1) into HAVE_data from td_sm_role;
     insert into td_sm_role (ROLE_ID, ROLE_NAME, ROLE_TYPE, ROLE_DESC, ROLE_USAGE, REMARK1, REMARK2, REMARK3, OWNER_ID)
	   values (HAVE_data||'', '单位档案管理员', '1', '单位管理员，用于管理本单位的档案', '', '', '', '', 1);
     commit;
  END IF;
END;
/
---备考表模板参数 增加

DECLARE
HAVE_data NUMBER;
BEGIN
  select COUNT(1) INTO HAVE_data from oa_dict_data where DICTDATA_NAME='保管期限' and DICT_ID = '885bf4c5-e064-451e-ac84-f86bf7e277b0';
  IF(HAVE_data=0) THEN
    insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('81701d98-772c-4403-a488-0a1ac5a814c4', '885bf4c5-e064-451e-ac84-f86bf7e277b0', '0', '保管期限', 'f_doc_deadline_name', '', '1', 6);
     commit;
  END IF;
END;
/

DECLARE
HAVE_data NUMBER;
BEGIN
  select COUNT(1) INTO HAVE_data from oa_flow_busitype_type where busitype_type_code ='dang_an';
  IF(HAVE_data=0) THEN
    insert into oa_flow_busitype_type (BUSITYPE_TYPE_CODE, BUSITYPE_TYPE_NAME, TYPE_DESC, IS_VALID, IS_FLOW, ORDER_NO)
	values ('dang_an', '档案', '档案', '1', '1', 4);
     commit;
  END IF;
END;
/


insert into oa_flow_busitype (BUSITYPE_CODE, BUSITYPE_NAME, TYPE_DESC, IS_VALID, BUSITYPE_TYPE_CODE)
values ('uuid-336', '档案借阅申请', '档案借阅申请', 'Y', 'dang_an');

insert into oa_flow_busitype (BUSITYPE_CODE, BUSITYPE_NAME, TYPE_DESC, IS_VALID, BUSITYPE_TYPE_CODE)
values ('uuid-337', '档案销毁申请1', '档案销毁申请', 'Y', 'dang_an');