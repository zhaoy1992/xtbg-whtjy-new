alter table CZT_IBRARY_BOOKINFO add zdtz VARCHAR2(40);
comment on column CZT_IBRARY_BOOKINFO.zdtz is 'װ������';

alter table CZT_IBRARY_BOOKINFO add whereform VARCHAR2(40);
comment on column CZT_IBRARY_BOOKINFO.whereform is '��Դ';


alter table CZT_IBRARY_BOOKINFO add book_number VARCHAR2(40);
comment on column CZT_IBRARY_BOOKINFO.book_number is '����';

alter table CZT_IBRARY_BOOKINFO add booker_dept_name VARCHAR2(200);
comment on column CZT_IBRARY_BOOKINFO.booker_dept_name is 'ͼ�鵥λ����';



create table TA_OA_REGBOOK 
(
   T_REGB_ID            VARCHAR2(50)                   not null,
   T_REGB_USER_ID       VARCHAR2(50)                   null,
   T_REGB_USER_NAME     VARCHAR2(200)                  null,
   T_REGB_DATE          DATE                           null,
   T_REGB_BOOKIDS       CLOB                           null,
   T_REGB_ORG_ID        VARCHAR2(50)                   null,
   T_REGB_ORG_NAME      VARCHAR2(200)                  null,
   T_REGB_DEPT_ID       VARCHAR2(50)                   null,
   T_REGB_DEPT_NAME     VARCHAR2(200)                  null,
   T_REGB_STATE         VARCHAR2(10)                   null,
   T_REGB_GH_DATE       DATE                           null,
   T_REGB_BOOKNAMES     CLOB                           null,
   T_REGB_ISKONW        VARCHAR2(4)                    null,
   T_REGB_JY_DATE       DATE                           null,
   T_REGB_TRUEGH_DATE   DATE                           null,
   T_REGB_ISXJ          VARCHAR2(4)                    null,
   constraint PK_TA_OA_REGBOOK primary key (T_REGB_ID)
);

comment on table TA_OA_REGBOOK is 
'ͼ�����������';

comment on column TA_OA_REGBOOK.T_REGB_ID is 
'����ID';

comment on column TA_OA_REGBOOK.T_REGB_USER_ID is 
'������ID';

comment on column TA_OA_REGBOOK.T_REGB_USER_NAME is 
'����������';

comment on column TA_OA_REGBOOK.T_REGB_DATE is 
'����ʱ��';

comment on column TA_OA_REGBOOK.T_REGB_BOOKIDS is 
'����ͼ��IDS';

comment on column TA_OA_REGBOOK.T_REGB_ORG_ID is 
'������������ID';

comment on column TA_OA_REGBOOK.T_REGB_ORG_NAME is 
'����������������';

comment on column TA_OA_REGBOOK.T_REGB_DEPT_ID is 
'����������λID';

comment on column TA_OA_REGBOOK.T_REGB_DEPT_NAME is 
'����������λ����';

comment on column TA_OA_REGBOOK.T_REGB_STATE is 
'����״̬';

comment on column TA_OA_REGBOOK.T_REGB_GH_DATE is 
'Ӧ�黹ʱ��';

comment on column TA_OA_REGBOOK.T_REGB_BOOKNAMES is 
'����ͼ��NAMES';

comment on column TA_OA_REGBOOK.T_REGB_ISKONW is 
'�Ƿ�֪Ϥ';

comment on column TA_OA_REGBOOK.T_REGB_JY_DATE is 
'����ʱ��';

comment on column TA_OA_REGBOOK.T_REGB_TRUEGH_DATE is 
'ʵ�ʹ黹ʱ��';

comment on column TA_OA_REGBOOK.T_REGB_ISXJ is 
'�Ƿ�����';


create table TA_OA_REGBOOK_BOOK 
(
   T_REG_BOOK_ID        VARCHAR2(50)                   not null,
   T_REG_BOOK_REGID     VARCHAR2(50)                   null,
   T_REG_BOOK_BOOK_ID   VARCHAR2(50)                   null,
   T_REG_BOOK_BOOK_NAME VARCHAR2(200)                  null,
   T_REG_BOOK_BOOK_JG   VARCHAR2(50)                   null,
   T_REG_BOOK_BOOK_NO   VARCHAR2(50)                   null,
   T_REG_BOOK_BOOK_BH   VARCHAR2(50)                   null,
   T_REG_BOOK_BOOK_AUTER VARCHAR2(200)                  null,
   constraint PK_TA_OA_REGBOOK_BOOK primary key (T_REG_BOOK_ID)
);

comment on table TA_OA_REGBOOK_BOOK is 
'ͼ����������ͼ���';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_ID is 
'����ID';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_REGID is 
'�����ID';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_ID is 
'ͼ��ID';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_NAME is 
'ͼ������';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_JG is 
'ͼ��۸�';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_NO is 
'ͼ������';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_BH is 
'ͼ����';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_AUTER is 
'ͼ������';



