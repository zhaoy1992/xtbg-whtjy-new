-- Add/modify columns 
alter table TA_OA_HAVA_OBJECT modify t_ha_no number;
alter table TA_OA_HAVA_OBJECT add t_ha_rkuser_date date;
-- Add comments to the columns 
comment on column TA_OA_HAVA_OBJECT.t_ha_rkuser_date
  is '»Îø‚ ±º‰';
