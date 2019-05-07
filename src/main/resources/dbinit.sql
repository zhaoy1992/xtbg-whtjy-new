--------�����û���ʼ--------

create user &user
  identified by "&password"
  default tablespace &deftablespace
  temporary tablespace &temptablespace
  profile DEFAULT;
  
---------�����û�����-------- 



---------��Ȩ��ʼ------------

grant connect to &user;
grant resource to &user;
grant dba to &user;

--�����б�Ȩ�� ��ʼ--
grant select on  td_proc_form_instancemap to &user;
grant select on  v_Worklist to &user;
grant select on  activitystates to &user;
grant select on  td_worklist_tobe to &user;
grant select on  tb_form_class to &user;
grant select on  activities to &user;
grant select on  processes to &user;
grant select on  tb_application_info to &user;
grant execute on sum_string to &user;
--�����б�Ȩ�� ����--

--�����Ȩ�� ��ʼ--
grant select on assignmentstable to &user;
--�����Ȩ�� ����--

---------��Ȩ����------------

---------���õ��ı�ʼ---------

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
'�������ֶα�';

comment on column FC_FLDLIST.FLDID is 
'�ֶμ�¼��';

comment on column FC_FLDLIST.TBID is 
'���¼��';

comment on column FC_FLDLIST.FDNAME is 
'�ֶ���';

comment on column FC_FLDLIST.CHNNAME is 
'�ֶ�������';

comment on column FC_FLDLIST.FDTYPE is 
'�ֶ�����';

comment on column FC_FLDLIST.FDSIZE is 
'�ֶγ���';

comment on column FC_FLDLIST.FDDEC is 
'�ֶ�����';

comment on column FC_FLDLIST.INPUTSTYLE is 
'���뷽ʽ';

comment on column FC_FLDLIST.OBJWIDTH is 
'���';

create table FC_TBLIST 
(
    TBID                 VARCHAR2(50)                   not null,
    TBNAME               VARCHAR2(50)                   not null,
    CHNNAME              VARCHAR2(50),
    TBTYPE               CHAR(10),
    constraint PK_FC_TBLIST primary key (TBID)
);

comment on table FC_TBLIST is 
'��������ݱ�';

comment on column FC_TBLIST.TBID is 
'���¼��';

comment on column FC_TBLIST.TBNAME is 
'����';

comment on column FC_TBLIST.CHNNAME is 
'��������';

comment on column FC_TBLIST.TBTYPE is 
'������';

alter table FC_FLDLIST
   add constraint FK_FLDLIST_TBLIST foreign key (TBID)
      references FC_TBLIST (TBID);      
      
create table FC_MAXBH
(
  BIAOSHI CHAR(3) not null,
  RECNUM  NUMBER(10)
);

--gaeditor�ؼ���
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
  is '�༭�ؼ����ݴ洢��';
-- Add comments to the columns 
comment on column TD_FORM_GAEDITDATA.URI
  is '����ID';
comment on column TD_FORM_GAEDITDATA.GADATA
  is 'GAEDIT�����ļ�';
comment on column TD_FORM_GAEDITDATA.DJID
  is '��id';
comment on column TD_FORM_GAEDITDATA.CTRLID
  is '�ؼ�id';
comment on column TD_FORM_GAEDITDATA.CC_FORM_INSTANCEID
  is '��ʵ��id';
comment on column TD_FORM_GAEDITDATA.CTRL_INSID
  is '�ؼ�ʵ��id';


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

COMMENT ON COLUMN TD_OCTL_Document.DOCUMENTID IS '�Զ����';
COMMENT ON COLUMN TD_OCTL_Document.RecordID IS '�ĵ����';
COMMENT ON COLUMN TD_OCTL_Document.Template IS 'ģ����';
COMMENT ON COLUMN TD_OCTL_Document.Subject IS '����';
COMMENT ON COLUMN TD_OCTL_Document.Author IS '����';
COMMENT ON COLUMN TD_OCTL_Document.FileDate IS '����';
COMMENT ON COLUMN TD_OCTL_Document.FileType IS '�ĵ�����';
COMMENT ON COLUMN TD_OCTL_Document.HtmlPath IS 'HTML·��';
COMMENT ON COLUMN TD_OCTL_Document.Status IS '״̬';
COMMENT ON COLUMN TD_OCTL_Document.djid IS '�����';

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
COMMENT ON COLUMN TD_OCTL_Document_File.FILEID IS '�Զ����';

COMMENT ON COLUMN TD_OCTL_Document_File.RecordID IS '�ĵ����';
COMMENT ON COLUMN TD_OCTL_Document_File.FileName IS '�ĵ�����';
COMMENT ON COLUMN TD_OCTL_Document_File.FileType IS '�ĵ�����';
COMMENT ON COLUMN TD_OCTL_Document_File.FileSize IS '�ĵ���С';
COMMENT ON COLUMN TD_OCTL_Document_File.FileDate IS '�ĵ�����';
COMMENT ON COLUMN TD_OCTL_Document_File.FileBody IS '�ĵ�����';
COMMENT ON COLUMN TD_OCTL_Document_File.FilePath IS '�ĵ�����·��';
COMMENT ON COLUMN TD_OCTL_Document_File.UserName IS '�û�����';
COMMENT ON COLUMN TD_OCTL_Document_File.Descript IS '�ĵ�����';


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

COMMENT ON COLUMN TD_OCTL_Version_File.FileID IS '�Զ����';
COMMENT ON COLUMN TD_OCTL_Version_File.RecordID IS '�ĵ����';
COMMENT ON COLUMN TD_OCTL_Version_File.FileName IS '�ĵ�����';
COMMENT ON COLUMN TD_OCTL_Version_File.FileType IS '�ĵ�����';
COMMENT ON COLUMN TD_OCTL_Version_File.FileSize IS '�ĵ���С';
COMMENT ON COLUMN TD_OCTL_Version_File.FileDate IS '�ĵ�����';
COMMENT ON COLUMN TD_OCTL_Version_File.FileBody IS '�ĵ�����';
COMMENT ON COLUMN TD_OCTL_Version_File.FilePath IS '�ĵ�����·��';
COMMENT ON COLUMN TD_OCTL_Version_File.UserName IS '�û�����';
COMMENT ON COLUMN TD_OCTL_Version_File.Descript IS '�ĵ�����';


