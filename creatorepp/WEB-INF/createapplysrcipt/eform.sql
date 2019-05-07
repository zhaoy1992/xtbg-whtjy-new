--------平台V3.0表单脚本开始--------
---------表单用到的表开始---------
CREATE TABLE FC_BILLZL
(
  DJID        NUMBER(20)                        NOT NULL,
  DJ_NAME     VARCHAR2(40 BYTE),
  DJLX        VARCHAR2(20 BYTE),
  XMLTEXT     CLOB,
  DJPOSITION  VARCHAR2(255 BYTE),
  DJSN        VARCHAR2(40 BYTE),
  ISFUNCTION  CHAR(2 BYTE),
  DESIGNTEXT  CLOB,
  STMPTABLE   VARCHAR2(4000 BYTE)
);

COMMENT ON TABLE FC_BILLZL IS '表单存储表';


CREATE UNIQUE INDEX PK_FC_BILLZL ON FC_BILLZL
(DJID);


ALTER TABLE FC_BILLZL ADD (
  CONSTRAINT PK_FC_BILLZL
 PRIMARY KEY
 (DJID));

create table FC_MAXBH
(
  BIAOSHI CHAR(3) not null,
  RECNUM  NUMBER(10)
);

--gaeditor控件表
-- Create table
create table TD_FORM_GAEDITDATA
(
  URI                VARCHAR2(200) not null,
  GADATA             BLOB,
  DJID               NUMBER(20),
  CTRLID             VARCHAR2(50),
  CC_FORM_INSTANCEID VARCHAR2(50),
  CTRL_INSID         VARCHAR2(50)
);
-- Add comments to the table 
comment on table TD_FORM_GAEDITDATA
  is '编辑控件数据存储表';
-- Add comments to the columns 
comment on column TD_FORM_GAEDITDATA.URI
  is '数据ID';
comment on column TD_FORM_GAEDITDATA.GADATA
  is 'GAEDIT数据文件';
comment on column TD_FORM_GAEDITDATA.DJID
  is '表单id';
comment on column TD_FORM_GAEDITDATA.CTRLID
  is '控件id';
comment on column TD_FORM_GAEDITDATA.CC_FORM_INSTANCEID
  is '表单实例id';
comment on column TD_FORM_GAEDITDATA.CTRL_INSID
  is '控件实例id';


CREATE TABLE TD_OCTL_Document(
    DOCUMENTID NUMBER(10) NOT NULL, 
    RECORDID VARCHAR2(16), 
    TEMPLATE VARCHAR2(16), 
    SUBJECT VARCHAR2(254), 
    AUTHOR VARCHAR2(64), 
    FILEDATE DATE, 
    FILETYPE VARCHAR2(50), 
    HTMLPATH VARCHAR2(128), 
    STATUS VARCHAR2(4),
    DJID NUMBER(20)); 

COMMENT ON COLUMN TD_OCTL_Document.DOCUMENTID IS '自动编号';
COMMENT ON COLUMN TD_OCTL_Document.RecordID IS '文档编号';
COMMENT ON COLUMN TD_OCTL_Document.Template IS '模板编号';
COMMENT ON COLUMN TD_OCTL_Document.Subject IS '主题';
COMMENT ON COLUMN TD_OCTL_Document.Author IS '作者';
COMMENT ON COLUMN TD_OCTL_Document.FileDate IS '日期';
COMMENT ON COLUMN TD_OCTL_Document.FileType IS '文档类型';
COMMENT ON COLUMN TD_OCTL_Document.HtmlPath IS 'HTML路径';
COMMENT ON COLUMN TD_OCTL_Document.Status IS '状态';
COMMENT ON COLUMN TD_OCTL_Document.djid IS '表单编号';

