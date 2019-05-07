/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-8-21 17:18:27                           */
/*==============================================================*/


drop table OA_FILE_FILES cascade constraints;

drop table OA_FILE_FILES_ACC cascade constraints;

drop table OA_FILE_NOTE cascade constraints;

drop table OA_FILE_PHOTO_INFO cascade constraints;

drop table oa_file_destroy cascade constraints;

drop table oa_file_destroy_detail cascade constraints;

drop table oa_file_doc cascade constraints;

drop table oa_file_docfiles cascade constraints;

drop table oa_file_favorites cascade constraints;

drop table oa_file_fondsno cascade constraints;

drop table oa_file_lending cascade constraints;

drop table oa_file_lending_detail cascade constraints;

drop table oa_file_normdate cascade constraints;

drop table oa_file_pan_ext cascade constraints;

drop table oa_file_program_page cascade constraints;

drop table oa_file_purview cascade constraints;

drop table oa_file_purviewuser cascade constraints;

drop table oa_file_recursion cascade constraints;

drop table oa_file_storage_location cascade constraints;

drop table oa_file_type cascade constraints;

drop table oa_file_type_norm cascade constraints;

/*==============================================================*/
/* Table: OA_FILE_FILES                                         */
/*==============================================================*/
create table OA_FILE_FILES 
(
   F_FILES_ID           VARCHAR2(50)         not null,
   F_FILES_TITLE        VARCHAR2(200),
   F_TYPE_NAME          VARCHAR2(500)        not null,
   F_FILES_NO           VARCHAR2(400),
   F_TYPENO             VARCHAR2(40),
   F_FONDSNO            VARCHAR2(40),
   F_FILESNO            VARCHAR2(40),
   F_STORAGE_FULLNAME   VARCHAR2(500),
   F_DOC_YEAR           VARCHAR2(4),
   F_SECRECY_ID         VARCHAR2(50),
   F_SECRECY_NAME       VARCHAR2(100),
   F_DOC_DEADLINE       VARCHAR2(40),
   F_ORG_ID             VARCHAR2(50),
   F_ORG_NAME           VARCHAR2(200),
   F_DEPT_ID            VARCHAR2(50),
   F_DEPT_NAME          VARCHAR2(200),
   F_DOC_BLNAME         VARCHAR2(200),
   F_FILES_NUM          NUMBER,
   F_FILES_CONTENT      VARCHAR2(2000),
   F_FILES_STATE        VARCHAR2(50)         not null,
   F_FILE_USERID        VARCHAR2(50),
   F_FILE_USERNAME      VARCHAR2(100),
   F_FILE_TIME          DATE,
   F_LISTNO             VARCHAR2(100),
   F_DOC_DEADLINE_NAME  VARCHAR2(100)        not null,
   F_ENTITY_TYPE_NAME   VARCHAR2(100),
   F_ENTITY_TYPE        VARCHAR2(50),
   F_FILES_STATE_NAME   VARCHAR2(100),
   F_START_TIME         DATE,
   F_END_TIME           DATE,
   F_DOC_BLID           VARCHAR2(50),
   F_TYPE_ID            VARCHAR2(50)         not null,
   constraint PK_OA_FILE_FILES primary key (F_FILES_ID)
);

comment on table OA_FILE_FILES is
'档案管理表';

comment on column OA_FILE_FILES.F_FILES_ID is
'案卷ID';

comment on column OA_FILE_FILES.F_FILES_TITLE is
'案卷标题';

comment on column OA_FILE_FILES.F_TYPE_NAME is
'所属分类名称(全称)';

comment on column OA_FILE_FILES.F_FILES_NO is
'档号';

comment on column OA_FILE_FILES.F_TYPENO is
'分类号';

comment on column OA_FILE_FILES.F_FONDSNO is
'全宗号';

comment on column OA_FILE_FILES.F_FILESNO is
'案卷号';

comment on column OA_FILE_FILES.F_STORAGE_FULLNAME is
'存放位置';

comment on column OA_FILE_FILES.F_DOC_YEAR is
'档案年份';

comment on column OA_FILE_FILES.F_SECRECY_ID is
'密级ID';

comment on column OA_FILE_FILES.F_SECRECY_NAME is
'密级名称';

comment on column OA_FILE_FILES.F_DOC_DEADLINE is
'保管期限';

comment on column OA_FILE_FILES.F_ORG_ID is
'所属的单位ID';

comment on column OA_FILE_FILES.F_ORG_NAME is
'所属单位名称';

comment on column OA_FILE_FILES.F_DEPT_ID is
'所属部门ID';

comment on column OA_FILE_FILES.F_DEPT_NAME is
'所属部门名';

comment on column OA_FILE_FILES.F_DOC_BLNAME is
'责任者';

comment on column OA_FILE_FILES.F_FILES_NUM is
'卷内件数';

comment on column OA_FILE_FILES.F_FILES_CONTENT is
'内容';

comment on column OA_FILE_FILES.F_FILES_STATE is
'案卷状态(0：待归档    1、已归档（正常状态）   8、已移交（移交到档案局）   9. 已销毁)';

comment on column OA_FILE_FILES.F_FILE_USERID is
'归档人ID';

comment on column OA_FILE_FILES.F_FILE_USERNAME is
'归档人姓名';

comment on column OA_FILE_FILES.F_FILE_TIME is
'归档日期（档案的最早正式归档日期）';

comment on column OA_FILE_FILES.F_LISTNO is
'目录号';

comment on column OA_FILE_FILES.F_DOC_DEADLINE_NAME is
'保管期限名';

comment on column OA_FILE_FILES.F_ENTITY_TYPE_NAME is
'实物类型name';

comment on column OA_FILE_FILES.F_ENTITY_TYPE is
'实物类型';

comment on column OA_FILE_FILES.F_FILES_STATE_NAME is
'案卷状态名';

comment on column OA_FILE_FILES.F_START_TIME is
'起始日期（档案的最早形成日期）';

