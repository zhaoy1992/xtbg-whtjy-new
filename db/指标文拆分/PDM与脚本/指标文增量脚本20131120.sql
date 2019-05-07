-- Add/modify columns 
alter table OA_BUDGET_FILE add SEND_STATUS VARCHAR2(1) default '0' not null;
-- Add comments to the columns 
comment on column OA_BUDGET_FILE.SEND_STATUS
  is '发送状态(0:未发送完;1:已发送完)';
  
--触发器 根据科室指标汇总计算指标文总信息金额
create or replace trigger TRIGGER_BUDGET_DETAIL
  after insert or delete on oa_budget_detail  
  for each row
declare
  -- local variables here
  v_amount number;
begin
  if inserting then
    update oa_budget_file set AMOUNT=(AMOUNT+:new.amount) where ID=:new.BUDGET_FILE_ID;
  elsif deleting then
    update oa_budget_file set AMOUNT=(AMOUNT-:old.amount) where ID=:old.BUDGET_FILE_ID;
  end if;
end TRIGGER_BUDGET_DETAIL;
/