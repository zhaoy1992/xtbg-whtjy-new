--------创建用户开始--------

create user &user
  identified by "&password"
  default tablespace &deftablespace
  temporary tablespace &temptablespace
  profile DEFAULT;
  
---------创建用户结束-------- 



---------授权开始------------

grant connect to &user;
grant resource to &user;
grant dba to &user;

--待办列表权限 开始--
grant select on  td_proc_form_instancemap to &user;
grant select on  v_Worklist to &user;
grant select on  activitystates to &user;
grant select on  td_worklist_tobe to &user;
grant select on  tb_form_class to &user;
grant select on  activities to &user;
grant select on  processes to &user;
grant select on  tb_application_info to &user;
grant execute on sum_string to &user;
--待办列表权限 结束--

--任务表权限 开始--
grant select on assignmentstable to &user;
--任务表权限 结束--

---------授权结束------------

---------表单用到的表开始---------

create table FC_FLDLIST 
(
    FLDID                VARCHAR2(50)                   not null,
    TBID                 VARCHAR2(50),
    FDNAME               VARCHAR2(50)                   not null,
    CHNNAME              VARCHAR2(50),
    FDTYPE               CHAR(4),
    FDSIZE               NUMBER(10),
    FDDEC                NUMBER(10),
    INPUTSTYLE           VARCHAR2(4000),
    OBJWIDTH             CHAR(10),
    constraint PK_FC_FLDLIST primary key (FLDID)
);

comment on table FC_FLDLIST is 
'表单数据字段表';

comment on column FC_FLDLIST.FLDID is 
'字段记录号';

comment on column FC_FLDLIST.TBID is 
'表记录号';

comment on column FC_FLDLIST.FDNAME is 
'字段名';

comment on column FC_FLDLIST.CHNNAME is 
'字段中文名';

comment on column FC_FLDLIST.FDTYPE is 
'字段类型';

comment on column FC_FLDLIST.FDSIZE is 
'字段长度';

comment on column FC_FLDLIST.FDDEC is 
'字段描述';

comment on column FC_FLDLIST.INPUTSTYLE is 
'输入方式';

comment on column FC_FLDLIST.OBJWIDTH is 
'宽度';

create table FC_TBLIST 
(
    TBID                 VARCHAR2(50)                   not null,
    TBNAME               VARCHAR2(50)                   not null,
    CHNNAME              VARCHAR2(50),
    TBTYPE               CHAR(10),
    constraint PK_FC_TBLIST primary key (TBID)
);

comment on table FC_TBLIST is 
'表单相关数据表';

comment on column FC_TBLIST.TBID is 
'表记录号';

comment on column FC_TBLIST.TBNAME is 
'表名';

comment on column FC_TBLIST.CHNNAME is 
'表中文名';

comment on column FC_TBLIST.TBTYPE is 
'表类型';

alter table FC_FLDLIST
   add constraint FK_FLDLIST_TBLIST foreign key (TBID)
      references FC_TBLIST (TBID);      
      
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
)
tablespace DZZWPT
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    minextents 1
    maxextents unlimited
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
    ORG_ID  VARCHAR2(50)); 

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



CREATE TABLE TD_OCTL_Template_BookMarks(
    BOOKMARKID NUMBER(10) NOT NULL, 
    RECORDID VARCHAR2(50), 
    BOOKMARKNAME VARCHAR2(120));

COMMENT ON COLUMN TD_OCTL_Template_BookMarks.BookMarkID IS '自动编号';
COMMENT ON COLUMN TD_OCTL_Template_BookMarks.RecordID IS '文档编号';
COMMENT ON COLUMN TD_OCTL_Template_BookMarks.BookMarkName IS '书签名称';


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
)
tablespace DZZWPT
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16
    minextents 1
    maxextents unlimited
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
  FILEPOS            VARCHAR2(250),
  CC_FORM_INSTANCEID VARCHAR2(50),
  ATTACHCONTENT      BLOB
);
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
)
tablespace DZZWPT
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
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
)
tablespace DZZWPT
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
  --通用控件运行态表
  -- Create table
create table TB_CTRL_RUN
(
  DJID               NUMBER(20) not null,
  CTRLID             VARCHAR2(50) not null,
  CC_FORM_INSTANCEID VARCHAR2(50) not null
)
tablespace DZZWPT
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table TB_CTRL_RUN
  add constraint PK_TB_CTRL_RUN primary key (CC_FORM_INSTANCEID)
  using index 
  tablespace DZZWPT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
  
  --上传控件运行态表
  -- Create table
create table TB_CTRL_UPLOAD_RUN
(
  DJID               NUMBER(20) not null,
  CTRLID             VARCHAR2(50) not null,
  CC_FORM_INSTANCEID VARCHAR2(50) not null,
  CTRL_INSID         VARCHAR2(50) not null,
  ALLOWDELETE        NUMBER(1) default 1
)
tablespace DZZWPT
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
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
)
tablespace DZZWPT
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column TB_FORM_INSTANCE.DJID
  is '表单id';
comment on column TB_FORM_INSTANCE.CC_FORM_INSTANCEID
  is '表单实例id';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TB_FORM_INSTANCE
  add constraint PK_TB_FORM_INSTANCE primary key (CC_FORM_INSTANCEID)
  using index 
  tablespace DZZWPT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
      
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
  
------------表单的表的数据初始化技术---------------
      
      
      
---------------系统管理用到的表开始------------------


-- Create table
create table TD_SM_ORGANIZATION
(
  ORG_ID           VARCHAR2(50) not null,
  ORG_SN           NUMBER not null,
  ORG_NAME         VARCHAR2(40) not null,
  PARENT_ID        VARCHAR2(100) not null,
  PATH             VARCHAR2(1000),
  LAYER            VARCHAR2(200),
  CHILDREN         VARCHAR2(1000),
  CODE             VARCHAR2(100),
  JP               VARCHAR2(40),
  QP               VARCHAR2(40),
  CREATINGTIME     DATE,
  CREATOR          VARCHAR2(100),
  ORGNUMBER        VARCHAR2(100),
  ORGDESC          VARCHAR2(300),
  REMARK1          VARCHAR2(100),
  REMARK2          VARCHAR2(100),
  REMARK3          VARCHAR2(100),
  REMARK4          VARCHAR2(100),
  REMARK5          VARCHAR2(100),
  CHARGEORGID      VARCHAR2(50),
  ISPARTYBUSSINESS NUMBER(1) default 1,
  SATRAPJOBID      VARCHAR2(50),
  ORG_LEVEL        VARCHAR2(1) default '1',
  ORG_XZQM         VARCHAR2(10)
)
;
-- Add comments to the columns 
comment on column TD_SM_ORGANIZATION.ORG_ID
  is '机构ID';
comment on column TD_SM_ORGANIZATION.ORG_SN
  is '机构排序ID';
comment on column TD_SM_ORGANIZATION.ORG_NAME
  is '机构名称';
comment on column TD_SM_ORGANIZATION.PARENT_ID
  is '父机构ID';
comment on column TD_SM_ORGANIZATION.PATH
  is '路径';
comment on column TD_SM_ORGANIZATION.LAYER
  is '层（阶次）';
comment on column TD_SM_ORGANIZATION.CHILDREN
  is '子机构';
comment on column TD_SM_ORGANIZATION.CODE
  is '机构代号';
comment on column TD_SM_ORGANIZATION.JP
  is '简拼';
comment on column TD_SM_ORGANIZATION.QP
  is '全拼';
comment on column TD_SM_ORGANIZATION.CREATINGTIME
  is '创建时间';
comment on column TD_SM_ORGANIZATION.CREATOR
  is '创建人';
comment on column TD_SM_ORGANIZATION.ORGNUMBER
  is '机构编号';
comment on column TD_SM_ORGANIZATION.ORGDESC
  is '机构描述';
comment on column TD_SM_ORGANIZATION.REMARK1
  is '备用字段1';
comment on column TD_SM_ORGANIZATION.REMARK2
  is '备用字段2';
comment on column TD_SM_ORGANIZATION.REMARK3
  is '机构类型
';
comment on column TD_SM_ORGANIZATION.REMARK4
  is '备用字段4';
comment on column TD_SM_ORGANIZATION.REMARK5
  is '机构显现名称';
comment on column TD_SM_ORGANIZATION.CHARGEORGID
  is '主管机构';