CREATE TABLE TD_OCTL_BookMarks(
    BOOKMARKID NUMBER(10) NOT NULL, 
    BOOKMARKNAME VARCHAR2(64), 
    BOOKMARKDESC VARCHAR2(128), 
    BOOKMARKTEXT VARCHAR2(200)); 

COMMENT ON COLUMN TD_OCTL_BookMarks.BookMarkID IS '�Զ����';
COMMENT ON COLUMN TD_OCTL_BookMarks.BookMarkName IS '��ǩ����';
COMMENT ON COLUMN TD_OCTL_BookMarks.BookMarkDesc IS '��ǩ˵��';
COMMENT ON COLUMN TD_OCTL_BookMarks.BookMarkText IS '��ǩ����';


CREATE TABLE TD_OCTL_Document_Signature(
    SIGNATUREID NUMBER(10) NOT NULL, 
    RECORDID VARCHAR2(50), 
    MARKNAME VARCHAR2(64), 
    USERNAME VARCHAR2(64), 
    DATETIME DATE, 
    HOSTNAME VARCHAR2(50), 
    MARKGUID VARCHAR2(128)); 
COMMENT ON COLUMN TD_OCTL_Document_Signature.SignatureID IS '�Զ����';
COMMENT ON COLUMN TD_OCTL_Document_Signature.RecordID IS '�ĵ����';
COMMENT ON COLUMN TD_OCTL_Document_Signature.MarkName IS 'ǩ������';
COMMENT ON COLUMN TD_OCTL_Document_Signature.UserName IS '�û�����';
COMMENT ON COLUMN TD_OCTL_Document_Signature.DateTime IS 'ǩ������';
COMMENT ON COLUMN TD_OCTL_Document_Signature.HostName IS '�û�����';
COMMENT ON COLUMN TD_OCTL_Document_Signature.MarkGuid IS 'ǩ����ʾ';

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
COMMENT ON COLUMN TD_OCTL_Signature.SignatureID IS '�Զ����';
COMMENT ON COLUMN TD_OCTL_Signature.UserName IS '�����û�';
COMMENT ON COLUMN TD_OCTL_Signature.MarkName IS 'ǩ������';
COMMENT ON COLUMN TD_OCTL_Signature.PassWord IS 'ǩ������';
COMMENT ON COLUMN TD_OCTL_Signature.MarkBody IS 'ǩ������';
COMMENT ON COLUMN TD_OCTL_Signature.MarkPath IS 'ǩ������·��';
COMMENT ON COLUMN TD_OCTL_Signature.MarkSize IS 'ǩ����С';
COMMENT ON COLUMN TD_OCTL_Signature.MarkDate IS '��������';


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

COMMENT ON COLUMN TD_OCTL_Template_File.TemplateID IS '�Զ����';
COMMENT ON COLUMN TD_OCTL_Template_File.RecordID IS 'ģ����';
COMMENT ON COLUMN TD_OCTL_Template_File.FileName IS 'ģ������';
COMMENT ON COLUMN TD_OCTL_Template_File.FileType IS 'ģ������';
COMMENT ON COLUMN TD_OCTL_Template_File.FileSize IS 'ģ���С';
COMMENT ON COLUMN TD_OCTL_Template_File.FileDate IS 'ģ������';
COMMENT ON COLUMN TD_OCTL_Template_File.FileBody IS 'ģ������';
COMMENT ON COLUMN TD_OCTL_Template_File.FilePath IS 'ģ������·��';
COMMENT ON COLUMN TD_OCTL_Template_File.UserName IS '�û�����';
COMMENT ON COLUMN TD_OCTL_Template_File.Descript IS 'ģ������';
COMMENT ON COLUMN TD_OCTL_Template_File.ORG_ID IS '��ģ�������Ļ���id';



CREATE TABLE TD_OCTL_Template_BookMarks(
    BOOKMARKID NUMBER(10) NOT NULL, 
    RECORDID VARCHAR2(50), 
    BOOKMARKNAME VARCHAR2(120));

COMMENT ON COLUMN TD_OCTL_Template_BookMarks.BookMarkID IS '�Զ����';
COMMENT ON COLUMN TD_OCTL_Template_BookMarks.RecordID IS '�ĵ����';
COMMENT ON COLUMN TD_OCTL_Template_BookMarks.BookMarkName IS '��ǩ����';


--���Ĵ���ϵͳ�Ľӿڱ�--
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
  is '�Զ����';
comment on column TD_OCTL_GWCS_FILE.RECORDID
  is '�ĵ����';
comment on column TD_OCTL_GWCS_FILE.FILENAME
  is '�ĵ�����';
comment on column TD_OCTL_GWCS_FILE.FILETYPE
  is '�ĵ�����';
comment on column TD_OCTL_GWCS_FILE.FILESIZE
  is '�ĵ���С';
comment on column TD_OCTL_GWCS_FILE.FILEDATE
  is '�ĵ�����';
comment on column TD_OCTL_GWCS_FILE.FILEBODY
  is '�ĵ�����';
comment on column TD_OCTL_GWCS_FILE.FILEPATH
  is '�ĵ�����·��';
comment on column TD_OCTL_GWCS_FILE.USERNAME
  is '�û�����';
comment on column TD_OCTL_GWCS_FILE.DESCRIPT
  is '�ĵ�����';


 --------upload�ϴ��ؼ��ı�ṹ��ʼ--------

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
  is '����';
comment on column FC_ATTACHEREF.REF_CTRL_INSID
  is '�ؼ�ʵ��ID';
comment on column FC_ATTACHEREF.NOTE
  is '��ע';
comment on column FC_ATTACHEREF.ADDTIME
  is 'ʱ��';
comment on column FC_ATTACHEREF.REF_ATTACHE_ID
  is '�����������attache_id';
comment on column FC_ATTACHEREF.REF_TYPE
  is '�ϴ�����';
  
  
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
  --------upload�ϴ��ؼ��ı�ṹ����--------


--���ݼ�����̬
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
  is '��id';
