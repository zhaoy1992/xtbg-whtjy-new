-- Add/modify columns 
alter table OA_KBM_DOC add k_approval_time date;
alter table OA_KBM_DOC add k_approval_user varchar2(40);
alter table OA_KBM_DOC add k_approval_user_name varchar2(100);
alter table OA_KBM_DOC add k_approval_info varchar2(1000);
-- Add comments to the columns 
comment on column OA_KBM_DOC.k_approval_time
  is '批准时间';
comment on column OA_KBM_DOC.k_approval_user
  is '批准人';
comment on column OA_KBM_DOC.k_approval_user_name
  is '批准人name';
comment on column OA_KBM_DOC.k_approval_info
  is '批准意见';


insert into TD_SM_ROLE(ROLE_ID,ROLE_NAME,ROLE_TYPE,ROLE_DESC,ROLE_USAGE,REMARK1,REMARK2,REMARK3,OWNER_ID)
values(SEQ_TD_SM_ROLE.NEXTVAL,'副总工程师', '1', '副总工程师', '', '', '', '', '1');

insert into TD_SM_ROLE (ROLE_ID, ROLE_NAME, ROLE_TYPE, ROLE_DESC, ROLE_USAGE, REMARK1, REMARK2, REMARK3, OWNER_ID)
values (SEQ_TD_SM_ROLE.NEXTVAL, '总工或院长', '1', '总工或院长', '', '', '', '', 1);

insert into TD_SM_ROLE (ROLE_ID, ROLE_NAME, ROLE_TYPE, ROLE_DESC, ROLE_USAGE, REMARK1, REMARK2, REMARK3, OWNER_ID)
values (SEQ_TD_SM_ROLE.NEXTVAL, '质保工程师', '1', '质保工程师', '', '', '', '', 1);
commit;
