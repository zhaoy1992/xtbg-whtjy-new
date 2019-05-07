alter table oa_meeting_msg_log   modify  m_contents  null;
alter table oa_meeting_topic     modify  m_topic_unit_ids  null;
alter table oa_meeting_topic     modify  m_topic_user_ids  null;
alter table oa_meeting_topic     modify  m_topic_unit_names  null;
alter table oa_meeting_topic     modify  m_topic_user_names  null;
alter table oa_meeting_notice    modify  m_colse_time null;
alter table oa_meeting_notice    modify  m_contents  null;

alter table oa_meeting_receiver_user    modify  m_receiver_user_id   null;
alter table oa_meeting_receiver_user    modify  m_receiver_user_name   null;
alter table oa_meeting_receiver_user    modify  m_receiver_unit_id   null;
alter table oa_meeting_receiver_user    modify  m_receiver_unit_name   null;

alter table oa_meeting_receiver_unit    modify  m_receiver_unit_id    null;
alter table oa_meeting_receiver_unit    modify  m_receiver_unit_name    null;

alter table oa_meeting_receiver_user     modify  m_call_type  varchar2(50);
alter table oa_meeting_receiver_unit     modify  m_call_type  varchar2(50);

comment  on column oa_meeting_msg_log.m_msg_send_flag is '发送类型重发、补发、发布、草稿、催发';
comment  on column oa_meeting_receiver_user.m_call_type is '催报类型';
comment  on column oa_meeting_receiver_unit.m_call_type is '催报类型';










