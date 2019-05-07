-- Add/modify columns 
alter table OA_GROUP_RESOURCES add noticetype VARCHAR2(64);
-- Add comments to the columns 
comment on column OA_GROUP_RESOURCES.noticetype
  is '财政厅区分内外部通知公告';