comment on column OA_FILE_FILES.F_END_TIME is
'终止日期（档案的最后修改日期）';

comment on column OA_FILE_FILES.F_DOC_BLID is
'责任者id';

comment on column OA_FILE_FILES.F_TYPE_ID is
'所属分类id';

/*==============================================================*/
/* Table: OA_FILE_FILES_ACC                                     */
/*==============================================================*/
create table OA_FILE_FILES_ACC 
(
   F_ACC_ID             VARCHAR2(50)         not null,
   F_FILE_MONTH         DATE,
   F_FILE_MONTHBOOKTOTAL VARCHAR2(20),
   F_FILE_MONTHBOOKINDEX VARCHAR2(20),
   F_FILE_STARTNO       VARCHAR2(20),
   F_FILE_ENDNO         VARCHAR2(20),
   F_ATTACH_ID          VARCHAR2(50),
   F_FILES_ID           VARCHAR2(50),
   constraint PK_OA_FILE_FILES_ACC primary key (F_ACC_ID)
);

comment on table OA_FILE_FILES_ACC is
'会计档案扩展表';

comment on column OA_FILE_FILES_ACC.F_ACC_ID is
'主键id';

comment on column OA_FILE_FILES_ACC.F_FILE_MONTH is
'所属年月';

comment on column OA_FILE_FILES_ACC.F_FILE_MONTHBOOKTOTAL is
'总册数';

comment on column OA_FILE_FILES_ACC.F_FILE_MONTHBOOKINDEX is
'第几册';

comment on column OA_FILE_FILES_ACC.F_FILE_STARTNO is
'记账凭证起始号';

comment on column OA_FILE_FILES_ACC.F_FILE_ENDNO is
'记账凭证终止号';

comment on column OA_FILE_FILES_ACC.F_ATTACH_ID is
'附件id';

comment on column OA_FILE_FILES_ACC.F_FILES_ID is
'档案id';

/*==============================================================*/
/* Table: OA_FILE_NOTE                                          */
/*==============================================================*/
create table OA_FILE_NOTE 
(
   F_NOTE_ID            VARCHAR2(50)         not null,
   F_NOTE_CONTENT       VARCHAR2(1024),
   F_CREATOR_ID         VARCHAR2(50),
   F_CREATOR_NAME       VARCHAR2(50),
   F_CHECKER_ID         VARCHAR2(50),
   F_CHECKER_NAME       VARCHAR2(50),
   F_CREAT_TIME         DATE,
   F_FILES_ID           VARCHAR2(50)         not null,
   constraint PK_F_FILE_NOTE primary key (F_NOTE_ID)
);

comment on table OA_FILE_NOTE is
'档案备考表';

comment on column OA_FILE_NOTE.F_NOTE_ID is
'备考表主键id';

comment on column OA_FILE_NOTE.F_NOTE_CONTENT is
'内容';

comment on column OA_FILE_NOTE.F_CREATOR_ID is
'创建人id';

comment on column OA_FILE_NOTE.F_CREATOR_NAME is
'创建人姓名';

comment on column OA_FILE_NOTE.F_CHECKER_ID is
'检查人id';

comment on column OA_FILE_NOTE.F_CHECKER_NAME is
'检查人姓名';

comment on column OA_FILE_NOTE.F_CREAT_TIME is
'生成时间';

comment on column OA_FILE_NOTE.F_FILES_ID is
'对应的档案id';

/*==============================================================*/
/* Table: OA_FILE_PHOTO_INFO                                    */
/*==============================================================*/
create table OA_FILE_PHOTO_INFO 
(
   f_id                 VARCHAR2(50)         not null,
   f_file_id            VARCHAR2(50)         not null,
   f_no                 VARCHAR2(600)        not null,
   f_cj_no              VARCHAR2(600),
   f_title              VARCHAR2(600),
   f_photo_media        char(1)             
      constraint CKC_F_PHOTO_MEDIA_OA_FILE_ check (f_photo_media is null or (f_photo_media in ('0','1','2'))),
   f_explain            VARCHAR2(4000),
   f_attach_id          VARCHAR2(50),
   f_dang_no            VARCHAR2(600),
   f_location           VARCHAR2(4000),
   constraint PK_OA_FILE_PHOTO_INFO primary key (f_id)
);

comment on table OA_FILE_PHOTO_INFO is
'文件管理-照片文件中照片文件表';

comment on column OA_FILE_PHOTO_INFO.f_id is
'照片信息ID';

comment on column OA_FILE_PHOTO_INFO.f_file_id is
'所属照片文件ID';

comment on column OA_FILE_PHOTO_INFO.f_no is
'照片/底片号';

comment on column OA_FILE_PHOTO_INFO.f_cj_no is
'参见号';

comment on column OA_FILE_PHOTO_INFO.f_title is
'题名';

comment on column OA_FILE_PHOTO_INFO.f_photo_media is
'介质类型';

comment on column OA_FILE_PHOTO_INFO.f_explain is
'文字说明';

comment on column OA_FILE_PHOTO_INFO.f_attach_id is
'附件ID';

comment on column OA_FILE_PHOTO_INFO.f_dang_no is
'档号';

comment on column OA_FILE_PHOTO_INFO.f_location is
'存放位置';

/*==============================================================*/
/* Table: oa_file_destroy                                       */
/*==============================================================*/
create table oa_file_destroy 
(
   f_destroy_id         VARCHAR2(50)         not null,
   f_destroy_title      VARCHAR2(200)        not null,
   f_destroy_reason     VARCHAR2(50)         not null,
   f_org_id             VARCHAR2(50)         not null,
   f_org_name           VARCHAR2(100)        not null,
   f_dept_id            VARCHAR2(50)         not null,
   f_dept_name          VARCHAR2(100)        not null,
   f_apply_userid       VARCHAR2(50)         not null,
   f_apply_username     VARCHAR2(100)        not null,
   f_apply_time         DATE                 not null,
   f_checkmsg           CLOB,
   f_attach_id          VARCHAR2(50),
   f_check_username     VARCHAR2(100),
   f_isagree_destroy    char(1)             
      constraint CKC_F_ISAGREE_DESTROY_OA_FILE_ check (f_isagree_destroy is null or (f_isagree_destroy in ('1','0'))),
   constraint PK_OA_FILE_DESTROY primary key (f_destroy_id)
);

