-- Add/modify columns 
alter table OA_USERANDSN add leavetime date;
-- Add comments to the columns 
comment on column OA_USERANDSN.leavetime
  is '离职时间';
