-- Add/modify columns 
alter table OA_NOTICE_BASEINFO add n_unit_id VARCHAR2(50);
alter table OA_NOTICE_BASEINFO add n_unit_name VARCHAR2(200);
-- Add comments to the columns 
comment on column OA_NOTICE_BASEINFO.N_ORGID
  is '部门ID';
comment on column OA_NOTICE_BASEINFO.N_ORGNAME
  is '部门名称';
comment on column OA_NOTICE_BASEINFO.n_unit_id
  is '单位ID';
comment on column OA_NOTICE_BASEINFO.n_unit_name
  is '单位名称';
