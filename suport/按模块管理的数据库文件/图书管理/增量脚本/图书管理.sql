alter table CZT_IBRARY_BOOKINFO add zdtz VARCHAR2(40);
comment on column CZT_IBRARY_BOOKINFO.zdtz is '装订特征';

alter table CZT_IBRARY_BOOKINFO add whereform VARCHAR2(40);
comment on column CZT_IBRARY_BOOKINFO.whereform is '来源';


alter table CZT_IBRARY_BOOKINFO add book_number VARCHAR2(40);
comment on column CZT_IBRARY_BOOKINFO.book_number is '数量';

alter table CZT_IBRARY_BOOKINFO add booker_dept_name VARCHAR2(200);
comment on column CZT_IBRARY_BOOKINFO.booker_dept_name is '图书单位名称';



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
'图书资料申请表';

comment on column TA_OA_REGBOOK.T_REGB_ID is 
'主键ID';

comment on column TA_OA_REGBOOK.T_REGB_USER_ID is 
'申请人ID';

comment on column TA_OA_REGBOOK.T_REGB_USER_NAME is 
'申请人名称';

comment on column TA_OA_REGBOOK.T_REGB_DATE is 
'申请时间';

comment on column TA_OA_REGBOOK.T_REGB_BOOKIDS is 
'申请图书IDS';

comment on column TA_OA_REGBOOK.T_REGB_ORG_ID is 
'申请所属部门ID';

comment on column TA_OA_REGBOOK.T_REGB_ORG_NAME is 
'申请所属部门名称';

comment on column TA_OA_REGBOOK.T_REGB_DEPT_ID is 
'申请所属单位ID';

comment on column TA_OA_REGBOOK.T_REGB_DEPT_NAME is 
'申请所属单位名称';

comment on column TA_OA_REGBOOK.T_REGB_STATE is 
'申请状态';

comment on column TA_OA_REGBOOK.T_REGB_GH_DATE is 
'应归还时间';

comment on column TA_OA_REGBOOK.T_REGB_BOOKNAMES is 
'申请图书NAMES';

comment on column TA_OA_REGBOOK.T_REGB_ISKONW is 
'是否知悉';

comment on column TA_OA_REGBOOK.T_REGB_JY_DATE is 
'借阅时间';

comment on column TA_OA_REGBOOK.T_REGB_TRUEGH_DATE is 
'实际归还时间';

comment on column TA_OA_REGBOOK.T_REGB_ISXJ is 
'是否续借';


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
'图书资料申请图书表';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_ID is 
'主键ID';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_REGID is 
'申请表ID';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_ID is 
'图书ID';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_NAME is 
'图书名称';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_JG is 
'图书价格';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_NO is 
'图书数量';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_BH is 
'图书编号';

comment on column TA_OA_REGBOOK_BOOK.T_REG_BOOK_BOOK_AUTER is 
'图书作者';



