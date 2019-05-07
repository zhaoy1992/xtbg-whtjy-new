/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 11                       */
/* Created on:     2013-8-7 16:16:14                            */
/*==============================================================*/


/*==============================================================*/
/* Table: OA_MAIL_RECV                                          */
/*==============================================================*/
create table OA_MAIL_RECV 
(
   recv_id              varchar2(50)                   not null,
   mail_id              varchar2(50)                   not null,
   recv_user            varchar2(50)                   not null,
   send_type            varchar2(1)                    not null,
   status               char(1)                        not null,
   read_date            date                           null,
   constraint PK_OA_MAIL_RECV primary key(recv_id)
);

comment on table OA_MAIL_RECV is 
'邮件接收表';

comment on column OA_MAIL_RECV.recv_id is 
'接收id';

comment on column OA_MAIL_RECV.mail_id is 
'邮件id';

comment on column OA_MAIL_RECV.recv_user is 
'收件人';

comment on column OA_MAIL_RECV.send_type is 
'主送(m)/抄送(c)标志';

comment on column OA_MAIL_RECV.status is 
'收件状态：1待阅，2已阅，3被撤销，4删除';

comment on column OA_MAIL_RECV.read_date is 
'阅读时间';

/*==============================================================*/
/* Table: OA_MAIL_TOPIC                                         */
/*==============================================================*/
create table OA_MAIL_TOPIC 
(
   mail_id              varchar2(50)                   not null,
   topic                varchar2(400)                  null,
   content              clob                           null,
   send_user            varchar2(50)                   not null,
   create_date          date                           not null,
   send_date            date                           null,
   mail_origin          char(1)                        not null,
   status               char(1)                        not null,
   constraint PK_OA_MAIL_TOPIC primary key(mail_id)
);

comment on table OA_MAIL_TOPIC is 
'系统邮件主题表';

comment on column OA_MAIL_TOPIC.mail_id is 
'邮件id';

comment on column OA_MAIL_TOPIC.topic is 
'邮件主题';

comment on column OA_MAIL_TOPIC.content is 
'邮件内容';

comment on column OA_MAIL_TOPIC.send_user is 
'发件人';

comment on column OA_MAIL_TOPIC.create_date is 
'创建时间';

comment on column OA_MAIL_TOPIC.send_date is 
'发件时间';

comment on column OA_MAIL_TOPIC.mail_origin is 
'邮件来源：1起草，2转发，3业务发送，4收件';

comment on column OA_MAIL_TOPIC.status is 
'邮件状态：1草稿，2正在发送，3已发送，4已撤销，5已删除';

/*==============================================================*/
/* Table: oa_mail_affix                                         */
/*==============================================================*/
create table oa_mail_affix 
(
   affix_id             varchar2(50)                   not null,
   mail_id              varchar2(50)                   not null,
   ORIGINAL_NAME        VARCHAR2(200)                  null,
   REALNAME             VARCHAR2(200)                  null,
   FILESIZE             NUMBER                         null,
   CONTENT              BLOB                           null,
   filetype             VARCHAR2(10)                   null,
   FILELOCATION         VARCHAR2(200)                  null,
   constraint PK_OA_MAIL_AFFIX primary key(affix_id)
);

comment on table oa_mail_affix is 
'邮件附件表';

comment on column oa_mail_affix.affix_id is 
'附件id';

comment on column oa_mail_affix.mail_id is 
'邮件id';

comment on column oa_mail_affix.ORIGINAL_NAME is 
'文件的原始名称';

comment on column oa_mail_affix.REALNAME is 
'系统更改后的文件名称';

comment on column oa_mail_affix.FILESIZE is 
'文件大小';

comment on column oa_mail_affix.CONTENT is 
'文件内容';

comment on column oa_mail_affix.filetype is 
'文件类型';

comment on column oa_mail_affix.FILELOCATION is 
'文件所在文件系统的路径地址';

alter table OA_MAIL_RECV
   add constraint FK_OA_MAIL_RECV foreign key (mail_id)
      references OA_MAIL_TOPIC (mail_id);

alter table oa_mail_affix
   add constraint FK_oa_mail_affix foreign key (mail_id)
      references OA_MAIL_TOPIC (mail_id);