CREATE TABLE TD_OCTL_Document_File(
    FILEID NUMBER(10) NOT NULL, 
    RECORDID VARCHAR2(16), 
    FILENAME VARCHAR2(254), 
    FILETYPE VARCHAR2(4), 
    FILESIZE NUMBER(10), 
    FILEDATE DATE, 
    FILEBODY BLOB , 
    FILEPATH VARCHAR2(128), 
    USERNAME VARCHAR2(64), 
    FILETEXT CLOB,
    DESCRIPT VARCHAR2(255)); 
COMMENT ON COLUMN TD_OCTL_Document_File.FILEID IS '自动编号';

COMMENT ON COLUMN TD_OCTL_Document_File.RecordID IS '文档编号';
COMMENT ON COLUMN TD_OCTL_Document_File.FileName IS '文档名称';
COMMENT ON COLUMN TD_OCTL_Document_File.FileType IS '文档类型';
COMMENT ON COLUMN TD_OCTL_Document_File.FileSize IS '文档大小';
COMMENT ON COLUMN TD_OCTL_Document_File.FileDate IS '文档日期';
COMMENT ON COLUMN TD_OCTL_Document_File.FileBody IS '文档内容';
COMMENT ON COLUMN TD_OCTL_Document_File.FilePath IS '文档所在路径';
COMMENT ON COLUMN TD_OCTL_Document_File.UserName IS '用户名称';
COMMENT ON COLUMN TD_OCTL_DOCUMENT_FILE.FILETEXT IS '文档文本内容';
COMMENT ON COLUMN TD_OCTL_Document_File.Descript IS '文档描述';


CREATE TABLE TD_OCTL_Version_File(
    FILEID NUMBER(10) NOT NULL, 
    RECORDID VARCHAR2(16), 
    FILENAME VARCHAR2(254), 
    FILETYPE VARCHAR2(4), 
    FILESIZE NUMBER(10), 
    FILEDATE DATE, 
    FILEBODY BLOB , 
    FILEPATH VARCHAR2(128), 
    USERNAME VARCHAR2(64), 
    DESCRIPT VARCHAR2(255)); 

COMMENT ON COLUMN TD_OCTL_Version_File.FileID IS '自动编号';
COMMENT ON COLUMN TD_OCTL_Version_File.RecordID IS '文档编号';
COMMENT ON COLUMN TD_OCTL_Version_File.FileName IS '文档名称';
COMMENT ON COLUMN TD_OCTL_Version_File.FileType IS '文档类型';
COMMENT ON COLUMN TD_OCTL_Version_File.FileSize IS '文档大小';
COMMENT ON COLUMN TD_OCTL_Version_File.FileDate IS '文档日期';
COMMENT ON COLUMN TD_OCTL_Version_File.FileBody IS '文档内容';
COMMENT ON COLUMN TD_OCTL_Version_File.FilePath IS '文档所在路径';
COMMENT ON COLUMN TD_OCTL_Version_File.UserName IS '用户名称';
COMMENT ON COLUMN TD_OCTL_Version_File.Descript IS '文档描述';


CREATE TABLE TD_OCTL_BookMarks(
    BOOKMARKID NUMBER(10) NOT NULL, 
    BOOKMARKNAME VARCHAR2(64), 
    BOOKMARKDESC VARCHAR2(128), 
    BOOKMARKTEXT VARCHAR2(200)); 

COMMENT ON COLUMN TD_OCTL_BookMarks.BookMarkID IS '自动编号';
COMMENT ON COLUMN TD_OCTL_BookMarks.BookMarkName IS '书签名称';
COMMENT ON COLUMN TD_OCTL_BookMarks.BookMarkDesc IS '书签说明';
COMMENT ON COLUMN TD_OCTL_BookMarks.BookMarkText IS '书签内容';


CREATE TABLE TD_OCTL_Document_Signature(
    SIGNATUREID NUMBER(10) NOT NULL, 
    RECORDID VARCHAR2(50), 
    MARKNAME VARCHAR2(64), 
    USERNAME VARCHAR2(64), 
    DATETIME DATE, 
    HOSTNAME VARCHAR2(50), 
    MARKGUID VARCHAR2(128)); 
