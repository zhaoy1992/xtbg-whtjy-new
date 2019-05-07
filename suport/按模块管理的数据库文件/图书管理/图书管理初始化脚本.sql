insert into OA_DICT_DATA (dictdata_id, dict_id, dictdata_parent_id, dictdata_name, dictdata_value, dictdata_remark, dictdata_is_valid, dictdata_order)
values ('53b24341-6d65-4a7a-b3f9-9f004a7a1aaf', '7', '0', '图书管理', '8', '8', '1', 8);


insert into OA_SYS_PARAM (p_id, p_type, p_code, p_name, p_content, p_valid, p_creator_time, p_isupdate, dictdata_id, p_remark)
values ('e049d717-0942-4727-b4ea-75e4b6f9dcf3', '0', 'system-parameter-ibrarybookback', '归还日期设置', '3', '1', to_date('12-09-2013 09:26:43', 'dd-mm-yyyy hh24:mi:ss'), '1', '53b24341-6d65-4a7a-b3f9-9f004a7a1aaf', '根据图书借阅日期 生成应当归还日期' || chr(13) || '' || chr(10) || '由参数内容来配置.这里配置3 单位是天, 为借阅日期加上这里的参数 生成应归还日期。');