comment on column TD_SM_ORGANIZATION.ISPARTYBUSSINESS
  is '表示机构是否是业务部门 0-是 1-不是 默认为1';
comment on column TD_SM_ORGANIZATION.SATRAPJOBID
  is '主管岗位';
comment on column TD_SM_ORGANIZATION.ORG_LEVEL
  is '机构行政级别，0:科室，1：省级，2：市州级，3：县区级，4：科所级';
comment on column TD_SM_ORGANIZATION.ORG_XZQM
  is '行政区码';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_ORGANIZATION
  add constraint PK_TD_SM_ORG primary key (ORG_ID)
  ;
  
  
  -- Create table
create table TD_SM_USER
(
  USER_ID         NUMBER not null,
  USER_SN         NUMBER not null,
  USER_NAME       VARCHAR2(200) not null,
  USER_PASSWORD   VARCHAR2(40) not null,
  USER_REALNAME   VARCHAR2(100) not null,
  USER_PINYIN     VARCHAR2(100),
  USER_SEX        VARCHAR2(100),
  USER_HOMETEL    VARCHAR2(100),
  USER_WORKTEL    VARCHAR2(100),
  USER_WORKNUMBER VARCHAR2(100),
  USER_MOBILETEL1 VARCHAR2(100),
  USER_MOBILETEL2 VARCHAR2(100),
  USER_FAX        VARCHAR2(100),
  USER_OICQ       VARCHAR2(100),
  USER_BIRTHDAY   DATE,
  USER_EMAIL      VARCHAR2(100),
  USER_ADDRESS    VARCHAR2(200),
  USER_POSTALCODE VARCHAR2(10),
  USER_IDCARD     VARCHAR2(50),
  USER_ISVALID    NUMBER,
  USER_REGDATE    DATE,
  USER_LOGINCOUNT NUMBER,
  USER_TYPE       VARCHAR2(100),
  REMARK1         VARCHAR2(100),
  REMARK2         VARCHAR2(100),
  REMARK3         VARCHAR2(100),
  REMARK4         VARCHAR2(100),
  REMARK5         VARCHAR2(100),
  PAST_TIME       DATE,
  DREDGE_TIME     VARCHAR2(50),
  LASTLOGIN_DATE  DATE,
  WORKLENGTH      VARCHAR2(50),
  POLITICS        VARCHAR2(100),
  ISTAXMANAGER    NUMBER(1)
)
;
-- Add comments to the columns 
comment on column TD_SM_USER.USER_ID
  is '用户ID';
comment on column TD_SM_USER.USER_SN
  is '用户排序号';
comment on column TD_SM_USER.USER_NAME
  is '用户帐号';
comment on column TD_SM_USER.USER_PASSWORD
  is '用户密码';
comment on column TD_SM_USER.USER_REALNAME
  is '用户实名';
comment on column TD_SM_USER.USER_PINYIN
  is '拼音';
comment on column TD_SM_USER.USER_SEX
  is '性别';
comment on column TD_SM_USER.USER_HOMETEL
  is '家庭电话';
comment on column TD_SM_USER.USER_WORKTEL
  is '公司电话';
comment on column TD_SM_USER.USER_WORKNUMBER
  is '公司地址';
comment on column TD_SM_USER.USER_MOBILETEL1
  is '手机1';
comment on column TD_SM_USER.USER_MOBILETEL2
  is '手机2';
comment on column TD_SM_USER.USER_FAX
  is '传真';
comment on column TD_SM_USER.USER_OICQ
  is 'OICQ';
comment on column TD_SM_USER.USER_BIRTHDAY
  is '生日';
comment on column TD_SM_USER.USER_EMAIL
  is '邮箱';
comment on column TD_SM_USER.USER_ADDRESS
  is '住址';
comment on column TD_SM_USER.USER_POSTALCODE
  is '邮编';
comment on column TD_SM_USER.USER_IDCARD
  is '身份证';
comment on column TD_SM_USER.USER_ISVALID
  is '是否使用';
comment on column TD_SM_USER.USER_REGDATE
  is '注册日期';
comment on column TD_SM_USER.USER_LOGINCOUNT
  is '登陆次数';
comment on column TD_SM_USER.USER_TYPE
  is '用户类型';
comment on column TD_SM_USER.REMARK1
  is '设置是否保密 若是,则各项信息显示***若否 则显示信息';
comment on column TD_SM_USER.REMARK2
  is '备用字段2';
comment on column TD_SM_USER.REMARK3
  is '备用字段3';
comment on column TD_SM_USER.REMARK4
  is '备用字段4';
comment on column TD_SM_USER.REMARK5
  is '备用字段5';
comment on column TD_SM_USER.PAST_TIME
  is '过期时间';
comment on column TD_SM_USER.DREDGE_TIME
  is '开通时间';
comment on column TD_SM_USER.LASTLOGIN_DATE
  is '用户最后登陆时间';
comment on column TD_SM_USER.ISTAXMANAGER
  is '是否税管员';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_USER
  add constraint PK_TD_SM_USER primary key (USER_ID)
  ;
-- Create/Recreate indexes 
create unique index IDX_TD_SM_USER_UNAME on TD_SM_USER (USER_NAME)
 ;
  
-- Create table
create table TD_SM_ORGMANAGER
(
  USER_ID NUMBER not null,
  ORG_ID  VARCHAR2(50) not null
)
;
-- Add comments to the table 
comment on table TD_SM_ORGMANAGER
  is '用户机构管理员表';
-- Add comments to the columns 
comment on column TD_SM_ORGMANAGER.USER_ID
  is '机构管理员id';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_ORGMANAGER
  add constraint PK_TD_SM_ORGMANAGER primary key (USER_ID, ORG_ID)
  ;
alter table TD_SM_ORGMANAGER
  add constraint FK_TD_SM_MGRORG foreign key (ORG_ID)
  references TD_SM_ORGANIZATION (ORG_ID);
alter table TD_SM_ORGMANAGER
  add constraint FK_TD_SM_ORGMGRUS foreign key (USER_ID)
  references TD_SM_USER (USER_ID);
  
  
  
  
  -- Create table
create table TD_SM_ROLETYPE
(
  TYPE_NAME VARCHAR2(100),
  TYPE_DESC VARCHAR2(500),
  TYPE_ID   NUMBER not null
)
;
-- Add comments to the table 
comment on table TD_SM_ROLETYPE
  is '角色类型信息表';
-- Add comments to the columns 
comment on column TD_SM_ROLETYPE.TYPE_NAME
  is '角色类型名称';
comment on column TD_SM_ROLETYPE.TYPE_DESC
  is '角色类型描述';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_ROLETYPE
  add constraint ROLE_TYPE_PK primary key (TYPE_ID)
  ;


-- Create table
create table TD_SM_ROLE
(
  ROLE_ID    VARCHAR2(50) not null,
  ROLE_NAME  VARCHAR2(100) not null,
  ROLE_TYPE  VARCHAR2(100),
  ROLE_DESC  VARCHAR2(1024),
  ROLE_USAGE VARCHAR2(1),
  REMARK1    VARCHAR2(100),
  REMARK2    VARCHAR2(100),
  REMARK3    VARCHAR2(100),
  OWNER_ID   NUMBER default 1
)
;
-- Add comments to the columns 
comment on column TD_SM_ROLE.ROLE_TYPE
  is '角色类型';
comment on column TD_SM_ROLE.OWNER_ID
  is '创建人id，默认维系统管理员';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_ROLE
  add constraint PK_TD_SM_ROLE primary key (ROLE_ID)
  ;
  
  
  -- Create table
create table TD_SM_JOB
(
  JOB_ID        VARCHAR2(50) not null,
  JOB_NAME      VARCHAR2(100),
  JOB_DESC      VARCHAR2(200),
  JOB_FUNCTION  VARCHAR2(200),
  JOB_AMOUNT    VARCHAR2(100),
  JOB_NUMBER    VARCHAR2(100),
  JOB_CONDITION VARCHAR2(200),
  JOB_RANK      VARCHAR2(100),
  OWNER_ID      NUMBER default 1
)
;
-- Add comments to the columns 
comment on column TD_SM_JOB.JOB_ID
  is '岗位ID';
comment on column TD_SM_JOB.JOB_NAME
  is '岗位名称';
