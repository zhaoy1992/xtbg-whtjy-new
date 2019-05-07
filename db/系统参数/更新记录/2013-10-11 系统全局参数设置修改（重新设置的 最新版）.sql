delete   OA_SYS_PARAM  where P_CODE='is_pub_mail' or P_CODE='is_pub_rtx' or P_CODE='is_pub_sms' or P_CODE='is_pub_msg';

delete OA_DICT_DATA where DICTDATA_NAME='系统全局参数';
commit;
insert into OA_DICT_DATA (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('bc790dba-bc3e-4147-bc66-894276963c06', '7', '0', '系统全局参数', 'system', '系统中各种全局参数', '1', 4);

insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('874b524a-699a-433d-8ad2-84d515eb9e3e', '1', 'is_pub_mail', '是否有邮件提醒', '0', '1', to_date('08-10-2013 09:43:25', 'dd-mm-yyyy hh24:mi:ss'), '1', 'bc790dba-bc3e-4147-bc66-894276963c06', '1：代表有邮件提醒
0：代表没有邮件提醒
说明：系统的参数值必须是1或0
该参数控制整个系统的是否有邮件提醒，如果配置了0表示系统中所有的模块都不发邮件提醒');

insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('e9d6ea8b-1ca3-494d-a533-92d7f9b112ac', '1', 'is_pub_rtx', '是否有及时通信', '0', '1', to_date('08-10-2013 09:38:47', 'dd-mm-yyyy hh24:mi:ss'), '1', 'bc790dba-bc3e-4147-bc66-894276963c06', '1：代表有及时通信
0：代表没有及时通信
说明：系统的参数值必须是1或0
该参数控制整个系统的是否有及时通信，如果配置了0表示系统中所有的模块都不发及时通信');

insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('7aba6abd-e9f9-4bc6-bf3a-c2abfbaa9980', '1', 'is_pub_sms', '系统是否有短信全局参数', '1', '1', to_date('08-10-2013 09:33:02', 'dd-mm-yyyy hh24:mi:ss'), '1', 'bc790dba-bc3e-4147-bc66-894276963c06', '1：代表有短信
0：代表没有短信
说明：系统的参数值必须是1或0
该参数控制整个系统的是否有短信，如果配置了0表示系统中所有的模块都不发短信');

insert into OA_SYS_PARAM (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('cefde5ea-deca-4e19-832b-1b1604182843', '1', 'is_pub_msg', '是否有站内消息提醒', '1', '1', to_date('08-10-2013 09:41:07', 'dd-mm-yyyy hh24:mi:ss'), '1', 'bc790dba-bc3e-4147-bc66-894276963c06', '1：代表有部内消息
0：代表没有部内消息
说明：系统的参数值必须是1或0
该参数控制整个系统的是否有站内消息，如果配置了0表示系统中所有的模块都不发部内消息');
commit;