-- Add/modify columns 
alter table OA_KBM_DOC add k_approval_time date;
alter table OA_KBM_DOC add k_approval_user varchar2(40);
alter table OA_KBM_DOC add k_approval_user_name varchar2(100);
alter table OA_KBM_DOC add k_approval_info varchar2(1000);
-- Add comments to the columns 
comment on column OA_KBM_DOC.k_approval_time
  is '��׼ʱ��';
comment on column OA_KBM_DOC.k_approval_user
  is '��׼��';
comment on column OA_KBM_DOC.k_approval_user_name
  is '��׼��name';
comment on column OA_KBM_DOC.k_approval_info
  is '��׼���';


insert into TD_SM_ROLE(ROLE_ID,ROLE_NAME,ROLE_TYPE,ROLE_DESC,ROLE_USAGE,REMARK1,REMARK2,REMARK3,OWNER_ID)
values(SEQ_TD_SM_ROLE.NEXTVAL,'���ܹ���ʦ', '1', '���ܹ���ʦ', '', '', '', '', '1');

insert into TD_SM_ROLE (ROLE_ID, ROLE_NAME, ROLE_TYPE, ROLE_DESC, ROLE_USAGE, REMARK1, REMARK2, REMARK3, OWNER_ID)
values (SEQ_TD_SM_ROLE.NEXTVAL, '�ܹ���Ժ��', '1', '�ܹ���Ժ��', '', '', '', '', 1);

insert into TD_SM_ROLE (ROLE_ID, ROLE_NAME, ROLE_TYPE, ROLE_DESC, ROLE_USAGE, REMARK1, REMARK2, REMARK3, OWNER_ID)
values (SEQ_TD_SM_ROLE.NEXTVAL, '�ʱ�����ʦ', '1', '�ʱ�����ʦ', '', '', '', '', 1);
commit;