comment on column TB_CTRL_DATASET_RUN.CTRLID
  is '�ؼ�id';
comment on column TB_CTRL_DATASET_RUN.CC_FORM_INSTANCEID
  is '��ʵ��id';
comment on column TB_CTRL_DATASET_RUN.DS_TYPE
  is '���ݼ����� 0��������¼�����ݼ� 1��������¼�����ݼ�';
comment on column TB_CTRL_DATASET_RUN.DS_SQL
  is '���ݼ���sql';
comment on column TB_CTRL_DATASET_RUN.DS_TBNAME
  is '���ݼ��ı������';
comment on column TB_CTRL_DATASET_RUN.REMARK
  is '��ע';


--office�ؼ�����̬��
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
  
  --ͨ�ÿؼ�����̬��
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
  
  
  --�ϴ��ؼ�����̬��
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
  is '��id';
comment on column TB_CTRL_UPLOAD_RUN.CTRLID
  is '�ؼ�id';
comment on column TB_CTRL_UPLOAD_RUN.CC_FORM_INSTANCEID
  is '��ʵ��id';
comment on column TB_CTRL_UPLOAD_RUN.CTRL_INSID
  is '�ؼ�ʵ��id';
comment on column TB_CTRL_UPLOAD_RUN.ALLOWDELETE
  is '�Ƿ�����ɾ�� 0�������� 1������';
  
  --��ʵ��
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
  is '��id';
comment on column TB_FORM_INSTANCE.CC_FORM_INSTANCEID
  is '��ʵ��id';
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
  
      
---------���õ��ı����--------  


------------���ı�����ݳ�ʼ����ʼ---------------

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
  
------------���ı�����ݳ�ʼ������---------------
      
      
      
---------------ϵͳ�����õ��ı�ʼ------------------


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
  is '����ID';
comment on column TD_SM_ORGANIZATION.ORG_SN
  is '��������ID';
comment on column TD_SM_ORGANIZATION.ORG_NAME
  is '��������';
comment on column TD_SM_ORGANIZATION.PARENT_ID
  is '������ID';
comment on column TD_SM_ORGANIZATION.PATH
  is '·��';
comment on column TD_SM_ORGANIZATION.LAYER
  is '�㣨�״Σ�';
comment on column TD_SM_ORGANIZATION.CHILDREN
  is '�ӻ���';
comment on column TD_SM_ORGANIZATION.CODE
  is '��������';
comment on column TD_SM_ORGANIZATION.JP
  is '��ƴ';
comment on column TD_SM_ORGANIZATION.QP
  is 'ȫƴ';
comment on column TD_SM_ORGANIZATION.CREATINGTIME
  is '����ʱ��';
comment on column TD_SM_ORGANIZATION.CREATOR
  is '������';
comment on column TD_SM_ORGANIZATION.ORGNUMBER
  is '�������';
comment on column TD_SM_ORGANIZATION.ORGDESC
  is '��������';
comment on column TD_SM_ORGANIZATION.REMARK1
  is '�����ֶ�1';
comment on column TD_SM_ORGANIZATION.REMARK2
  is '�����ֶ�2';
comment on column TD_SM_ORGANIZATION.REMARK3
  is '��������
';
comment on column TD_SM_ORGANIZATION.REMARK4
  is '�����ֶ�4';
comment on column TD_SM_ORGANIZATION.REMARK5
  is '������������';
comment on column TD_SM_ORGANIZATION.CHARGEORGID
  is '���ܻ���';
comment on column TD_SM_ORGANIZATION.ISPARTYBUSSINESS
  is '��ʾ�����Ƿ���ҵ���� 0-�� 1-���� Ĭ��Ϊ1';
comment on column TD_SM_ORGANIZATION.SATRAPJOBID
  is '���ܸ�λ';
comment on column TD_SM_ORGANIZATION.ORG_LEVEL
  is '������������0:���ң�1��ʡ����2�����ݼ���3����������4��������';
comment on column TD_SM_ORGANIZATION.ORG_XZQM
  is '��������';
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
  is '�û�ID';
comment on column TD_SM_USER.USER_SN
  is '�û������';
comment on column TD_SM_USER.USER_NAME
  is '�û��ʺ�';
comment on column TD_SM_USER.USER_PASSWORD
  is '�û�����';
comment on column TD_SM_USER.USER_REALNAME
  is '�û�ʵ��';
comment on column TD_SM_USER.USER_PINYIN
  is 'ƴ��';
comment on column TD_SM_USER.USER_SEX
  is '�Ա�';
comment on column TD_SM_USER.USER_HOMETEL
  is '��ͥ�绰';
comment on column TD_SM_USER.USER_WORKTEL
  is '��˾�绰';
comment on column TD_SM_USER.USER_WORKNUMBER
  is '��˾��ַ';
comment on column TD_SM_USER.USER_MOBILETEL1
  is '�ֻ�1';
comment on column TD_SM_USER.USER_MOBILETEL2
  is '�ֻ�2';
comment on column TD_SM_USER.USER_FAX
  is '����';
comment on column TD_SM_USER.USER_OICQ
  is 'OICQ';
comment on column TD_SM_USER.USER_BIRTHDAY
  is '����';
comment on column TD_SM_USER.USER_EMAIL
  is '����';
comment on column TD_SM_USER.USER_ADDRESS
  is 'סַ';
comment on column TD_SM_USER.USER_POSTALCODE
  is '�ʱ�';
comment on column TD_SM_USER.USER_IDCARD
  is '���֤';
comment on column TD_SM_USER.USER_ISVALID
  is '�Ƿ�ʹ��';
comment on column TD_SM_USER.USER_REGDATE
  is 'ע������';
comment on column TD_SM_USER.USER_LOGINCOUNT
  is '��½����';
comment on column TD_SM_USER.USER_TYPE
  is '�û�����';
comment on column TD_SM_USER.REMARK1
  is '�����Ƿ��� ����,�������Ϣ��ʾ***���� ����ʾ��Ϣ';
comment on column TD_SM_USER.REMARK2
  is '�����ֶ�2';
comment on column TD_SM_USER.REMARK3
  is '�����ֶ�3';
