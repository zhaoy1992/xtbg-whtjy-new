-- Add/modify columns 
alter table TA_OA_OSAPPLAN add t_rkuser_id varchar2(50);
alter table TA_OA_OSAPPLAN add t_rkuser_name varchar2(100);
alter table TA_OA_OSAPPLAN add t_rkdate date;
-- Add comments to the columns 
comment on column TA_OA_OSAPPLAN.t_rkuser_id
  is '�����id';
comment on column TA_OA_OSAPPLAN.t_rkuser_name
  is '�������';
comment on column TA_OA_OSAPPLAN.t_rkdate
  is '���ʱ��';
