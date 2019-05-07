-- Add/modify columns 
alter table OA_FLOW_BUSITYPE add BUSITYPE_ORDER number;
-- Add comments to the columns 
comment on column OA_FLOW_BUSITYPE.BUSITYPE_ORDER
  is '排序号';
  
---文号定义表
DROP TABLE OA_WORD_NUMBER_DEF CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_WORD_NUMBER_DEF                                    */
/*==============================================================*/
CREATE TABLE OA_WORD_NUMBER_DEF 
(
   NUMBER_TYPE          VARCHAR2(50)         NOT NULL,
   NUMBER_YEAR          VARCHAR2(50)         NOT NULL,
   NUMBER_ORDER         NUMBER,
   NUMBER_ORG_ID        VARCHAR2(50)         NOT NULL,
   REMARK1              VARCHAR2(200),
   CONSTRAINT PK_OA_WORD_NUMBER_DEF PRIMARY KEY (NUMBER_TYPE, NUMBER_YEAR, NUMBER_ORG_ID)
);

COMMENT ON TABLE OA_WORD_NUMBER_DEF IS
'公文编号定义表';

COMMENT ON COLUMN OA_WORD_NUMBER_DEF.NUMBER_TYPE IS
'编号类型';

COMMENT ON COLUMN OA_WORD_NUMBER_DEF.NUMBER_YEAR IS
'编号年份';

COMMENT ON COLUMN OA_WORD_NUMBER_DEF.NUMBER_ORDER IS
'排序号';

COMMENT ON COLUMN OA_WORD_NUMBER_DEF.NUMBER_ORG_ID IS
'机构号';

COMMENT ON COLUMN OA_WORD_NUMBER_DEF.REMARK1 IS
'扩展字段';
  

-- Add/modify columns 
alter table OA_ACT_TEXT_STAUTS add IS_XD CHAR(1);
alter table OA_ACT_TEXT_STAUTS add IS_GWFF CHAR(1);
alter table OA_ACT_TEXT_STAUTS add IS_CD CHAR(1);
alter table OA_ACT_TEXT_STAUTS add IS_CKLC CHAR(1);
alter table OA_ACT_TEXT_STAUTS add IS_NEWFLOW CHAR(1);
alter table OA_ACT_TEXT_STAUTS add IS_GK CHAR(1);
-- Add comments to the columns 
comment on column OA_ACT_TEXT_STAUTS.IS_XD
  is '是否校对';
comment on column OA_ACT_TEXT_STAUTS.IS_GWFF
  is '是否分发公文';
comment on column OA_ACT_TEXT_STAUTS.IS_CD
  is '是否存档';
comment on column OA_ACT_TEXT_STAUTS.IS_CKLC
  is '是否查看流程';
comment on column OA_ACT_TEXT_STAUTS.IS_NEWFLOW
  is '是否能发起新的流程';
comment on column OA_ACT_TEXT_STAUTS.IS_GK
  is '是否公开';

-- Add/modify columns 
alter table OA_FLOW_INSTANCE add IS_OPEN CHAR(1);
-- Add comments to the columns 
comment on column OA_FLOW_INSTANCE.IS_OPEN
  is '是否公开1，公开。2，不公开。3，申请后公开';
  
  