-- Add/modify columns 
alter table CZT_IBRARY_BOOKINFO add validstate varchar2(10);
-- Add comments to the columns 
comment on column CZT_IBRARY_BOOKINFO.validstate
  is '有效状态';
