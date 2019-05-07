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
       i.Template_Id
  from view_oa_instance i,OA_FLOW_BUSITYPE bt
 where i.is_valid = 'Y' and i.BUSITYPE_CODE=bt.busitype_code
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
          i.Template_Id;
/          