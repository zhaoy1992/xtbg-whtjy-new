create or replace view oa_fw_v_vworklist as
select i.INS_ID,
       i.BUSITYPE_NAME,
       i.BUSITYPE_CODE,
       i.ACCEPT_TIME,
       i.ACTION_FORM,
       i.INS_NAME,
       i.INS_CODE,
       i.BUSI_ID,
       i.ORG_ID,
       i.ACCEPTER,
       bt.busitype_type_code,
       btt.count_type,
       i.Template_Id
  from view_oa_instance i,OA_FLOW_BUSITYPE bt,oa_flow_busitype_type btt
 where i.is_valid = 'Y' and i.BUSITYPE_CODE=bt.busitype_code and bt.busitype_type_code = btt.busitype_type_code 
 group by i.INS_ID,
          i.BUSITYPE_NAME,
          i.BUSITYPE_CODE,
          i.ACCEPT_TIME,
          i.ACTION_FORM,
          i.INS_NAME,
          i.INS_CODE,
          i.BUSI_ID,
          i.ORG_ID,
          i.ACCEPTER,
          bt.busitype_type_code,
          btt.count_type,
          i.Template_Id;




DROP TABLE OA_SFW_USERLISTCONF CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_SFW_USERLISTCONF                                   */
/*==============================================================*/
CREATE TABLE OA_SFW_USERLISTCONF 
(
   ID                   VARCHAR(50)          NOT NULL,
   LIST_TYPE            VARCHAR(30)          NOT NULL,
   EXTABLE              VARCHAR(30),
   COLUMN_LIST          VARCHAR(200),
   USER_ID              VARCHAR(50)          NOT NULL,
   CONSTRAINT PK_OA_SFW_USERLISTCONF PRIMARY KEY (ID)
);

COMMENT ON TABLE OA_SFW_USERLISTCONF IS
'收发文登记薄用户列表配置表';

COMMENT ON COLUMN OA_SFW_USERLISTCONF.LIST_TYPE IS
'列表类型';

COMMENT ON COLUMN OA_SFW_USERLISTCONF.EXTABLE IS
'绑定的扩展表';

COMMENT ON COLUMN OA_SFW_USERLISTCONF.COLUMN_LIST IS
'绑定的相应的表的字段集合';

COMMENT ON COLUMN OA_SFW_USERLISTCONF.USER_ID IS
'用户id';