comment on column TD_SM_JOB.JOB_DESC
  is '岗位描述';
comment on column TD_SM_JOB.JOB_FUNCTION
  is '岗位职责';
comment on column TD_SM_JOB.JOB_AMOUNT
  is '岗位编制人数';
comment on column TD_SM_JOB.JOB_NUMBER
  is '岗位编号';
comment on column TD_SM_JOB.JOB_CONDITION
  is '任职条件';
comment on column TD_SM_JOB.JOB_RANK
  is '岗位级别';
comment on column TD_SM_JOB.OWNER_ID
  is '创建人id，默认维系统管理员';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_JOB
  add constraint PK_TD_SM_JOB primary key (JOB_ID)
  ;
  
  
  -- Create table
create table TD_SM_GROUP
(
  GROUP_ID   INTEGER not null,
  GROUP_NAME VARCHAR2(100),
  GROUP_DESC VARCHAR2(100),
  REMARK1    VARCHAR2(100),
  REMARK2    VARCHAR2(100),
  REMARK3    VARCHAR2(100),
  REMARK4    VARCHAR2(100),
  REMARK5    VARCHAR2(100),
  PARENT_ID  INTEGER,
  OWNER_ID   NUMBER default 1
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_GROUP
  add constraint PK_TD_SM_GROUP primary key (GROUP_ID)
  ;
  
  
  -- Create table
create table TD_SM_LOGMODULE
(
  LOGMODULE   VARCHAR2(50),
  STATUS      NUMBER,
  MODULE_DESC VARCHAR2(50),
  ID          VARCHAR2(50) not null
)
;
-- Add comments to the columns 
comment on column TD_SM_LOGMODULE.LOGMODULE
  is '日志模块类型';
comment on column TD_SM_LOGMODULE.STATUS
  is '记录日志状态';
comment on column TD_SM_LOGMODULE.MODULE_DESC
  is '日志模块描述';
comment on column TD_SM_LOGMODULE.ID
  is '日志模块ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_LOGMODULE
  add constraint LOGMODULE_ID primary key (ID)
  ;


 -- Create table
create table TD_SM_LOG
(
  LOG_ID         INTEGER not null,
  LOG_OPERUSER   VARCHAR2(100),
  LOG_OPER       VARCHAR2(200),
  LOG_VISITORIAL VARCHAR2(200),
  LOG_OPERTIME   DATE,
  LOG_TYPE       VARCHAR2(4000),
  REMARK1        VARCHAR2(100),
  REMARK2        VARCHAR2(100),
  REMARK3        VARCHAR2(100)
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_LOG
  add constraint PK_TD_SM_LOG primary key (LOG_ID)
  ;
  
  
  -- Create table
create table TD_SM_RES
(
  RES_ID     VARCHAR2(50) not null,
  RESTYPE_ID VARCHAR2(50),
  TITLE      VARCHAR2(500),
  ROLE_USAGE VARCHAR2(1),
  PARENT_ID  VARCHAR2(50),
  PATH       VARCHAR2(1000),
  MARKER     VARCHAR2(200),
  RESERVED1  VARCHAR2(200),
  RESERVED3  VARCHAR2(200),
  RESERVED4  VARCHAR2(200),
  RESERVED5  VARCHAR2(200),
  ATTR1      VARCHAR2(200),
  ATTR2      VARCHAR2(200),
  ATTR3      VARCHAR2(200),
  ATTR4      VARCHAR2(200),
  ATTR5      VARCHAR2(200),
  ATTR6      VARCHAR2(200),
  ATTR7      VARCHAR2(200),
  ATTR8      VARCHAR2(200),
  ATTR9      VARCHAR2(200),
  ATTR10     VARCHAR2(200),
  ATTR11     VARCHAR2(200),
  ATTR12     VARCHAR2(200),
  ATTR13     VARCHAR2(200),
  ATTR14     VARCHAR2(200),
  ATTR15     VARCHAR2(200),
  ATTR16     VARCHAR2(200),
  ATTR17     VARCHAR2(200),
  ATTR18     VARCHAR2(200),
  ATTR19     VARCHAR2(200),
  ATTR20     VARCHAR2(200),
  ATTR21     VARCHAR2(200),
  ATTR22     VARCHAR2(200),
  ATTR23     VARCHAR2(200),
  ATTR24     VARCHAR2(200),
  ATTR25     VARCHAR2(200),
  ATTR26     VARCHAR2(200),
  ATTR27     VARCHAR2(1000)
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_RES
  add constraint PK_TD_SM_RES primary key (RES_ID)
  ;
-- Create/Recreate indexes 
create index IDX_RES_ID on TD_SM_RES (RESTYPE_ID)
  ;
  
  
  -- Create table
create table TD_SM_GROUPROLE
(
  GROUP_ID            INTEGER not null,
  ROLE_ID             VARCHAR2(50) not null,
  RESOP_ORIGIN_USERID VARCHAR2(50) default '1'
)
;
-- Add comments to the columns 
comment on column TD_SM_GROUPROLE.RESOP_ORIGIN_USERID
  is '授予角色的用户';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_GROUPROLE
  add constraint PK_TD_SM_GROUPROLE primary key (GROUP_ID, ROLE_ID)
  ;
alter table TD_SM_GROUPROLE
  add constraint FK_GROUP_ROLE foreign key (ROLE_ID)
  references TD_SM_ROLE (ROLE_ID);
-- Create/Recreate indexes 
create index IDX_GROUPROLE_GID on TD_SM_GROUPROLE (GROUP_ID)
  ;
create index IDX_GROUPROLE_RID on TD_SM_GROUPROLE (ROLE_ID)
  ;
  
  
  -- Create table
create table TD_SM_USERROLE
(
  USER_ID             INTEGER not null,
  ROLE_ID             VARCHAR2(50) not null,
  RESOP_ORIGIN_USERID VARCHAR2(50) default '1'
)
;
-- Add comments to the columns 
comment on column TD_SM_USERROLE.RESOP_ORIGIN_USERID
  is '授予角色的用户';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_USERROLE
  add constraint PK_TD_SM_USERROLE primary key (USER_ID, ROLE_ID)
  ;
alter table TD_SM_USERROLE
  add constraint FK_USER_ROLE foreign key (ROLE_ID)
  references TD_SM_ROLE (ROLE_ID);
alter table TD_SM_USERROLE
  add constraint FK_USERROLE_UID foreign key (USER_ID)
  references TD_SM_USER (USER_ID);
-- Create/Recreate indexes 
create index IDX_USERROLE_UID on TD_SM_USERROLE (USER_ID)
 ;
create index IDX_USERROLE_RID on TD_SM_USERROLE (ROLE_ID)
  ;
  
  
  
  -- Create table
create table TD_SM_USERGROUP
(
  GROUP_ID INTEGER not null,
  USER_ID  INTEGER not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_USERGROUP
  add constraint PK_TD_SM_USERGROUP primary key (GROUP_ID, USER_ID)
 ;
-- Create/Recreate indexes 
create index IDX_USERGRP_GID on TD_SM_USERGROUP (GROUP_ID)
  ;
create index IDX_USERGRP_UID on TD_SM_USERGROUP (USER_ID)
  ;
  
  
  
  -- Create table
create table TD_SM_ORGUSER
(
  ORG_ID  VARCHAR2(50) not null,
  USER_ID INTEGER not null
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_ORGUSER
  add constraint PK_TD_SM_ORGUSER1 primary key (USER_ID)
 ;
alter table TD_SM_ORGUSER
  add constraint FK_TD_SM_ORGUSER1 foreign key (ORG_ID)
  references TD_SM_ORGANIZATION (ORG_ID);
alter table TD_SM_ORGUSER
  add constraint FK_TD_SM_ORGUSER2 foreign key (USER_ID)
  references TD_SM_USER (USER_ID);
  
  
  -- Create table
create table TD_SM_ORGROLE
(
  ORG_ID              VARCHAR2(50) not null,
  ROLE_ID             VARCHAR2(50) not null,
  RESOP_ORIGIN_USERID VARCHAR2(50) default '1'
)
;
-- Add comments to the columns 
comment on column TD_SM_ORGROLE.RESOP_ORIGIN_USERID
  is '授予角色的用户';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_ORGROLE
  add constraint PK_TD_SM_ORGROLE primary key (ORG_ID, ROLE_ID)
  ;
alter table TD_SM_ORGROLE
  add constraint FK_ORGROLE_ROLE foreign key (ROLE_ID)
  references TD_SM_ROLE (ROLE_ID);
-- Create/Recreate indexes 
create index IDX_ORGROLE_ORGID on TD_SM_ORGROLE (ORG_ID)
  ;
create index IDX_ORGROLE_ROLEID on TD_SM_ORGROLE (ROLE_ID)
  ;
  
  
  -- Create table
create table TD_SM_ORGJOB
(
  ORG_ID VARCHAR2(50) not null,
  JOB_ID VARCHAR2(50) not null,
  JOB_SN INTEGER
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_ORGJOB
  add constraint PK_TD_SM_ORGJOB primary key (ORG_ID, JOB_ID)
  ;
alter table TD_SM_ORGJOB
  add constraint FK_ORGJOB_JOBID foreign key (JOB_ID)
  references TD_SM_JOB (JOB_ID);
-- Create/Recreate indexes 
create index IDX_ORGJOB_ORGID on TD_SM_ORGJOB (ORG_ID)
  ;
create index IDX_ORGJOB_JOBID on TD_SM_ORGJOB (JOB_ID)
  ;
  
  
  -- Create table
create table TD_SM_USERJOBORG
(
  USER_ID          INTEGER not null,
  JOB_ID           VARCHAR2(50) not null,
  ORG_ID           VARCHAR2(50) not null,
  SAME_JOB_USER_SN INTEGER,
  JOB_SN           INTEGER,
  JOB_STARTTIME    DATE,
  JOB_FETTLE       INTEGER
)
;
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_USERJOBORG
  add constraint PK_TD_SM_USERJOBORG primary key (USER_ID, JOB_ID, ORG_ID)
  ;
alter table TD_SM_USERJOBORG
  add constraint FK_USERJOBORG_JID foreign key (JOB_ID)
  references TD_SM_JOB (JOB_ID);
-- Create/Recreate indexes 
create index IDX_USERJOBORG_UID on TD_SM_USERJOBORG (USER_ID)
  ;
create index IDX_USERJOBORG_JID on TD_SM_USERJOBORG (JOB_ID)
  ;
create index IDX_USERJOBORG_OID on TD_SM_USERJOBORG (ORG_ID)
  ;
  
  
  
  -- Create table
create table TD_SM_USERJOBORG_HISTORY
(
  USER_ID       INTEGER not null,
  JOB_ID        VARCHAR2(50) not null,
  ORG_ID        VARCHAR2(50) not null,
  JOB_STARTTIME DATE,
  JOB_QUASHTIME DATE,
  JOB_FETTLE    INTEGER
)
;



-- Create table
create table TD_SM_ORGJOBROLE
(
  ORG_ID              VARCHAR2(50) not null,
  JOB_ID              VARCHAR2(50) not null,
  ROLE_ID             VARCHAR2(50) not null,
  RESOP_ORIGIN_USERID VARCHAR2(50) default '1'
)
;
-- Add comments to the table 
comment on table TD_SM_ORGJOBROLE
  is '存放为机构岗位设置的角色信息';
-- Add comments to the columns 
comment on column TD_SM_ORGJOBROLE.ORG_ID
  is '机构id，与机构表外键关联';
comment on column TD_SM_ORGJOBROLE.JOB_ID
  is '岗位id，与岗位表主键关联';
comment on column TD_SM_ORGJOBROLE.ROLE_ID
  is '角色id，与角色表主键关联';
comment on column TD_SM_ORGJOBROLE.RESOP_ORIGIN_USERID
  is '授予角色的用户';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_ORGJOBROLE
  add constraint ORG_JOB_ROLE_RELATION primary key (ORG_ID, JOB_ID, ROLE_ID)
  ;
alter table TD_SM_ORGJOBROLE
  add constraint F_JOB_ROLE_ORG foreign key (JOB_ID)
  references TD_SM_JOB (JOB_ID);
alter table TD_SM_ORGJOBROLE
  add constraint F_ORG_JOB_ROLE foreign key (ORG_ID)
  references TD_SM_ORGANIZATION (ORG_ID);
alter table TD_SM_ORGJOBROLE
  add constraint F_ROLE_ORG_JOB foreign key (ROLE_ID)
  references TD_SM_ROLE (ROLE_ID);
  
  
  -- Create table
create table TD_SM_ROLERESOP
(
  OP_ID               VARCHAR2(50) not null,
  RES_ID              VARCHAR2(100) not null,
  ROLE_ID             VARCHAR2(50) not null,
  RESTYPE_ID          VARCHAR2(50) not null,
  AUTO                VARCHAR2(50),
  RES_NAME            VARCHAR2(500),
  TYPES               VARCHAR2(50) not null,
  AUTHORIZATION_TYPE  NUMBER default 0,
  USE_COUNT           NUMBER,
  AUTHORIZATION_STIME DATE,
  AUTHORIZATION_ETIME DATE,
  USE_COUNTED         NUMBER
)
;
-- Add comments to the columns 
comment on column TD_SM_ROLERESOP.OP_ID
  is '操作ID';
comment on column TD_SM_ROLERESOP.RES_ID
  is '资源ID';
comment on column TD_SM_ROLERESOP.ROLE_ID
  is '角色ID';
comment on column TD_SM_ROLERESOP.RESTYPE_ID
  is '资源类型ID';
comment on column TD_SM_ROLERESOP.AUTO
  is '标识资源维护方式，0自动维护，1手动维护';
comment on column TD_SM_ROLERESOP.RES_NAME
  is '资源名称';
comment on column TD_SM_ROLERESOP.TYPES
  is '资源分类（是角色资源还是用户资源）';
comment on column TD_SM_ROLERESOP.AUTHORIZATION_TYPE
  is '授权的方式:0:永久授权,1:计数授权,2:时效授权';
comment on column TD_SM_ROLERESOP.USE_COUNT
  is '授权可使用次数';
comment on column TD_SM_ROLERESOP.AUTHORIZATION_STIME
  is '授权使用开始时间';
comment on column TD_SM_ROLERESOP.AUTHORIZATION_ETIME
  is '授权使用结束时间';
comment on column TD_SM_ROLERESOP.USE_COUNTED
  is '权限已使用次数';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_ROLERESOP
  add constraint PK_TD_SM_ROLERESOP primary key (OP_ID, RES_ID, ROLE_ID, RESTYPE_ID, TYPES)
  ;
-- Create/Recreate check constraints 
alter table TD_SM_ROLERESOP
  add constraint ROLE_ID_NUMCHECK
  check (to_number(role_id)  > 0);
  
  
  -- Create table
create table TD_SM_PERMISSION_ORIGINE
(
  ORIGINE_TYPE VARCHAR2(50) not null,
  ORIGINE_ID   VARCHAR2(20) not null,
  OP_ID        VARCHAR2(50) not null,
  RES_ID       VARCHAR2(100) not null,
  ROLE_ID      VARCHAR2(50) not null,
  RESTYPE_ID   VARCHAR2(50) not null,
  TYPES        VARCHAR2(50) not null
)
;
-- Add comments to the table 
comment on table TD_SM_PERMISSION_ORIGINE
  is 'TD_SM_PERMISSION_ORIGINE信息维护：
授权时，首先反查授权人操作的权限的来源，分以下几种：
是不是授权人本身的资源，如果是将来源信息存入本表
是不是授权人所属机构的资源，如果是将来源信息存入本表
是不是授权人拥有的角色的资源，如果是将多个角色信息条记录存入本表

取消授权时，到本表中检查被授权人是否将该权限授予其他用户，如果授予则需要取消由被授权人授予该用户的权限，如此递归执行，是否取消权限还需判断被授权人在本表中还有通过其他渠道获得该权限，如果没有则删除权限表中的该条记录，同时删除本表中的相关权限来源信息';
-- Add comments to the columns 
comment on column TD_SM_PERMISSION_ORIGINE.ORIGINE_TYPE
  is '权限来源类型：
user,role,organization';
comment on column TD_SM_PERMISSION_ORIGINE.ORIGINE_ID
  is '权限来源角色id，根据角色类型确定为：
用户id，角色id，机构id';
comment on column TD_SM_PERMISSION_ORIGINE.OP_ID
  is '操作ID';
comment on column TD_SM_PERMISSION_ORIGINE.RES_ID
  is '资源ID';
comment on column TD_SM_PERMISSION_ORIGINE.ROLE_ID
  is '角色ID';
comment on column TD_SM_PERMISSION_ORIGINE.RESTYPE_ID
  is '资源类型ID';
comment on column TD_SM_PERMISSION_ORIGINE.TYPES
  is '资源分类（是角色资源还是用户资源）';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_PERMISSION_ORIGINE
  add constraint PK_PERM_ORIGINE primary key (ORIGINE_TYPE, ORIGINE_ID, OP_ID, RES_ID, ROLE_ID, RESTYPE_ID, TYPES)
  ;
  
  
  --------系统管理字典管理表开始---------
  
  -- Create table
create table TB_SM_INPUTTYPE
(
  INPUT_TYPE_ID   NUMBER(5) not null,
  INPUT_TYPE_DESC VARCHAR2(200),
  DATASOURCE_PATH VARCHAR2(200),
  INPUT_TYPE_NAME VARCHAR2(200) not null,
  SCRIPT          VARCHAR2(4000)
)
;
-- Add comments to the table 
comment on table TB_SM_INPUTTYPE
  is '字典数据项输入类型';
-- Add comments to the columns 
comment on column TB_SM_INPUTTYPE.DATASOURCE_PATH
  is '数据源选择界面';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TB_SM_INPUTTYPE
  add constraint PK_TB_SM_INPUTTYPE primary key (INPUT_TYPE_ID)
  ;

-- Create table
create table TD_SM_DICTTYPE
(
  DATA_VALIDATE_FIELD     VARCHAR2(50),
  DATA_CREATE_ORGID_FIELD VARCHAR2(50),
  DICTTYPE_TYPE           NUMBER(2),
  IS_TREE                 NUMBER(1) default 0,
  DICTTYPE_ID             VARCHAR2(50) not null,
  USER_ID                 NUMBER,
  DICTTYPE_NAME           VARCHAR2(100),
  DICTTYPE_DESC           VARCHAR2(100),
  DICTTYPE_PARENT         VARCHAR2(50),
  DATA_TABLE_NAME         VARCHAR2(50),
  DATA_NAME_FILED         VARCHAR2(50),
  DATA_VALUE_FIELD        VARCHAR2(50),
  DATA_ORDER_FIELD        VARCHAR2(50),
  DATA_TYPEID_FIELD       VARCHAR2(50),
  DATA_DBNAME             VARCHAR2(50),
  DATA_PARENTID_FIELD     VARCHAR2(50),
  DATA_NAME_CN            VARCHAR2(100) default '名称',
  DATA_VALUE_CN           VARCHAR2(100) default '真实值',
  KEY_GENERAL_TYPE        NUMBER(2)
)
;
-- Add comments to the columns 
comment on column TD_SM_DICTTYPE.DICTTYPE_TYPE
  is '0:基础字典类型;1:无权限业务字典2:带权限业务字典';
comment on column TD_SM_DICTTYPE.IS_TREE
  is '判断字典数据项是树状的还是列表型的数据项
0-列表类型，缺省值
1-树状结构，必须指定DATA_PARENT_FIELD字段';
comment on column TD_SM_DICTTYPE.DICTTYPE_ID
  is '字典类型ID';
comment on column TD_SM_DICTTYPE.USER_ID
  is '用户ID';
comment on column TD_SM_DICTTYPE.DICTTYPE_NAME
  is '字典类型名称';
comment on column TD_SM_DICTTYPE.DICTTYPE_DESC
  is '字典类型描述';
comment on column TD_SM_DICTTYPE.DATA_TABLE_NAME
  is '字典数据存放表名，缺省为td_sm_dictdata';
comment on column TD_SM_DICTTYPE.DATA_NAME_FILED
  is '字典数据名称存放字段，缺省为DICTDATA_NAME';
comment on column TD_SM_DICTTYPE.DATA_VALUE_FIELD
  is '字典数据值存放字段，缺省值为DICTDATA_value';
comment on column TD_SM_DICTTYPE.DATA_ORDER_FIELD
  is '字典数据排序字段，缺省值为DICTDATA_ORDER';
comment on column TD_SM_DICTTYPE.DATA_DBNAME
  is '字典表对应的数据库';
comment on column TD_SM_DICTTYPE.DATA_PARENTID_FIELD
  is '树状结构数据字典中每个数据项对应的父节点字段名称';
comment on column TD_SM_DICTTYPE.DATA_NAME_CN
  is '字典名称字段采集时的中文名称';
comment on column TD_SM_DICTTYPE.DATA_VALUE_CN
  is '值字段采集时的中文名称';
comment on column TD_SM_DICTTYPE.KEY_GENERAL_TYPE
  is '0:手工录入;1:自动生成 tableinfo表';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_DICTTYPE
  add constraint PK_TD_SM_DICTTYPE primary key (DICTTYPE_ID)
  ;
alter table TD_SM_DICTTYPE
  add constraint FK_DICTTYPE_UID foreign key (USER_ID)
  references TD_SM_USER (USER_ID);

-- 2009.4.21 minghua.guo add  
alter table TD_SM_DICTTYPE 
  add ENABLE_VALUE_MODIFY NUMBER(1) default 0;
comment on column TD_SM_DICTTYPE.ENABLE_VALUE_MODIFY 
  is '是否允许修改字典的值字段的值 0-不允许，默认值 1-可以修改 ';
  
  -- Create table
create table TD_SM_DICTDATA
(
  DICTDATA_ID    VARCHAR2(50) not null,
  DICTTYPE_ID    VARCHAR2(50),
  DICTDATA_NAME  VARCHAR2(100),
  DICTDATA_VALUE VARCHAR2(100),
  DICTDATA_ORDER NUMBER(10) default 0
)
;
-- Add comments to the columns 
comment on column TD_SM_DICTDATA.DICTDATA_ID
  is '字典ID';
comment on column TD_SM_DICTDATA.DICTTYPE_ID
  is '字典类型ID';
comment on column TD_SM_DICTDATA.DICTDATA_NAME
  is '字典名称';
comment on column TD_SM_DICTDATA.DICTDATA_VALUE
  is '字典的值';
comment on column TD_SM_DICTDATA.DICTDATA_ORDER
  is '字典排序数据字段，缺省值为0';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_DICTDATA
  add constraint PK_TD_SM_DICTDATA primary key (DICTDATA_ID)
  ;
alter table TD_SM_DICTDATA
  add constraint FK_TD_TYPE_DATA foreign key (DICTTYPE_ID)
  references TD_SM_DICTTYPE (DICTTYPE_ID);
  
  
  -- Create table
create table TD_SM_DICATTACHFIELD
(
  DICTTYPE_ID   VARCHAR2(50),
  FIELD_NAME    VARCHAR2(50),
  LABEL         VARCHAR2(100),
  INPUT_TYPE_ID NUMBER(5),
  TABLE_COLUMN  VARCHAR2(50),
  ISNULLABLE    NUMBER(1),
  DATEFORMAT    VARCHAR2(50),
  ISUNIQUE      NUMBER(1),
  SN            NUMBER(5) default 1
)
;
-- Add comments to the columns 
comment on column TD_SM_DICATTACHFIELD.DICTTYPE_ID
  is '字典类型ID';
comment on column TD_SM_DICATTACHFIELD.FIELD_NAME
  is '存放数据库字段,以及对应的输入类型的附加信息
当输入类型: 主键生成, 选择字典 都需要维护这个字段
filedName:'''':''''';
comment on column TD_SM_DICATTACHFIELD.TABLE_COLUMN
  is '字典字段对应数据库表';
comment on column TD_SM_DICATTACHFIELD.ISNULLABLE
  is '字段是否必填
0:不是必填
1:必填';
comment on column TD_SM_DICATTACHFIELD.DATEFORMAT
  is '日期类型字段';
comment on column TD_SM_DICATTACHFIELD.ISUNIQUE
  is '字段的值是否唯一性保证  1-唯一,字典维护时需要进行唯一性检测  0-可重复，缺省值';
comment on column TD_SM_DICATTACHFIELD.SN
  is '高级字段排序';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_DICATTACHFIELD
  add constraint FK_FIELD_TYPE foreign key (INPUT_TYPE_ID)
  references TB_SM_INPUTTYPE (INPUT_TYPE_ID);
alter table TD_SM_DICATTACHFIELD
  add constraint FK_TD_SM_DI_REFERE foreign key (DICTTYPE_ID)
  references TD_SM_DICTTYPE (DICTTYPE_ID);
  
 
  --------系统管理字典管理表结束---------
  

--------消息资源表开始------------

-- Create table
create table TD_MSG_RESOURCE
(
  R_ID       NUMBER,
  R_NAME     VARCHAR2(50),
  R_DESC     VARCHAR2(50),
  R_MSG_TYPE VARCHAR2(128)
);
-- Add comments to the table 
comment on table TD_MSG_RESOURCE
  is '消息资源表';
-- Add comments to the columns 
comment on column TD_MSG_RESOURCE.R_ID
  is '流水号';
comment on column TD_MSG_RESOURCE.R_NAME
  is '资源名称';
comment on column TD_MSG_RESOURCE.R_DESC
  is '资源描述';
comment on column TD_MSG_RESOURCE.R_MSG_TYPE
  is '消息类型';
  
--------消息资源表结束------------

--------用户与消息资源映射表开始------------

-- Create table
create table TD_USER_MSG_RESOURCE
(
  USER_ID    NUMBER,
  R_ID       NUMBER,
  R_MSG_TYPE VARCHAR2(128)
);
-- Add comments to the table 
comment on table TD_USER_MSG_RESOURCE
  is '用户与消息资源映射表';
-- Add comments to the columns 
comment on column TD_USER_MSG_RESOURCE.USER_ID
  is '用户id';
comment on column TD_USER_MSG_RESOURCE.R_ID
  is '消息资源id';
comment on column TD_USER_MSG_RESOURCE.R_MSG_TYPE
  is '用户自定义消息类型';

--------用户与消息资源映射表结束------------

---------------菜单快捷方式表开始--------------------

CREATE TABLE TD_SM_SHORTCUTMENU_USER  (
   "USER_ID"            NUMBER,
   "MENU_ID"            VARCHAR2(2000)
);

COMMENT ON TABLE TD_SM_SHORTCUTMENU_USER IS
'应用下用户快捷菜单';

COMMENT ON COLUMN TD_SM_SHORTCUTMENU_USER.USER_ID IS
'用户id';

COMMENT ON COLUMN TD_SM_SHORTCUTMENU_USER.MENU_ID IS
'菜单id';

---------------菜单快捷方式表结束--------------------

 -- added by zhou.luo 20081219
--Create table  文档模板使用授权表 修正后的sql，前面的那个不要用
/*==============================================================*/
/* Table: TD_OCTL_TEMPLATE_GRANT                                */
/*==============================================================*/
CREATE TABLE TD_OCTL_TEMPLATE_GRANT  (
   RECORDID             VARCHAR2(16),
   USER_ID              NUMBER,
   USER_REALNAME        VARCHAR2(100)
);

COMMENT ON TABLE TD_OCTL_TEMPLATE_GRANT IS
'文档模板使用授权表';

COMMENT ON COLUMN TD_OCTL_TEMPLATE_GRANT.RECORDID IS
'模板编号';

COMMENT ON COLUMN TD_OCTL_TEMPLATE_GRANT.USER_ID IS
'用户ID';

COMMENT ON COLUMN TD_OCTL_TEMPLATE_GRANT.USER_REALNAME IS
'用户实名';
  

alter table TD_OCTL_TEMPLATE_FILE add (record_sn  number(10));
comment on column TD_OCTL_TEMPLATE_FILE.record_sn is '模板排序号';

alter table td_octl_template_grant add(granttype varchar2(20),role_id varchar2(50),role_name varchar2(100));
comment on column td_octl_template_grant.granttype is '授权类型： user,按用户授权；role,按角色授权';
comment on column td_octl_template_grant.role_id is '角色id';
comment on column td_octl_template_grant.role_name is '角色名称';

---------------系统管理用到的表结束------------------


---------------系统管理数据初始化开始--------------------


-----------------用户初始化开始------------------
INSERT INTO TD_SM_USER ("USER_ID" ,"USER_SN" ,"USER_NAME" ,"USER_PASSWORD" ,"USER_REALNAME","USER_ISVALID","USER_TYPE","USER_SEX" )  
VALUES (1 ,1 ,'admin' ,'123456' ,'系统管理员','2','0','M'  );
commit;
-----------------用户初始化结束------------------


-----------------角色初始化开始------------------
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) 
 VALUES ('1' ,'administrator' ,'1' ,'超级管理员角色，此角色不要修改' ,'' ,'' ,'' ,''  );
 
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) 
 VALUES ('2' ,'roleofeveryone' ,'1' ,'每个用户都缺省拥有的角色，此角色不要修改' ,'' ,'' ,'' ,''  );

INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) 
 VALUES ('3' ,'orgmanager' ,'1' ,'部门管理员角色,此角色不要修改' ,'' ,'' ,'' ,''  );

 INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) 
 VALUES ('4' ,'orgmanagerroletemplate' ,'1' ,'部门管理员角色模板,本角色不能删除，也不能授予普通用户，只能够授权，一旦授了权限后所有的部门管理员都拥有这些权限，部门管理员角色只有超级管理员才能给它授权' ,'' ,'' ,'' ,''  );

INSERT INTO td_sm_roletype ("TYPE_NAME" ,"TYPE_DESC" ,"TYPE_ID" ) 
 VALUES ('通用角色类型' ,'通用角色类型' ,1);

commit;
-----------------角色初始化结束------------------

-----------------资源权限初始化开始------------------

-------------------------机构管理员权限初始化开始------------------------
INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) 
VALUES ('rolemanager', 'globalroleoperation','3' ,'role' ,'0' , '角色资源', 'role' );

INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) 
VALUES ('visible', 'sysmanager','3' ,'column' ,'0' ,'系统管理' ,'role');
-------------------------机构管理员权限初始化结束-------------------------