comment on column TD_SM_USER.REMARK4
  is '�����ֶ�4';
comment on column TD_SM_USER.REMARK5
  is '�����ֶ�5';
comment on column TD_SM_USER.PAST_TIME
  is '����ʱ��';
comment on column TD_SM_USER.DREDGE_TIME
  is '��ͨʱ��';
comment on column TD_SM_USER.LASTLOGIN_DATE
  is '�û�����½ʱ��';
comment on column TD_SM_USER.ISTAXMANAGER
  is '�Ƿ�˰��Ա';
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
  is '�û���������Ա��';
-- Add comments to the columns 
comment on column TD_SM_ORGMANAGER.USER_ID
  is '��������Աid';
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
  is '��ɫ������Ϣ��';
-- Add comments to the columns 
comment on column TD_SM_ROLETYPE.TYPE_NAME
  is '��ɫ��������';
comment on column TD_SM_ROLETYPE.TYPE_DESC
  is '��ɫ��������';
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
  is '��ɫ����';
comment on column TD_SM_ROLE.OWNER_ID
  is '������id��Ĭ��άϵͳ����Ա';
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
  is '��λID';
comment on column TD_SM_JOB.JOB_NAME
  is '��λ����';
comment on column TD_SM_JOB.JOB_DESC
  is '��λ����';
comment on column TD_SM_JOB.JOB_FUNCTION
  is '��λְ��';
comment on column TD_SM_JOB.JOB_AMOUNT
  is '��λ��������';
comment on column TD_SM_JOB.JOB_NUMBER
  is '��λ���';
comment on column TD_SM_JOB.JOB_CONDITION
  is '��ְ����';
comment on column TD_SM_JOB.JOB_RANK
  is '��λ����';
comment on column TD_SM_JOB.OWNER_ID
  is '������id��Ĭ��άϵͳ����Ա';
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
  is '��־ģ������';
comment on column TD_SM_LOGMODULE.STATUS
  is '��¼��־״̬';
comment on column TD_SM_LOGMODULE.MODULE_DESC
  is '��־ģ������';
comment on column TD_SM_LOGMODULE.ID
  is '��־ģ��ID';
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
  is '�����ɫ���û�';
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
  is '�����ɫ���û�';
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
  is '�����ɫ���û�';
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
  is '���Ϊ������λ���õĽ�ɫ��Ϣ';
-- Add comments to the columns 
comment on column TD_SM_ORGJOBROLE.ORG_ID
  is '����id����������������';
comment on column TD_SM_ORGJOBROLE.JOB_ID
  is '��λid�����λ����������';
comment on column TD_SM_ORGJOBROLE.ROLE_ID
  is '��ɫid�����ɫ����������';
comment on column TD_SM_ORGJOBROLE.RESOP_ORIGIN_USERID
  is '�����ɫ���û�';
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
  is '����ID';
comment on column TD_SM_ROLERESOP.RES_ID
  is '��ԴID';
comment on column TD_SM_ROLERESOP.ROLE_ID
  is '��ɫID';
comment on column TD_SM_ROLERESOP.RESTYPE_ID
  is '��Դ����ID';
comment on column TD_SM_ROLERESOP.AUTO
  is '��ʶ��Դά����ʽ��0�Զ�ά����1�ֶ�ά��';
comment on column TD_SM_ROLERESOP.RES_NAME
  is '��Դ����';
comment on column TD_SM_ROLERESOP.TYPES
  is '��Դ���ࣨ�ǽ�ɫ��Դ�����û���Դ��';
comment on column TD_SM_ROLERESOP.AUTHORIZATION_TYPE
  is '��Ȩ�ķ�ʽ:0:������Ȩ,1:������Ȩ,2:ʱЧ��Ȩ';
comment on column TD_SM_ROLERESOP.USE_COUNT
  is '��Ȩ��ʹ�ô���';
comment on column TD_SM_ROLERESOP.AUTHORIZATION_STIME
  is '��Ȩʹ�ÿ�ʼʱ��';
comment on column TD_SM_ROLERESOP.AUTHORIZATION_ETIME
  is '��Ȩʹ�ý���ʱ��';
comment on column TD_SM_ROLERESOP.USE_COUNTED
  is 'Ȩ����ʹ�ô���';
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
  is 'TD_SM_PERMISSION_ORIGINE��Ϣά����
��Ȩʱ�����ȷ�����Ȩ�˲�����Ȩ�޵���Դ�������¼��֣�
�ǲ�����Ȩ�˱������Դ������ǽ���Դ��Ϣ���뱾��
�ǲ�����Ȩ��������������Դ������ǽ���Դ��Ϣ���뱾��
�ǲ�����Ȩ��ӵ�еĽ�ɫ����Դ������ǽ������ɫ��Ϣ����¼���뱾��

ȡ����Ȩʱ���������м�鱻��Ȩ���Ƿ񽫸�Ȩ�����������û��������������Ҫȡ���ɱ���Ȩ��������û���Ȩ�ޣ���˵ݹ�ִ�У��Ƿ�ȡ��Ȩ�޻����жϱ���Ȩ���ڱ����л���ͨ������������ø�Ȩ�ޣ����û����ɾ��Ȩ�ޱ��еĸ�����¼��ͬʱɾ�������е����Ȩ����Դ��Ϣ';
-- Add comments to the columns 
comment on column TD_SM_PERMISSION_ORIGINE.ORIGINE_TYPE
  is 'Ȩ����Դ���ͣ�
user,role,organization';
comment on column TD_SM_PERMISSION_ORIGINE.ORIGINE_ID
  is 'Ȩ����Դ��ɫid�����ݽ�ɫ����ȷ��Ϊ��
�û�id����ɫid������id';
comment on column TD_SM_PERMISSION_ORIGINE.OP_ID
  is '����ID';
comment on column TD_SM_PERMISSION_ORIGINE.RES_ID
  is '��ԴID';
comment on column TD_SM_PERMISSION_ORIGINE.ROLE_ID
  is '��ɫID';
comment on column TD_SM_PERMISSION_ORIGINE.RESTYPE_ID
  is '��Դ����ID';
