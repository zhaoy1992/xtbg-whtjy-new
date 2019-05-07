delete OA_DICT_TYPE  where DICT_CODE IN ('xtcs');
commit;

insert into OA_DICT_TYPE (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('7', '0', '系统参数', 'xtcs', '系统参数设置', '1', 7, '0');
commit;

delete OA_DICT_DATA  where DICTDATA_VALUE IN ('syspubparam');
commit;

insert into OA_DICT_DATA (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('fb4fcbd5-4406-43af-8d3b-dbc73fcd7f0e', '7', '0', '系统全局参数', 'syspubparam', '系统全局参数:记录系统中全局参数，例如：是否有短信', '1', null);
commit;

delete OA_SYS_PARAM d where d.p_code IN ('is_pub_msg','is_pub_rtx','is_pub_mail','is_pub_sms');
commit;

insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('e93144d2-a6b9-42f4-960b-8a3a0abf4956', '1', 'is_pub_msg', '是否有站内消息提醒', '1', '1', to_date('08-08-2013 09:36:02', 'dd-mm-yyyy hh24:mi:ss'), '1', 'fb4fcbd5-4406-43af-8d3b-dbc73fcd7f0e', '1：代表有部内消息' || chr(13) || '' || chr(10) || '0：代表没有部内消息' || chr(13) || '' || chr(10) || '说明：系统的参数值必须是1或0' || chr(13) || '' || chr(10) || '该参数控制整个系统的是否有站内消息，如果配置了0表示系统中所有的模块都不发部内消息');
insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('2781a3e2-7036-4fc3-810b-93dfea8d2f87', '1', 'is_pub_rtx', '是否有及时通信', '0', '1', to_date('08-08-2013 09:42:57', 'dd-mm-yyyy hh24:mi:ss'), '1', 'fb4fcbd5-4406-43af-8d3b-dbc73fcd7f0e', '1：代表有及时通信' || chr(13) || '' || chr(10) || '0：代表没有及时通信' || chr(13) || '' || chr(10) || '说明：系统的参数值必须是1或0' || chr(13) || '' || chr(10) || '该参数控制整个系统的是否有及时通信，如果配置了0表示系统中所有的模块都不发及时通信');
insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('e2855b33-66ba-4923-aadf-db6d5418d036', '1', 'is_pub_mail', '是否有邮件提醒', '0', '1', to_date('08-08-2013 09:40:52', 'dd-mm-yyyy hh24:mi:ss'), '1', 'fb4fcbd5-4406-43af-8d3b-dbc73fcd7f0e', '1：代表有邮件提醒' || chr(13) || '' || chr(10) || '0：代表没有邮件提醒' || chr(13) || '' || chr(10) || '说明：系统的参数值必须是1或0' || chr(13) || '' || chr(10) || '该参数控制整个系统的是否有邮件提醒，如果配置了0表示系统中所有的模块都不发邮件提醒' || chr(13) || '' || chr(10) || '');
insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('c62f23c7-14fb-4316-b024-0e8f5f324392', '1', 'is_pub_sms', '系统是否有短信全局参数', '1', '1', to_date('08-08-2013 09:32:28', 'dd-mm-yyyy hh24:mi:ss'), '1', 'fb4fcbd5-4406-43af-8d3b-dbc73fcd7f0e', '1：代表有短信' || chr(13) || '' || chr(10) || '0：代表没有短信' || chr(13) || '' || chr(10) || '说明：系统的参数值必须是1或0' || chr(13) || '' || chr(10) || '该参数控制整个系统的是否有短信，如果配置了0表示系统中所有的模块都不发短信');
commit;