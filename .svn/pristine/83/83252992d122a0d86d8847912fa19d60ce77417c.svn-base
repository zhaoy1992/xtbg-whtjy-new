ALTER TABLE OA_FLOW_BUSITYPE
   DROP CONSTRAINT FK_OA_FLOW_BUSITYPE_TYPE;

DROP TABLE OA_FLOW_BUSITYPE_TYPE CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_FLOW_BUSITYPE_TYPE                                 */
/*==============================================================*/
CREATE TABLE OA_FLOW_BUSITYPE_TYPE 
(
   BUSITYPE_TYPE_CODE   VARCHAR2(50)         NOT NULL,
   BUSITYPE_TYPE_NAME   VARCHAR2(50)         NOT NULL,
   TYPE_DESC            VARCHAR2(200),
   IS_VALID             CHAR(1)              DEFAULT 'Y' NOT NULL,
   IS_FLOW              CHAR(1)              DEFAULT 'Y' NOT NULL,
   ORDER_NO             NUMBER,
   CONSTRAINT PK_OA_FLOW_BUSITYPE_TYPE PRIMARY KEY (BUSITYPE_TYPE_CODE)
);

COMMENT ON TABLE OA_FLOW_BUSITYPE_TYPE IS
'业务类型分类表';

COMMENT ON COLUMN OA_FLOW_BUSITYPE_TYPE.BUSITYPE_TYPE_CODE IS
'类型分类编码';

COMMENT ON COLUMN OA_FLOW_BUSITYPE_TYPE.BUSITYPE_TYPE_NAME IS
'类型分类名称';

COMMENT ON COLUMN OA_FLOW_BUSITYPE_TYPE.TYPE_DESC IS
'类型分类描述';

COMMENT ON COLUMN OA_FLOW_BUSITYPE_TYPE.IS_VALID IS
'是否有效';

COMMENT ON COLUMN OA_FLOW_BUSITYPE_TYPE.IS_FLOW IS
'是否在流程列表中显示';

COMMENT ON COLUMN OA_FLOW_BUSITYPE_TYPE.ORDER_NO IS
'排序号';

-- Add/modify columns 
alter table OA_FLOW_BUSITYPE add busitype_type_code VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_FLOW_BUSITYPE.busitype_type_code
  is '业务类型分类CODE';

  -- Create/Recreate primary, unique and foreign key constraints 
alter table OA_FLOW_BUSITYPE
add constraint FK_OA_FLOW_BUSITYPE_TYPE foreign key (BUSITYPE_TYPE_CODE)
references oa_flow_busitype_type (BUSITYPE_TYPE_CODE);
    
--初始化业务类型分类，此处也可以手动修改数据库
insert into Oa_Flow_Busitype_Type (BUSITYPE_TYPE_CODE, BUSITYPE_TYPE_NAME, TYPE_DESC, IS_VALID, IS_FLOW, ORDER_NO)
values ('cs', '测试', '测试', '1', '1', 3);

update  Oa_Flow_Busitype  set busitype_type_code = 'cs';

commit;

DROP TABLE OA_WORD_NUMBER CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_WORD_NUMBER                                        */
/*==============================================================*/
CREATE TABLE OA_WORD_NUMBER 
(
   BUSI_ID              VARCHAR2(50)         NOT NULL,
   NUMBER_TYPE          VARCHAR2(50)         NOT NULL,
   NUMBER_YEAR          VARCHAR2(50)         NOT NULL,
   NUMBER_CODE          NUMBER               NOT NULL,
   CONSTRAINT PK_OA_WORD_NUMBER PRIMARY KEY (BUSI_ID, NUMBER_TYPE, NUMBER_YEAR, NUMBER_CODE)
);

COMMENT ON TABLE OA_WORD_NUMBER IS
'公文编号';

COMMENT ON COLUMN OA_WORD_NUMBER.BUSI_ID IS
'业务ID';

COMMENT ON COLUMN OA_WORD_NUMBER.NUMBER_TYPE IS
'编号类型';

COMMENT ON COLUMN OA_WORD_NUMBER.NUMBER_YEAR IS
'编号年份';

COMMENT ON COLUMN OA_WORD_NUMBER.NUMBER_CODE IS
'编号号码';