commit;
-----------------资源权限初始化结束------------------


-----------------用户角色初始化开始------------------
INSERT INTO TD_SM_USERROLE ("USER_ID" ,"ROLE_ID" ) VALUES (1 ,'1'  );
commit;
-----------------用户角色初始化结束------------------


-----------------岗位初始化开始------------------
INSERT INTO TD_SM_JOB ("JOB_ID" ,"JOB_NAME" ,"JOB_DESC" ) VALUES ('1' ,'在职' ,'不能删除' )  ; 
commit;
-----------------岗位初始化结束------------------




-----------------平台tableinfo添加应用的信息初始化开始------------------

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_sm_dictdata', 'dictdata_id', 1, 0, NULL, 'string', NULL); 

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_sm_dicttype', 'dicttype_id', 1, 0, NULL, 'string', NULL); 

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_sm_group', 'group_id', 1, 0, NULL, 'int', NULL); 

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_sm_job', 'job_id', 1, 0, NULL, 'string', NULL); 

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_sm_res', 'res_id', 1, 0, NULL, 'string', NULL); 

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_sm_role', 'role_id', 1, 100, NULL, 'string', NULL); 

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_sm_log', 'log_id', 1, 0, NULL, 'int', NULL); 

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_sm_roletype', 'type_id', 1, 0, NULL, 'int', NULL);

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_sm_logmodule', 'id', 1, 0, NULL, 'string', NULL);

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_MSG_RESOURCE', 'R_ID', 1, 0, NULL, 'int', NULL);

