delete oa_files_devolve_detail;
commit;

drop table OA_FILES_DEVOLVE cascade constraints;

/*==============================================================*/
/* Table: OA_FILES_DEVOLVE                                      */
/*==============================================================*/
create table OA_FILES_DEVOLVE 
(
   F_DEVOLVE_ID         VARCHAR2(50)         not null,
   F_TITLE              VARCHAR2(400),
   F_STATE              char(1),
   F_DEADLINE           VARCHAR2(40),
   F_TYPE               CHAR(1),
   F_RECEIVE_ORG_ID     VARCHAR2(50),
   F_RECEIVE_ORG_NAME   VARCHAR2(200),
   F_BEGIN_TIME         DATE,
   F_DEN_TIME           DATE,
   F_NUM                NUMBER,
   F_LOG_USER_ID        VARCHAR2(50),
   F_LOG_USER_NAME      VARCHAR2(100),
   F_LOG_TIME           DATE,
   F_ORG_ID             VARCHAR2(50),
   F_ORG_NAME           VARCHAR2(500),
   F_DEPT_ID            VARCHAR2(50),
   F_DEPT_NAME          VARCHAR2(500),
   F_REMARKS            VARCHAR2(1000),
   F_ATTACH_ID          VARCHAR2(50),
   F_YEAR               CHAR(4),
   F_FONDS_NO           VARCHAR2(40),
   F_CATALOG_NO         VARCHAR2(100),
   F_FILES_NO           VARCHAR2(100),
   constraint PK_OA_FILES_DEVOLVE primary key (F_DEVOLVE_ID)
);

comment on table OA_FILES_DEVOLVE is
'档案移交记录表';

comment on column OA_FILES_DEVOLVE.F_DEVOLVE_ID is
'移交记录ID';

comment on column OA_FILES_DEVOLVE.F_TITLE is
'移交标题';

comment on column OA_FILES_DEVOLVE.F_STATE is
'移交状态(0:暂存,1:已移交)';

comment on column OA_FILES_DEVOLVE.F_DEADLINE is
'保管期限';

comment on column OA_FILES_DEVOLVE.F_TYPE is
'档案类型(1234:文书照片视频光盘)';

comment on column OA_FILES_DEVOLVE.F_RECEIVE_ORG_ID is
'档案接收单位ID';

comment on column OA_FILES_DEVOLVE.F_RECEIVE_ORG_NAME is
'档案接收单位名称';

comment on column OA_FILES_DEVOLVE.F_BEGIN_TIME is
'起始日期';

comment on column OA_FILES_DEVOLVE.F_DEN_TIME is
'终止日期';

comment on column OA_FILES_DEVOLVE.F_NUM is
'本次移交的卷数(移交卷数)';

comment on column OA_FILES_DEVOLVE.F_LOG_USER_ID is
'登记人ID';

comment on column OA_FILES_DEVOLVE.F_LOG_USER_NAME is
'登记人名称';

comment on column OA_FILES_DEVOLVE.F_LOG_TIME is
'登记日期';

comment on column OA_FILES_DEVOLVE.F_ORG_ID is
'记录所属机构(单位)ID';

comment on column OA_FILES_DEVOLVE.F_ORG_NAME is
'记录所属机构名称';

comment on column OA_FILES_DEVOLVE.F_DEPT_ID is
'记录所属部门ID';

comment on column OA_FILES_DEVOLVE.F_DEPT_NAME is
'记录所属部门名称';

comment on column OA_FILES_DEVOLVE.F_REMARKS is
'备注';

comment on column OA_FILES_DEVOLVE.F_ATTACH_ID is
'附件ID';

comment on column OA_FILES_DEVOLVE.F_YEAR is
'移交年份';

comment on column OA_FILES_DEVOLVE.F_FONDS_NO is
'全宗号(已经作废)';

comment on column OA_FILES_DEVOLVE.F_CATALOG_NO is
'目录号(已经作废)';

comment on column OA_FILES_DEVOLVE.F_FILES_NO is
'案卷号(本次移交的案卷的起止号)(已经作废)';



---修复档案 卷内件数
declare
 v_num number;
 CURSOR c_oa_file_files IS
    select f_files_id from oa_file_files;
begin
 for onerow in c_oa_file_files loop
   select count(1) into v_num from oa_file_doc ofd
   where ofd.f_doc_id in (select f_doc_id from oa_file_docfiles where f_files_id = onerow.f_files_id);
   dbms_output.put_line(v_num);
   if  v_num is null then
     v_num :=0;
   end if;
   update oa_file_files set F_FILES_NUM = v_num where f_files_id = onerow.f_files_id;
 end loop;
 commit;
end;
---修复档案 照片张数
declare
 v_num number;
 CURSOR c_oa_file_doc IS
    select f_doc_id
  from oa_file_doc ofd
 where ofd.f_type_id in
       (select f_type_id
          from oa_file_type
         where f_program_id = 'ed635d24-fced-4353-81f9-86b18e378ef6');
begin
 for onerow in c_oa_file_doc loop
   select count(1) into v_num from oa_file_photo_info ofpi
   where ofpi.F_FILE_ID =  onerow.f_doc_id;
   if  v_num is null then
     v_num :=0;
   end if;
   update oa_file_doc set F_FILE_QUANTITY = v_num where f_doc_id = onerow.f_doc_id;
 end loop;
 commit;
end;

