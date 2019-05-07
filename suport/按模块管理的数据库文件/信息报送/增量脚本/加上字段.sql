-- Add/modify columns 
alter table TA_OA_INFRE_SUBMITTED_INFO add sbuserid VARCHAR2(50);
alter table TA_OA_INFRE_SUBMITTED_INFO add ssuserid VARCHAR2(50);
alter table TA_OA_INFRE_SUBMITTED_INFO add fbuserid VARCHAR2(50);
-- Add comments to the columns 
comment on column TA_OA_INFRE_SUBMITTED_INFO.sbuserid
  is '上报接收人';
comment on column TA_OA_INFRE_SUBMITTED_INFO.ssuserid
  is '送审接收人';
comment on column TA_OA_INFRE_SUBMITTED_INFO.fbuserid
  is '发布接收人';
  
  
-- Add/modify columns 
alter table TA_OA_INFRE_SUBMITTED_INFO add SBUSERNAME VARCHAR2(100);
alter table TA_OA_INFRE_SUBMITTED_INFO add SSUSERNAME VARCHAR2(100);
alter table TA_OA_INFRE_SUBMITTED_INFO add FBUSERNAME VARCHAR2(100);
-- Add comments to the columns 
comment on column TA_OA_INFRE_SUBMITTED_INFO.SBUSERID
  is '上报接收人ID';
comment on column TA_OA_INFRE_SUBMITTED_INFO.SSUSERID
  is '送审接收人ID';
comment on column TA_OA_INFRE_SUBMITTED_INFO.FBUSERID
  is '发布接收人ID';
comment on column TA_OA_INFRE_SUBMITTED_INFO.SBUSERNAME
  is '上报接收人姓名';
comment on column TA_OA_INFRE_SUBMITTED_INFO.SSUSERNAME
  is '送审接收人姓名';
comment on column TA_OA_INFRE_SUBMITTED_INFO.FBUSERNAME
  is '发布接收人姓名';  
  
  