commit; 

-----------------tableinfo初始化结束------------------



-----------------输入类型初始化开始------------------
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(1,'文本类型','','',''); 
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(2,'选择字典','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(3,'选择时间','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(4,'主键生成','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(5,'选择机构','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(6,'选择人员','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(7,'当前用户','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(8,'当前机构','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(9,'当前用户','','','') ;
commit;
-----------------输入类型初始化结束------------------


-----------------字典类型初始化开始------------------
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'9', 'isPublicAffair', '日程管理是否公事', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'6', 'intervalType', '日程管理提醒时间间隔单位', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'2', 'isvalid', '有效否', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'1', 'sex', '性别', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'5', 'orgType', '机构类型', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'4', 'MailPostfix', '邮箱后缀', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'3', 'userType', '用户类型', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'7', 'essentiality', '日程管理重要性', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'8', 'isLeisure', '日程管理是否空闲', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC, 
DICTTYPE_PARENT,DICTTYPE_TYPE) VALUES ( 
'45', 'ispartybussiness', '机构是否业务部门', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT ) VALUES ( 
'2312', '是否字典', '是否字典', '0')
;
commit;
-----------------字典类型初始化结束------------------

-----------------字典数据初始化开始------------------
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 70, '2312', '是', '1','0')
;
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 71 , '2312', '否', '0','1')
;
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'60', '9', '公事', '0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'61', '9', '私事', '1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'62', '6', '分', '0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'63', '6', '小时', '1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'64', '6', '天', '2'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'65', '7', '重要', '0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'66', '7', '一般', '1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'67', '7', '不重要', '2'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'68', '8', '忙', '0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'69', '8', '空闲', '1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'11', '1', '男', 'M'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'12', '1', '女', 'F');
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'124', '2', '删除', '0','3'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'125', '2', '申请', '1','1');   
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'126', '2', '开通', '2','0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'127', '2', '停用', '3','2'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'31', '4', 'kechuang.com', 'kechuang.com'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'32', '4', 'furongwang.com', 'furongwang.com'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'33', '4', 'china.com', 'china.com'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'13', '1', '未知', '-1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'41', '5', '有效', '0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'42', '5', '无效', '1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'51', '3', '外部用户', '1','1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'53', '3', '系统用户', '0','0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME, DICTDATA_VALUE,
DICTDATA_ORDER ) VALUES ( 
'192', '45', '是', '0', 1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME, DICTDATA_VALUE,
DICTDATA_ORDER ) VALUES ( 
'193', '45', '否', '1', 2); 
commit;
-----------------字典数据初始化结束------------------