comment on table oa_file_destroy is
'档案销毁主表';

comment on column oa_file_destroy.f_destroy_id is
'销毁ID';

comment on column oa_file_destroy.f_destroy_title is
'标题';

comment on column oa_file_destroy.f_destroy_reason is
'销毁理由';

comment on column oa_file_destroy.f_org_id is
'所属的单位ID';

comment on column oa_file_destroy.f_org_name is
'所属单位名称';

comment on column oa_file_destroy.f_dept_id is
'所属部门ID';

comment on column oa_file_destroy.f_dept_name is
'所属部门名';

comment on column oa_file_destroy.f_apply_userid is
'申请人ID';

comment on column oa_file_destroy.f_apply_username is
'申请人名称';

comment on column oa_file_destroy.f_apply_time is
'申请日期';

comment on column oa_file_destroy.f_checkmsg is
'审批意见';

comment on column oa_file_destroy.f_attach_id is
'附件ID';

comment on column oa_file_destroy.f_check_username is
'批准人姓名';

comment on column oa_file_destroy.f_isagree_destroy is
'是否同意销毁';

/*==============================================================*/
/* Table: oa_file_destroy_detail                                */
/*==============================================================*/
create table oa_file_destroy_detail 
(
   f_detail_id          VARCHAR2(50)         not null,
   f_doc_id             VARCHAR2(50),
   f_user_id            VARCHAR2(50),
   f_user_name          VARCHAR2(100),
   f_destroy_time       DATE,
   f_destroy_state      char(1)             
      constraint CKC_F_DESTROY_STATE_OA_FILE_ check (f_destroy_state is null or (f_destroy_state in ('1','9'))),
   constraint PK_OA_FILE_DESTROY_DETAIL primary key (f_detail_id)
);

comment on table oa_file_destroy_detail is
'档案销毁文件明细表';

comment on column oa_file_destroy_detail.f_detail_id is
'销毁文件ID';

comment on column oa_file_destroy_detail.f_doc_id is
'文件ID';

comment on column oa_file_destroy_detail.f_user_id is
'销毁经手人ID';

comment on column oa_file_destroy_detail.f_user_name is
'销毁经手人姓名';

comment on column oa_file_destroy_detail.f_destroy_time is
'销毁日期';

comment on column oa_file_destroy_detail.f_destroy_state is
'销毁状态';

/*==============================================================*/
/* Table: oa_file_doc                                           */
/*==============================================================*/
create table oa_file_doc 
(
   f_doc_id             VARCHAR2(50)         not null,
   f_doc_name           VARCHAR2(200)        not null,
   f_doc_fontsize       VARCHAR2(40),
   f_type_id            VARCHAR2(50)         not null,
   f_type_name          VARCHAR2(200)        not null,
   f_doc_keywords       VARCHAR2(500),
   f_doc_year           VARCHAR2(4)          not null,
   f_secrecy_id         VARCHAR2(50)         not null,
   f_secrecy_name       VARCHAR2(100)        not null,
   f_org_id             VARCHAR2(50)         not null,
   f_org_name           VARCHAR2(100)        not null,
   f_dept_id            VARCHAR2(50)         not null,
   f_dept_name          VARCHAR2(100)        not null,
   f_doc_checkuser      VARCHAR2(50),
   f_doc_blname         VARCHAR2(50),
   f_file_formtime      DATE                 not null,
   f_file_quantity      VARCHAR2(40),
   f_type_remark        VARCHAR2(1000),
   f_user_id            VARCHAR2(50)         not null,
   f_user_name          VARCHAR2(100)        not null,
   f_creator_time       DATE                 not null,
   f_doc_content        VARCHAR2(2000),
   f_attach_id          VARCHAR2(50),
   f_doc_state          char(1)              default '0' not null
      constraint CKC_F_DOC_STATE_OA_FILE_ check (f_doc_state in ('0','1','2','8','9')),
   f_doc_state_name     VARCHAR2(100)        not null,
   f_file_no            VARCHAR2(100),
   f_typeno             VARCHAR2(50),
   f_doc_num            NUMBER,
   f_info_num           VARCHAR2(40),
   f_doc_media          char(1)              not null
      constraint CKC_F_DOC_MEDIA_OA_FILE_ check (f_doc_media in ('0','1','2')),
   f_doc_media_name     VARCHAR2(100)        not null,
   f_entity_type        char(1)              not null,
   f_entity_type_name   VARCHAR2(100)        not null,
   f_burn_user_id       VARCHAR2(40),
   f_burn_user_name     VARCHAR2(40),
   f_file_num           NUMBER               not null,
   f_file_num_unit      VARCHAR2(50)         not null,
   f_file_num_unit_name VARCHAR2(100)        not null,
   f_doc_deadline       VARCHAR2(40)         not null,
   f_info_type          VARCHAR2(50),
   f_info_type_name     VARCHAR2(100),
   f_file_userid        VARCHAR2(50),
   f_file_username      VARCHAR2(100),
   f_file_time          DATE,
   f_doc_deadline_name  VARCHAR2(100),
   constraint PK_OA_FILE_DOC primary key (f_doc_id)
);

comment on table oa_file_doc is
'文件管理表';

comment on column oa_file_doc.f_doc_id is
'文件ID';

comment on column oa_file_doc.f_doc_name is
'文件标题';

comment on column oa_file_doc.f_doc_fontsize is
'文件字号';

comment on column oa_file_doc.f_type_id is
'档案分类ID';

comment on column oa_file_doc.f_type_name is
'档案分类名称';

