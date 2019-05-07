-- Add/modify columns 
alter table OA_ACT_TEXT_STAUTS add msg_txt varchar2(400);
-- Add comments to the columns 
comment on column OA_ACT_TEXT_STAUTS.msg_txt
  is '短信配置';