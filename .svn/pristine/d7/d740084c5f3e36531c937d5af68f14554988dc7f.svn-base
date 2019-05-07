/**
 * 档案查询记录表
 * 1：表结构
 *
 */
 -----1
DECLARE
HAVE_TABLE NUMBER;
BEGIN
  SELECT COUNT(1) INTO HAVE_TABLE FROM ALL_TABLES WHERE  TABLE_NAME = 'OA_FILE_READ_RECODE_INFO' AND OWNER=SYS.LOGIN_USER;
  IF(HAVE_TABLE>0) THEN
      EXECUTE IMMEDIATE 'DROP TABLE OA_FILE_READ_RECODE_INFO';
  END IF;
END;
/

create table OA_FILE_READ_RECODE_INFO 
(
   f_id                 VARCHAR2(50),
   f_user_id            VARCHAR2(50),
   f_user_name          VARCHAR2(500),
   f_org_id             VARCHAR2(50),
   f_org_name           VARCHAR2(500),
   f_dept_id            VARCHAR2(50),
   f_dept_name          VARCHAR2(500),
   recode_type          char(1),
   f_doc_id             VARCHAR2(50),
   f_type_id            VARCHAR2(50),
   f_type_name          VARCHAR2(500),
   f_page_id            VARCHAR2(50),
   f_year               CHAR(4),
   f_month              CHAR(2),
   f_date               CHAR(8),
   read_count           NUMBER,
   f_create_time        DATE,
   f_update_time        DATE,
   f_doc_name           VARCHAR2(500),
   f_files_id           VARCHAR2(50)
);

comment on column OA_FILE_READ_RECODE_INFO.f_id is
'记录编号';

comment on column OA_FILE_READ_RECODE_INFO.f_user_id is
'用户ID';

comment on column OA_FILE_READ_RECODE_INFO.f_user_name is
'用户名称';

comment on column OA_FILE_READ_RECODE_INFO.f_org_id is
'用户所属机构ID';

comment on column OA_FILE_READ_RECODE_INFO.f_org_name is
'用户所属机构名称';

comment on column OA_FILE_READ_RECODE_INFO.f_dept_id is
'用户所属部门ID';

comment on column OA_FILE_READ_RECODE_INFO.f_dept_name is
'用户所属部门名称';

comment on column OA_FILE_READ_RECODE_INFO.recode_type is
'记录类型:阅读1 ';

comment on column OA_FILE_READ_RECODE_INFO.f_doc_id is
'档案ID(文件ID)';

comment on column OA_FILE_READ_RECODE_INFO.f_type_id is
'档案所属类型ID(可能过期)';

comment on column OA_FILE_READ_RECODE_INFO.f_type_name is
'档案所属类型Name(全路径)(可能过期)';

comment on column OA_FILE_READ_RECODE_INFO.f_page_id is
'档案所属页面ID';

comment on column OA_FILE_READ_RECODE_INFO.f_year is
'查看记录所属年份(冗余方便查询)';

comment on column OA_FILE_READ_RECODE_INFO.f_month is
'查看月份(冗余方便查询)';

comment on column OA_FILE_READ_RECODE_INFO.f_date is
'查看日期(冗余方便查询)';

comment on column OA_FILE_READ_RECODE_INFO.read_count is
'单日内查看次数';

comment on column OA_FILE_READ_RECODE_INFO.f_create_time is
'记录创建时间';

comment on column OA_FILE_READ_RECODE_INFO.f_update_time is
'记录最近更新时间';

comment on column OA_FILE_READ_RECODE_INFO.f_doc_name is
'档案名称(可能过期)';

comment on column OA_FILE_READ_RECODE_INFO.f_files_id is
'档案所属案卷ID(查看会计是已案卷为单位)';