comment on column oa_file_doc.f_doc_keywords is
'主题词';

comment on column oa_file_doc.f_doc_year is
'档案年份';

comment on column oa_file_doc.f_secrecy_id is
'密级ID';

comment on column oa_file_doc.f_secrecy_name is
'密级名称';

comment on column oa_file_doc.f_org_id is
'所属的单位ID';

comment on column oa_file_doc.f_org_name is
'所属单位名称';

comment on column oa_file_doc.f_dept_id is
'所属部门ID';

comment on column oa_file_doc.f_dept_name is
'所属部门名';

comment on column oa_file_doc.f_doc_checkuser is
'审批人';

comment on column oa_file_doc.f_doc_blname is
'责任者';

comment on column oa_file_doc.f_file_formtime is
'文件形成日期';

comment on column oa_file_doc.f_file_quantity is
'数量';

comment on column oa_file_doc.f_type_remark is
'备注';

comment on column oa_file_doc.f_user_id is
'登记人ID';

comment on column oa_file_doc.f_user_name is
'登记姓名';

comment on column oa_file_doc.f_creator_time is
'登记时间';

comment on column oa_file_doc.f_doc_content is
'内容';

comment on column oa_file_doc.f_attach_id is
'附件ID';

comment on column oa_file_doc.f_doc_state is
'归档状态';

comment on column oa_file_doc.f_doc_state_name is
'归档状态name';

comment on column oa_file_doc.f_file_no is
'档号(全综号_档案分类号_保管期限_案卷号_件号)';

comment on column oa_file_doc.f_typeno is
'档案分类号';

comment on column oa_file_doc.f_doc_num is
'件号';

comment on column oa_file_doc.f_info_num is
'参见号';

comment on column oa_file_doc.f_doc_media is
'介质类型';

comment on column oa_file_doc.f_doc_media_name is
'介质类型name';

comment on column oa_file_doc.f_entity_type is
'实物类型';

comment on column oa_file_doc.f_entity_type_name is
'实物类型name';

comment on column oa_file_doc.f_burn_user_id is
'刻录人id';

comment on column oa_file_doc.f_burn_user_name is
'刻录人name';

comment on column oa_file_doc.f_file_num is
'归档数量';

comment on column oa_file_doc.f_file_num_unit is
'数量单位';

comment on column oa_file_doc.f_file_num_unit_name is
'数量单位name';

comment on column oa_file_doc.f_doc_deadline is
'保管期限';

comment on column oa_file_doc.f_info_type is
'信息类型';

comment on column oa_file_doc.f_info_type_name is
'信息类型name';

comment on column oa_file_doc.f_file_userid is
'归档人ID';

comment on column oa_file_doc.f_file_username is
'归档人姓名';

comment on column oa_file_doc.f_file_time is
'归档日期';

comment on column oa_file_doc.f_doc_deadline_name is
'保管期限name';

/*==============================================================*/
/* Table: oa_file_docfiles                                      */
/*==============================================================*/
create table oa_file_docfiles 
(
   f_docfiles_id        VARCHAR2(50)         not null,
   f_files_id           VARCHAR2(50),
   f_doc_id             VARCHAR2(50),
   constraint PK_OA_FILE_DOCFILES primary key (f_docfiles_id)
);

comment on table oa_file_docfiles is
'案卷与文件关系表';

comment on column oa_file_docfiles.f_docfiles_id is
'主健ID';

comment on column oa_file_docfiles.f_files_id is
'案卷ID';

comment on column oa_file_docfiles.f_doc_id is
'文件ID';

/*==============================================================*/
/* Table: oa_file_favorites                                     */
/*==============================================================*/
create table oa_file_favorites 
(
   f_favorites_id       VARCHAR2(50)         not null,
   f_doc_id             VARCHAR2(50)         not null,
   f_user_id            VARCHAR2(50)         not null,
   f_favorites_time     DATE                 not null,
   constraint PK_OA_FILE_FAVORITES primary key (f_favorites_id)
);

comment on table oa_file_favorites is
'收藏数据表';

comment on column oa_file_favorites.f_favorites_id is
'收藏ID';

comment on column oa_file_favorites.f_doc_id is
'文件ID';

comment on column oa_file_favorites.f_user_id is
'用户ID';

comment on column oa_file_favorites.f_favorites_time is
'收藏日期';

/*==============================================================*/
/* Table: oa_file_fondsno                                       */
/*==============================================================*/
create table oa_file_fondsno 
(
   f_fonds_id           VARCHAR2(50)         not null,
   f_fondsno_name       VARCHAR2(100)        not null,
   f_fondsno            VARCHAR2(40)         not null,
   f_fonds_remark       VARCHAR2(50),
   f_fonds_order        NUMBER,
   f_org_id             VARCHAR2(50)         not null,
   f_org_name           VARCHAR2(100)        not null,
   f_dept_id            VARCHAR2(50)         not null,
   f_dept_name          VARCHAR2(100)        not null,
   constraint PK_OA_FILE_FONDSNO primary key (f_fonds_id)
);

comment on table oa_file_fondsno is
'全宗号管理';

comment on column oa_file_fondsno.f_fonds_id is
'全宗号ID';

comment on column oa_file_fondsno.f_fondsno_name is
'全宗号名称';

comment on column oa_file_fondsno.f_fondsno is
'全宗号';

comment on column oa_file_fondsno.f_fonds_remark is
'备注';

comment on column oa_file_fondsno.f_fonds_order is
'排序号';

comment on column oa_file_fondsno.f_org_id is
'所属的单位ID';

comment on column oa_file_fondsno.f_org_name is
'所属单位名称';

comment on column oa_file_fondsno.f_dept_id is
'所属部门ID';

comment on column oa_file_fondsno.f_dept_name is
'所属部门名';

