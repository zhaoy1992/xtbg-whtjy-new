--------ƽ̨V3.0ϵͳ��Ϣ�ű���ʼ--------
-- Create table ����δ�����ʼ���
create table TD_MSG_PERSONAL_NOSEND
(
  ID            VARCHAR2(100) not null,
  TITLE         VARCHAR2(500),
  CONTENT       CLOB,
  SENDER_ID     VARCHAR2(100),
  SENDER_NAME   VARCHAR2(100),
  RECEIVER_ID   VARCHAR2(1000),
  RECEIVER_NAME VARCHAR2(1000),
  SEND_TIME     VARCHAR2(100),
  SAVE_TIME     VARCHAR2(100)
);
-- Add comments to the table 
comment on table TD_MSG_PERSONAL_NOSEND is '����δ�����ʼ���';
-- Add comments to the columns 
comment on column TD_MSG_PERSONAL_NOSEND.ID is '��¼���';
comment on column TD_MSG_PERSONAL_NOSEND.TITLE is '�ʼ�����';
comment on column TD_MSG_PERSONAL_NOSEND.CONTENT is '�ʼ�����';
comment on column TD_MSG_PERSONAL_NOSEND.SENDER_ID is '������ID';
comment on column TD_MSG_PERSONAL_NOSEND.SENDER_NAME is '����������';
comment on column TD_MSG_PERSONAL_NOSEND.RECEIVER_ID is '������ID';
comment on column TD_MSG_PERSONAL_NOSEND.RECEIVER_NAME is '����������';
comment on column TD_MSG_PERSONAL_NOSEND.SEND_TIME is '����ʱ��';
comment on column TD_MSG_PERSONAL_NOSEND.SAVE_TIME is '����ʱ��';
commit;

-- Create table ���˽����ʼ���
create table TD_MSG_PERSONAL_RECEIVE
(
  ID            VARCHAR2(100) not null,
  TITLE         VARCHAR2(500),
  CONTENT       CLOB,
  SENDER_ID     VARCHAR2(100),
  SENDER_NAME   VARCHAR2(100),
  RECEIVER_ID   VARCHAR2(100),
  RECEIVER_NAME VARCHAR2(100),
  SEND_TIME     VARCHAR2(100),
  ISREAD        VARCHAR2(10),
  ISDELETE      VARCHAR2(10)
);
-- Add comments to the table 
comment on table TD_MSG_PERSONAL_RECEIVE is '���˽����ʼ���';
-- Add comments to the columns 
comment on column TD_MSG_PERSONAL_RECEIVE.ID is '��¼���';
comment on column TD_MSG_PERSONAL_RECEIVE.TITLE is '�ʼ�����';
comment on column TD_MSG_PERSONAL_RECEIVE.CONTENT is '�ʼ�����';
comment on column TD_MSG_PERSONAL_RECEIVE.SENDER_ID is '������ID';
comment on column TD_MSG_PERSONAL_RECEIVE.SENDER_NAME is '����������';
comment on column TD_MSG_PERSONAL_RECEIVE.RECEIVER_ID is '������ID';
comment on column TD_MSG_PERSONAL_RECEIVE.RECEIVER_NAME is '����������';
comment on column TD_MSG_PERSONAL_RECEIVE.SEND_TIME is '����ʱ��';
comment on column TD_MSG_PERSONAL_RECEIVE.ISREAD is '�Ƿ��Ѷ�';
comment on column TD_MSG_PERSONAL_RECEIVE.ISDELETE is '�Ƿ�ɾ��';
commit;

-- Create table ���˷����ʼ���
create table TD_MSG_PERSONAL_SEND
(
  ID            VARCHAR2(100) not null,
  TITLE         VARCHAR2(500),
  CONTENT       CLOB,
  SENDER_ID     VARCHAR2(100),
  SENDER_NAME   VARCHAR2(100),
  RECEIVER_ID   VARCHAR2(1000),
  RECEIVER_NAME VARCHAR2(1000),
  SEND_TIME     VARCHAR2(100)
);
-- Add comments to the table 
comment on table TD_MSG_PERSONAL_SEND is '���˷����ʼ���';
-- Add comments to the columns 
comment on column TD_MSG_PERSONAL_SEND.ID is '��¼���';
comment on column TD_MSG_PERSONAL_SEND.TITLE is '�ʼ�����';
comment on column TD_MSG_PERSONAL_SEND.CONTENT is '�ʼ�����';
comment on column TD_MSG_PERSONAL_SEND.SENDER_ID is '������ID';
comment on column TD_MSG_PERSONAL_SEND.SENDER_NAME is '����������';
comment on column TD_MSG_PERSONAL_SEND.RECEIVER_ID is '������ID';
comment on column TD_MSG_PERSONAL_SEND.RECEIVER_NAME is '����������';
comment on column TD_MSG_PERSONAL_SEND.SEND_TIME is '����ʱ��';
commit;


