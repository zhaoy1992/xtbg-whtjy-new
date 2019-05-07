delete from OA_DICT_DATA where dict_id='11' ;
commit;
delete from OA_DICT_TYPE where dict_id='11' ;
commit;
insert into OA_DICT_TYPE (dict_id, dict_parent_id, dict_name, dict_code, dict_remark, dict_is_valid, dict_order, dict_type)
values ('11', '0', '报名情况', 'bmqk', '报名情况', '1', 12, '0');
commit;

insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1103', '11', '0', '委托人参加', '2', null, '1', 3);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1101', '11', '0', '未回复', '0', null, '1', 1);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1102', '11', '0', '本人参加', '1', null, '1', 2);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1104', '11', '0', '安排人参加', '3', null, '1', 4);
insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1105', '11', '0', '请假', '9', null, '1', 5);
commit;
