drop table OA_MEETING_NOTE_TEMPLATE cascade constraints;

/*==============================================================*/
/* Table: OA_MEETING_NOTE_TEMPLATE                              */
/*==============================================================*/
create table OA_MEETING_NOTE_TEMPLATE 
(
   M_ID                 varchar2(50)         not null,
   M_NAME               varchar2(50)         not null,
   M_NOTICE_ID          varchar2(50),
   M_CONTENTS           varchar2(300)        not null,
   constraint PK_OA_MEETING_NOTE_TEMPLATE primary key (M_ID)
);

comment on table OA_MEETING_NOTE_TEMPLATE is
'会议发送消息模板';

comment on column OA_MEETING_NOTE_TEMPLATE.M_ID is
'主键id';

comment on column OA_MEETING_NOTE_TEMPLATE.M_NAME is
'短信模板名称';

comment on column OA_MEETING_NOTE_TEMPLATE.M_NOTICE_ID is
'会议id';

comment on column OA_MEETING_NOTE_TEMPLATE.M_CONTENTS is
' 短信内容';