comment on column TD_SM_PERMISSION_ORIGINE.TYPES
  is '��Դ���ࣨ�ǽ�ɫ��Դ�����û���Դ��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_PERMISSION_ORIGINE
  add constraint PK_PERM_ORIGINE primary key (ORIGINE_TYPE, ORIGINE_ID, OP_ID, RES_ID, ROLE_ID, RESTYPE_ID, TYPES)
  ;
  
  
  --------ϵͳ�����ֵ�����ʼ---------
  
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
  is '�ֵ���������������';
-- Add comments to the columns 
comment on column TB_SM_INPUTTYPE.DATASOURCE_PATH
  is '����Դѡ�����';
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
  DATA_NAME_CN            VARCHAR2(100) default '����',
  DATA_VALUE_CN           VARCHAR2(100) default '��ʵֵ',
  KEY_GENERAL_TYPE        NUMBER(2)
)
;
-- Add comments to the columns 
comment on column TD_SM_DICTTYPE.DICTTYPE_TYPE
  is '0:�����ֵ�����;1:��Ȩ��ҵ���ֵ�2:��Ȩ��ҵ���ֵ�';
comment on column TD_SM_DICTTYPE.IS_TREE
  is '�ж��ֵ�����������״�Ļ����б��͵�������
0-�б����ͣ�ȱʡֵ
1-��״�ṹ������ָ��DATA_PARENT_FIELD�ֶ�';
comment on column TD_SM_DICTTYPE.DICTTYPE_ID
  is '�ֵ�����ID';
comment on column TD_SM_DICTTYPE.USER_ID
  is '�û�ID';
comment on column TD_SM_DICTTYPE.DICTTYPE_NAME
  is '�ֵ���������';
comment on column TD_SM_DICTTYPE.DICTTYPE_DESC
  is '�ֵ���������';
comment on column TD_SM_DICTTYPE.DATA_TABLE_NAME
  is '�ֵ����ݴ�ű�����ȱʡΪtd_sm_dictdata';
comment on column TD_SM_DICTTYPE.DATA_NAME_FILED
  is '�ֵ��������ƴ���ֶΣ�ȱʡΪDICTDATA_NAME';
comment on column TD_SM_DICTTYPE.DATA_VALUE_FIELD
  is '�ֵ�����ֵ����ֶΣ�ȱʡֵΪDICTDATA_value';
comment on column TD_SM_DICTTYPE.DATA_ORDER_FIELD
  is '�ֵ����������ֶΣ�ȱʡֵΪDICTDATA_ORDER';
comment on column TD_SM_DICTTYPE.DATA_DBNAME
  is '�ֵ���Ӧ�����ݿ�';
comment on column TD_SM_DICTTYPE.DATA_PARENTID_FIELD
  is '��״�ṹ�����ֵ���ÿ���������Ӧ�ĸ��ڵ��ֶ�����';
comment on column TD_SM_DICTTYPE.DATA_NAME_CN
  is '�ֵ������ֶβɼ�ʱ����������';
comment on column TD_SM_DICTTYPE.DATA_VALUE_CN
  is 'ֵ�ֶβɼ�ʱ����������';
comment on column TD_SM_DICTTYPE.KEY_GENERAL_TYPE
  is '0:�ֹ�¼��;1:�Զ����� tableinfo��';
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
  is '�Ƿ������޸��ֵ��ֵ�ֶε�ֵ 0-������Ĭ��ֵ 1-�����޸� ';
  
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
  is '�ֵ�ID';
comment on column TD_SM_DICTDATA.DICTTYPE_ID
  is '�ֵ�����ID';
comment on column TD_SM_DICTDATA.DICTDATA_NAME
  is '�ֵ�����';
comment on column TD_SM_DICTDATA.DICTDATA_VALUE
  is '�ֵ��ֵ';
comment on column TD_SM_DICTDATA.DICTDATA_ORDER
  is '�ֵ����������ֶΣ�ȱʡֵΪ0';
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
  is '�ֵ�����ID';
comment on column TD_SM_DICATTACHFIELD.FIELD_NAME
  is '������ݿ��ֶ�,�Լ���Ӧ���������͵ĸ�����Ϣ
����������: ��������, ѡ���ֵ� ����Ҫά������ֶ�
filedName:'''':''''';
comment on column TD_SM_DICATTACHFIELD.TABLE_COLUMN
  is '�ֵ��ֶζ�Ӧ���ݿ��';
comment on column TD_SM_DICATTACHFIELD.ISNULLABLE
  is '�ֶ��Ƿ����
0:���Ǳ���
1:����';
comment on column TD_SM_DICATTACHFIELD.DATEFORMAT
  is '���������ֶ�';
comment on column TD_SM_DICATTACHFIELD.ISUNIQUE
  is '�ֶε�ֵ�Ƿ�Ψһ�Ա�֤  1-Ψһ,�ֵ�ά��ʱ��Ҫ����Ψһ�Լ��  0-���ظ���ȱʡֵ';
comment on column TD_SM_DICATTACHFIELD.SN
  is '�߼��ֶ�����';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TD_SM_DICATTACHFIELD
  add constraint FK_FIELD_TYPE foreign key (INPUT_TYPE_ID)
  references TB_SM_INPUTTYPE (INPUT_TYPE_ID);
alter table TD_SM_DICATTACHFIELD
  add constraint FK_TD_SM_DI_REFERE foreign key (DICTTYPE_ID)
  references TD_SM_DICTTYPE (DICTTYPE_ID);
  
 
  --------ϵͳ�����ֵ��������---------
  

--------��Ϣ��Դ��ʼ------------

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
  is '��Ϣ��Դ��';
-- Add comments to the columns 
comment on column TD_MSG_RESOURCE.R_ID
  is '��ˮ��';
comment on column TD_MSG_RESOURCE.R_NAME
  is '��Դ����';
comment on column TD_MSG_RESOURCE.R_DESC
  is '��Դ����';
comment on column TD_MSG_RESOURCE.R_MSG_TYPE
  is '��Ϣ����';
  
--------��Ϣ��Դ�����------------

--------�û�����Ϣ��Դӳ���ʼ------------

