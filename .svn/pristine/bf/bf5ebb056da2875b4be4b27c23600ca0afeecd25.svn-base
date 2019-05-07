/**
 * 档案移交-建表sql脚本
 * 1：表结构
 * zoutuo
 */
DECLARE
HAVE_TABLE NUMBER;
BEGIN
  SELECT COUNT(1) INTO HAVE_TABLE FROM ALL_TABLES WHERE  TABLE_NAME = 'OA_FILES_DEVOLVE' AND OWNER=SYS.LOGIN_USER;
  IF(HAVE_TABLE>0) THEN
      EXECUTE IMMEDIATE 'DROP TABLE OA_FILES_DEVOLVE';
  END IF;
  
  SELECT COUNT(1) INTO HAVE_TABLE FROM ALL_TABLES WHERE  TABLE_NAME = 'OA_FILES_DEVOLVE_DETAIL' AND OWNER=SYS.LOGIN_USER;
  IF(HAVE_TABLE>0) THEN
      EXECUTE IMMEDIATE 'DROP TABLE OA_FILES_DEVOLVE_DETAIL';
  END IF;
END;
/
create table OA_FILES_DEVOLVE 
(
   F_DEVOLVE_ID         VARCHAR2(50)         not null,
   F_STATE              char(1),
   F_FONDS_NO           VARCHAR2(40),
   F_CATALOG_NO         VARCHAR2(100),
   F_BEGIN_TIME         DATE,
   F_DEN_TIME           DATE,
   F_NUM                NUMBER,
   F_FILES_NO           VARCHAR2(100),
   F_DEADLINE           VARCHAR2(40),
   F_ATTACH_ID          VARCHAR2(50),
   F_ORG_ID             VARCHAR2(50),
   F_ORG_NAME           VARCHAR2(500),
   F_DEPT_ID            VARCHAR2(50),
   F_DEPT_NAME          VARCHAR2(500),
   F_LOG_USER_ID        VARCHAR2(50),
   F_LOG_USER_NAME      VARCHAR2(100),
   F_LOG_TIME           DATE,
   F_RECEIVE_ORG_NAME   VARCHAR2(200),
   F_RECEIVE_ORG_ID     VARCHAR2(50),
   F_YEAR               CHAR(4),
   constraint PK_OA_FILES_DEVOLVE primary key (F_DEVOLVE_ID)
);

comment on table OA_FILES_DEVOLVE is
'档案移交记录表';

comment on column OA_FILES_DEVOLVE.F_DEVOLVE_ID is
'移交记录ID';

comment on column OA_FILES_DEVOLVE.F_STATE is
'移交状态(0:暂存,1:已移交)';

comment on column OA_FILES_DEVOLVE.F_FONDS_NO is
'全宗号';

comment on column OA_FILES_DEVOLVE.F_CATALOG_NO is
'目录号';

comment on column OA_FILES_DEVOLVE.F_BEGIN_TIME is
'起始日期';

comment on column OA_FILES_DEVOLVE.F_DEN_TIME is
'终止日期';

comment on column OA_FILES_DEVOLVE.F_NUM is
'本次移交的卷数(移交卷数)';

comment on column OA_FILES_DEVOLVE.F_FILES_NO is
'案卷号(本次移交的案卷的起止号)';

comment on column OA_FILES_DEVOLVE.F_DEADLINE is
'保管期限';

comment on column OA_FILES_DEVOLVE.F_ATTACH_ID is
'附件ID';

comment on column OA_FILES_DEVOLVE.F_ORG_ID is
'记录所属机构(单位)ID';

comment on column OA_FILES_DEVOLVE.F_ORG_NAME is
'记录所属机构名称';

comment on column OA_FILES_DEVOLVE.F_DEPT_ID is
'记录所属部门ID';

comment on column OA_FILES_DEVOLVE.F_DEPT_NAME is
'记录所属部门名称';

comment on column OA_FILES_DEVOLVE.F_LOG_USER_ID is
'登记人ID';

comment on column OA_FILES_DEVOLVE.F_LOG_USER_NAME is
'登记人名称';

comment on column OA_FILES_DEVOLVE.F_LOG_TIME is
'登记日期';

comment on column OA_FILES_DEVOLVE.F_RECEIVE_ORG_NAME is
'档案接收单位名称';

comment on column OA_FILES_DEVOLVE.F_RECEIVE_ORG_ID is
'档案接收单位ID';

comment on column OA_FILES_DEVOLVE.F_YEAR is
'移交年份';


create table OA_FILES_DEVOLVE_DETAIL 
(
   F_DEVOLVE_DETAIL_ID  VARCHAR2(50)         not null,
   F_DEVOLVE_ID         VARCHAR2(50),
   F_FILES_ID           VARCHAR2(50),
   F_START_TIME         DATE,
   F_END_TIME           DATE,
   F_PAGE_NUM           NUMBER,
   F_STATE              CHAR(1),
   constraint PK_OA_FILES_DEVOLVE_DETAIL primary key (F_DEVOLVE_DETAIL_ID)
);

comment on table OA_FILES_DEVOLVE_DETAIL is
'档案移交明细表';

comment on column OA_FILES_DEVOLVE_DETAIL.F_DEVOLVE_DETAIL_ID is
'移交明细记录ID';

comment on column OA_FILES_DEVOLVE_DETAIL.F_DEVOLVE_ID is
'所属移交记录ID';

comment on column OA_FILES_DEVOLVE_DETAIL.F_FILES_ID is
'关联的案卷ID';

comment on column OA_FILES_DEVOLVE_DETAIL.F_START_TIME is
'档案开始日期';

comment on column OA_FILES_DEVOLVE_DETAIL.F_END_TIME is
'档案结束日期';

comment on column OA_FILES_DEVOLVE_DETAIL.F_PAGE_NUM is
'页数';

comment on column OA_FILES_DEVOLVE_DETAIL.F_STATE is
'移交状态(0:暂存,1:已移交)';