/*==============================================================*/
/* Table: oa_file_lending                                       */
/*==============================================================*/
create table oa_file_lending 
(
   f_lending_id         VARCHAR2(50)         not null,
   f_lending_reason     VARCHAR2(500)        not null,
   f_lending_userid     VARCHAR2(50)         not null,
   f_lending_username   VARCHAR2(100)        not null,
   f_org_id             VARCHAR2(50)         not null,
   f_org_name           VARCHAR2(100)        not null,
   f_dept_id            VARCHAR2(50)         not null,
   f_dept_name          VARCHAR2(100)        not null,
   f_tel                VARCHAR2(40),
   f_creator_time       DATE                 not null,
   f_checkmsg           CLOB,
   constraint PK_OA_FILE_LENDING primary key (f_lending_id)
);

comment on table oa_file_lending is
'档案借阅主表';

comment on column oa_file_lending.f_lending_id is
'借阅ID';

comment on column oa_file_lending.f_lending_reason is
'借阅理由';

comment on column oa_file_lending.f_lending_userid is
'借阅人ID';

comment on column oa_file_lending.f_lending_username is
'借阅人姓名';

comment on column oa_file_lending.f_org_id is
'所属的单位ID';

comment on column oa_file_lending.f_org_name is
'所属单位名称';

comment on column oa_file_lending.f_dept_id is
'所属部门ID';

comment on column oa_file_lending.f_dept_name is
'所属部门名';

comment on column oa_file_lending.f_tel is
'联系电话';

comment on column oa_file_lending.f_creator_time is
'申请日期';

comment on column oa_file_lending.f_checkmsg is
'审批意见';

/*==============================================================*/
/* Table: oa_file_lending_detail                                */
/*==============================================================*/
create table oa_file_lending_detail 
(
   f_detail_id          VARCHAR2(50)         not null,
   f_doc_id             VARCHAR2(50),
   f_lending_type       char(1)             
      constraint CKC_F_LENDING_TYPE_OA_FILE_ check (f_lending_type is null or (f_lending_type in ('0','1','2'))),
   f_isagree            char(1)             
      constraint CKC_F_ISAGREE_OA_FILE_ check (f_isagree is null or (f_isagree in ('1','0'))),
   f_islending          char(1)             
      constraint CKC_F_ISLENDING_OA_FILE_ check (f_islending is null or (f_islending in ('0','1'))),
   f_lending_time       DATE,
   f_lending_day        NUMBER,
   f_user_id            VARCHAR2(50),
   f_user_name          VARCHAR2(100),
   f_isback             char(1)             
      constraint CKC_F_ISBACK_OA_FILE_ check (f_isback is null or (f_isback in ('0','1','3'))),
   f_reback_time        DATE,
   f_back_userid        VARCHAR2(50),
   f_back_username      VARCHAR2(100),
   f_read_purview       char(1)             
      constraint CKC_F_READ_PURVIEW_OA_FILE_ check (f_read_purview is null or (f_read_purview in ('1','2','0'))),
   f_read_approve       char(1)             
      constraint CKC_F_READ_APPROVE_OA_FILE_ check (f_read_approve is null or (f_read_approve in ('0','1','2'))),
   f_lending_userid     VARCHAR2(50)         not null,
   f_lending_id         VARCHAR2(50),
   f_back_time          DATE,
   constraint PK_OA_FILE_LENDING_DETAIL primary key (f_detail_id)
);

comment on table oa_file_lending_detail is
'档案借阅主表';

comment on column oa_file_lending_detail.f_detail_id is
'借阅文件详细 ID';

comment on column oa_file_lending_detail.f_doc_id is
'文件ID';

comment on column oa_file_lending_detail.f_lending_type is
'借阅类型';

comment on column oa_file_lending_detail.f_isagree is
'是否同意借阅';

comment on column oa_file_lending_detail.f_islending is
'是否已借阅';

comment on column oa_file_lending_detail.f_lending_time is
'借阅日期';

comment on column oa_file_lending_detail.f_lending_day is
'借阅天数';

comment on column oa_file_lending_detail.f_user_id is
'借出经手人ID';

comment on column oa_file_lending_detail.f_user_name is
'借出经手人姓名';

comment on column oa_file_lending_detail.f_isback is
'是否已归还';

comment on column oa_file_lending_detail.f_reback_time is
'计划归还日期';

comment on column oa_file_lending_detail.f_back_userid is
'归还经手人ID';

comment on column oa_file_lending_detail.f_back_username is
'归还经手人姓名';

comment on column oa_file_lending_detail.f_read_purview is
'申请的阅读权限';

comment on column oa_file_lending_detail.f_read_approve is
'批准的阅读权限';

comment on column oa_file_lending_detail.f_lending_userid is
'借阅人ID';

comment on column oa_file_lending_detail.f_lending_id is
'借阅ID';

comment on column oa_file_lending_detail.f_back_time is
'归还日期';

/*==============================================================*/
/* Table: oa_file_normdate                                      */
/*==============================================================*/
create table oa_file_normdate 
(
   f_normdate_id        VARCHAR2(50)         not null,
   f_norm_id            VARCHAR2(50)         not null,
   f_norm_name          VARCHAR2(200)        not null,
   f_norm_title         VARCHAR2(200)        not null,
   f_norm_fontsize      VARCHAR2(40),
   f_org_id             VARCHAR2(50),
   f_org_name           VARCHAR2(100),
   f_remark             VARCHAR2(1000),
   f_attach_id          VARCHAR2(50),
   f_user_id            VARCHAR2(50)         not null,
   f_user_name          VARCHAR2(100)        not null,
   f_creator_time       DATE                 default SYSDATE not null,
   constraint PK_OA_FILE_NORMDATE primary key (f_normdate_id)
);

comment on table oa_file_normdate is
'档案规范资料表';

comment on column oa_file_normdate.f_normdate_id is
'文件ID';

comment on column oa_file_normdate.f_norm_id is
'所属分类ID';

comment on column oa_file_normdate.f_norm_name is
'规范分类名称';

comment on column oa_file_normdate.f_norm_title is
'标题';

