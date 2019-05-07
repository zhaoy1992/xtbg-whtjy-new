

DROP TABLE CZT_IBRARYTREE CASCADE CONSTRAINTS;

CREATE TABLE CZT_IBRARYTREE 
(
   TREE_ID              VARCHAR2(40)         NOT NULL,
   TREE_PARENT_ID       VARCHAR2(40),
   TREE_NAME            VARCHAR2(200)        NOT NULL,
   TREE_TYPE_CODE       VARCHAR2(40),
   TREE_TYPE_NO         VARCHAR2(40),
   ORDER_NO             INTEGER              NOT NULL,
   REMARK               VARCHAR2(1000),
   CONSTRAINT PK_CZT_IBRARYTREE PRIMARY KEY (TREE_ID)
);

COMMENT ON TABLE CZT_IBRARYTREE IS
'图书分类表';

COMMENT ON COLUMN CZT_IBRARYTREE.TREE_ID IS
'图书分类ID';

COMMENT ON COLUMN CZT_IBRARYTREE.TREE_PARENT_ID IS
'父分类点ID';

COMMENT ON COLUMN CZT_IBRARYTREE.TREE_NAME IS
'类型名称';

COMMENT ON COLUMN CZT_IBRARYTREE.TREE_TYPE_CODE IS
'分类代码';

COMMENT ON COLUMN CZT_IBRARYTREE.TREE_TYPE_NO IS
'分类级次';

COMMENT ON COLUMN CZT_IBRARYTREE.ORDER_NO IS
'排序号';

COMMENT ON COLUMN CZT_IBRARYTREE.REMARK IS
'描述';

DROP TABLE CZT_PRESS CASCADE CONSTRAINTS;
-- Create table
create table CZT_PRESS
(
  PRESS_ID   VARCHAR2(50 CHAR) not null,
  PRESS_NAME VARCHAR2(200 CHAR),
  ORDER_NO   NUMBER
);
-- Add comments to the table 
comment on table CZT_PRESS
  is '出版社';
-- Add comments to the columns 
comment on column CZT_PRESS.PRESS_ID
  is '出版社id';
comment on column CZT_PRESS.PRESS_NAME
  is '出版社名';
comment on column CZT_PRESS.ORDER_NO
  is '排序号';
-- Create/Recreate primary, unique and foreign key constraints 
alter table CZT_PRESS
  add constraint PK_CZT_PRESS primary key (PRESS_ID);
  
  



DROP TABLE CZT_IBRARY_BOOKINFO CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: CZT_IBRARY_BOOKINFO                                   */
/*==============================================================*/
CREATE TABLE CZT_IBRARY_BOOKINFO 
(
   BOOK_ID              VARCHAR2(40)         NOT NULL,
   TREE_ID              VARCHAR2(40),
   BOOK_NAME            VARCHAR2(200)        NOT NULL,
   BOOK_NO              VARCHAR2(40),
   BOOK_AUTHOR          VARCHAR2(200),
   BOOK_PRESSNAME       VARCHAR2(200),
   BOOK_PRESSNO         VARCHAR2(40),
   BOOK_PRESSDATE       DATE,
   BOOK_PRESSBUNVER     VARCHAR2(40),
   BOOK_PAGE            VARCHAR2(40),
   BOOK_PRICE           NUMBER(18,2),
   BOOK_STATE           VARCHAR2(1)          DEFAULT '0'
      CONSTRAINT CKC_BOOK_STATE_CZT_IBRA CHECK (BOOK_STATE IS NULL OR (BOOK_STATE BETWEEN '0' AND '1' AND BOOK_STATE IN ('0','1'))),
   BOOKER_ID            VARCHAR2(40),
   BOOKER_DATE          DATE,
   BOOKER_DEPT_ID       VARCHAR2(40),
   REMARK               VARCHAR2(1000),
   ACCESSORY            VARCHAR2(40),
   BORROW_ID            VARCHAR2(40),
   "TREE_NAME"          VARCHAR2(200),
   CONSTRAINT PK_CZT_IBRARY_BOOKINFO PRIMARY KEY (BOOK_ID)
);