-- ���ݳ�ʼ��
DELETE TABLEINFO WHERE TABLE_NAME='td_msg_personal_nosend';
commit;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_msg_personal_nosend', 'id', 1, 0, NULL, 'string', NULL);
commit;

DELETE TABLEINFO WHERE TABLE_NAME='TD_MSG_PERSONAL_SEND';
commit;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('TD_MSG_PERSONAL_SEND', 'ID', 1, 0, NULL, 'string', NULL);
commit;

DELETE TABLEINFO WHERE TABLE_NAME='td_msg_personal_receive';
commit;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ('td_msg_personal_receive', 'id', 1, 0, NULL, 'string', NULL);
commit;

-- Create table ��Ϣ��Դ��
create table TD_MSG_RESOURCE
(
  R_ID       NUMBER,
  R_NAME     VARCHAR2(50),
  R_DESC     VARCHAR2(50),
  R_MSG_TYPE VARCHAR2(128)
);
-- Add comments to the table 
comment on table TD_MSG_RESOURCE is '��Ϣ��Դ��';
-- Add comments to the columns 
comment on column TD_MSG_RESOURCE.R_ID is '��ˮ��';
comment on column TD_MSG_RESOURCE.R_NAME is '��Դ����';
comment on column TD_MSG_RESOURCE.R_DESC is '��Դ����';
comment on column TD_MSG_RESOURCE.R_MSG_TYPE is '��Ϣ����';
commit;

-- Create table
create table TD_USER_MSG_RESOURCE
(
  USER_ID    NUMBER,
  R_ID       VARCHAR2(20),
  R_MSG_TYPE VARCHAR2(128)
);
-- Add comments to the table 
comment on table TD_USER_MSG_RESOURCE is '�û�����Ϣ��Դӳ���';
-- Add comments to the columns 
comment on column TD_USER_MSG_RESOURCE.USER_ID is '�û�id';
comment on column TD_USER_MSG_RESOURCE.R_ID is '��Ϣ��Դid';
comment on column TD_USER_MSG_RESOURCE.R_MSG_TYPE is '�û��Զ�����Ϣ����';
commit;


