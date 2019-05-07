/*==============================================================*/
/* dbms name:      oracle version 11g                           */
/* created on:     2013/8/19 14:43:15                           */
/*==============================================================*/


drop table oa_kbm_doc cascade constraints;

drop table oa_kbm_doc_bbs cascade constraints;

drop table oa_kbm_doc_favorites cascade constraints;

drop table oa_kbm_doc_operate_log cascade constraints;

drop table oa_kbm_doc_rss cascade constraints;

drop table oa_kbm_doc_suggest cascade constraints;

drop table oa_kbm_doc_type cascade constraints;

drop table oa_kbm_doc_type_right_config cascade constraints;

/*==============================================================*/
/* table: oa_kbm_doc                                            */
/*==============================================================*/
create table oa_kbm_doc 
(
   k_doc_id             varchar2(40)         not null,
   k_title              varchar2(200)        not null,
   k_code               varchar2(40),
   k_type_id            varchar2(40)         not null,
   k_type_name          varchar2(200)        not null,
   k_key                varchar2(400),
   k_secrecy_id         varchar2(40),
   k_secrecy_name       varchar2(100),
   k_unit               varchar2(40),
   k_unit_name          varchar2(100),
   k_dept               varchar2(40),
   k_dept_name          varchar2(100),
   k_first_time         date,
   k_create_time        date,
   k_create_user        varchar2(40),
   k_create_user_name   varchar2(100),
   k_contents           clob,
   k_attach_id          varchar2(40),
   k_flag               char(1),
   k_flag_name          varchar2(100),
   k_remark             varchar2(1000),
   k_check_time         date,
   k_check_user         varchar2(40),
   k_check_user_name    varchar2(100),
   k_check_info         varchar2(1000),
   k_dcount             number,
   k_update_time        date,
   constraint pk_oa_kbm_doc primary key (k_doc_id)
);

comment on table oa_kbm_doc is
'知识库文档表';

comment on column oa_kbm_doc.k_doc_id is
'知识库id';

comment on column oa_kbm_doc.k_title is
'标题';

comment on column oa_kbm_doc.k_code is
'编号';

comment on column oa_kbm_doc.k_type_id is
'分类';

comment on column oa_kbm_doc.k_type_name is
'分类name';

comment on column oa_kbm_doc.k_key is
'关键字';

comment on column oa_kbm_doc.k_secrecy_id is
'密级';

comment on column oa_kbm_doc.k_secrecy_name is
'密级name';

comment on column oa_kbm_doc.k_unit is
'单位';

comment on column oa_kbm_doc.k_unit_name is
'单位name';

comment on column oa_kbm_doc.k_dept is
'部门';

comment on column oa_kbm_doc.k_dept_name is
'部门name';

comment on column oa_kbm_doc.k_first_time is
'文件形成时间';

comment on column oa_kbm_doc.k_create_time is
'文件登记时间';

comment on column oa_kbm_doc.k_create_user is
'文件登记人';

comment on column oa_kbm_doc.k_create_user_name is
'文件登记人name';

comment on column oa_kbm_doc.k_contents is
'内容';

comment on column oa_kbm_doc.k_attach_id is
'附件id';

comment on column oa_kbm_doc.k_flag is
'文档状态(3草稿、0送审、1通过、2不通过)';

comment on column oa_kbm_doc.k_flag_name is
'文档状态name';

comment on column oa_kbm_doc.k_remark is
'修改备注';

comment on column oa_kbm_doc.k_check_time is
'审核时间';

comment on column oa_kbm_doc.k_check_user is
'审核人';

comment on column oa_kbm_doc.k_check_user_name is
'审核人name';

comment on column oa_kbm_doc.k_check_info is
'审核意见';

comment on column oa_kbm_doc.k_dcount is
'下载次数';

comment on column oa_kbm_doc.k_update_time is
'更新时间';

/*==============================================================*/
/* table: oa_kbm_doc_bbs                                        */
/*==============================================================*/
create table oa_kbm_doc_bbs 
(
   k_id                 varchar2(40)         not null,
   k_create_user        varchar2(40)         not null,
   k_create_user_name   varchar2(100)        not null,
   k_is_guest           char(1)              not null,
   k_doc_id             varchar2(40)         not null,
   k_title              varchar2(200)        not null,
   k_content            varchar2(200)        not null,
   k_create_time        date                 not null,
   constraint pk_oa_kbm_doc_bbs primary key (k_id)
);

comment on table oa_kbm_doc_bbs is
'用户评论表';

comment on column oa_kbm_doc_bbs.k_id is
'key';

comment on column oa_kbm_doc_bbs.k_create_user is
'评论人';

comment on column oa_kbm_doc_bbs.k_create_user_name is
'评论人name';

comment on column oa_kbm_doc_bbs.k_is_guest is
'是否匿名（1是，0否）';

comment on column oa_kbm_doc_bbs.k_doc_id is
'文档主键id';

comment on column oa_kbm_doc_bbs.k_title is
'文档标题';

comment on column oa_kbm_doc_bbs.k_content is
'评论内容(不超过200个了)';