---------------系统管理数据初始化结束--------------------





------------------------系统管理视图开始-----------------------

create or replace view v_tb_res_org_role as
select roleres.role_id, roleres.res_id as org_id , roleres.op_id,roleres.restype_id, org.parent_id
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id
where roleres.types='role' and roleres.restype_id='orgunit'
;


create or replace view v_tb_res_org_user as
select to_char(allroles.user_id) as user_id,
  orgres_role.org_id as org_id,orgres_role.parent_id as parent_id,
  orgres_role.op_id as op_id,orgres_role.restype_id  as restype_id
from (
--一个用户所有的角色的机构资源
--用户角色
select u_role.user_id, u_role.role_id from td_sm_userrole u_role
union
--用户所在用户组的 角色
select u_group.user_id,g_role.role_id from td_sm_usergroup u_group
join td_sm_grouprole g_role on u_group.group_id=g_role.group_id
union
--用户所属机构的角色
select org_user.user_id,org_role.role_id from td_sm_userjoborg org_user
join td_sm_orgrole org_role on  org_user.org_id=org_role.org_id
union
--用户机构岗位的角色
select u_job.user_id,org_job_role.role_id from td_sm_userjoborg u_job
 inner join td_sm_orgjobrole org_job_role
 on u_job.job_id=org_job_role.job_id and u_job.org_id=org_job_role.org_id
)allroles
--通过角色ID,关联CS资源视图
,
v_tb_res_org_role orgres_role
where  orgres_role.role_id in(allroles.role_id,
    --再加上'普通用户'角色ID
    (select t.role_id from td_sm_role t where t.role_name='roleofeveryone')
)
union
--union 直接分配给用户的资源
select to_char(roleres.role_id) as user_id,  
       roleres.res_id as org_id,
       org.parent_id as parent_id,
       roleres.op_id as op_id,
       roleres.restype_id  as restype_id
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id 
where roleres.types='user' and roleres.restype_id='orgunit'
union
--union 直接分配给用户机构的资源
select to_char(userjoborg.user_id) as user_id,  
       roleres.res_id as org_id,
       org.parent_id as parent_id,
       roleres.op_id as op_id,
       roleres.restype_id  as restype_id
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id
    join td_sm_userjoborg userjoborg on  userjoborg.org_id = roleres.role_id
