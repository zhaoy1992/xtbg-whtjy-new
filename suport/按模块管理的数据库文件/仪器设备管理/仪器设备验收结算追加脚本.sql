-- Add/modify columns 
alter table TA_OA_DEVEQUIPMENTACC add t_sl varchar2(20);
-- Add comments to the columns 
comment on column TA_OA_DEVEQUIPMENTACC.t_sl
  is '����';


-- Create table
create table TA_OA_DEVSETTLEITEM
(
  T_ID          VARCHAR2(40) not null,
  DEVSETTLE_ID  VARCHAR2(50),
  ITEM_NAME     VARCHAR2(200),
  ITEM_TYPE     VARCHAR2(200),
  ITEM_COUNT    VARCHAR2(20),
  ITEM_PRICE    VARCHAR2(100),
  ITEM_NO       VARCHAR2(10),
  ITEM_REPORTID VARCHAR2(50)
);
-- Add comments to the table 
comment on table TA_OA_DEVSETTLEITEM
  is '�ɹ����ս����Ʒ����';
-- Add comments to the columns 
comment on column TA_OA_DEVSETTLEITEM.T_ID
  is '����ID';
comment on column TA_OA_DEVSETTLEITEM.DEVSETTLE_ID
  is '�ɹ����ս���ID';
comment on column TA_OA_DEVSETTLEITEM.ITEM_NAME
  is '��Ʒ����';
comment on column TA_OA_DEVSETTLEITEM.ITEM_TYPE
  is '�ͺŹ��';
comment on column TA_OA_DEVSETTLEITEM.ITEM_COUNT
  is '����';
comment on column TA_OA_DEVSETTLEITEM.ITEM_PRICE
  is '����';
comment on column TA_OA_DEVSETTLEITEM.ITEM_NO
  is '�����';
comment on column TA_OA_DEVSETTLEITEM.ITEM_REPORTID
  is '���յ�ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TA_OA_DEVSETTLEITEM
  add constraint PK_TA_OA_DEVSETTLEITEM_ID primary key (T_ID);

  
--�������̱�����Ҫ���������������ݿ������õ����̱�
-- Create table
--create table TA_OA_DEVSETTLEMENT
--(
--  T_ID            VARCHAR2(50) not null,
--  T_FJ_ID         VARCHAR2(50),
--  T_ZW_ID         VARCHAR2(50),
--  T_TITLE         VARCHAR2(500),
--  T_APPORDER_NO   VARCHAR2(200),
--  T_APPDATE       DATE,
--  T_ORDER_NO      VARCHAR2(200),
--  T_SUPP_UNIT     VARCHAR2(200),
--  T_TECHNOLOGY_YJ VARCHAR2(2000),
--  T_FINANCE_YJ    VARCHAR2(2000),
--  T_SUPP_UNITID   VARCHAR2(100)
--);
---- Add comments to the table 
--comment on table TA_OA_DEVSETTLEMENT
--  is '�����ɹ����ս����';
---- Add comments to the columns 
--comment on column TA_OA_DEVSETTLEMENT.T_ID
--  is '����';
--comment on column TA_OA_DEVSETTLEMENT.T_FJ_ID
--  is '����id';
--comment on column TA_OA_DEVSETTLEMENT.T_ZW_ID
--  is '����id';
--comment on column TA_OA_DEVSETTLEMENT.T_TITLE
--  is '����';
--comment on column TA_OA_DEVSETTLEMENT.T_APPORDER_NO
--  is '�����ɹ����';
--comment on column TA_OA_DEVSETTLEMENT.T_APPDATE
--  is '��������';
--comment on column TA_OA_DEVSETTLEMENT.T_ORDER_NO
--  is '���';
--comment on column TA_OA_DEVSETTLEMENT.T_SUPP_UNIT
--  is '������λ';
--comment on column TA_OA_DEVSETTLEMENT.T_TECHNOLOGY_YJ
--  is '������Ա���';
--comment on column TA_OA_DEVSETTLEMENT.T_FINANCE_YJ
--  is '�������';
--comment on column TA_OA_DEVSETTLEMENT.T_SUPP_UNITID
--  is '������λId';
---- Create/Recreate primary, unique and foreign key constraints 
--alter table TA_OA_DEVSETTLEMENT
--  add constraint PK_TA_OA_DEVSETTLEMENT primary key (T_ID);

--�����������������ɹ����ս������̱�
insert into oa_flow_form (FORM_PATH, FORM_NAME, FORM_DESC, CREATOR_TIME)
values ('/ccapp/xtbg/tjy/device/jsp/devsettlement.jsp', '�����ɹ����ս���', '�����ɹ����ս���', to_date('15-03-2014 11:00:00', 'dd-mm-yyyy hh24:mi:ss'));


