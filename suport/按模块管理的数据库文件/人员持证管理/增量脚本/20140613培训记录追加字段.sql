-- Add/modify columns 
alter table TA_OA_TRAIN add tr_results varchar2(4000);
alter table TA_OA_TRAIN add tr_Assess varchar2(4000);
-- Add comments to the columns 
comment on column TA_OA_TRAIN.tr_results
  is '��ѵ�ɼ�';
comment on column TA_OA_TRAIN.tr_Assess
  is '���˳ɼ�';