COMMENT ON TABLE CZT_IBRARY_BOOKINFO IS
'图书基本信息表';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_ID IS
'图书ID';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.TREE_ID IS
'图书分类ID';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_NAME IS
'图书名称';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_NO IS
'图书编号';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_AUTHOR IS
'作者';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_PRESSNAME IS
'出版社名称';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_PRESSNO IS
'出版号';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_PRESSDATE IS
'出版日期';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_PRESSBUNVER IS
'版次';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_PAGE IS
'页数';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_PRICE IS
'价格';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOK_STATE IS
'库存状态,0在库，1已借出';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOKER_ID IS
'登记人ID';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOKER_DATE IS
'登记时间';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BOOKER_DEPT_ID IS
'登记部门ID';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.REMARK IS
'内容说明';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.ACCESSORY IS
'附件ID';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO.BORROW_ID IS
'借阅ID';

COMMENT ON COLUMN CZT_IBRARY_BOOKINFO."TREE_NAME" IS
'图书分类名称';

ALTER TABLE CZT_IBRARY_BOOKINFO
   ADD CONSTRAINT FK_TYPE_REFERENCE_CZT_IBRA FOREIGN KEY (TREE_ID)
      REFERENCES CZT_IBRARYTREE (TREE_ID);


  
DROP TABLE CZT_IBRARY_BORROWINFO CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: CZT_IBRARY_BORROWINFO                                 */
/*==============================================================*/
CREATE TABLE CZT_IBRARY_BORROWINFO 
(
   BORROW_ID            VARCHAR2(40)         NOT NULL,
   BOOK_ID              VARCHAR2(40),
   BORROW_TIME          DATE                 NOT NULL,
   BORROW_GIVETIME      DATE,
   BOOROW_BACKTIME      DATE,
   BOOROW_STATE         VARCHAR2(1)          DEFAULT '1' NOT NULL
      CONSTRAINT CKC_BOOROW_STATE_CZT_IBRA CHECK (BOOROW_STATE BETWEEN '1' AND '2' AND BOOROW_STATE IN ('1','2')),
   PHONE_NUMBER         VARCHAR2(18),
   BOOROW_USER_ID       VARCHAR2(40)         NOT NULL,
   BOOROW_OUT_USER_ID   VARCHAR2(40),
   BOOROW_IN_USER_ID    VARCHAR2(40),
   "BOOROW_USER_NAME"   VARCHAR2(40),
   CONSTRAINT PK_CZT_IBRARY_BORROWINFO PRIMARY KEY (BORROW_ID)
);

COMMENT ON TABLE CZT_IBRARY_BORROWINFO IS
'图书借阅表';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO.BORROW_ID IS
'借阅ID';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO.BOOK_ID IS
'图书ID';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO.BORROW_TIME IS
'借阅时间';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO.BORROW_GIVETIME IS
'应归还时间';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO.BOOROW_BACKTIME IS
'实际归还时间';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO.BOOROW_STATE IS
'借阅状态，1借阅中，2已归还';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO.PHONE_NUMBER IS
'联系电话';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO.BOOROW_USER_ID IS
'借阅人ID';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO.BOOROW_OUT_USER_ID IS
'借阅经手人ID';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO.BOOROW_IN_USER_ID IS
'归还经手人ID';

COMMENT ON COLUMN CZT_IBRARY_BORROWINFO."BOOROW_USER_NAME" IS
'借阅人';

ALTER TABLE CZT_IBRARY_BORROWINFO
   ADD CONSTRAINT FK_BOOKE_REFERENCE_CZT_IBRA FOREIGN KEY (BOOK_ID)
      REFERENCES CZT_IBRARY_BOOKINFO (BOOK_ID);


