-- Add/modify columns 
alter table TA_OA_WHTJY_CHEWEIXIU add weixiuneirong varchar2(4000);
-- Add comments to the columns 
comment on column TA_OA_WHTJY_CHEWEIXIU.weixiuneirong
  is 'Î¬ÐÞ±£ÑøÄÚÈÝ';