COMMENT ON COLUMN TD_OCTL_Document_Signature.SignatureID IS '自动编号';
COMMENT ON COLUMN TD_OCTL_Document_Signature.RecordID IS '文档编号';
COMMENT ON COLUMN TD_OCTL_Document_Signature.MarkName IS '签名名称';
COMMENT ON COLUMN TD_OCTL_Document_Signature.UserName IS '用户名称';
COMMENT ON COLUMN TD_OCTL_Document_Signature.DateTime IS '签名日期';
COMMENT ON COLUMN TD_OCTL_Document_Signature.HostName IS '用户主机';
COMMENT ON COLUMN TD_OCTL_Document_Signature.MarkGuid IS '签名标示';

CREATE TABLE TD_OCTL_Signature(
    SIGNATUREID NUMBER(10) NOT NULL, 
    USERNAME VARCHAR2(64), 
    PASSWORD VARCHAR2(64), 
    MARKNAME VARCHAR2(254), 
    MARKTYPE VARCHAR2(50), 
    MARKBODY BLOB , 
    MARKPATH VARCHAR2(128), 
    MARKSIZE NUMBER(10), 
    MARKDATE DATE); 
COMMENT ON COLUMN TD_OCTL_Signature.SignatureID IS '自动编号';
COMMENT ON COLUMN TD_OCTL_Signature.UserName IS '所属用户';
COMMENT ON COLUMN TD_OCTL_Signature.MarkName IS '签名名称';
COMMENT ON COLUMN TD_OCTL_Signature.PassWord IS '签名密码';
COMMENT ON COLUMN TD_OCTL_Signature.MarkBody IS '签名数据';
COMMENT ON COLUMN TD_OCTL_Signature.MarkPath IS '签名所在路径';
COMMENT ON COLUMN TD_OCTL_Signature.MarkSize IS '签名大小';
COMMENT ON COLUMN TD_OCTL_Signature.MarkDate IS '保存日期';


CREATE TABLE TD_OCTL_Template_File(
    TEMPLATEID NUMBER(10) NOT NULL, 
    RECORDID VARCHAR2(16) NOT NULL, 
    FILENAME VARCHAR2(254), 
    FILETYPE VARCHAR2(50), 
    FILESIZE NUMBER(10), 
    FILEDATE DATE, 
    FILEBODY BLOB , 
    FILEPATH VARCHAR2(255), 
    USERNAME VARCHAR2(64), 
    DESCRIPT VARCHAR2(255),
    ORG_ID  VARCHAR2(50),
    RECORD_SN  NUMBER(10)
    ); 

COMMENT ON COLUMN TD_OCTL_Template_File.TemplateID IS '自动编号';
COMMENT ON COLUMN TD_OCTL_Template_File.RecordID IS '模板编号';
COMMENT ON COLUMN TD_OCTL_Template_File.FileName IS '模板名称';
COMMENT ON COLUMN TD_OCTL_Template_File.FileType IS '模板类型';
COMMENT ON COLUMN TD_OCTL_Template_File.FileSize IS '模板大小';
COMMENT ON COLUMN TD_OCTL_Template_File.FileDate IS '模板日期';
COMMENT ON COLUMN TD_OCTL_Template_File.FileBody IS '模板内容';
COMMENT ON COLUMN TD_OCTL_Template_File.FilePath IS '模板所在路径';
COMMENT ON COLUMN TD_OCTL_Template_File.UserName IS '用户名称';
COMMENT ON COLUMN TD_OCTL_Template_File.Descript IS '模板描述';
COMMENT ON COLUMN TD_OCTL_Template_File.ORG_ID IS '该模板所属的机构id';
comment on column TD_OCTL_TEMPLATE_FILE.RECORD_SN is '模板排序号';


