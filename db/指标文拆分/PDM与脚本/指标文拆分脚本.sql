ALTER TABLE OA_SPLIT_LOG
   DROP CONSTRAINT FK_OA_SPLIT_REFERENCE_OA_SPLIT;

DROP TABLE OA_SPLIT_UNIT CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_SPLIT_UNIT                                         */
/*==============================================================*/
CREATE TABLE OA_SPLIT_UNIT 
(
   UNIT_ID              VARCHAR2(40)         NOT NULL,
   PARENT_ID            VARCHAR2(40),
   UNIT_NAME            VARCHAR2(200),
   REMARK               VARCHAR2(400),
   IS_VALID             VARCHAR2(1),
   GWCS_ORG_ID          VARCHAR2(40),
   CONSTRAINT PK_OA_SPLIT_UNIT PRIMARY KEY (UNIT_ID)
);

COMMENT ON TABLE OA_SPLIT_UNIT IS
'�ļ���ֵ�λά��';

COMMENT ON COLUMN OA_SPLIT_UNIT.UNIT_ID IS
'��ֵ�λID';

COMMENT ON COLUMN OA_SPLIT_UNIT.PARENT_ID IS
'�ϼ�ID';

COMMENT ON COLUMN OA_SPLIT_UNIT.UNIT_NAME IS
'��ֵ�λ����';

COMMENT ON COLUMN OA_SPLIT_UNIT.REMARK IS
'��ע';

COMMENT ON COLUMN OA_SPLIT_UNIT.IS_VALID IS
'�Ƿ���Ч';

COMMENT ON COLUMN OA_SPLIT_UNIT.GWCS_ORG_ID IS
'���Ĵ��䵥λid������͹��Ĵ���Խ�';


ALTER TABLE OA_SPLIT_LOG
   DROP CONSTRAINT FK_OA_SPLIT_REFERENCE_OA_SPLIT;

DROP TABLE OA_SPLIT_LOG CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_SPLIT_LOG                                          */
/*==============================================================*/
CREATE TABLE OA_SPLIT_LOG 
(
   SPLIT_LOG_ID         VARCHAR2(40)         NOT NULL,
   UNIT_ID              VARCHAR2(40),
   BUSS_ID              VARCHAR2(40),
   PARENT_ID            VARCHAR2(40),
   FILE_NAME            VARCHAR2(200),
   FILE_PATH            VARCHAR2(500),
   FILE_SIZE            NUMBER,
   CREATED              DATE,
   USER_ID              VARCHAR2(40),
   CONSTRAINT PK_OA_SPLIT_LOG PRIMARY KEY (SPLIT_LOG_ID)
);

COMMENT ON TABLE OA_SPLIT_LOG IS
'�ļ���ּ�¼��';

COMMENT ON COLUMN OA_SPLIT_LOG.SPLIT_LOG_ID IS
'���';

COMMENT ON COLUMN OA_SPLIT_LOG.UNIT_ID IS
'��ֵ�λID';

COMMENT ON COLUMN OA_SPLIT_LOG.BUSS_ID IS
'�ļ����ҵ��ID';

COMMENT ON COLUMN OA_SPLIT_LOG.PARENT_ID IS
'��ID';

COMMENT ON COLUMN OA_SPLIT_LOG.FILE_NAME IS
'��ֵ��ļ���';

COMMENT ON COLUMN OA_SPLIT_LOG.FILE_PATH IS
'�ļ����·��';

COMMENT ON COLUMN OA_SPLIT_LOG.FILE_SIZE IS
'�ļ���С(��λ���ֽ�)';

COMMENT ON COLUMN OA_SPLIT_LOG.CREATED IS
'���ʱ��';

COMMENT ON COLUMN OA_SPLIT_LOG.USER_ID IS
'������ԱID';

ALTER TABLE OA_SPLIT_LOG
   ADD CONSTRAINT FK_OA_SPLIT_REFERENCE_OA_SPLIT FOREIGN KEY (UNIT_ID)
      REFERENCES OA_SPLIT_UNIT (UNIT_ID);