where roleres.types='organization' and roleres.restype_id='orgunit'
;



create or replace view v_tb_res_role_role as
select roleres.role_id as role_id,roleres.res_id as res_id, roleres.op_id,roleres.restype_id
    from td_sm_roleresop roleres
    join td_sm_role role on roleres.res_id=role.role_id
where roleres.types='role' and roleres.restype_id='role'
;



create or replace view v_tb_res_role_user as
select
  to_char(allroles.user_id) as user_id,
  roleres_role.res_id as role_id,
  roleres_role.op_id as op_id,
  roleres_role.restype_id  as restype_id
from (
--一个用户所有的角色的角色资源
--用户角色
select u_role.user_id, u_role.role_id from td_sm_userrole u_role
union
--用户所在用户组的 角色
select u_group.user_id,g_role.role_id from td_sm_usergroup u_group
join td_sm_grouprole g_role on u_group.group_id=g_role.group_id
union
--用户所属机构的角色
select org_user.user_id,org_role.role_id from td_sm_userjoborg org_user
join td_sm_orgrole org_role on  org_user.org_id=org_role.org_id
union
--用户机构岗位的角色
select u_job.user_id,org_job_role.role_id from td_sm_userjoborg u_job
 inner join td_sm_orgjobrole org_job_role
 on u_job.job_id=org_job_role.job_id and u_job.org_id=org_job_role.org_id
)allroles
--通过角色ID,关联CS资源视图
,
v_tb_res_role_role roleres_role
where  roleres_role.role_id in(allroles.role_id,
    --再加上'普通用户'角色ID
    (select t.role_id from td_sm_role t where t.role_name='roleofeveryone')
)
union
--union 直接分配给用户的资源
select to_char(roleres.role_id) as user_id,
       roleres.res_id as role_id,
       roleres.op_id as op_id,
       roleres.restype_id as restype_id
    from td_sm_roleresop roleres
where roleres.types='user' and roleres.restype_id='role'
union
--union 直接分配给用户机构的资源
select to_char(userjoborg.user_id) as user_id,
       roleres.res_id as role_id,
       roleres.op_id as op_id,
       roleres.restype_id  as restype_id
    from td_sm_roleresop roleres
    join td_sm_userjoborg userjoborg on userjoborg.org_id = roleres.role_id
where roleres.types='organization' and roleres.restype_id='role'
;



create or replace view v_tb_user_allrole as
select "USER_ID","ROLE_ID"
    from (
--一个用户所有的角色的机构资源
--用户角色
select u_role.user_id, u_role.role_id from td_sm_userrole u_role
union
--用户所在用户组的 角色
select u_group.user_id,g_role.role_id from td_sm_usergroup u_group
join td_sm_grouprole g_role on u_group.group_id=g_role.group_id
union
--用户所属机构的角色
select org_user.user_id,org_role.role_id from td_sm_userjoborg org_user
join td_sm_orgrole org_role on  org_user.org_id=org_role.org_id
union
--用户机构岗位的角色
select u_job.user_id,org_job_role.role_id from td_sm_userjoborg u_job
 inner join td_sm_orgjobrole org_job_role
 on u_job.job_id=org_job_role.job_id and u_job.org_id=org_job_role.org_id)
 ;
 





--待办列表
--用于查询当前用户在所登录的应用中所有的待办任务
create or replace view v_app_work_list as
select v.pkgId,
       v.actname,
       c.ec_name,
       case
         when m.BUSITITLE is not null then
          m.BUSITITLE
         else
          (select max(t.BUSITITLE)
             from &dbuser.td_proc_form_instancemap t
            where v.activityrequesterprocessid = t.procinstanceid)
       end as BUSITITLE,
       case
         when m.businessid is not null then
          m.businessid
         else
          (select max(t.businessid)
             from &dbuser.td_proc_form_instancemap t
            where v.activityrequesterprocessid = t.procinstanceid)
       end as businessid,
       v.actId,
       v.procId,
       v.username
  from &dbuser.v_Worklist v,
       (select max(t.businessid) businessid,
               max(t.BUSITITLE) BUSITITLE,
               max(t.ec_id) ec_id,
               procinstanceid
          from &dbuser.td_proc_form_instancemap t
         group by t.procinstanceid) m,
       &dbuser.activitystates,
       &dbuser.tb_form_class c
 where m.ec_id = c.ec_id
   and (v.procId = m.procinstanceid or
       v.activityrequesterprocessid = m.procinstanceid)
   and m.ec_id = c.ec_id
   and activitystates.oid = v.state
   and activitystates.keyvalue <> 'open.not_running.suspended'
   and c.app_id = substr('&user',5)
   and not exists (select '1'
          from &dbuser.td_worklist_tobe t
         where v.actId = t.act_ins_id)
   and v.limittime > (
                      SELECT TO_CHAR((SYSDATE -
               TO_DATE('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') -
               (1 / 3)) * 24 * 60 * 60 * 1000,
               '999999999999999')
  FROM DUAL)