comment on column oa_kbm_doc_bbs.k_create_time is
'评论时间（设默认值）';

/*==============================================================*/
/* table: oa_kbm_doc_favorites                                  */
/*==============================================================*/
create table oa_kbm_doc_favorites 
(
   k_favorites_id       varchar2(40)         not null,
   k_create_user        varchar2(40)         not null,
   k_create_userr_name  varchar2(100)        not null,
   k_create_time        date                 not null,
   k_doc_id             varchar2(40)         not null,
   k_title              varchar2(200)        not null,
   k_type_id            varchar2(40)         not null,
   k_type_name          varchar2(100)        not null,
   k_doc_user           varchar2(40)         not null,
   k_doc_user_name      varchar2(100)        not null,
   constraint pk_oa_kbm_doc_favorites primary key (k_favorites_id)
);

comment on table oa_kbm_doc_favorites is
'用户文档收藏夹表';

comment on column oa_kbm_doc_favorites.k_favorites_id is
'收藏表主键';

comment on column oa_kbm_doc_favorites.k_create_user is
'收藏人';

comment on column oa_kbm_doc_favorites.k_create_userr_name is
'收藏人name';

comment on column oa_kbm_doc_favorites.k_create_time is
'收藏日期';

comment on column oa_kbm_doc_favorites.k_doc_id is
'收藏文档';

comment on column oa_kbm_doc_favorites.k_title is
'收藏文档标题';

comment on column oa_kbm_doc_favorites.k_type_id is
'所属分类';

comment on column oa_kbm_doc_favorites.k_type_name is
'所属分类name';

comment on column oa_kbm_doc_favorites.k_doc_user is
'上传人';

comment on column oa_kbm_doc_favorites.k_doc_user_name is
'人传人name';

/*==============================================================*/
/* table: oa_kbm_doc_operate_log                                */
/*==============================================================*/
create table oa_kbm_doc_operate_log 
(
   k_id                 varchar2(40)         not null,
   k_create_user        varchar2(40)         not null,
   k_create_user_name   varchar2(100)        not null,
   k_create_time        date                 not null,
   k_doc_id             varchar2(40)         not null,
   k_title              varchar2(100)        not null,
   k_is_read            char(1),
   k_is_download        char(1),
   constraint pk_oa_kbm_doc_operate_log primary key (k_id)
);

comment on table oa_kbm_doc_operate_log is
'文档用户操作情况记录表';

comment on column oa_kbm_doc_operate_log.k_id is
'key';

comment on column oa_kbm_doc_operate_log.k_create_user is
'文档操作人';

comment on column oa_kbm_doc_operate_log.k_create_user_name is
'文档操作人name';

comment on column oa_kbm_doc_operate_log.k_create_time is
'操作时间';

comment on column oa_kbm_doc_operate_log.k_doc_id is
'文档id';

comment on column oa_kbm_doc_operate_log.k_title is
'文档标题';

comment on column oa_kbm_doc_operate_log.k_is_read is
'是否阅读（1阅读，0未阅读）';

comment on column oa_kbm_doc_operate_log.k_is_download is
'是否下载（1下载，0未下载）';

/*==============================================================*/
/* table: oa_kbm_doc_rss                                        */
/*==============================================================*/
create table oa_kbm_doc_rss 
(
   k_rss_id             varchar2(40)         not null,
   k_rss_user           varchar2(40)         not null,
   k_rss_user_name      varchar2(100)        not null,
   k_create_time        date                 not null,
   k_type_id            varchar2(40)         not null,
   k_type_name          varchar2(200)        not null,
   k_key                varchar2(400),
   constraint pk_oa_kbm_doc_rss primary key (k_rss_id)
);

comment on table oa_kbm_doc_rss is
'知识库文档订阅';

comment on column oa_kbm_doc_rss.k_rss_id is
'主键';

comment on column oa_kbm_doc_rss.k_rss_user is
'订阅用户';

comment on column oa_kbm_doc_rss.k_rss_user_name is
'订阅用户name';

comment on column oa_kbm_doc_rss.k_create_time is
'订阅时间';

comment on column oa_kbm_doc_rss.k_type_id is
'订阅的分类';

comment on column oa_kbm_doc_rss.k_type_name is
'订阅的分类name';

comment on column oa_kbm_doc_rss.k_key is
'订阅的关键字（界面提示逗号分开）';

/*==============================================================*/
/* table: oa_kbm_doc_suggest                                    */
/*==============================================================*/
create table oa_kbm_doc_suggest 
(
   k_id                 varchar2(40)         not null,
   k_user               varchar2(40)         not null,
   k_user_name          varchar2(100)        not null,
   k_is_read            char(1),
   k_read_time          date,
   k_create_user        varchar2(40)         not null,
   k_create_user_name   varchar2(100)        not null,
   k_create_time        date,
   k_type               varchar2(40)         not null,
   k_type_name          varchar2(100)        not null,
   k_doc_id             varchar2(40)         not null,
   k_title              varchar2(200)        not null,
   k_unit               varchar2(40),
   k_unit_name          varchar2(100),
   constraint pk_oa_kbm_doc_suggest primary key (k_id)
);