CREATE TABLE TD_OCTL_Template_BookMarks(
    BOOKMARKID NUMBER(10) NOT NULL, 
    RECORDID VARCHAR2(50), 
    BOOKMARKNAME VARCHAR2(120));

COMMENT ON COLUMN TD_OCTL_Template_BookMarks.BookMarkID IS '自动编号';
COMMENT ON COLUMN TD_OCTL_Template_BookMarks.RecordID IS '文档编号';
COMMENT ON COLUMN TD_OCTL_Template_BookMarks.BookMarkName IS '书签名称';

create table TD_OCTL_TEMPLATE_GRANT
(
  RECORDID      VARCHAR2(16),
  USER_ID       NUMBER,
  USER_REALNAME VARCHAR2(100),
  GRANTTYPE     VARCHAR2(20),
  ROLE_ID       VARCHAR2(50),
  ROLE_NAME     VARCHAR2(100)
);

--公文传输系统的接口表--
create table TD_OCTL_GWCS_FILE
(
  FILEID   NUMBER(10) not null,
  RECORDID VARCHAR2(33),
  FILENAME VARCHAR2(254),
  FILETYPE VARCHAR2(4),
  FILESIZE NUMBER(10),
  FILEDATE DATE,
  FILEBODY BLOB,
  FILEPATH VARCHAR2(128),
  USERNAME VARCHAR2(64),
  DESCRIPT VARCHAR2(255)
);
-- Add comments to the columns 
comment on column TD_OCTL_GWCS_FILE.FILEID
  is '自动编号';
comment on column TD_OCTL_GWCS_FILE.RECORDID
  is '文档编号';
comment on column TD_OCTL_GWCS_FILE.FILENAME
  is '文档名称';
comment on column TD_OCTL_GWCS_FILE.FILETYPE
  is '文档类型';
comment on column TD_OCTL_GWCS_FILE.FILESIZE
  is '文档大小';
comment on column TD_OCTL_GWCS_FILE.FILEDATE
  is '文档日期';
comment on column TD_OCTL_GWCS_FILE.FILEBODY
  is '文档内容';
comment on column TD_OCTL_GWCS_FILE.FILEPATH
  is '文档所在路径';
comment on column TD_OCTL_GWCS_FILE.USERNAME
  is '用户名称';
comment on column TD_OCTL_GWCS_FILE.DESCRIPT
  is '文档描述';


 --------upload上传控件的表结构开始--------

create table FC_ATTACHEREF
(
  REFID          VARCHAR2(32) not null,
  REF_CTRL_INSID VARCHAR2(20),
  NOTE           VARCHAR2(100),
  ADDTIME        DATE,
  REF_ATTACHE_ID VARCHAR2(20),
  REF_TYPE       CHAR(1),
  DJBH           VARCHAR2(15)
)
;
comment on column FC_ATTACHEREF.REFID
  is '主键';
comment on column FC_ATTACHEREF.REF_CTRL_INSID
  is '控件实例ID';
comment on column FC_ATTACHEREF.NOTE
  is '备注';
comment on column FC_ATTACHEREF.ADDTIME
  is '时间';
comment on column FC_ATTACHEREF.REF_ATTACHE_ID
  is '关联附件表的attache_id';
comment on column FC_ATTACHEREF.REF_TYPE
  is '上传类型';
  
  
create table FC_ATTACH
(
  EXTEND             VARCHAR2(255),
  DJBH               VARCHAR2(15) not null,
  DJ_SN              NUMBER(20),
  FILENAME           VARCHAR2(255),
  ATTACHID           VARCHAR2(11) not null,
  BZ                 VARCHAR2(255),
  DJSN               VARCHAR2(20),
  FILEPOS            VARCHAR2(500),
  CC_FORM_INSTANCEID VARCHAR2(50),
  UPLOAD_MODE CHAR(1) default '1',
  CREATOR	     VARCHAR2(30),
  ATTACHCONTENT      BLOB
);
-- Add comments to the columns 
comment on column FC_ATTACH.UPLOAD_MODE
  is '文件存取模式：1-数据库、2-本地磁盘、3-FTP远程服务器';
  --------upload上传控件的表结构结束--------


