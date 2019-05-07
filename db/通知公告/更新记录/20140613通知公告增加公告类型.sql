-- Add/modify columns 
alter table OA_NOTICE_BASEINFO add N_TYPE varchar2(1);
-- Add comments to the columns 
comment on column OA_NOTICE_BASEINFO.N_TYPE
  is '公告类型（默认null为普通公告,1院内资讯，2员工公告）';