-- Create table
create table TD_USER_MSG_RESOURCE
(
  USER_ID    NUMBER,
  R_ID       NUMBER,
  R_MSG_TYPE VARCHAR2(128)
);
-- Add comments to the table 
comment on table TD_USER_MSG_RESOURCE
  is '�û�����Ϣ��Դӳ���';
-- Add comments to the columns 
comment on column TD_USER_MSG_RESOURCE.USER_ID
  is '�û�id';
comment on column TD_USER_MSG_RESOURCE.R_ID
  is '��Ϣ��Դid';
comment on column TD_USER_MSG_RESOURCE.R_MSG_TYPE
  is '�û��Զ�����Ϣ����';

--------�û�����Ϣ��Դӳ������------------

---------------�˵���ݷ�ʽ��ʼ--------------------

CREATE TABLE TD_SM_SHORTCUTMENU_USER  (
   "USER_ID"            NUMBER,
   "MENU_ID"            VARCHAR2(2000)
);

COMMENT ON TABLE TD_SM_SHORTCUTMENU_USER IS
'Ӧ�����û���ݲ˵�';

COMMENT ON COLUMN TD_SM_SHORTCUTMENU_USER.USER_ID IS
'�û�id';

COMMENT ON COLUMN TD_SM_SHORTCUTMENU_USER.MENU_ID IS
'�˵�id';

---------------�˵���ݷ�ʽ�����--------------------

 -- added by zhou.luo 20081219
--Create table  �ĵ�ģ��ʹ����Ȩ�� �������sql��ǰ����Ǹ���Ҫ��
/*==============================================================*/
/* Table: TD_OCTL_TEMPLATE_GRANT                                */
/*==============================================================*/
CREATE TABLE TD_OCTL_TEMPLATE_GRANT  (
   RECORDID             VARCHAR2(16),
   USER_ID              NUMBER,
   USER_REALNAME        VARCHAR2(100)
);

COMMENT ON TABLE TD_OCTL_TEMPLATE_GRANT IS
'�ĵ�ģ��ʹ����Ȩ��';

COMMENT ON COLUMN TD_OCTL_TEMPLATE_GRANT.RECORDID IS
'ģ����';

COMMENT ON COLUMN TD_OCTL_TEMPLATE_GRANT.USER_ID IS
'�û�ID';

COMMENT ON COLUMN TD_OCTL_TEMPLATE_GRANT.USER_REALNAME IS
'�û�ʵ��';
  

alter table TD_OCTL_TEMPLATE_FILE add (record_sn  number(10));
comment on column TD_OCTL_TEMPLATE_FILE.record_sn is 'ģ�������';

alter table td_octl_template_grant add(granttype varchar2(20),role_id varchar2(50),role_name varchar2(100));
comment on column td_octl_template_grant.granttype is '��Ȩ���ͣ� user,���û���Ȩ��role,����ɫ��Ȩ';
comment on column td_octl_template_grant.role_id is '��ɫid';
comment on column td_octl_template_grant.role_name is '��ɫ����';

---------------ϵͳ�����õ��ı����------------------


---------------ϵͳ�������ݳ�ʼ����ʼ--------------------


-----------------�û���ʼ����ʼ------------------
INSERT INTO TD_SM_USER ("USER_ID" ,"USER_SN" ,"USER_NAME" ,"USER_PASSWORD" ,"USER_REALNAME","USER_ISVALID","USER_TYPE","USER_SEX" )  
VALUES (1 ,1 ,'admin' ,'123456' ,'ϵͳ����Ա','2','0','M'  );
commit;
-----------------�û���ʼ������------------------


-----------------��ɫ��ʼ����ʼ------------------
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) 
 VALUES ('1' ,'administrator' ,'1' ,'��������Ա��ɫ���˽�ɫ��Ҫ�޸�' ,'' ,'' ,'' ,''  );
 
INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) 
 VALUES ('2' ,'roleofeveryone' ,'1' ,'ÿ���û���ȱʡӵ�еĽ�ɫ���˽�ɫ��Ҫ�޸�' ,'' ,'' ,'' ,''  );

INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) 
 VALUES ('3' ,'orgmanager' ,'1' ,'���Ź���Ա��ɫ,�˽�ɫ��Ҫ�޸�' ,'' ,'' ,'' ,''  );

 INSERT INTO TD_SM_ROLE ("ROLE_ID" ,"ROLE_NAME" ,"ROLE_TYPE" ,"ROLE_DESC" ,"ROLE_USAGE" ,"REMARK1" ,"REMARK2" ,"REMARK3" ) 
 VALUES ('4' ,'orgmanagerroletemplate' ,'1' ,'���Ź���Ա��ɫģ��,����ɫ����ɾ����Ҳ����������ͨ�û���ֻ�ܹ���Ȩ��һ������Ȩ�޺����еĲ��Ź���Ա��ӵ����ЩȨ�ޣ����Ź���Ա��ɫֻ�г�������Ա���ܸ�����Ȩ' ,'' ,'' ,'' ,''  );

INSERT INTO td_sm_roletype ("TYPE_NAME" ,"TYPE_DESC" ,"TYPE_ID" ) 
 VALUES ('ͨ�ý�ɫ����' ,'ͨ�ý�ɫ����' ,1);

commit;
-----------------��ɫ��ʼ������------------------

-----------------��ԴȨ�޳�ʼ����ʼ------------------

-------------------------��������ԱȨ�޳�ʼ����ʼ------------------------
INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) 
VALUES ('rolemanager', 'globalroleoperation','3' ,'role' ,'0' , '��ɫ��Դ', 'role' );

INSERT INTO td_sm_roleresop 
("OP_ID" ,"RES_ID" ,"ROLE_ID" ,"RESTYPE_ID" ,"AUTO" ,"RES_NAME" ,"TYPES" ) 
VALUES ('visible', 'sysmanager','3' ,'column' ,'0' ,'ϵͳ����' ,'role');
-------------------------��������ԱȨ�޳�ʼ������-------------------------

commit;
-----------------��ԴȨ�޳�ʼ������------------------


-----------------�û���ɫ��ʼ����ʼ------------------
INSERT INTO TD_SM_USERROLE ("USER_ID" ,"ROLE_ID" ) VALUES (1 ,'1'  );
commit;
-----------------�û���ɫ��ʼ������------------------


