-- Add/modify columns 
alter table OA_ARCHIVE_DISPATCH add UNION_ARCHIVE_BUSS_ID VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_ARCHIVE_DISPATCH.UNION_ARCHIVE_BUSS_ID
  is '联合盖章发送成功后返回的业务ID';
  
-- Add/modify columns 
alter table OA_ARCHIVE_DISPATCH add UNION_ARCHIVE_IS_SEND VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_ARCHIVE_DISPATCH.UNION_ARCHIVE_IS_SEND
  is '联合盖章发送是否成功';  
  
DROP TABLE OA_UNION_ARCHIVE_SIGN CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_UNION_ARCHIVE_SIGN                                 */
/*==============================================================*/
CREATE TABLE OA_UNION_ARCHIVE_SIGN 
(
   ID                   VARCHAR2(50)         NOT NULL,
   BUSS_ID              VARCHAR2(50)         NOT NULL,
   ORGADDR              VARCHAR2(500)        NOT NULL,
   ORGNAME   		    VARCHAR2(500),
   SIGNORDER            VARCHAR2(50),
   ISSIGNED             VARCHAR2(50),
   TERMINATE            VARCHAR2(500),
   ISSTAMPING           VARCHAR2(50),
   STAMPDATE            DATE,
   CONSTRAINT PK_OA_UNION_ARCHIVE_SIGN PRIMARY KEY (ID)
);

COMMENT ON TABLE OA_UNION_ARCHIVE_SIGN IS
'联合盖章表';

COMMENT ON COLUMN OA_UNION_ARCHIVE_SIGN.ID IS
'流程实例ID';

COMMENT ON COLUMN OA_UNION_ARCHIVE_SIGN.BUSS_ID IS
'公文业务ID';

COMMENT ON COLUMN OA_UNION_ARCHIVE_SIGN.ORGADDR IS
'参与盖章的单位地址码';

comment on column OA_UNION_ARCHIVE_SIGN.ORGNAME IS 
'参与盖章的单位名称';
  
COMMENT ON COLUMN OA_UNION_ARCHIVE_SIGN.SIGNORDER IS
'盖章顺序，主办方默认为第一位 1 ';

COMMENT ON COLUMN OA_UNION_ARCHIVE_SIGN.ISSIGNED IS
'是否完成盖章操作默认为 0 表示未完成盖章 1 表示完成盖章';

COMMENT ON COLUMN OA_UNION_ARCHIVE_SIGN.TERMINATE IS
'该单位是否终止联合盖章 0 表示未终止 1 表示终止';

COMMENT ON COLUMN OA_UNION_ARCHIVE_SIGN.ISSTAMPING IS
'盖章流程标识默认为0表示未到此单位，1 表示已到此单位';

COMMENT ON COLUMN OA_UNION_ARCHIVE_SIGN.STAMPDATE IS
' 盖章或者终止的时间';
  