-- Add/modify columns 
alter table OA_WORD_TEMPLATE add SINGN_CONFIG VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_WORD_TEMPLATE.SINGN_CONFIG
  is '会签内容';
  
-- Add/modify columns 
alter table OA_ACT_TEXT_STAUTS rename column IS_SAVEAS to is_gwzl;
alter table OA_ACT_TEXT_STAUTS add is_ckcg CHAR(1);
alter table OA_ACT_TEXT_STAUTS add is_ckzw CHAR(1);
alter table OA_ACT_TEXT_STAUTS add is_ckmq CHAR(1);
alter table OA_ACT_TEXT_STAUTS add is_singname CHAR(1);
alter table OA_ACT_TEXT_STAUTS add is_affix CHAR(1);
alter table OA_ACT_TEXT_STAUTS add remark1 VARCHAR2(400);
-- Add comments to the columns 
comment on column OA_ACT_TEXT_STAUTS.is_ckcg
  is '是否可以查看草稿';
comment on column OA_ACT_TEXT_STAUTS.is_ckzw
  is '是否可以查看正文';
comment on column OA_ACT_TEXT_STAUTS.is_ckmq
  is '是否可以查看面签';
comment on column OA_ACT_TEXT_STAUTS.is_singname
  is '是否签名';
comment on column OA_ACT_TEXT_STAUTS.is_affix
  is '是否可以盖章';
comment on column OA_ACT_TEXT_STAUTS.remark1
  is '扩展字段';
  