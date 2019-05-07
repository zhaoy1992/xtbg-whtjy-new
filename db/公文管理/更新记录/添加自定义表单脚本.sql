ALTER TABLE OA_FORM_TAG_CONFIG
   DROP CONSTRAINT FK_OA_TAG_TYPE_1;

DROP TABLE OA_TAG_TYPE CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_TAG_TYPE                                           */
/*==============================================================*/
CREATE TABLE OA_TAG_TYPE 
(
   TAG_TYPE_CODE        VARCHAR2(40)         NOT NULL,
   TAG_TYPE_NAME        VARCHAR2(200),
   CONSTRAINT PK_OA_TAG_TYPE PRIMARY KEY (TAG_TYPE_CODE)
);

COMMENT ON TABLE OA_TAG_TYPE IS
'控件类型表';

COMMENT ON COLUMN OA_TAG_TYPE.TAG_TYPE_CODE IS
'tag_type_code';

COMMENT ON COLUMN OA_TAG_TYPE.TAG_TYPE_NAME IS
'tag_type_name';

ALTER TABLE OA_FORM_TAG_CONFIG
   DROP CONSTRAINT FK_OA_FORM_CONFIG;

DROP TABLE OA_FORM_CONFIG CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_FORM_CONFIG                                        */
/*==============================================================*/
CREATE TABLE OA_FORM_CONFIG 
(
   FORM_ID              VARCHAR2(40)         NOT NULL,
   FORM_NAME            VARCHAR2(400)        NOT NULL,
   FORM_JSP_NAME        VARCHAR2(200)        NOT NULL,
   FORM_BACKGROUND      VARCHAR2(40),
   TAG_BACKGROUND       VARCHAR2(40),
   TAG_WIDTH            VARCHAR2(40),
   TAG_HEIGHT           VARCHAR2(40),
   TAG_MARGINS          VARCHAR2(40),
   FROM_EXT_PARM        VARCHAR2(400),
   TAG_CONFIG_HTML      CLOB,
   FORM_WIDTH           VARCHAR2(40),
   IS_TEXT              VARCHAR2(2),
   CONSTRAINT PK_OA_FORM_CONFIG PRIMARY KEY (FORM_ID)
);

COMMENT ON TABLE OA_FORM_CONFIG IS
'表单配置表';

COMMENT ON COLUMN OA_FORM_CONFIG.FORM_ID IS
'表单ID';

COMMENT ON COLUMN OA_FORM_CONFIG.FORM_NAME IS
'表单名称';

COMMENT ON COLUMN OA_FORM_CONFIG.FORM_JSP_NAME IS
'表单JSP名称';

COMMENT ON COLUMN OA_FORM_CONFIG.FORM_BACKGROUND IS
'表单底色';

COMMENT ON COLUMN OA_FORM_CONFIG.TAG_BACKGROUND IS
'元素底色';

COMMENT ON COLUMN OA_FORM_CONFIG.TAG_WIDTH IS
'元素宽度';

COMMENT ON COLUMN OA_FORM_CONFIG.TAG_HEIGHT IS
'元素高度';

COMMENT ON COLUMN OA_FORM_CONFIG.TAG_MARGINS IS
'元素间隔PX';

COMMENT ON COLUMN OA_FORM_CONFIG.FROM_EXT_PARM IS
'表单扩展属性';

COMMENT ON COLUMN OA_FORM_CONFIG.TAG_CONFIG_HTML IS
'配置HTML';

COMMENT ON COLUMN OA_FORM_CONFIG.FORM_WIDTH IS
'表单宽度';

COMMENT ON COLUMN OA_FORM_CONFIG.IS_TEXT IS
'是否有正文';

ALTER TABLE OA_FORM_TAG_CONFIG
   DROP CONSTRAINT FK_OA_FORM_CONFIG;

ALTER TABLE OA_FORM_TAG_CONFIG
   DROP CONSTRAINT FK_OA_TAG_TYPE_1;

DROP TABLE OA_FORM_TAG_CONFIG CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_FORM_TAG_CONFIG                                    */
/*==============================================================*/
CREATE TABLE OA_FORM_TAG_CONFIG 
(
   TAG_ID               VARCHAR2(40)         NOT NULL,
   FORM_ID              VARCHAR2(40)         NOT NULL,
   TAG_TYPE_ID          VARCHAR2(40)         NOT NULL,
   TITLE                VARCHAR2(40),
   TABLE_ID             VARCHAR2(40),
   COLUMN_ID            VARCHAR2(40),
   STYLE_TEXT           VARCHAR2(400),
   DISPLAY_HTML         VARCHAR2(4000),
   TAG_HTML             VARCHAR2(4000),
   SELECT_TYPE          VARCHAR2(1),
   SELECT_TEXT          VARCHAR2(400),
   DEFAULT_VALUE        VARCHAR2(400),
   CONSTRAINT PK_OA_FORM_TAG_CONFIG PRIMARY KEY (TAG_ID)
);

COMMENT ON TABLE OA_FORM_TAG_CONFIG IS
'表单元素配置表';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.TAG_ID IS
'控件ID';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.FORM_ID IS
'表单ID';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.TAG_TYPE_ID IS
'控件类型ID';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.TITLE IS
'控件标题';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.TABLE_ID IS
'对应表名';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.COLUMN_ID IS
'对应字段名';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.STYLE_TEXT IS
'样式文本';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.DISPLAY_HTML IS
'显示HTML';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.TAG_HTML IS
'标签HTML';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.SELECT_TYPE IS
'下拉框类型';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.SELECT_TEXT IS
'下拉框文本';

COMMENT ON COLUMN OA_FORM_TAG_CONFIG.DEFAULT_VALUE IS
'默认值';

ALTER TABLE OA_FORM_TAG_CONFIG
   ADD CONSTRAINT FK_OA_FORM_CONFIG FOREIGN KEY (FORM_ID)
      REFERENCES OA_FORM_CONFIG (FORM_ID);

ALTER TABLE OA_FORM_TAG_CONFIG
   ADD CONSTRAINT FK_OA_TAG_TYPE_1 FOREIGN KEY (TAG_TYPE_ID)
      REFERENCES OA_TAG_TYPE (TAG_TYPE_CODE);

      DROP TABLE OA_DOCUMENT_COMIDEA CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_DOCUMENT_COMIDEA                                   */
/*==============================================================*/
CREATE TABLE OA_DOCUMENT_COMIDEA 
(
   IDEA_ID               VARCHAR2(50),
   IDEA_CONTENT         VARCHAR2(500),
   USER_ID              VARCHAR2(50)
);

COMMENT ON TABLE OA_DOCUMENT_COMIDEA IS
'意见表';

COMMENT ON COLUMN OA_DOCUMENT_COMIDEA.IDEA_ID IS
' 主键';

COMMENT ON COLUMN OA_DOCUMENT_COMIDEA.IDEA_CONTENT IS
'意见内容';

COMMENT ON COLUMN OA_DOCUMENT_COMIDEA.USER_ID IS
'用户';

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('afixlist', '附件列表');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('txt', '正文');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('hide', '隐藏域');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('input', '文本框');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('select', '下拉框');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('textarea', '文本域');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('text', '文本');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('date', '日期');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('viewtext', '意见框');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('afix', '附件');

commit;

insert into oa_document_comidea (IDEA_ID, IDEA_CONTENT, USER_ID)
values ('1', '同意', '');

insert into oa_document_comidea (IDEA_ID, IDEA_CONTENT, USER_ID)
values ('2', '不同意1', '');

commit;