-----------------��λ��ʼ����ʼ------------------
INSERT INTO TD_SM_JOB ("JOB_ID" ,"JOB_NAME" ,"JOB_DESC" ) VALUES ('1' ,'��ְ' ,'����ɾ��' )  ; 
commit;
-----------------��λ��ʼ������------------------




-----------------ƽ̨tableinfo���Ӧ�õ���Ϣ��ʼ����ʼ------------------

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

-----------------tableinfo��ʼ������------------------



-----------------�������ͳ�ʼ����ʼ------------------
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(1,'�ı�����','','',''); 
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(2,'ѡ���ֵ�','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(3,'ѡ��ʱ��','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(4,'��������','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(5,'ѡ�����','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(6,'ѡ����Ա','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(7,'��ǰ�û�','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(8,'��ǰ����','','','') ;
insert into tb_sm_inputtype(INPUT_TYPE_ID,INPUT_TYPE_NAME,INPUT_TYPE_DESC,DATASOURCE_PATH,SCRIPT)
values(9,'��ǰ�û�','','','') ;
commit;
-----------------�������ͳ�ʼ������------------------


-----------------�ֵ����ͳ�ʼ����ʼ------------------
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'9', 'isPublicAffair', '�ճ̹����Ƿ���', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'6', 'intervalType', '�ճ̹�������ʱ������λ', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'2', 'isvalid', '��Ч��', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'1', 'sex', '�Ա�', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'5', 'orgType', '��������', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'4', 'MailPostfix', '�����׺', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'3', 'userType', '�û�����', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'7', 'essentiality', '�ճ̹�����Ҫ��', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT,DICTTYPE_TYPE ) VALUES ( 
'8', 'isLeisure', '�ճ̹����Ƿ����', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC, 
DICTTYPE_PARENT,DICTTYPE_TYPE) VALUES ( 
'45', 'ispartybussiness', '�����Ƿ�ҵ����', '0', 0); 
INSERT INTO TD_SM_DICTTYPE ( DICTTYPE_ID, DICTTYPE_NAME, DICTTYPE_DESC,
DICTTYPE_PARENT ) VALUES ( 
'2312', '�Ƿ��ֵ�', '�Ƿ��ֵ�', '0')
;
commit;
-----------------�ֵ����ͳ�ʼ������------------------

-----------------�ֵ����ݳ�ʼ����ʼ------------------
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 70, '2312', '��', '1','0')
;
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 71 , '2312', '��', '0','1')
;
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'60', '9', '����', '0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'61', '9', '˽��', '1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'62', '6', '��', '0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'63', '6', 'Сʱ', '1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'64', '6', '��', '2'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'65', '7', '��Ҫ', '0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'66', '7', 'һ��', '1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'67', '7', '����Ҫ', '2'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'68', '8', 'æ', '0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'69', '8', '����', '1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'11', '1', '��', 'M'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'12', '1', 'Ů', 'F');
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'124', '2', 'ɾ��', '0','3'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'125', '2', '����', '1','1');   
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'126', '2', '��ͨ', '2','0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'127', '2', 'ͣ��', '3','2'); 
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
'13', '1', 'δ֪', '-1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'41', '5', '��Ч', '0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ) VALUES ( 
'42', '5', '��Ч', '1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'51', '3', '�ⲿ�û�', '1','1'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME,
DICTDATA_VALUE ,DICTDATA_ORDER) VALUES ( 
'53', '3', 'ϵͳ�û�', '0','0'); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME, DICTDATA_VALUE,
DICTDATA_ORDER ) VALUES ( 
'192', '45', '��', '0', 1); 
INSERT INTO TD_SM_DICTDATA ( DICTDATA_ID, DICTTYPE_ID, DICTDATA_NAME, DICTDATA_VALUE,
DICTDATA_ORDER ) VALUES ( 
'193', '45', '��', '1', 2); 
commit;
-----------------�ֵ����ݳ�ʼ������------------------

---------------ϵͳ�������ݳ�ʼ������--------------------





------------------------ϵͳ������ͼ��ʼ-----------------------

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
--һ���û����еĽ�ɫ�Ļ�����Դ
--�û���ɫ
select u_role.user_id, u_role.role_id from td_sm_userrole u_role
union
--�û������û���� ��ɫ
select u_group.user_id,g_role.role_id from td_sm_usergroup u_group
join td_sm_grouprole g_role on u_group.group_id=g_role.group_id
union
--�û����������Ľ�ɫ
select org_user.user_id,org_role.role_id from td_sm_userjoborg org_user
join td_sm_orgrole org_role on  org_user.org_id=org_role.org_id
union
--�û�������λ�Ľ�ɫ
select u_job.user_id,org_job_role.role_id from td_sm_userjoborg u_job
 inner join td_sm_orgjobrole org_job_role
 on u_job.job_id=org_job_role.job_id and u_job.org_id=org_job_role.org_id
)allroles
--ͨ����ɫID,����CS��Դ��ͼ
,
v_tb_res_org_role orgres_role
where  orgres_role.role_id in(allroles.role_id,
    --�ټ���'��ͨ�û�'��ɫID
    (select t.role_id from td_sm_role t where t.role_name='roleofeveryone')
)
union
--union ֱ�ӷ�����û�����Դ
select to_char(roleres.role_id) as user_id,  
       roleres.res_id as org_id,
       org.parent_id as parent_id,
       roleres.op_id as op_id,
       roleres.restype_id  as restype_id
    from td_sm_roleresop roleres
    join td_sm_organization org on roleres.res_id=org.org_id 
