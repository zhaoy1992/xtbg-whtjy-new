-- Create table
create table oa_hetong
(
  hetong_id              VARCHAR2(50),
  hetong_userands_id     VARCHAR2(50),
  hetong_isold             CHAR(2),
  hetong_isyl              CHAR(2),
  hetong_issy              CHAR(2),
  hetong_isgs              CHAR(2),
  hetong_isshiye           CHAR(2),
  hetong_type           VARCHAR2(10),
  hetong_number         VARCHAR2(10),
  hetong_first_date        DATE,
  hetong_nowstart_date     DATE,
  hetong_nowsend_date      DATE,
  hetong_trystart_date     DATE,
  hetong_tryend_date       DATE
);

-- Add comments to the table 
comment on table oa_hetong
  is '人员合同表';
-- Add comments to the columns 
comment on column oa_hetong.hetong_id
  is '主键id';
comment on column oa_hetong.hetong_userands_id
  is '人员主键id';
comment on column oa_hetong.hetong_isold
  is '是否参加养老保险"1:是,0:否"';
comment on column oa_hetong.hetong_isyl
  is '是否参加医疗保险"1:是,0:否"';  
comment on column oa_hetong.hetong_issy
  is '是否参加生育保险"1:是,0:否"';
comment on column oa_hetong.hetong_isgs
  is '是否参加工伤保险"1:是,0:否"';
comment on column oa_hetong.hetong_isshiye
  is '是否参加失业保险"1:是,0:否"';
comment on column oa_hetong.hetong_type
  is '合同类别'; 
comment on column oa_hetong.hetong_number
  is '08年后劳动合同签订次数';
comment on column oa_hetong.hetong_first_date
  is '首次合同签订日期';
comment on column oa_hetong.hetong_nowstart_date
  is '现合同起始期';
comment on column oa_hetong.hetong_nowsend_date
  is '现合同终止期';
comment on column oa_hetong.hetong_trystart_date
  is '合同试用起始期';
comment on column oa_hetong.hetong_tryend_date
  is '合同试用终止期';    

  
  
alter table oa_userandsn add new_user_type VARCHAR2(20);
comment on column oa_userandsn.new_user_type is '人员类别';

alter table oa_userandsn add new_job_state VARCHAR2(20);
comment on column oa_userandsn.new_job_state is '在岗状态';

alter table oa_userandsn add new_job_no VARCHAR2(20);
comment on column oa_userandsn.new_job_no is '职工工号';

alter table oa_userandsn add new_job_set VARCHAR2(20);
comment on column oa_userandsn.new_job_set is '岗位设置';

alter table oa_userandsn add new_join_zzdate DATE;
comment on column oa_userandsn.new_join_zzdate is '参加组织日期';

alter table oa_userandsn add new_in_hosb DATE;
comment on column oa_userandsn.new_in_hosb is '入院时间';

alter table oa_userandsn add new_toother_date DATE;
comment on column oa_userandsn.new_toother_date is '借调时间';

alter table oa_userandsn add new_first_xingshi VARCHAR2(50);
comment on column oa_userandsn.new_first_xingshi is '学习形式(第一学历)';

alter table oa_userandsn add new_first_zy VARCHAR2(50);
comment on column oa_userandsn.new_first_zy is '专业(第一学历)';

alter table oa_userandsn add new_first_bydate DATE;
comment on column oa_userandsn.new_first_bydate is '毕业时间(第一学历)';

alter table oa_userandsn add new_zg_byyx VARCHAR2(50);
comment on column oa_userandsn.new_zg_byyx is '毕业院校(最高学历)';

alter table oa_userandsn add new_zg_xl VARCHAR2(50);
comment on column oa_userandsn.new_zg_xl is '学历(最高学历)';

alter table oa_userandsn add new_zg_xw VARCHAR2(20);
comment on column oa_userandsn.new_zg_xw is '学位(最高学历)';

alter table oa_userandsn add new_zg_xingshi VARCHAR2(50);
comment on column oa_userandsn.new_zg_xingshi is '学习形式(最高学历)';

alter table oa_userandsn add new_zg_zy VARCHAR2(50);
comment on column oa_userandsn.new_zg_zy is '专业(最高学历)';

alter table oa_userandsn add new_zg_bydate DATE;
comment on column oa_userandsn.new_zg_bydate is '毕业时间(最高学历)';

alter table oa_userandsn add new_jszc VARCHAR2(20);
comment on column oa_userandsn.new_jszc is '技术职称';

alter table oa_userandsn add new_zc_getdate DATE;
comment on column oa_userandsn.new_zc_getdate is '职称获取时间';

alter table oa_userandsn add new_zc_pydate DATE;
comment on column oa_userandsn.new_zc_pydate is '职称聘任时间';

         