;
-- 视图字段增加备注脚本：
COMMENT ON COLUMN v_app_work_list.pkgId
   IS '流程';
   COMMENT ON COLUMN v_app_work_list.actname
   IS '活动';
COMMENT ON COLUMN v_app_work_list.ec_name
   IS '业务类别';
COMMENT ON COLUMN v_app_work_list.BUSITITLE
   IS '表单名称';
   COMMENT ON COLUMN v_app_work_list.businessid
   IS '业务id';

--未发送列表
--用于查询保存了表单数据而没有完成工作流的任务
create or replace view v_app_tobework_list as
select t.act_name,
       c.ec_name,
       t.busititle,
       to_char(t.createtime, 'yyyy-mm-dd hh24:mi') createtime,
       t.businessid,
       t.act_ins_id actInsId,
       t.mgrname,
       t.id,t.username,
       t.DYNAMICPERFORMER,
       t.next_act,
       t.andsplitusers
  from &dbuser.td_worklist_tobe t, &dbuser.tb_form_class c, &dbuser.assignmentstable a
 where t.ec_id = c.ec_id
   and c.app_id = substr('&user',5)
   and a.activityid=t.act_ins_id
   and a.resourceid=t.username
;

COMMENT ON COLUMN v_app_tobework_list.act_name
   IS '当前环节';
   COMMENT ON COLUMN v_app_tobework_list.ec_name
   IS '业务类别';
COMMENT ON COLUMN v_app_tobework_list.busititle
   IS '表单名称';
COMMENT ON COLUMN v_app_tobework_list.createtime
   IS '暂存时间';
   COMMENT ON COLUMN v_app_tobework_list.businessid
   IS '业务id';


--办结列表
--用于查询用户进行过操作的流程列表
create or replace view v_app_donework_list as
select a.name act_name,
       (select max(act.name)
          from &dbuser.v_activities act, &dbuser.activitystates state
         where act.state = state.oid
           and state.keyvalue like 'open%'
           and act.process = p.oid) as run_actname,
       c.ec_name,
       m.busititle,
       m.businessid,
       a.id actInsId,
       p.id procInsId,
       (select max(act.id)
          from &dbuser.activities act, &dbuser.activitystates state
         where act.state = state.oid
           and state.keyvalue like 'open%'
           and act.process = p.oid) as run_actinsid,
       p.pdefname mgrname,
       a.resourceid username
  from &dbuser.v_activities a,
       &dbuser.processes p,
       &dbuser.activitystates sa,
       (select max(t.businessid) businessid,
               max(t.BUSITITLE) BUSITITLE,
               max(t.ec_id) ec_id,
               procinstanceid
          from &dbuser.td_proc_form_instancemap t
         group by t.procinstanceid) m,
       &dbuser.tb_form_class c
 where a.state = sa.oid
   and sa.keyvalue = 'closed.completed'
   and m.procinstanceid = p.id
   and m.ec_id = c.ec_id
   and c.app_id = substr('&user',5)
   and a.process = p.oid
;
   
COMMENT ON COLUMN v_app_donework_list.act_name
   IS '本人执行活动';
   COMMENT ON COLUMN v_app_donework_list.run_actname
   IS '当前运行活动';
COMMENT ON COLUMN v_app_donework_list.busititle
   IS '表单名称';
   COMMENT ON COLUMN v_app_donework_list.ec_name
   IS '业务类别';
   COMMENT ON COLUMN v_app_donework_list.businessid
   IS '业务id';


--流程监控列表
create or replace view v_app_process_monitor_list as
select c.ec_name ec_name,
       m.busititle busititle,
       m.businessid businessid,
       (select &dbuser.sum_string('&dbuser.v_activities a, &dbuser.activitystates s','a.name','where a.process = ' || p.oid || '
           and a.state = s.oid
           and s.keyvalue like ''open%''') from dual) run_actname,
       p.id procinsid  from &dbuser.processes p,
       (select max(t.businessid) businessid,
               max(t.BUSITITLE) BUSITITLE,
               max(t.ec_id) ec_id,
               procinstanceid
          from &dbuser.td_proc_form_instancemap t
         group by t.procinstanceid) m,
       &dbuser.tb_application_info a,
       &dbuser.tb_form_class c
where p.id = m.procinstanceid
   and a.app_id = c.app_id
   and m.ec_id = c.ec_id
   and c.app_id = substr('&user',5);


COMMENT ON COLUMN v_app_process_monitor_list.ec_name
   IS '业务类别';
   COMMENT ON COLUMN v_app_process_monitor_list.busititle
   IS '表单名称';
COMMENT ON COLUMN v_app_process_monitor_list.businessid
   IS '业务id';
COMMENT ON COLUMN v_app_process_monitor_list.run_actname
   IS '当前活动';

   
 ------------------------系统管理视图结束-----------------------
 
 
 ------------------------工作流操作日志-------------------------
create table WORKFLOW_OPERATE_LOG  (
   LOG_ID               VARCHAR2(50)                    not null,
   BUSINESS_ID          VARCHAR2(50),
   OPERATE_TIME         DATE,
   OPERATE_USER         VARCHAR2(50),
   OPERATE_TYPE         VARCHAR2(100),
   OPERATE_PARAMS       VARCHAR2(2000),
   OPERATE_RESULT       CHAR(1),
   PROC_DEFNAME         VARCHAR2(200),
   ACT_DEFID            VARCHAR2(90),
   PROC_INSTANCEID      VARCHAR2(100),
   ACT_INSTANCEID       VARCHAR2(100),
   MODULE_ID            VARCHAR2(100),
   APP_ID               VARCHAR2(20),
   constraint PK_WORKFLOW_OPERATE_LOG primary key (LOG_ID)
);

comment on table WORKFLOW_OPERATE_LOG is
'工作流操作日志';

comment on column WORKFLOW_OPERATE_LOG.LOG_ID is
'日志ID';

comment on column WORKFLOW_OPERATE_LOG.BUSINESS_ID is
'业务ID';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_TIME is
'操作时间';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_USER is
'操作用户';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_TYPE is
'流程操作类型';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_PARAMS is
'操作参数（JSON格式）';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_RESULT is
'流程操作结果';

comment on column WORKFLOW_OPERATE_LOG.PROC_DEFNAME is
'流程定义名称';

comment on column WORKFLOW_OPERATE_LOG.ACT_DEFID is
'活动定义ID';

comment on column WORKFLOW_OPERATE_LOG.PROC_INSTANCEID is
'流程实例ID';

comment on column WORKFLOW_OPERATE_LOG.ACT_INSTANCEID is
'活动实例ID';

comment on column WORKFLOW_OPERATE_LOG.MODULE_ID is
'事项ID';

comment on column WORKFLOW_OPERATE_LOG.APP_ID is
'所属应用ID';


--工作流操作视图

CREATE OR REPLACE VIEW V_APP_WORKFLOW_OPERATE_LOG AS 
  select
   l.LOG_ID,
   l.BUSINESS_ID,
   l.OPERATE_TIME,
   l.OPERATE_USER,
   l.OPERATE_TYPE,
   decode(l.OPERATE_RESULT,'Y','成功','N','失败') as OPERATE_RESULT_NAME,
   l.OPERATE_PARAMS,
   l.OPERATE_RESULT,
   l.APP_ID
from
   &user.WORKFLOW_OPERATE_LOG l
 ;
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.LOG_ID IS '日志ID';
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.BUSINESS_ID IS '业务编号';
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.OPERATE_TIME IS '操作时间';
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.OPERATE_USER IS '操作用户';
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.OPERATE_TYPE IS '流程操作类型';
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.OPERATE_RESULT_NAME IS '流程操作结果';
   
------------------------工作流操作日志结束-------------------------