
--1
create sequence SEQ_OA_FLOW_INSWFACTION
minvalue 1
maxvalue 99999999999999999999
start with 1
increment by 1
nocache;
/
--2
-- Add/modify columns 
alter table OA_FLOW_INSWFACTION add INSERT_ORDER number;
-- Add comments to the columns 
comment on column OA_FLOW_INSWFACTION.INSERT_ORDER
  is '活动环节信息''新增序号''';
/
--3
CREATE OR REPLACE FUNCTION OA_IS_BACK(V_INS_ID IN VARCHAR2,
                                      V_USER_NAME IN VARCHAR2)
--该函数用于查询，该用户是否有该流程实例的退回权限，如果是在办的并且上一步提交人是自己就有权限
  RETURN VARCHAR2 AS
  ACT_INDEX VARCHAR2(50);
  T_STATUS_CODE VARCHAR2(50);
BEGIN
  SELECT MIN(ACT_INDEX)
    INTO ACT_INDEX
    FROM (SELECT ROW_NUMBER() OVER(ORDER BY NVL(INSERT_ORDER,0) DESC,W.TACHE_BEGIN_TIME DESC) ACT_INDEX,
                 W.ACTION_HANDERNAME
            FROM OA_FLOW_INSWFACTION W
           WHERE W.INS_ID = V_INS_ID
             AND W.IS_VALID = 'Y')
   WHERE ACTION_HANDERNAME = V_USER_NAME;
   --如果是2代表，上一步是自己提交
   IF ACT_INDEX = 2 THEN
   SELECT STATUS_CODE INTO T_STATUS_CODE FROM OA_FLOW_INSTANCE WHERE INS_ID = V_INS_ID;
       IF T_STATUS_CODE = '01' THEN
          RETURN 1;
       ELSE
         RETURN 0;
       END IF;
   ELSE
   RETURN 0;
   END IF;
END;
/