comment on table oa_kbm_doc_suggest is
'知识库文档推荐用户阅读情况表';

comment on column oa_kbm_doc_suggest.k_id is
'主键';

comment on column oa_kbm_doc_suggest.k_user is
'被推荐用户id';

comment on column oa_kbm_doc_suggest.k_user_name is
'被推荐用户name';

comment on column oa_kbm_doc_suggest.k_is_read is
'是否已阅读';

comment on column oa_kbm_doc_suggest.k_read_time is
'阅读时间';

comment on column oa_kbm_doc_suggest.k_create_user is
'推荐人';

comment on column oa_kbm_doc_suggest.k_create_user_name is
'推荐人name';

comment on column oa_kbm_doc_suggest.k_create_time is
'推荐j时间';

comment on column oa_kbm_doc_suggest.k_type is
'所属分类';

comment on column oa_kbm_doc_suggest.k_type_name is
'所属分类name';

comment on column oa_kbm_doc_suggest.k_doc_id is
'知识库id';

comment on column oa_kbm_doc_suggest.k_title is
'标题';

comment on column oa_kbm_doc_suggest.k_unit is
'来源';

comment on column oa_kbm_doc_suggest.k_unit_name is
'来源name';

/*==============================================================*/
/* table: oa_kbm_doc_type                                       */
/*==============================================================*/
create table oa_kbm_doc_type 
(
   k_type_id            varchar2(40)         not null,
   k_type_name          varchar2(200)        not null,
   k_type_unit          varchar2(40),
   k_type_unit_name     varchar2(100),
   k_type_dept          varchar2(40),
   k_type_dept_name     varchar2(100),
   k_type_level         number               not null,
   k_type_order         number,
   k_remark             varchar2(1000),
   k_create_user        varchar2(40),
   k_create_user_name   varchar2(100),
   k_create_time        date,
   k_content_by_isre    char(1),
   k_content_template   varchar2(1000),
   k_isrecursion_content char(1),
   k_parent_type_id     varchar2(40),
   constraint pk_oa_kbm_doc_type primary key (k_type_id)
);

comment on table oa_kbm_doc_type is
'知识库文档分类表';

comment on column oa_kbm_doc_type.k_type_id is
'知识分类id';

comment on column oa_kbm_doc_type.k_type_name is
'知识分类名称';

comment on column oa_kbm_doc_type.k_type_unit is
'所属的单位';

comment on column oa_kbm_doc_type.k_type_unit_name is
'所属的单位name';

comment on column oa_kbm_doc_type.k_type_dept is
'所属的部门';

comment on column oa_kbm_doc_type.k_type_dept_name is
'所属的部门name';

comment on column oa_kbm_doc_type.k_type_level is
'分类层次';

comment on column oa_kbm_doc_type.k_type_order is
'排序号';

comment on column oa_kbm_doc_type.k_remark is
'备注';

comment on column oa_kbm_doc_type.k_create_user is
'登记人';

comment on column oa_kbm_doc_type.k_create_user_name is
'登记人name';

comment on column oa_kbm_doc_type.k_create_time is
'登记时间';

comment on column oa_kbm_doc_type.k_content_by_isre is
'内容模板 是否来自递归';

comment on column oa_kbm_doc_type.k_content_template is
'内容模板';

comment on column oa_kbm_doc_type.k_isrecursion_content is
'内容模板 是否递归(1递归0不递归)';

comment on column oa_kbm_doc_type.k_parent_type_id is
'所属上级分类';

/*==============================================================*/
/* table: oa_kbm_doc_type_right_config                          */
/*==============================================================*/
create table oa_kbm_doc_type_right_config 
(
   k_id                 varchar2(40)         not null,
   k_type_id            varchar2(40)         not null,
   k_secrecy_id         varchar2(40)         not null,
   k_secrecy_name       varchar2(100)        not null,
   k_role_ids           clob,
   k_role_names         clob,
   k_role_range         varchar2(40),
   k_role_range_name    varchar2(100),
   constraint pk_oa_kbm_doc_type_right_confi primary key (k_id)
);

comment on table oa_kbm_doc_type_right_config is
'知识库分类权限设置表';

comment on column oa_kbm_doc_type_right_config.k_id is
'主键';

comment on column oa_kbm_doc_type_right_config.k_type_id is
'分类id';

comment on column oa_kbm_doc_type_right_config.k_secrecy_id is
'密级';

comment on column oa_kbm_doc_type_right_config.k_secrecy_name is
'密级name';

comment on column oa_kbm_doc_type_right_config.k_role_ids is
'角色ids';

comment on column oa_kbm_doc_type_right_config.k_role_names is
'角色names';

comment on column oa_kbm_doc_type_right_config.k_role_range is
'角色范围（所有人or本部门）';

comment on column oa_kbm_doc_type_right_config.k_role_range_name is
'角色范围（所有人or本部门）name';


alter table OA_KBM_DOC_OPERATE_LOG modify k_title VARCHAR2(200);