insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('1106', '7', '0', '湘特检简报', '9', '9', '1', 9);

insert into oa_sys_param (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('8a9c3179-1c88-4eeb-a667-9ef4bed3822c', '0', 'report_url', '湘特检简报路径', '/aacc/Noname1.html', '1', to_date('12-03-2015 09:47:42', 'dd-mm-yyyy hh24:mi:ss'), '1', '1106', '湘特检简报路径的路径，配置是在tomcat里面的文件夹');

commit;