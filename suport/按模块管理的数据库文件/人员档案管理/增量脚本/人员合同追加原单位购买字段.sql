-- Add/modify columns 
alter table OA_HETONG add hetong_isydwgm CHAR(2);
-- Add comments to the columns 
comment on column OA_HETONG.hetong_isydwgm
  is '是否原单位购买 保险 "1":是 , "0":否';