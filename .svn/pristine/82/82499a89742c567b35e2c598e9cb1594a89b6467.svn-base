/**
 * 望城项目中 该触发器报错,查询new_wait_id表出现多条记录
 * 
 * 查询表查询new_wait_id表出现多条记录时，增加BUSINESS_TYPE='youjian',过滤掉其他模块数据
 * 
 * 
 */
create or replace trigger "PTMX_YMJ_DZYJ_USER"
  after insert
  --or delete or update
/**
 * 原触发器:mobile_dzyj
 * tuo.zou
 * 2014-02-19更新
 */
ON YMJ_OA_USER_MAIL
  FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
  mainMessState VARCHAR(50);--主表MID
BEGIN

  --新增与更新
  IF INSERTING THEN
     select yojm.state into mainMessState from ymj_oa_jbxx_mail yojm where yojm.mid = :NEW.MID;
     --'1':状态=1的邮件，是已发送的邮件
     IF mainMessState = '1' THEN
      --1:获取 主消息表中的 ID
       select wait_id into new_wait_id from M_AA_WAIT where business_id = :NEW.MID and BUSINESS_TYPE='youjian';
      --2:
      insert into M_AA_UF values(new_wait_id,:NEW.RECEIVEPID);
     END IF;
  end if;
END PTMX_YMJ_DZYJ_USER;