-- Create table ��Ϣ����
create table TD_MESSAGE_MAIN
(
  MSG_MAIN_ID          VARCHAR2(32)  primary key,
  MSG_MAIN_TITLE       VARCHAR2(500),
  MSG_MAIN_CONTENT     VARCHAR2(2000),
  MSG_MAIN_SENDER      VARCHAR2(200),
  MSG_MAIN_RECEIVES    VARCHAR2(1000),
  MSG_MAIN_SEND_TYPE   VARCHAR2(100),
  MSG_MAIN_SEND_TIME   DATE,
  MSG_MAIN_BUSINESS_ID VARCHAR2(50)
);
-- Add comments to the table 
comment on table TD_MESSAGE_MAIN is '��Ϣ��Դ����';
-- Add comments to the columns 
comment on column TD_MESSAGE_MAIN.MSG_MAIN_ID is '����ID';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_TITLE is '��Ϣ����';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_CONTENT is '��Ϣ����';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_SENDER is '�������û���';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_RECEIVES is '�������û���';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_SEND_TYPE is '��Ϣ��������';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_SEND_TIME is '����ʱ��';
comment on column TD_MESSAGE_MAIN.MSG_MAIN_BUSINESS_ID is 'ҵ��ID';
commit;
-- Create table ��Ϣ��Դ�ֵ��
create table TD_MSG_DICT
(
  DICT_MSG_NO             VARCHAR2(10) primary key,
  DICT_MSG_NAME		  VARCHAR2(100),
  DICT_MSG_SEND_BEAN_ID   VARCHAR2(100),
  DICT_MSG_SAVE_BEAN_ID   VARCHAR2(100),
  DICT_MSG_RESEND_BEAN_ID VARCHAR2(100),
  DICT_MSG_REMARK         VARCHAR2(100)
);
-- Add comments to the table 
comment on table TD_MSG_DICT is '��Ϣ��Դ�ֵ��';
-- Add comments to the columns 
comment on column TD_MSG_DICT.DICT_MSG_NO is '�ֵ�ID';
comment on column TD_MSG_DICT.DICT_MSG_NAME is '��Ϣ��������';
comment on column TD_MSG_DICT.DICT_MSG_SEND_BEAN_ID is '����beanId';
comment on column TD_MSG_DICT.DICT_MSG_SAVE_BEAN_ID is '����beanId';
comment on column TD_MSG_DICT.DICT_MSG_RESEND_BEAN_ID is '�ط�beanId';
comment on column TD_MSG_DICT.DICT_MSG_REMARK is '��ע�ֶ�';
commit;
-- Create table ��Ϣ���ͱ�
create table TD_MSG_SENDING
(
  MSG_LOG_ID        NUMBER PRIMARY KEY,
  MSG_MAIN_ID       VARCHAR2(32) references TD_MESSAGE_MAIN (MSG_MAIN_ID),
  MSG_LOG_STATE     CHAR(1),
  MSG_LOG_RECEIVER  VARCHAR2(200),
  MSG_LOG_SEND_TYPE VARCHAR2(50),
  MSG_LOG_DATE      DATE,
  MSG_LOG_REMARK_A  VARCHAR2(100),
  MSG_LOG_REMARK_B  VARCHAR2(100)
);
-- Add comments to the table 
comment on table TD_MSG_SENDING is '��Ϣ���ͱ�';
-- Add comments to the columns 
comment on column TD_MSG_SENDING.MSG_LOG_ID is '���ͼ�¼ID';
comment on column TD_MSG_SENDING.MSG_MAIN_ID is '��Ϣ����ID';
comment on column TD_MSG_SENDING.MSG_LOG_STATE is '����״̬';
comment on column TD_MSG_SENDING.MSG_LOG_RECEIVER is '������';
comment on column TD_MSG_SENDING.MSG_LOG_SEND_TYPE is '������Ϣ����';
comment on column TD_MSG_SENDING.MSG_LOG_DATE is '����ʱ��';
comment on column TD_MSG_SENDING.MSG_LOG_REMARK_A is '��עA';
comment on column TD_MSG_SENDING.MSG_LOG_REMARK_B is '��עB';
commit;
--��������
create sequence SEQ_TD_MSG_SENDING
minvalue 1
maxvalue 99999999999999999999
start with 421
increment by 1
nocache;
--��������
update td_user_msg_resource t set t.r_msg_type = 'rtx,sms,sys';
update td_msg_resource t set t.r_msg_type='rtx,sms,sys';
--Ӧ���²������� update tb_application_info i set i.functionlist='rtx,sms,sys';
commit;
--�������
insert into TD_MSG_DICT (DICT_MSG_NO, DICT_MSG_NAME, DICT_MSG_SEND_BEAN_ID, DICT_MSG_SAVE_BEAN_ID, DICT_MSG_RESEND_BEAN_ID, DICT_MSG_REMARK)
values ('rtx', 'RTX', 'RtxSendImpl', 'RtxSaveImpl', 'RtxReSendImpl', null);
insert into TD_MSG_DICT (DICT_MSG_NO, DICT_MSG_NAME, DICT_MSG_SEND_BEAN_ID, DICT_MSG_SAVE_BEAN_ID, DICT_MSG_RESEND_BEAN_ID, DICT_MSG_REMARK)
values ('sms', '����', 'SmsSendImpl', 'SmsSaveImpl', 'SmsReSendImpl', null);
insert into TD_MSG_DICT (DICT_MSG_NO, DICT_MSG_NAME, DICT_MSG_SEND_BEAN_ID, DICT_MSG_SAVE_BEAN_ID, DICT_MSG_RESEND_BEAN_ID, DICT_MSG_REMARK)
values ('sys', '�ʼ�', 'SysSendImpl', null, null, null);
commit;
--------ƽ̨V3.0��Ϣ�ű�����--------
