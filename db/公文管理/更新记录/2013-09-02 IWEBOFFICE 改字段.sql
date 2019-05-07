-- Add/modify columns 
alter table OA_OCTL_TEMPLATE_FILE modify TEMPLATEID VARCHAR2(50);

-- Add/modify columns 
alter table OA_ACT_TEXT_STAUTS add IS_SAVEAS CHAR(1);
-- Add comments to the columns 
comment on column OA_ACT_TEXT_STAUTS.IS_SAVEAS
  is '是否可整理';