comment on column oa_file_normdate.f_norm_fontsize is
'字号';

comment on column oa_file_normdate.f_org_id is
'所属的单位ID';

comment on column oa_file_normdate.f_org_name is
'所属单位名称';

comment on column oa_file_normdate.f_remark is
'备注';

comment on column oa_file_normdate.f_attach_id is
'附件ID';

comment on column oa_file_normdate.f_user_id is
'登记人ID';

comment on column oa_file_normdate.f_user_name is
'登记姓名';

comment on column oa_file_normdate.f_creator_time is
'登记时间';

/*==============================================================*/
/* Table: oa_file_pan_ext                                       */
/*==============================================================*/
create table oa_file_pan_ext 
(
   f_pan_id             VARCHAR2(50)         not null,
   f_doc_id             VARCHAR2(50)         not null,
   f_specification      VARCHAR2(100),
   f_shooting_user      VARCHAR2(100),
   f_ADD                VARCHAR2(100),
   f_PERSON             VARCHAR2(100),
   f_background         VARCHAR2(100),
   f_save_format        VARCHAR2(50),
   constraint PK_OA_FILE_PAN_EXT primary key (f_pan_id)
);

comment on table oa_file_pan_ext is
'声像档案扩展表';

comment on column oa_file_pan_ext.f_pan_id is
'文件扩充属性ID';

comment on column oa_file_pan_ext.f_doc_id is
'文件ID';

comment on column oa_file_pan_ext.f_specification is
'规格';

comment on column oa_file_pan_ext.f_shooting_user is
'拍摄人';

comment on column oa_file_pan_ext.f_ADD is
'地点';

comment on column oa_file_pan_ext.f_PERSON is
'人物';

comment on column oa_file_pan_ext.f_background is
'背景';

comment on column oa_file_pan_ext.f_save_format is
'存储格式';

/*==============================================================*/
/* Table: oa_file_program_page                                  */
/*==============================================================*/
create table oa_file_program_page 
(
   f_program_id         VARCHAR2(50)         not null,
   f_program_page       VARCHAR2(200)        not null,
   f_file_list          VARCHAR2(1000),
   f_file_detail        VARCHAR2(1000)       not null,
   f_files_list         VARCHAR2(1000),
   f_files_detail       VARCHAR2(1000)       not null,
   f_order              NUMBER,
   f_remark             VARCHAR2(1000),
   constraint PK_OA_FILE_PROGRAM_PAGE primary key (f_program_id)
);

comment on table oa_file_program_page is
'程序界面表';

comment on column oa_file_program_page.f_program_id is
'程序界面ID';

comment on column oa_file_program_page.f_program_page is
'程序界面';

comment on column oa_file_program_page.f_file_list is
'文件列表界面';

comment on column oa_file_program_page.f_file_detail is
'文件明细界面';

comment on column oa_file_program_page.f_files_list is
'案卷列表界面';

comment on column oa_file_program_page.f_files_detail is
'案卷明细界面';

comment on column oa_file_program_page.f_order is
'排序号';

comment on column oa_file_program_page.f_remark is
'备注';

/*==============================================================*/
/* Table: oa_file_purview                                       */
/*==============================================================*/
create table oa_file_purview 
(
   f_purview_id         VARCHAR2(50)         not null,
   f_type_id            VARCHAR2(50)         not null,
   f_secrecy_id         VARCHAR2(50),
   f_secrecy_name       VARCHAR2(100),
   f_read_all_user      char(1)             
      constraint CKC_F_READ_ALL_USER_OA_FILE_ check (f_read_all_user is null or (f_read_all_user in ('0','1'))),
   f_download_all_user  char(1)             
      constraint CKC_F_DOWNLOAD_ALL_US_OA_FILE_ check (f_download_all_user is null or (f_download_all_user in ('0','1'))),
   f_read_dept_user     char(1)             
      constraint CKC_F_READ_DEPT_USER_OA_FILE_ check (f_read_dept_user is null or (f_read_dept_user in ('0','1'))),
   f_download_dept_user char(1)             
      constraint CKC_F_DOWNLOAD_DEPT_U_OA_FILE_ check (f_download_dept_user is null or (f_download_dept_user in ('0','1'))),
   f_read_user_groupid  VARCHAR2(1000),
   f_read_user_groupname VARCHAR2(4000),
   f_download_user_groupid VARCHAR2(1000),
   f_download_user_groupname VARCHAR2(4000),
   constraint PK_OA_FILE_PURVIEW primary key (f_purview_id)
);

comment on table oa_file_purview is
'档案权限';

comment on column oa_file_purview.f_purview_id is
'阅读权限ID';

comment on column oa_file_purview.f_type_id is
'所属档案分类ID';

comment on column oa_file_purview.f_secrecy_id is
'密级ID';

comment on column oa_file_purview.f_secrecy_name is
'密级名称';

comment on column oa_file_purview.f_read_all_user is
'所有人读取权限';

comment on column oa_file_purview.f_download_all_user is
'所有人下载权限';

comment on column oa_file_purview.f_read_dept_user is
'部门读取权限';

comment on column oa_file_purview.f_download_dept_user is
'部门下载权限';

comment on column oa_file_purview.f_read_user_groupid is
'可读取权限的组ID';

comment on column oa_file_purview.f_read_user_groupname is
'可读取权限的组名称';

comment on column oa_file_purview.f_download_user_groupid is
'可下载权限的组ID';

comment on column oa_file_purview.f_download_user_groupname is
'可下载权限的组名称';