--数据集运行态
-- Create table
create table TB_CTRL_DATASET_RUN
(
  DJID               NUMBER(20) not null,
  CTRLID             VARCHAR2(50) not null,
  CC_FORM_INSTANCEID VARCHAR2(50) not null,
  DS_TYPE            NUMBER(2) default 0,
  DS_SQL             VARCHAR2(200),
  DS_TBNAME          VARCHAR2(50),
  REMARK             VARCHAR2(200)
);
-- Add comments to the columns 
comment on column TB_CTRL_DATASET_RUN.DJID
  is '表单id';
comment on column TB_CTRL_DATASET_RUN.CTRLID
  is '控件id';
comment on column TB_CTRL_DATASET_RUN.CC_FORM_INSTANCEID
  is '表单实例id';
comment on column TB_CTRL_DATASET_RUN.DS_TYPE
  is '数据集类型 0、单条记录的数据集 1、多条记录的数据集';
comment on column TB_CTRL_DATASET_RUN.DS_SQL
  is '数据集的sql';
comment on column TB_CTRL_DATASET_RUN.DS_TBNAME
  is '数据集的保存表名';
comment on column TB_CTRL_DATASET_RUN.REMARK
  is '备注';


--office控件运行态表
 -- Create table
create table TB_CTRL_OFFICE_RUN
(
  DJID               NUMBER(20) not null,
  CTRLID             VARCHAR2(50) not null,
  CC_FORM_INSTANCEID VARCHAR2(50) not null,
  CTRL_INSID         VARCHAR2(50) not null,
  STATUS             NUMBER(2)
);
  
  --通用控件运行态表
  -- Create table
