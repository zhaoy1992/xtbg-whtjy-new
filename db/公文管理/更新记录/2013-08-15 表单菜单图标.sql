-- Add/modify columns 
alter table OA_FLOW_BASEINFO add FORM_IMAGE_ID VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_FLOW_BASEINFO.FORM_IMAGE_ID
  is '表单菜单图标';

-- Add/modify columns 
alter table OA_FLOW_BASEINFO add ATTACH_ID VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_FLOW_BASEINFO.ATTACH_ID
  is '附件ID';

-- Add/modify columns 
alter table OA_FLOW_INSTANCE add TEMPLATE_ID VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_FLOW_INSTANCE.TEMPLATE_ID
  is '模板ID';

CREATE OR REPLACE VIEW VIEW_OA_INSTANCE AS
SELECT
   I.INS_ID,
   B.BUSITYPE_NAME,
   I.BUSITYPE_CODE,
   I.INS_NAME,
   I.INS_CODE,
   I.ACCEPT_TIME,
   I.ACCEPTER,
   I.ACCEPTER_ID,
   I.ORG_ID,
   I.FLOW_ID,
   I.DEF_ID,
   I.CC_FORM_INSTANCEID,
   I.BUSI_ID,
   I.LASTMODIFEDTIME,
   I.STATUS_CODE,
   C.ACTION_FORM,
   C.ACT_INSID,
   C.PROCESSID,
   C.ACTION_NAME,
   C.ACT_DEFID,
   C.ACTION_HANDERNAME,
   C.ACTION_HANDERID,
   C.TACHE_BEGIN_TIME,
   C.TACHE_END_TIME,
   C.IS_VALID,
   I.Template_Id
FROM
   OA_FLOW_BUSITYPE B,
   OA_FLOW_INSTANCE I,
   OA_FLOW_INSWFACTION C
WHERE
   I.BUSITYPE_CODE = TRIM(B.BUSITYPE_CODE)
   AND I.INS_ID = C.INS_ID;

CREATE OR REPLACE VIEW VIEW_OA_WORK_LIST AS
SELECT
       I.INS_ID,
       I.INS_CODE,
       I.BUSITYPE_NAME,
       I.BUSITYPE_CODE,
       I.INS_NAME,
       I.ACCEPTER,
       I.ACCEPT_TIME,
       I.LASTMODIFEDTIME,
       I.CC_FORM_INSTANCEID,
       I.BUSI_ID,
       I.FLOW_ID,
       I.DEF_ID,
       I.ACTION_NAME AS ACT_NAME,
       I.ACT_INSID AS ACTINSID,
       I.PROCESSID AS PROCID,
       I.ACT_DEFID AS ACTION_DEFID,
       I.ACTION_FORM AS FLOW_FORM,
       I.STATUS_CODE,
       I.Template_Id,
       U.USER_NAME AS USERNAME,
        (SELECT W.ACTIONTYPE_CODE
          FROM OA_FLOW_WFACTION W
         WHERE W.DEF_ID = I.DEF_ID
           AND W.ACTION_DEFID = I.ACT_DEFID) AS ACTIONTYPE_CODE
  FROM VIEW_OA_INSTANCE I,
       OA_FLOW_ACTIONUSER U
 WHERE I.INS_ID = U.INS_ID AND I.ACTION_HANDERNAME IS NULL AND I.STATUS_CODE != '04' AND U.IS_HANDLE='1' AND I.ACT_INSID = U.ACTIVITY;


CREATE OR REPLACE VIEW VIEW_OA_TOBEWORK_LIST AS
SELECT
   I.INS_ID,
   I.INS_CODE,
   I.BUSITYPE_NAME,
   I.BUSITYPE_CODE,
   I.INS_NAME,
   I.ACCEPTER,
   I.ACCEPT_TIME,
   I.LASTMODIFEDTIME,
   I.CC_FORM_INSTANCEID,
   I.BUSI_ID,
   I.FLOW_ID,
   I.DEF_ID,
   I.ACTION_NAME AS ACT_NAME,
   I.ACT_INSID AS ACTINSID,
   I.ACTION_FORM AS FLOW_FORM,
   U.ACTIVITYPROCESSDEFNAME AS MGRNAME,
   U.USER_NAME AS USERNAME,
   I.Template_Id
FROM
   VIEW_OA_INSTANCE I,
   OA_FLOW_ACTIONUSER U
WHERE I.INS_ID = U.INS_ID AND I.ACTION_HANDERNAME IS NULL AND I.STATUS_CODE = '04';