/*==============================================================*/
/* Table: oa_file_purviewuser                                   */
/*==============================================================*/
create table oa_file_purviewuser 
(
   f_purviewuser_id     VARCHAR2(50)         not null,
   f_type_id            VARCHAR2(50),
   f_secrecy_id         VARCHAR2(50),
   f_user_id            VARCHAR2(50),
   f_user_name          VARCHAR2(100)       
      constraint CKC_F_USER_NAME_OA_FILE_ check (f_user_name is null or (f_user_name in ('1','0'))),
   f_readordownload     char(1)              default '1'
      constraint CKC_F_READORDOWNLOAD_OA_FILE_ check (f_readordownload is null or (f_readordownload in ('1','2'))),
   f_user_groupid       VARCHAR2(500),
   f_purview_id         VARCHAR2(50)         not null,
   constraint PK_OA_FILE_PURVIEWUSER primary key (f_purviewuser_id)
);

comment on table oa_file_purviewuser is
'档案用户权限';

comment on column oa_file_purviewuser.f_purviewuser_id is
'主键ID';

comment on column oa_file_purviewuser.f_type_id is
'所属档案分类ID';

comment on column oa_file_purviewuser.f_secrecy_id is
'密级ID';

comment on column oa_file_purviewuser.f_user_id is
'用户ID';

comment on column oa_file_purviewuser.f_user_name is
'用户名称';

comment on column oa_file_purviewuser.f_readordownload is
'可读或可下载 ';

comment on column oa_file_purviewuser.f_user_groupid is
'用户所以的组ID';

comment on column oa_file_purviewuser.f_purview_id is
'阅读权限ID';

/*==============================================================*/
/* Table: oa_file_recursion                                     */
/*==============================================================*/
create table oa_file_recursion 
(
   f_recursion_id       VARCHAR2(50)         not null,
   f_type_id            VARCHAR2(50)         not null,
   f_isrecursion        char(1)              not null
      constraint CKC_F_ISRECURSION_OA_FILE_ check (f_isrecursion in ('1','0')),
   f_id                 VARCHAR2(1000),
   f_content            VARCHAR2(4000),
   f_state              char(1)              not null
      constraint CKC_F_STATE_OA_FILE_ check (f_state in ('1','2','3','4','5')),
   constraint PK_OA_FILE_RECURSION primary key (f_recursion_id)
);

comment on table oa_file_recursion is
'档案类型权限递归表';

comment on column oa_file_recursion.f_recursion_id is
'递归ID';

comment on column oa_file_recursion.f_type_id is
'所属档案分类ID';

comment on column oa_file_recursion.f_isrecursion is
'是否取的递归数据';

comment on column oa_file_recursion.f_id is
'ID';

comment on column oa_file_recursion.f_content is
'内容';

comment on column oa_file_recursion.f_state is
'状态(1管理员,2程序界面,3案卷内容模板,4文件内容模板,5备考件模板)';

/*==============================================================*/
/* Table: oa_file_storage_location                              */
/*==============================================================*/
create table oa_file_storage_location 
(
   f_storage_id         VARCHAR2(50)         not null,
   f_storage_shotname   VARCHAR2(200),
   f_storage_fullname   VARCHAR2(500)        not null,
   f_org_id             VARCHAR2(50),
   f_org_name           VARCHAR2(100),
   f_perant_id          VARCHAR2(50),
   f_order_num          NUMBER,
   f_remark             VARCHAR2(1000),
   f_user_id            VARCHAR2(50)         not null,
   f_user_name          VARCHAR2(100)        not null,
   f_creator_time       DATE                 not null,
   f_storage_urlid      VARCHAR2(1000),
   f_storage_urlname    VARCHAR2(1000),
   f_dept_id            VARCHAR2(50)         not null,
   f_dept_name          VARCHAR2(100)        not null,
   constraint PK_OA_FILE_STORAGE_LOCATION primary key (f_storage_id)
);

comment on table oa_file_storage_location is
'档案存放位置表';

comment on column oa_file_storage_location.f_storage_id is
'档案存放位置ID';

comment on column oa_file_storage_location.f_storage_shotname is
'位置简称';

comment on column oa_file_storage_location.f_storage_fullname is
'位置全称';

comment on column oa_file_storage_location.f_org_id is
'所属的单位ID';

comment on column oa_file_storage_location.f_org_name is
'所属单位名称';

comment on column oa_file_storage_location.f_perant_id is
'所属上级位置';

comment on column oa_file_storage_location.f_order_num is
'排序号';

comment on column oa_file_storage_location.f_remark is
'备注';

comment on column oa_file_storage_location.f_user_id is
'登记人ID';

comment on column oa_file_storage_location.f_user_name is
'登记姓名';

comment on column oa_file_storage_location.f_creator_time is
'登记时间';

comment on column oa_file_storage_location.f_storage_urlid is
'存放位置路径ID';

comment on column oa_file_storage_location.f_storage_urlname is
'存放位置路径名';

comment on column oa_file_storage_location.f_dept_id is
'所属部门ID';

comment on column oa_file_storage_location.f_dept_name is
'所属部门名';