create table TB_CTRL_RUN
(
  DJID               NUMBER(20) not null,
  CTRLID             VARCHAR2(50) not null,
  CC_FORM_INSTANCEID VARCHAR2(50) not null
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table TB_CTRL_RUN
  add constraint PK_TB_CTRL_RUN primary key (CC_FORM_INSTANCEID);
  
  
  --上传控件运行态表
  -- Create table
create table TB_CTRL_UPLOAD_RUN
(
  DJID               NUMBER(20) not null,
  CTRLID             VARCHAR2(50) not null,
  CC_FORM_INSTANCEID VARCHAR2(50) not null,
  CTRL_INSID         VARCHAR2(50) not null,
  ALLOWDELETE        NUMBER(1) default 1
);
-- Add comments to the columns 
comment on column TB_CTRL_UPLOAD_RUN.DJID
  is '表单id';
comment on column TB_CTRL_UPLOAD_RUN.CTRLID
  is '控件id';
comment on column TB_CTRL_UPLOAD_RUN.CC_FORM_INSTANCEID
  is '表单实例id';
comment on column TB_CTRL_UPLOAD_RUN.CTRL_INSID
  is '控件实例id';
comment on column TB_CTRL_UPLOAD_RUN.ALLOWDELETE
  is '是否允许删除 0、不允许 1、允许';
  
  --表单实例
  -- Create table
create table TB_FORM_INSTANCE
(
  DJID               NUMBER(20) not null,
  CC_FORM_INSTANCEID VARCHAR2(50) not null
);
-- Add comments to the columns 
comment on column TB_FORM_INSTANCE.DJID
  is '表单id';
comment on column TB_FORM_INSTANCE.CC_FORM_INSTANCEID
  is '表单实例id';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TB_FORM_INSTANCE
  add constraint PK_TB_FORM_INSTANCE primary key (CC_FORM_INSTANCEID)
  using index;
  

CREATE TABLE TB_FORM
(
  EFORM_ID      VARCHAR2(20 BYTE),
  DJID          NUMBER(20),
  STORE_TYPE    VARCHAR2(16 BYTE),
  REMARK        VARCHAR2(512 BYTE),
  DJ_VER        VARCHAR2(20 BYTE),
  DJ_NAME       VARCHAR2(64 BYTE),
  CREATOR       VARCHAR2(32 BYTE),
  CREATTIME     DATE,
  PUBLISHSTATE  NUMBER(1)                       DEFAULT 0                     NOT NULL,
  PUBLISHTIME   DATE,
  PUBLISHER     VARCHAR2(32 BYTE),
  DJ_MTYPE      NUMBER(1)                       DEFAULT 0                     NOT NULL,
  PROCATTR      NUMBER(1)                       DEFAULT 0,
  HASOFFICE     NUMBER(1)                       DEFAULT 0                     NOT NULL,
  HASUPLOAD     NUMBER(1)                       DEFAULT 0                     NOT NULL,
  HASGAEDITOR   NUMBER(1)                       DEFAULT 0                     NOT NULL,
  DS_IDS        VARCHAR2(300 BYTE),
  DJ_LOG        NUMBER(1)                       DEFAULT 0,
  DJ_PROTECT    NUMBER(1)                       DEFAULT 1,
  DJ_MODIFIED   NUMBER(1)                       DEFAULT 0,
  DJ_EDITOR     VARCHAR2(20 BYTE),
  DJ_EDITTIME   DATE,
  HASHTM        NUMBER(1)                       DEFAULT 0,
  HASEXT        NUMBER(1)                       DEFAULT 0,
  CSSFOLDER     VARCHAR2(50 BYTE)
);

COMMENT ON TABLE TB_FORM IS '表单';

COMMENT ON COLUMN TB_FORM.EFORM_ID IS '表单编号';

COMMENT ON COLUMN TB_FORM.DJID IS 'DJID';

COMMENT ON COLUMN TB_FORM.STORE_TYPE IS '存储方式';

COMMENT ON COLUMN TB_FORM.REMARK IS '表单描述';

COMMENT ON COLUMN TB_FORM.DJ_VER IS '版本号';

COMMENT ON COLUMN TB_FORM.DJ_NAME IS '表单名称';

COMMENT ON COLUMN TB_FORM.CREATOR IS '创建人';

COMMENT ON COLUMN TB_FORM.CREATTIME IS '创建时间';

COMMENT ON COLUMN TB_FORM.PUBLISHSTATE IS '发布状态';

COMMENT ON COLUMN TB_FORM.PUBLISHTIME IS '发布时间';

COMMENT ON COLUMN TB_FORM.PUBLISHER IS '发布人';

COMMENT ON COLUMN TB_FORM.DJ_MTYPE IS '0、表单 1、模板';

COMMENT ON COLUMN TB_FORM.PROCATTR IS '流程关联属性：是否与流程相关，0：不相关，1相关';

COMMENT ON COLUMN TB_FORM.HASOFFICE IS '0、没有 1、有';

COMMENT ON COLUMN TB_FORM.HASUPLOAD IS '0、没有 1、有';

COMMENT ON COLUMN TB_FORM.HASGAEDITOR IS '0、没有 1、有';

COMMENT ON COLUMN TB_FORM.DS_IDS IS '表单包含的所有的数据集id';

COMMENT ON COLUMN TB_FORM.DJ_LOG IS '0、不记录日志 1、记录日志';

COMMENT ON COLUMN TB_FORM.DJ_PROTECT IS '1、进行页面保护 0、不进行页面保护';

COMMENT ON COLUMN TB_FORM.DJ_MODIFIED IS '表单是否处于修改状态：1，正在修改；0，没有修改';

COMMENT ON COLUMN TB_FORM.DJ_EDITOR IS '表单的最近修改人';

COMMENT ON COLUMN TB_FORM.DJ_EDITTIME IS '表单的最近保存时间';

COMMENT ON COLUMN TB_FORM.HASHTM IS '是否有离线表单,0、没有 1、有';

COMMENT ON COLUMN TB_FORM.HASEXT IS '是否有EXT控件,0、没有 1、有';

COMMENT ON COLUMN TB_FORM.CSSFOLDER IS '表单CSS目录';


CREATE INDEX IDX_FORM_EC_ID ON TB_FORM
(EFORM_ID);

CREATE INDEX IDX_FORM_ID ON TB_FORM
(DJID);

ALTER TABLE TB_FORM ADD (
  CONSTRAINT FK_FORM_BILLZL 
 FOREIGN KEY (DJID) 
 REFERENCES FC_BILLZL (DJID)
 );

create table TD_FORM_PERATTR
(
  PERATTR_ID    VARCHAR2(40) not null,
  DJID          NUMBER(20),
  OID           VARCHAR2(100),
  CTRL_ID       VARCHAR2(128),
  PERATTR_TYPE  NUMBER(2) default '0',
  REMARK        VARCHAR2(512),
  READONLYSTYLE VARCHAR2(50)
);
-- Add comments to the table 
comment on table TD_FORM_PERATTR
  is '表单权限参数';
-- Add comments to the columns 
comment on column TD_FORM_PERATTR.PERATTR_ID
  is '权限参数记录编号';
comment on column TD_FORM_PERATTR.DJID
  is '单据ID';
comment on column TD_FORM_PERATTR.OID
  is '活动ID';
comment on column TD_FORM_PERATTR.CTRL_ID
  is '控件ID：DJ_ID || CTRL_ID';
comment on column TD_FORM_PERATTR.PERATTR_TYPE
  is '权限控制类型(0:enabled 1:disable 2:invisible)';
comment on column TD_FORM_PERATTR.REMARK
  is '备注';
comment on column TD_FORM_PERATTR.READONLYSTYLE
  is '只读元素的样式';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_FORM_PERATTR
  add constraint PK_TD_FORM_PERATTR primary key (PERATTR_ID);
alter table TD_FORM_PERATTR
  add constraint FK_FORM_PEARPAR foreign key (DJID)
  references FC_BILLZL (DJID);
  
  
create table TD_FORM_CTRLATTR
(
  CTRLATTR_ID VARCHAR2(40) not null,
  DJID        NUMBER(20),
  OID         VARCHAR2(100),
  CTRL_ID     VARCHAR2(128),
  CTRL_CNNAME VARCHAR2(256),
  FIELD_TYPE  VARCHAR2(16),
  INIT_VALUE  VARCHAR2(512),
  FIELD_DESC  VARCHAR2(1023)
);
-- Add comments to the table 
comment on table TD_FORM_CTRLATTR
  is '表单控制参数';
-- Add comments to the columns 
comment on column TD_FORM_CTRLATTR.CTRLATTR_ID
  is '控制参数记录编号';
comment on column TD_FORM_CTRLATTR.OID
  is '流程定义ID';
comment on column TD_FORM_CTRLATTR.CTRL_ID
  is '控件ID："F_"||DJ_ID || CTRL_ID';
comment on column TD_FORM_CTRLATTR.CTRL_CNNAME
  is '控件中文名称';
comment on column TD_FORM_CTRLATTR.FIELD_TYPE
  is '数据类型:1 bool 2 float 3 int 6 string 7 date';
comment on column TD_FORM_CTRLATTR.INIT_VALUE
  is '初始值';
comment on column TD_FORM_CTRLATTR.FIELD_DESC
  is '描述';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_FORM_CTRLATTR
  add constraint PK_TD_FORM_CTRLATTR primary key (CTRLATTR_ID);
alter table TD_FORM_CTRLATTR
  add constraint FK_FORM_CTRLPAR foreign key (DJID)
  references FC_BILLZL (DJID);

create table TB_FORM_DATASTRU
(
  FRMSTRU_ID VARCHAR2(20) not null,
  DJID       NUMBER(20),
  DS_ID      VARCHAR2(100),
  DS_TYPE    NUMBER,
  DS_SQL     VARCHAR2(1023),
  DS_TBNAME  VARCHAR2(100),
  REMARK     VARCHAR2(512),
  UPLOADATTR NUMBER(2) default 0,
  DS_PRIMARY VARCHAR2(100)
);
comment on table TB_FORM_DATASTRU
  is '表单数据结构表';
-- Add comments to the columns 
comment on column TB_FORM_DATASTRU.FRMSTRU_ID
  is 'ID';
comment on column TB_FORM_DATASTRU.DS_ID
  is '数据集ID';
comment on column TB_FORM_DATASTRU.DS_TYPE
  is '数据集类型
1、单记录【主数据集】
2、多记录【从数据集】
3、自定义数据集
4、GAEDIT数据
5、WORD数据';
comment on column TB_FORM_DATASTRU.DS_SQL
  is '数据集SQL';
comment on column TB_FORM_DATASTRU.DS_TBNAME
  is '数据集表名';
comment on column TB_FORM_DATASTRU.REMARK
  is '备注';
comment on column TB_FORM_DATASTRU.UPLOADATTR
  is '是否为上传下载控件的组件 1：是；0：不是';
comment on column TB_FORM_DATASTRU.DS_PRIMARY
  is '表的主键名';
alter table TB_FORM_DATASTRU
  add constraint PK_TB_FORM_DATASTRU primary key (FRMSTRU_ID);
alter table TB_FORM_DATASTRU
  add constraint FK_DJ_DATASTRU foreign key (DJID)
  references FC_BILLZL (DJID);
  
  
create table TB_CTRL_DESIGN
(
  DJID     NUMBER(20) not null,
  CTRLID   VARCHAR2(50) not null,
  CTRLTYPE VARCHAR2(50),
  CTRLXML  CLOB
);
comment on column TB_CTRL_DESIGN.DJID
  is '表单id';
comment on column TB_CTRL_DESIGN.CTRLID
  is '控件id';
comment on column TB_CTRL_DESIGN.CTRLTYPE
  is '控件类型';
comment on column TB_CTRL_DESIGN.CTRLXML
  is '控件的xml串';
alter table TB_CTRL_DESIGN
  add constraint PK_CTRLID primary key (CTRLID, DJID);

      
---------表单用到的表结束--------  


------------表单的表的数据初始化开始---------------

insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('A  ', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('AAA', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('act', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('att', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('ATT', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('B  ', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('BBB', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('BCD', 3);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('BIL', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('BJG', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('BJI', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('BJS', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('cha', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('CHA', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('CHB', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('CHU', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('CPL', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('CPP', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('CPR', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('DDD', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('DUC', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('ECO', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('EVA', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('EXT', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('FCD', 4);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('GFX', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('GRA', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('HHH', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('hyt', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('ILI', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('ITE', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('JBX', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('LGZ', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('MLI', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('NFO', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('NOL', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('NOT', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('PLI', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('POI', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('PRO', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('PZH', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('rec', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('REP', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('RRR', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('sch', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('SHH', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('SHS', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('SLI', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('SSS', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('STA', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('TEM', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('TJG', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('TSQ', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('UPF', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('VID', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('WFB', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('win', 1);
insert into FC_MAXBH (BIAOSHI, RECNUM)
values ('ZID', 1);
commit;
  
------------表单的表的数据初始化结束---------------


-- Create sequence
create sequence SEQ_GAEDITOR_INS
minvalue 1
maxvalue 999999999999
start with 141
increment by 1
cache 20;


-- Create sequence
create sequence SEQ_OFFICE_INS
minvalue 1
maxvalue 999999999999
start with 341
increment by 1
cache 20;


-- Create sequence
create sequence SEQ_OTHER_INS
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20;


-- Create sequence
create sequence SEQ_UPLOAD_INS
minvalue 1
maxvalue 999999999999
start with 141
increment by 1
cache 20;


  