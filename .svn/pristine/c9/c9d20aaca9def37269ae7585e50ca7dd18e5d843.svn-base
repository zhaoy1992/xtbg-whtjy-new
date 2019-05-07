-- Add/modify columns 
alter table OA_ACT_TEXT_STAUTS add is_msg CHAR(1);
alter table OA_ACT_TEXT_STAUTS add is_sign CHAR(1);
alter table OA_ACT_TEXT_STAUTS add is_keeptrace CHAR(1);
alter table OA_ACT_TEXT_STAUTS add is_attachment CHAR(1);
alter table OA_ACT_TEXT_STAUTS add is_serialnumber CHAR(1);
-- Add comments to the columns 
comment on column OA_ACT_TEXT_STAUTS.is_msg
  is '是否发送短信';
comment on column OA_ACT_TEXT_STAUTS.is_sign
  is '是否可签名';
comment on column OA_ACT_TEXT_STAUTS.is_keeptrace
  is '是否保留痕迹';
comment on column OA_ACT_TEXT_STAUTS.is_attachment
  is '是否处理附件';
comment on column OA_ACT_TEXT_STAUTS.is_serialnumber
  is '是否可编号';

DROP TABLE OA_WORD_NUMBER CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_WORD_NUMBER                                        */
/*==============================================================*/
CREATE TABLE OA_WORD_NUMBER 
(
   NUMBER_ID            VARCHAR2(50)         NOT NULL,
   NUMBER_TYPE          VARCHAR2(50)         NOT NULL,
   NUMBER_YEAR          VARCHAR2(50)         NOT NULL,
   NUMBER_CODE          NUMBER               NOT NULL,
   BUSI_ID              VARCHAR2(50),
   CONSTRAINT PK_OA_WORD_NUMBER PRIMARY KEY (NUMBER_ID)
);

COMMENT ON TABLE OA_WORD_NUMBER IS
'公文编号';

COMMENT ON COLUMN OA_WORD_NUMBER.NUMBER_ID IS
'编号ID';

COMMENT ON COLUMN OA_WORD_NUMBER.NUMBER_TYPE IS
'编号类型';

COMMENT ON COLUMN OA_WORD_NUMBER.NUMBER_YEAR IS
'编号年份';

COMMENT ON COLUMN OA_WORD_NUMBER.NUMBER_CODE IS
'编号号码';

COMMENT ON COLUMN OA_WORD_NUMBER.BUSI_ID IS
'业务ID';


insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
values ('724ec03e-31d5-4a8e-92a7-132e8022d36b', '0', '公文编号类型', 'gwbhlx', '公文编号类型', '1', null, '0');

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('9123c6d2-e092-4ae2-ba92-d462f1b750c4', '724ec03e-31d5-4a8e-92a7-132e8022d36b', '0', 'XX办', '2', 'XX办', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('66145faa-896b-4be2-8509-cb77bd928943', '724ec03e-31d5-4a8e-92a7-132e8022d36b', '0', 'XX提', '1', 'XX提', '1', 1);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('af342593-03ce-4fee-a3d7-7a62f6985c68', '724ec03e-31d5-4a8e-92a7-132e8022d36b', '0', 'XX行罚', '3', 'XX行罚', '1', 3);