/*==============================================================*/
/* Table: oa_file_type                                          */
/*==============================================================*/
create table oa_file_type 
(
   f_type_id            VARCHAR2(50)         not null,
   F_PARENT_TYPE_ID     VARCHAR2(50),
   f_type_name          VARCHAR2(200)        not null,
   f_type_level         NUMBER               not null
      constraint CKC_F_TYPE_LEVEL_OA_FILE_ check (f_type_level in (1,2,3)),
   f_org_id             VARCHAR2(50)         not null,
   f_org_name           VARCHAR2(100)        not null,
   f_dept_id            VARCHAR2(50),
   f_dept_name          VARCHAR2(100),
   f_typeno             VARCHAR2(40),
   f_type_order         NUMBER,
   f_program_id         VARCHAR2(50)         not null,
   f_program_page       VARCHAR2(200)        not null,
   f_isrecursion_page   char(1)             
      constraint CKC_F_ISRECURSION_PAG_OA_FILE_ check (f_isrecursion_page is null or (f_isrecursion_page in ('1','0'))),
   f_page_by_isre       char(1),
   f_type_admin         VARCHAR2(1000)       not null,
   f_type_adminname     VARCHAR2(4000)       not null,
   f_isrecursion_admin  char(1)             
      constraint CKC_F_ISRECURSION_ADM_OA_FILE_ check (f_isrecursion_admin is null or (f_isrecursion_admin in ('1','0'))),
   f_admin_by_isre      char(1),
   f_template_content   VARCHAR2(1000),
   f_isrecursion_content char(1)             
      constraint CKC_F_ISRECURSION_CON_OA_FILE_ check (f_isrecursion_content is null or (f_isrecursion_content in ('1','0'))),
   f_content_by_isre    char(1),
   f_template_file      VARCHAR2(1000),
   f_isrecursion_file   char(1)             
      constraint CKC_F_ISRECURSION_FIL_OA_FILE_ check (f_isrecursion_file is null or (f_isrecursion_file in ('1','0'))),
   f_file_by_isre       char(1),
   f_template_record_table VARCHAR2(1000),
   f_isrecursion_record_table char(1),
   f_record_table_by_isre char(1),
   f_type_remark        VARCHAR2(1000),
   f_user_id            VARCHAR2(50)         not null,
   f_user_name          VARCHAR2(100)        not null,
   f_creator_time       DATE                 not null,
   f_type_parentname    VARCHAR2(4000)       not null,
   f_type_parentid      VARCHAR2(1000)       not null,
   f_type_table         VARCHAR2(50),
   F_FILENO_TEMPLATE    VARCHAR2(1000),
   F_FILENO_TEMPLATE_ISRECURSION CHAR(1),
   constraint PK_OA_FILE_TYPE primary key (f_type_id)
);

comment on table oa_file_type is
'档案分类管理';

comment on column oa_file_type.f_type_id is
'档案分类ID';

comment on column oa_file_type.F_PARENT_TYPE_ID is
'所属上级分类';

comment on column oa_file_type.f_type_name is
'档案分类名称';

comment on column oa_file_type.f_type_level is
'分类层次';

comment on column oa_file_type.f_org_id is
'所属的单位ID';

comment on column oa_file_type.f_org_name is
'所属的单位名称';

comment on column oa_file_type.f_dept_id is
'所属的部门ID';

comment on column oa_file_type.f_dept_name is
'所属的部门名称';

comment on column oa_file_type.f_typeno is
'分类号';

comment on column oa_file_type.f_type_order is
'排序号';

comment on column oa_file_type.f_program_id is
'程序界面ID';

comment on column oa_file_type.f_program_page is
'程序界面';

comment on column oa_file_type.f_isrecursion_page is
'程序界面 是否递归(1递归0不递归)';

comment on column oa_file_type.f_page_by_isre is
'程序界面是否来自递归';

comment on column oa_file_type.f_type_admin is
'档案管理员ID';

comment on column oa_file_type.f_type_adminname is
'档案管理员名称';

comment on column oa_file_type.f_isrecursion_admin is
'档案管理员是否递归(1递归0不递归)';

comment on column oa_file_type.f_admin_by_isre is
'档案管理员是否来自递归';

comment on column oa_file_type.f_template_content is
'案卷内容模板';

comment on column oa_file_type.f_isrecursion_content is
'案卷内容模板 是否递归(1递归0不递归)';

comment on column oa_file_type.f_content_by_isre is
'案卷内容是否来自递归';

comment on column oa_file_type.f_template_file is
'文件内容模板';

comment on column oa_file_type.f_isrecursion_file is
'文件内容模板 是否递归(1递归0不递归)';

comment on column oa_file_type.f_file_by_isre is
'文件内容是否来自递归';

comment on column oa_file_type.f_template_record_table is
'备考表模板';

comment on column oa_file_type.f_isrecursion_record_table is
'备考表是否递归(1递归0不递归)';

comment on column oa_file_type.f_record_table_by_isre is
'备考表是否来自递归';

comment on column oa_file_type.f_type_remark is
'备注';

comment on column oa_file_type.f_user_id is
'登记人ID';

comment on column oa_file_type.f_user_name is
'登记姓名';

comment on column oa_file_type.f_creator_time is
'登记时间';

comment on column oa_file_type.f_type_parentname is
'从上到下所有类型名称连接';

comment on column oa_file_type.f_type_parentid is
'从上到下所有类型ID用逗号分开';

comment on column oa_file_type.f_type_table is
'类型对应的表';

comment on column oa_file_type.F_FILENO_TEMPLATE is
'档案档号模板';

comment on column oa_file_type.F_FILENO_TEMPLATE_ISRECURSION is
'档号是否递归（1递归，0不递归）';

/*==============================================================*/
/* Table: oa_file_type_norm                                     */
/*==============================================================*/
create table oa_file_type_norm 
(
   f_norm_id            VARCHAR2(50)         not null,
   f_norm_name          VARCHAR2(200)        not null,
   f_org_id             VARCHAR2(50),
   f_org_name           VARCHAR2(100),
   f_perant_id          VARCHAR2(50),
   f_order_num          NUMBER,
   f_remark             VARCHAR2(1000),
   f_user_id            VARCHAR2(50),
   f_user_name          VARCHAR2(100),
   f_creator_time       DATE,
   constraint PK_OA_FILE_TYPE_NORM primary key (f_norm_id)
);

comment on table oa_file_type_norm is
'档案规范类型表';

comment on column oa_file_type_norm.f_norm_id is
'规范分类ID';

comment on column oa_file_type_norm.f_norm_name is
'规范分类名称';

comment on column oa_file_type_norm.f_org_id is
'所属的单位ID';

comment on column oa_file_type_norm.f_org_name is
'所属单位名称';

comment on column oa_file_type_norm.f_perant_id is
'所属上级位置';

comment on column oa_file_type_norm.f_order_num is
'排序号';

comment on column oa_file_type_norm.f_remark is
'备注';

comment on column oa_file_type_norm.f_user_id is
'登记人ID';

comment on column oa_file_type_norm.f_user_name is
'登记姓名';

comment on column oa_file_type_norm.f_creator_time is
'登记时间';

