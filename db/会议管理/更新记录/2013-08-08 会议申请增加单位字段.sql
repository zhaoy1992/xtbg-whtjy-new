alter table oa_meeting_notice add m_create_unit_name varchar(200);
alter table oa_meeting_notice add m_create_unit_id varchar(50);
alter table oa_meeting_notice     modify  m_create_dept_name  varchar2(200);
comment  on column oa_meeting_notice.m_create_unit_id is '申请人单位id';
comment  on column oa_meeting_notice.m_create_unit_name is '申请人单位name';