DROP TABLE OA_GWRECEIVE CASCADE CONSTRAINTS;
-- Create table
create table OA_GWRECEIVE
(
  GWRECEIVE_ID   VARCHAR2(50) not null,
  TITLE          VARCHAR2(100) not null,
  PREFIX         VARCHAR2(50) not null,
  SYMBOL         VARCHAR2(50),
  SERIAL_NUMBER  VARCHAR2(50),
  SECRECY_GRADE  VARCHAR2(50) not null,
  EFFECT_DATE    VARCHAR2(50),
  URGENCY_GRADE  VARCHAR2(50),
  CAPTION        VARCHAR2(100),
  KEYWORD        VARCHAR2(100),
  DISPATCH_TYPE  VARCHAR2(50) not null,
  SENDER         VARCHAR2(50),
  SENDSCOPE      VARCHAR2(100),
  CREATE_DATE    VARCHAR2(50) not null,
  SEND_DATE      VARCHAR2(50) not null,
  SEND_ORG_NAME  VARCHAR2(100) not null,
  SEND_ORG_ADDR  VARCHAR2(100),
  SENDUSERNAME   VARCHAR2(100),
  ISSIGN         VARCHAR2(10) not null,
  CONTACT_PHONE  VARCHAR2(100),
  RECV_ORG_NAME  VARCHAR2(100),
  RECV_ORG_ADDR  VARCHAR2(100) not null,
  FILE_NAME      VARCHAR2(100) not null,
  IS_ACCEPT      VARCHAR2(2) not null,
  ATTACH_ID      VARCHAR2(100),
  CREATOR_TIME   DATE default SYSDATE not null,
  PSS_NUMBER     VARCHAR2(150),
  OA_ORG_ID      VARCHAR2(50),
  INSERT_BY_SELF VARCHAR2(2) 
);
-- Add comments to the table 
comment on table OA_GWRECEIVE
  is '公文接收表';
-- Add comments to the columns 
comment on column OA_GWRECEIVE.GWRECEIVE_ID
  is '主键id';
comment on column OA_GWRECEIVE.TITLE
  is '公文标题';
comment on column OA_GWRECEIVE.PREFIX
  is '文号前缀';
comment on column OA_GWRECEIVE.SYMBOL
  is '文号年份';
comment on column OA_GWRECEIVE.SERIAL_NUMBER
  is '文号';
comment on column OA_GWRECEIVE.SECRECY_GRADE
  is '公文密级';
comment on column OA_GWRECEIVE.EFFECT_DATE
  is '保密期限';
comment on column OA_GWRECEIVE.URGENCY_GRADE
  is '紧急程度';
comment on column OA_GWRECEIVE.CAPTION
  is '主题词';
comment on column OA_GWRECEIVE.KEYWORD
  is '关键字';
comment on column OA_GWRECEIVE.DISPATCH_TYPE
  is '文种';
comment on column OA_GWRECEIVE.SENDER
  is '签发人';
comment on column OA_GWRECEIVE.SENDSCOPE
  is '发布层次';
comment on column OA_GWRECEIVE.CREATE_DATE
  is '成文时间';
comment on column OA_GWRECEIVE.SEND_DATE
  is '公文发送时间';
comment on column OA_GWRECEIVE.SEND_ORG_NAME
  is '发文单位机构名称';
comment on column OA_GWRECEIVE.SEND_ORG_ADDR
  is '发文单位20位地址码';
comment on column OA_GWRECEIVE.SENDUSERNAME
  is '发文操作的用户名称';
comment on column OA_GWRECEIVE.ISSIGN
  is '是否加盖电子印章';
comment on column OA_GWRECEIVE.CONTACT_PHONE
  is '询问公文相关问题的联系方式';
comment on column OA_GWRECEIVE.RECV_ORG_NAME
  is '收文单位机构名称';
comment on column OA_GWRECEIVE.RECV_ORG_ADDR
  is '收文单位的20位地址码';
comment on column OA_GWRECEIVE.FILE_NAME
  is '公文文件名称';
comment on column OA_GWRECEIVE.IS_ACCEPT
  is '是否已受理';
comment on column OA_GWRECEIVE.ATTACH_ID
  is '附件';
comment on column OA_GWRECEIVE.CREATOR_TIME
  is '创建时间';
comment on column OA_GWRECEIVE.PSS_NUMBER
  is '完整文号(文号前缀+文号年份+文号)';
comment on column OA_GWRECEIVE.OA_ORG_ID
  is 'OA处理机构名称';
comment on column OA_GWRECEIVE.INSERT_BY_SELF
  is '是否手动输入1:是';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_GWRECEIVE
  add constraint PK_OA_GWRECEIVE primary key (GWRECEIVE_ID)
 ;