where roleres.types='user' and roleres.restype_id='orgunit'
union
--union ֱ�ӷ�����û���������Դ
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
--һ���û����еĽ�ɫ�Ľ�ɫ��Դ
--�û���ɫ
select u_role.user_id, u_role.role_id from td_sm_userrole u_role
union
--�û������û���� ��ɫ
select u_group.user_id,g_role.role_id from td_sm_usergroup u_group
join td_sm_grouprole g_role on u_group.group_id=g_role.group_id
union
--�û����������Ľ�ɫ
select org_user.user_id,org_role.role_id from td_sm_userjoborg org_user
join td_sm_orgrole org_role on  org_user.org_id=org_role.org_id
union
--�û�������λ�Ľ�ɫ
select u_job.user_id,org_job_role.role_id from td_sm_userjoborg u_job
 inner join td_sm_orgjobrole org_job_role
 on u_job.job_id=org_job_role.job_id and u_job.org_id=org_job_role.org_id
)allroles
--ͨ����ɫID,����CS��Դ��ͼ
,
v_tb_res_role_role roleres_role
where  roleres_role.role_id in(allroles.role_id,
    --�ټ���'��ͨ�û�'��ɫID
    (select t.role_id from td_sm_role t where t.role_name='roleofeveryone')
)
union
--union ֱ�ӷ�����û�����Դ
select to_char(roleres.role_id) as user_id,
       roleres.res_id as role_id,
       roleres.op_id as op_id,
       roleres.restype_id as restype_id
    from td_sm_roleresop roleres
where roleres.types='user' and roleres.restype_id='role'
union
--union ֱ�ӷ�����û���������Դ
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
--һ���û����еĽ�ɫ�Ļ�����Դ
--�û���ɫ
select u_role.user_id, u_role.role_id from td_sm_userrole u_role
union
--�û������û���� ��ɫ
select u_group.user_id,g_role.role_id from td_sm_usergroup u_group
join td_sm_grouprole g_role on u_group.group_id=g_role.group_id
union
--�û����������Ľ�ɫ
select org_user.user_id,org_role.role_id from td_sm_userjoborg org_user
join td_sm_orgrole org_role on  org_user.org_id=org_role.org_id
union
--�û�������λ�Ľ�ɫ
select u_job.user_id,org_job_role.role_id from td_sm_userjoborg u_job
 inner join td_sm_orgjobrole org_job_role
 on u_job.job_id=org_job_role.job_id and u_job.org_id=org_job_role.org_id)
 ;
 





--�����б�
--���ڲ�ѯ��ǰ�û�������¼��Ӧ�������еĴ�������
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
-- ��ͼ�ֶ����ӱ�ע�ű���
COMMENT ON COLUMN v_app_work_list.pkgId
   IS '����';
   COMMENT ON COLUMN v_app_work_list.actname
   IS '�';
COMMENT ON COLUMN v_app_work_list.ec_name
   IS 'ҵ�����';
COMMENT ON COLUMN v_app_work_list.BUSITITLE
   IS '������';
   COMMENT ON COLUMN v_app_work_list.businessid
   IS 'ҵ��id';

--δ�����б�
--���ڲ�ѯ�����˱����ݶ�û����ɹ�����������
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
   IS '��ǰ����';
   COMMENT ON COLUMN v_app_tobework_list.ec_name
   IS 'ҵ�����';
COMMENT ON COLUMN v_app_tobework_list.busititle
   IS '������';
COMMENT ON COLUMN v_app_tobework_list.createtime
   IS '�ݴ�ʱ��';
   COMMENT ON COLUMN v_app_tobework_list.businessid
   IS 'ҵ��id';


--����б�
--���ڲ�ѯ�û����й������������б�
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
   IS '����ִ�л';
   COMMENT ON COLUMN v_app_donework_list.run_actname
   IS '��ǰ���л';
COMMENT ON COLUMN v_app_donework_list.busititle
   IS '������';
   COMMENT ON COLUMN v_app_donework_list.ec_name
   IS 'ҵ�����';
   COMMENT ON COLUMN v_app_donework_list.businessid
   IS 'ҵ��id';


--���̼���б�
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
   IS 'ҵ�����';
   COMMENT ON COLUMN v_app_process_monitor_list.busititle
   IS '������';
COMMENT ON COLUMN v_app_process_monitor_list.businessid
   IS 'ҵ��id';
COMMENT ON COLUMN v_app_process_monitor_list.run_actname
   IS '��ǰ�';

   
 ------------------------ϵͳ������ͼ����-----------------------
 
 
 ------------------------������������־-------------------------
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
'������������־';

comment on column WORKFLOW_OPERATE_LOG.LOG_ID is
'��־ID';

comment on column WORKFLOW_OPERATE_LOG.BUSINESS_ID is
'ҵ��ID';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_TIME is
'����ʱ��';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_USER is
'�����û�';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_TYPE is
'���̲�������';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_PARAMS is
'����������JSON��ʽ��';

comment on column WORKFLOW_OPERATE_LOG.OPERATE_RESULT is
'���̲������';

comment on column WORKFLOW_OPERATE_LOG.PROC_DEFNAME is
'���̶�������';

comment on column WORKFLOW_OPERATE_LOG.ACT_DEFID is
'�����ID';

comment on column WORKFLOW_OPERATE_LOG.PROC_INSTANCEID is
'����ʵ��ID';

comment on column WORKFLOW_OPERATE_LOG.ACT_INSTANCEID is
'�ʵ��ID';

comment on column WORKFLOW_OPERATE_LOG.MODULE_ID is
'����ID';

comment on column WORKFLOW_OPERATE_LOG.APP_ID is
'����Ӧ��ID';


--������������ͼ

CREATE OR REPLACE VIEW V_APP_WORKFLOW_OPERATE_LOG AS 
  select
   l.LOG_ID,
   l.BUSINESS_ID,
   l.OPERATE_TIME,
   l.OPERATE_USER,
   l.OPERATE_TYPE,
   decode(l.OPERATE_RESULT,'Y','�ɹ�','N','ʧ��') as OPERATE_RESULT_NAME,
   l.OPERATE_PARAMS,
   l.OPERATE_RESULT,
   l.APP_ID
from
   &user.WORKFLOW_OPERATE_LOG l
 ;
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.LOG_ID IS '��־ID';
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.BUSINESS_ID IS 'ҵ����';
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.OPERATE_TIME IS '����ʱ��';
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.OPERATE_USER IS '�����û�';
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.OPERATE_TYPE IS '���̲�������';
 
   COMMENT ON COLUMN V_APP_WORKFLOW_OPERATE_LOG.OPERATE_RESULT_NAME IS '���̲������';
   
------------------------������������־����-------------------------