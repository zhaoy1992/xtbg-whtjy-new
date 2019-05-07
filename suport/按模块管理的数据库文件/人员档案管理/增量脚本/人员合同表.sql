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
  is '��Ա��ͬ��';
-- Add comments to the columns 
comment on column oa_hetong.hetong_id
  is '����id';
comment on column oa_hetong.hetong_userands_id
  is '��Ա����id';
comment on column oa_hetong.hetong_isold
  is '�Ƿ�μ����ϱ���"1:��,0:��"';
comment on column oa_hetong.hetong_isyl
  is '�Ƿ�μ�ҽ�Ʊ���"1:��,0:��"';  
comment on column oa_hetong.hetong_issy
  is '�Ƿ�μ���������"1:��,0:��"';
comment on column oa_hetong.hetong_isgs
  is '�Ƿ�μӹ��˱���"1:��,0:��"';
comment on column oa_hetong.hetong_isshiye
  is '�Ƿ�μ�ʧҵ����"1:��,0:��"';
comment on column oa_hetong.hetong_type
  is '��ͬ���'; 
comment on column oa_hetong.hetong_number
  is '08����Ͷ���ͬǩ������';
comment on column oa_hetong.hetong_first_date
  is '�״κ�ͬǩ������';
comment on column oa_hetong.hetong_nowstart_date
  is '�ֺ�ͬ��ʼ��';
comment on column oa_hetong.hetong_nowsend_date
  is '�ֺ�ͬ��ֹ��';
comment on column oa_hetong.hetong_trystart_date
  is '��ͬ������ʼ��';
comment on column oa_hetong.hetong_tryend_date
  is '��ͬ������ֹ��';    

  
  
alter table oa_userandsn add new_user_type VARCHAR2(20);
comment on column oa_userandsn.new_user_type is '��Ա���';

alter table oa_userandsn add new_job_state VARCHAR2(20);
comment on column oa_userandsn.new_job_state is '�ڸ�״̬';

alter table oa_userandsn add new_job_no VARCHAR2(20);
comment on column oa_userandsn.new_job_no is 'ְ������';

alter table oa_userandsn add new_job_set VARCHAR2(20);
comment on column oa_userandsn.new_job_set is '��λ����';

alter table oa_userandsn add new_join_zzdate DATE;
comment on column oa_userandsn.new_join_zzdate is '�μ���֯����';

alter table oa_userandsn add new_in_hosb DATE;
comment on column oa_userandsn.new_in_hosb is '��Ժʱ��';

alter table oa_userandsn add new_toother_date DATE;
comment on column oa_userandsn.new_toother_date is '���ʱ��';

alter table oa_userandsn add new_first_xingshi VARCHAR2(50);
comment on column oa_userandsn.new_first_xingshi is 'ѧϰ��ʽ(��һѧ��)';

alter table oa_userandsn add new_first_zy VARCHAR2(50);
comment on column oa_userandsn.new_first_zy is 'רҵ(��һѧ��)';

alter table oa_userandsn add new_first_bydate DATE;
comment on column oa_userandsn.new_first_bydate is '��ҵʱ��(��һѧ��)';

alter table oa_userandsn add new_zg_byyx VARCHAR2(50);
comment on column oa_userandsn.new_zg_byyx is '��ҵԺУ(���ѧ��)';

alter table oa_userandsn add new_zg_xl VARCHAR2(50);
comment on column oa_userandsn.new_zg_xl is 'ѧ��(���ѧ��)';

alter table oa_userandsn add new_zg_xw VARCHAR2(20);
comment on column oa_userandsn.new_zg_xw is 'ѧλ(���ѧ��)';

alter table oa_userandsn add new_zg_xingshi VARCHAR2(50);
comment on column oa_userandsn.new_zg_xingshi is 'ѧϰ��ʽ(���ѧ��)';

alter table oa_userandsn add new_zg_zy VARCHAR2(50);
comment on column oa_userandsn.new_zg_zy is 'רҵ(���ѧ��)';

alter table oa_userandsn add new_zg_bydate DATE;
comment on column oa_userandsn.new_zg_bydate is '��ҵʱ��(���ѧ��)';

alter table oa_userandsn add new_jszc VARCHAR2(20);
comment on column oa_userandsn.new_jszc is '����ְ��';

alter table oa_userandsn add new_zc_getdate DATE;
comment on column oa_userandsn.new_zc_getdate is 'ְ�ƻ�ȡʱ��';

alter table oa_userandsn add new_zc_pydate DATE;
comment on column oa_userandsn.new_zc_pydate is 'ְ��Ƹ��ʱ��';

         
