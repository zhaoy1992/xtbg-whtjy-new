---系统参数
delete from OA_SYS_PARAMVALUE where  p_value_id = '8742ce65-9086-4a91-b509-ffb7af0d1790';
commit;
insert into OA_SYS_PARAMVALUE (p_value_id, p_code, p_value_code, p_value_name, p_value_valid, p_creator_time)
values ('8742ce65-9086-4a91-b509-ffb7af0d1790', 'makenotice', 'p_title', 'XXX', '1', to_date('13-09-2013 14:27:16', 'dd-mm-yyyy hh24:mi:ss'));
commit;
delete from OA_SYS_PARAM where  p_id = '497579ad-54fc-48e2-85c8-873669bbe21b';
commit;
insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('497579ad-54fc-48e2-85c8-873669bbe21b', 'PAPER_MAKE_NOTICE', 'makenotice', '约稿通知(短信提醒)', '约稿通知' || chr(13) || '' || chr(10) || '通知标题：XXX   请及时查阅约稿通知', '1', to_date('13-09-2013 14:22:42', 'dd-mm-yyyy hh24:mi:ss'), '1', '8a7da04e-08cd-48dd-8df7-41540e991e9d', 'xxx  用  约稿标题代替');
commit;
---数据权限了
delete from OA_DATA_RESOURCES  where resources_id in ('30','31','32');
commit;
insert into OA_DATA_RESOURCES (resources_id, resources_parent_id, resources_name, resources_logo, resources_desc, creator_time, resources_type, tree_type, is_view)
values ('30', '0', '信息上报', 'paper', '信息上报', to_date('11-09-2013', 'dd-mm-yyyy'), '1', null, '1');
insert into OA_DATA_RESOURCES (resources_id, resources_parent_id, resources_name, resources_logo, resources_desc, creator_time, resources_type, tree_type, is_view)
values ('31', '30', '上报的接收单位', 'paperreporttounit', '上报的接收单位', to_date('11-09-2013', 'dd-mm-yyyy'), '1', '2', '1');
insert into OA_DATA_RESOURCES (resources_id, resources_parent_id, resources_name, resources_logo, resources_desc, creator_time, resources_type, tree_type, is_view)
values ('32', '30', '收通知的约稿单位', 'paperreceiveunit', '收通知的约稿单位', to_date('11-09-2013', 'dd-mm-yyyy'), '1', '2', '1');
commit;
----
delete from TD_SM_ROLE where role_name in ('信息报送管理领导批示角色','信息发布的审核人员角色','接收约稿通知者角色');
commit;
insert into TD_SM_ROLE (role_id, role_name, role_type, role_desc, role_usage, remark1, remark2, remark3, owner_id)
values (SEQ_TD_SM_ROLE.NEXTVAL, '信息报送管理领导批示角色', '1', '信息报送管理领导批示角色', null, null, null, null, 1);
insert into TD_SM_ROLE (role_id, role_name, role_type, role_desc, role_usage, remark1, remark2, remark3, owner_id)
values (SEQ_TD_SM_ROLE.NEXTVAL, '信息发布的审核人员角色', '1', '在信息采编送审为待发布时，包括可以进行审核发布信息的人员。', null, null, null, null, 1);
insert into TD_SM_ROLE (role_id, role_name, role_type, role_desc, role_usage, remark1, remark2, remark3, owner_id)
values (SEQ_TD_SM_ROLE.NEXTVAL, '接收约稿通知者角色', '1', '该角色应包括能够接收上级单位发送来的约稿通知的人', null, null, null, null, 1);
commit;

--del data,del type

delete from OA_DICT_DATA where dict_id IN ('17631aec-a754-4aec-a0f3-5b5d6e5f2ee5','880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5');
commit;
delete from OA_DICT_TYPE where dict_id IN ('17631aec-a754-4aec-a0f3-5b5d6e5f2ee5','880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5');
commit;
 
--insert t

insert into OA_DICT_TYPE (dict_id, dict_parent_id, dict_name, dict_code, dict_remark, dict_is_valid, dict_order, dict_type)
values ('17631aec-a754-4aec-a0f3-5b5d6e5f2ee5', '0', '信息报送类型', 'infotype', null, '1', null, '0');
insert into OA_DICT_TYPE (dict_id, dict_parent_id, dict_name, dict_code, dict_remark, dict_is_valid, dict_order, dict_type)
values ('880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5', '0', '信息报送状态', 'infoflag', null, '1', null, '0');
commit;
---insert d
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('ca38cf70-ed48-4fa3-bab4-db2918064a82', '17631aec-a754-4aec-a0f3-5b5d6e5f2ee5', '0', '类型2', '002', null, '1', null);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('6faaacf9-daee-40d3-8a41-f13687473fcc', '880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5', '0', '草稿（采编）', '7', '采编后的暂存的草稿', '1', null);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('51aef37e-8a0a-4b05-8ba8-a093f7482787', '17631aec-a754-4aec-a0f3-5b5d6e5f2ee5', '0', '类型1', '001', null, '1', null);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('ff8f8504-9b3d-4bdd-a855-15567385c7c8', '880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5', '0', '待采编', '0', null, '1', 2);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('ff8f8504-9b3d-4bdd-a855-25567385c7c8', '880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5', '0', '已采编', '1', null, '1', 3);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('ff8f8504-9b3d-4bdd-a855-35567385c7c8', '880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5', '0', '退稿', '2', null, '1', 4);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('ff8f8504-9b3d-4bdd-a855-45567385c7c8', '880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5', '0', '草稿', '3', null, '1', 1);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('ff8f8504-9b3d-4bdd-a855-55567385c7c8', '880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5', '0', '已发布', '4', null, '1', 5);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('ff8f8504-9b3d-4bdd-a855-65567385c7c8', '880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5', '0', '待发布', '5', null, '1', 6);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('ff8f8504-9b3d-4bdd-a855-75567385c7c8', '880ef4c4-a7a7-41e5-9b08-6bb6f37b7bb5', '0', '退回', '6', null, '1', 7);
commit;
/
create   function getDictName(P_DICTDATA_VALUE in VARCHAR2,
                                       P_DICT_CODE      in VARCHAR2)
  return varchar2 is
  ResultDICTDATA_NAME VARCHAR2(100);
begin
  ResultDICTDATA_NAME := '';

  select dd.dictdata_name
    INTO ResultDICTDATA_NAME
    from (SELECT d.dictdata_name
            FROM oa_dict_data d, oa_dict_type t
           WHERE d.dict_id = t.dict_id
             and d.dictdata_value = P_DICTDATA_VALUE
             and t.dict_code = P_DICT_CODE) dd
   where rownum = 1;
  return(ResultDICTDATA_NAME);
end;



