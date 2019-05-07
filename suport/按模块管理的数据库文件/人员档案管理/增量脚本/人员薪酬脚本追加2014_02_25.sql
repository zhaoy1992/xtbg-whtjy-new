-- Add/modify columns 
alter table OA_USERANDSN add NEW_XC_GWGZ VARCHAR2(30);
alter table OA_USERANDSN add NEW_XC_XJGZ VARCHAR2(30);
alter table OA_USERANDSN add NEW_XC_YFGZ VARCHAR2(30);
alter table OA_USERANDSN add NEW_XC_YB VARCHAR2(30);
alter table OA_USERANDSN add NEW_XC_YLBX VARCHAR2(30);
alter table OA_USERANDSN add NEW_XC_SYBX VARCHAR2(30);
alter table OA_USERANDSN add NEW_XC_GJJ VARCHAR2(30);
alter table OA_USERANDSN add NEW_XC_CB VARCHAR2(30);
alter table OA_USERANDSN add NEW_XC_CBHJ VARCHAR2(30);
alter table OA_USERANDSN add NEW_XC_SFHJ VARCHAR2(30);
-- Add comments to the columns 
comment on column OA_USERANDSN.NEW_XC_GWGZ
  is '岗位工资';
comment on column OA_USERANDSN.NEW_XC_XJGZ
  is '薪级工资';
comment on column OA_USERANDSN.NEW_XC_YFGZ
  is '应发合计';
comment on column OA_USERANDSN.NEW_XC_YB
  is '医保';
comment on column OA_USERANDSN.NEW_XC_YLBX
  is '养老保险';
comment on column OA_USERANDSN.NEW_XC_SYBX
  is '失业保险';
comment on column OA_USERANDSN.NEW_XC_GJJ
  is '公积金';
comment on column OA_USERANDSN.NEW_XC_CB
  is '补扣';
comment on column OA_USERANDSN.NEW_XC_CBHJ
  is '扣款合计';
comment on column OA_USERANDSN.NEW_XC_SFHJ
  is '实发合计';
