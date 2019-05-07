DROP TABLE OA_SERIAL_NUMBER CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_SERIAL_NUMBER                                    */
/*==============================================================*/
CREATE TABLE OA_SERIAL_NUMBER 
(
   S_ID               VARCHAR2(50)         NOT NULL,
   INS_ID             VARCHAR2(50),
   S_CODE             VARCHAR2(100),
   S_TIME             VARCHAR2(100),
   S_LSH              VARCHAR2(50),
   S_ORGID            VARCHAR2(50),
   S_ORGNAME          VARCHAR2(100),
   S_CREATETIME       DATE,
   S_ALLCODE          VARCHAR2(300),
   CONSTRAINT PK_OA_SERIAL_NUMBER PRIMARY KEY (S_ID)
);

COMMENT ON TABLE OA_SERIAL_NUMBER IS
'编号自动生成规则';

COMMENT ON COLUMN OA_SERIAL_NUMBER.S_ID IS
'主键id';

COMMENT ON COLUMN OA_SERIAL_NUMBER.INS_ID IS
'流程实例id';

COMMENT ON COLUMN OA_SERIAL_NUMBER.S_CODE IS
'代码';

COMMENT ON COLUMN OA_SERIAL_NUMBER.S_TIME IS
'日期';

COMMENT ON COLUMN OA_SERIAL_NUMBER.S_LSH IS
'流水号';

COMMENT ON COLUMN OA_SERIAL_NUMBER.S_ORGID IS
'单位id';

COMMENT ON COLUMN OA_SERIAL_NUMBER.S_ORGNAME IS
'单位名称';

COMMENT ON COLUMN OA_SERIAL_NUMBER.S_CREATETIME IS
'创建日期';

COMMENT ON COLUMN OA_SERIAL_NUMBER.S_ALLCODE IS
'流水全号（代码+日期+流水号）';