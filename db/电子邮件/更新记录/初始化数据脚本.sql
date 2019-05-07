delete oa_mail_menu where MENU_ID in ('0','1','2','3','4');

insert into oa_mail_menu (MENU_ID, MENU_NAME, MENU_REMARK, MENU_PARENTID, REMARK1, REMARK2)
values ('0', '电子邮件', null, null, null, null);

insert into oa_mail_menu (MENU_ID, MENU_NAME, MENU_REMARK, MENU_PARENTID, REMARK1, REMARK2)
values ('1', '收件箱', '1', '0', null, null);

insert into oa_mail_menu (MENU_ID, MENU_NAME, MENU_REMARK, MENU_PARENTID, REMARK1, REMARK2)
values ('2', '草稿箱', '2', '0', null, null);

insert into oa_mail_menu (MENU_ID, MENU_NAME, MENU_REMARK, MENU_PARENTID, REMARK1, REMARK2)
values ('3', '已发邮件', '3', '0', null, null);

insert into oa_mail_menu (MENU_ID, MENU_NAME, MENU_REMARK, MENU_PARENTID, REMARK1, REMARK2)
values ('4', '发邮件', '4', '0', null, null);

commit;