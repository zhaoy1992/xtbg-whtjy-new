CREATE OR REPLACE FUNCTION OA_IS_BACK(V_INS_ID IN VARCHAR2,
                                      V_USER_NAME IN VARCHAR2)
--该函数用于查询，该用户是否有该流程实例的退回权限，如果是在办的并且上一步提交人是自己就有权限
  RETURN VARCHAR2 AS
  ACT_INDEX VARCHAR2(50);
  T_STATUS_CODE VARCHAR2(50);
  IS_SIGN_ACTION VARCHAR2(50);
  CURR_ACTION_ID VARCHAR2(50);--流程实例当前的ACTION_ID
  USER_ACTION_ID VARCHAR2(50);--用户所在该流程实例最新的ACTION_ID
BEGIN
  SELECT STATUS_CODE INTO T_STATUS_CODE FROM OA_FLOW_INSTANCE WHERE INS_ID = V_INS_ID;
  IF T_STATUS_CODE = '01' THEN

      --查新出该流程实例所在的ACTION
      SELECT NVL(OFW.ISSIGNJOINBYORDER,'0'), OFW.ACTION_ID INTO IS_SIGN_ACTION ,CURR_ACTION_ID FROM OA_FLOW_WFACTIONEXT OFW WHERE OFW.ACTION_ID =(
      SELECT OFII.ACTION_ID
        FROM OA_FLOW_INSWFACTION OFII
       WHERE OFII.INSERT_ORDER =
             (SELECT MAX(OFI.INSERT_ORDER)
                FROM OA_FLOW_INSWFACTION OFI
               WHERE OFI.INS_ID = V_INS_ID));

      --查询当前环节是否是会签环节
      --判断处理
         IF IS_SIGN_ACTION = '0' THEN
             --查询出用户所在的该流程的最后的环节ID，及排序号。（查询SQL待优化）
             SELECT ACT_INDEX,ACITON_ID
              INTO ACT_INDEX, USER_ACTION_ID
              FROM (SELECT ROW_NUMBER() OVER(ORDER BY NVL(INSERT_ORDER,0) DESC,W.TACHE_BEGIN_TIME DESC) ACT_INDEX, W.ACTION_HANDERNAME  ACTION_HANDERNAME,W.ACTION_ID ACITON_ID
                      FROM OA_FLOW_INSWFACTION W
                     WHERE W.INS_ID = V_INS_ID
                            AND W.IS_VALID = 'Y'
                            AND ((W.ACTION_ID = CURR_ACTION_ID
                                  AND W.ACTION_HANDERNAME NOT IN (SELECT USER_NAME FROM OA_FLOW_ACTIONUSER W WHERE W.INS_ID = V_INS_ID))
                                 OR W.ACTION_ID <> CURR_ACTION_ID)
                            ) M
             WHERE ACTION_HANDERNAME = V_USER_NAME
              AND ACT_INDEX =
               ( SELECT MIN(ACT_INDEX)
                  FROM (SELECT ROW_NUMBER() OVER(ORDER BY NVL(INSERT_ORDER, 0) DESC, W.TACHE_BEGIN_TIME DESC) ACT_INDEX,
                                W.ACTION_HANDERNAME ACTION_HANDERNAME
                           FROM OA_FLOW_INSWFACTION W
                          WHERE W.INS_ID = V_INS_ID
                            AND W.IS_VALID = 'Y'
                            AND ((W.ACTION_ID = CURR_ACTION_ID
                                  AND W.ACTION_HANDERNAME NOT IN (SELECT USER_NAME FROM OA_FLOW_ACTIONUSER W WHERE W.INS_ID = V_INS_ID))
                                 OR W.ACTION_ID <> CURR_ACTION_ID)
                            ) M
                 WHERE ACTION_HANDERNAME = V_USER_NAME);

             --查询该环节是不是会签环节
             SELECT NVL(ISSIGNJOINBYORDER,'0') INTO IS_SIGN_ACTION FROM OA_FLOW_WFACTIONEXT WHERE ACTION_ID = USER_ACTION_ID;
             IF IS_SIGN_ACTION <> '0' THEN
               --如果是会签环节，那么返回0，不能被追回。
               RETURN 0;
             ELSE
                 --如果是1代表，上一步是自己提交，并且不是会签环节
                 IF ACT_INDEX = 1 THEN
                 --SELECT STATUS_CODE INTO T_STATUS_CODE FROM OA_FLOW_INSTANCE WHERE INS_ID = V_INS_ID;
                   IF T_STATUS_CODE = '01' THEN
                      RETURN 1;
                   ELSE
                     RETURN 0;
                   END IF;
                 ELSE
                   RETURN 0;
                 END IF;
              END IF;

         ELSE
             --用户在除去会签环节的第一个环节可以追回，否则不行
             SELECT MIN(ACT_INDEX)
              INTO ACT_INDEX
               FROM (SELECT ROW_NUMBER() OVER(ORDER BY NVL(INSERT_ORDER,0) DESC,W.TACHE_BEGIN_TIME DESC) ACT_INDEX, W.ACTION_HANDERNAME
                        FROM OA_FLOW_INSWFACTION W ,OA_FLOW_WFACTIONEXT F
                       WHERE W.ACTION_ID = F.ACTION_ID AND  W.INS_ID = V_INS_ID
                         AND W.IS_VALID = 'Y' AND F.ISSIGNJOINBYORDER IS  NULL )
               WHERE ACTION_HANDERNAME = V_USER_NAME;
                --如果是2代表，上一步是自己提交
               IF ACT_INDEX = 1 THEN
               SELECT STATUS_CODE INTO T_STATUS_CODE FROM OA_FLOW_INSTANCE WHERE INS_ID = V_INS_ID;
                   IF T_STATUS_CODE = '01' THEN
                      RETURN 1;
                   ELSE
                     RETURN 0;
                   END IF;
               ELSE
               RETURN 0;
               END IF;
         END IF;
       
     ELSE
       RETURN 0;
     END IF;
END;
