delete from OA_SYS_PARAM where p_name='是否需要报名';
insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('173c2958-0517-4080-af8e-0ecc27dbab89', '0', 'isneedsignup', '是否需要报名', '0', '1', to_date('04-09-2013 09:34:20', 'dd-mm-yyyy hh24:mi:ss'), '1', '21', '为 1 默认显示是否需要报名和报名截止日期；' || chr(13) || '' || chr(10) || '为 0 默认不显示是否能报名和报名截止日期。');
commit;
/
delete from OA_DATA_RESOURCES t where t.resources_name in ('会议管理','会议接收人','会议接收单位','会议单位接收人');
insert into OA_DATA_RESOURCES (resources_id, resources_parent_id, resources_name, resources_logo, resources_desc, creator_time, resources_type, tree_type, is_view)
values ('1', '0', '会议管理', 'meeting', '会议管理', to_date('16-07-2013', 'dd-mm-yyyy'), '1', null, '1');
insert into OA_DATA_RESOURCES (resources_id, resources_parent_id, resources_name, resources_logo, resources_desc, creator_time, resources_type, tree_type, is_view)
values ('2', '1', '会议接收人', 'meetingreson', '会议接收人', to_date('16-07-2013', 'dd-mm-yyyy'), '1', '1', '1');
insert into OA_DATA_RESOURCES (resources_id, resources_parent_id, resources_name, resources_logo, resources_desc, creator_time, resources_type, tree_type, is_view)
values ('3', '1', '会议接收单位', 'meetingunit', '会议接收单位', to_date('16-07-2013', 'dd-mm-yyyy'), '1', '2', '1');
insert into OA_DATA_RESOURCES (resources_id, resources_parent_id, resources_name, resources_logo, resources_desc, creator_time, resources_type, tree_type, is_view)
values ('9', '1', '会议单位接收人', 'meetingunitresion', '会议接收单位接收人', to_date('16-07-2013', 'dd-mm-yyyy'), '2', null, '1');
commit;
/