
DECLARE
HAVE_TABLE NUMBER;
BEGIN
  SELECT COUNT(1) INTO HAVE_TABLE FROM ALL_TABLES WHERE  TABLE_NAME = 'OA_FILE_BEFORE_ARCHIVE_INFO' AND OWNER=SYS.LOGIN_USER;
  IF(HAVE_TABLE>0) THEN
      EXECUTE IMMEDIATE 'drop table oa_file_before_archive_info cascade constraints';
  END IF;
END;
/
/*==============================================================*/
/* Table: oa_file_before_archive_info                           */
/*==============================================================*/
create table oa_file_before_archive_info 
(
   f_id                 VARCHAR2(50),
   f_title              VARCHAR2(500),
   f_file_no            VARCHAR2(500),
   f_archive_type       VARCHAR2(10),
   f_org_id             VARCHAR2(50),
   f_org_name           VARCHAR2(100),
   f_dept_id            VARCHAR2(50),
   f_dept_name          VARCHAR2(100),
   f_oldfile_content    BLOB,
   f_oldfile_type       VARCHAR2(20),
   f_mainfile_content   BLOB,
   f_mainfile_type      VARCHAR2(20),
   f_attach_id          VARCHAR2(50),
   f_create_user_id     VARCHAR2(50),
   f_create_date        date,
   f_archive_user_id    VARCHAR2(50),
   f_archive_date       date,
   f_is_archived        char(1)
);

comment on column oa_file_before_archive_info.f_id is
'信息ID';

comment on column oa_file_before_archive_info.f_title is
'标题';

comment on column oa_file_before_archive_info.f_file_no is
'文号';

comment on column oa_file_before_archive_info.f_archive_type is
'归档类型1:公文归档';

comment on column oa_file_before_archive_info.f_org_id is
'信息所属机构ID';

comment on column oa_file_before_archive_info.f_org_name is
'信息所属机构名';

comment on column oa_file_before_archive_info.f_dept_id is
'信息所属部门ID';

comment on column oa_file_before_archive_info.f_dept_name is
'所属部门=归档部门';

comment on column oa_file_before_archive_info.f_oldfile_content is
'原文内容';

comment on column oa_file_before_archive_info.f_oldfile_type is
'原文文件类型';

comment on column oa_file_before_archive_info.f_mainfile_content is
'正文内容';

comment on column oa_file_before_archive_info.f_mainfile_type is
'正文文件类型';

comment on column oa_file_before_archive_info.f_attach_id is
'附件ID';

comment on column oa_file_before_archive_info.f_create_user_id is
'创建人';

comment on column oa_file_before_archive_info.f_create_date is
'创建时间';

comment on column oa_file_before_archive_info.f_archive_user_id is
'归档人';

comment on column oa_file_before_archive_info.f_archive_date is
'归档时间';

comment on column oa_file_before_archive_info.f_is_archived is
'是否已经归档0:否,1:是';