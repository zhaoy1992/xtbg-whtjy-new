/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2013-7-2 15:15:59                            */
/*==============================================================*/


ALTER TABLE OA_NOTE_DETAIL
   DROP CONSTRAINT FK_TD_NOTE_BUFFER;

ALTER TABLE OA_NOTE_DETAILHIS
   DROP CONSTRAINT FK_TD_NOTE_BUFFERHIS;

DROP TABLE OA_NOTE_BUFFER CASCADE CONSTRAINTS;

DROP TABLE OA_NOTE_BUFFERHIS CASCADE CONSTRAINTS;

DROP TABLE OA_NOTE_DETAIL CASCADE CONSTRAINTS;

DROP TABLE OA_NOTE_DETAILHIS CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: OA_NOTE_BUFFER                                        */
/*==============================================================*/
CREATE TABLE OA_NOTE_BUFFER 
(
   BUFFER_ID            VARCHAR2(50)         NOT NULL,
   CONTENT              VARCHAR2(4000)       NOT NULL,
   CREATE_DATE          DATE                 NOT NULL,
   SEND_DATE            DATE                 NOT NULL,
   NEED_STATUS          CHAR(1)              NOT NULL,
   NEED_CONTENT         CHAR(1)              NOT NULL,
   RETRY_TIMES          NUMBER               NOT NULL,
   USER_ID              NUMBER,
   USER_NAME            VARCHAR2(100),
   ORG_ID               VARCHAR2(50),
   ORG_NAME             VARCHAR2(100),
   BUSINESS_ID          VARCHAR2(100),
   BUSINESS_TYPE        VARCHAR2(10),
   SUBJECT              VARCHAR2(200),
   TAG                  CHAR(1),
   CONSTRAINT PK_OA_NOTE_BUFFER PRIMARY KEY (BUFFER_ID)
);

COMMENT ON TABLE OA_NOTE_BUFFER IS
'短信发送缓存表';

COMMENT ON COLUMN OA_NOTE_BUFFER.BUFFER_ID IS
'短信id';

COMMENT ON COLUMN OA_NOTE_BUFFER.CONTENT IS
'短信内容';

COMMENT ON COLUMN OA_NOTE_BUFFER.CREATE_DATE IS
'短信创建时间';

COMMENT ON COLUMN OA_NOTE_BUFFER.SEND_DATE IS
'短信发送时间（可以设置此时间为定时发送时间，如果不需要定时发送直接设置为数据库系统时间）';

COMMENT ON COLUMN OA_NOTE_BUFFER.NEED_STATUS IS
'是否获取短信回执（0不要1需要）';

COMMENT ON COLUMN OA_NOTE_BUFFER.NEED_CONTENT IS
'是否获取回复短信（0不要1需要）';

COMMENT ON COLUMN OA_NOTE_BUFFER.RETRY_TIMES IS
'重发次数';

COMMENT ON COLUMN OA_NOTE_BUFFER.USER_ID IS
'发送人id';

COMMENT ON COLUMN OA_NOTE_BUFFER.USER_NAME IS
'发送人姓名';

COMMENT ON COLUMN OA_NOTE_BUFFER.ORG_ID IS
'发送人单位id';

COMMENT ON COLUMN OA_NOTE_BUFFER.ORG_NAME IS
'发送人单位名称';

COMMENT ON COLUMN OA_NOTE_BUFFER.BUSINESS_ID IS
'业务id';

COMMENT ON COLUMN OA_NOTE_BUFFER.BUSINESS_TYPE IS
'业务类型';

COMMENT ON COLUMN OA_NOTE_BUFFER.SUBJECT IS
'彩信主题';

COMMENT ON COLUMN OA_NOTE_BUFFER.TAG IS
'彩信与短信标识(null或者0普通短信，1彩信)';

/*==============================================================*/
/* Table: OA_NOTE_BUFFERHIS                                     */
/*==============================================================*/
CREATE TABLE OA_NOTE_BUFFERHIS 
(
   BUFFER_ID            VARCHAR2(50)         NOT NULL,
   CONTENT              VARCHAR2(4000)       NOT NULL,
   CREATE_DATE          DATE                 NOT NULL,
   SEND_DATE            DATE                 NOT NULL,
   NEED_STATUS          CHAR(1)              NOT NULL,
   NEED_CONTENT         CHAR(1)              NOT NULL,
   RETRY_TIMES          NUMBER               NOT NULL,
   USER_ID              VARCHAR2(50),
   USER_NAME            VARCHAR2(100),
   ORG_ID               VARCHAR2(50),
   ORG_NAME             VARCHAR2(100),
   BUSINESS_ID          VARCHAR2(100),
   BUSINESS_TYPE        VARCHAR2(10),
   SUBJECT              VARCHAR2(200),
   TAG                  CHAR(1),
   CONSTRAINT PK_OA_NOTE_BUFFERHIS PRIMARY KEY (BUFFER_ID)
);

COMMENT ON TABLE OA_NOTE_BUFFERHIS IS
'短信发送历史表';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.BUFFER_ID IS
'短信id';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.CONTENT IS
'短信内容';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.CREATE_DATE IS
'短信创建时间';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.SEND_DATE IS
'短信发送时间（真是发送时间）';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.NEED_STATUS IS
'是否获取短信回执（0不要1需要）';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.NEED_CONTENT IS
'是否获取回复短信（0不要1需要）';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.RETRY_TIMES IS
'重发次数';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.USER_ID IS
'发送人id';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.USER_NAME IS
'发送人姓名';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.ORG_ID IS
'发送人单位id';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.ORG_NAME IS
'发送人单位名称';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.BUSINESS_ID IS
'业务id';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.BUSINESS_TYPE IS
'业务类型';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.SUBJECT IS
'彩信主题';

COMMENT ON COLUMN OA_NOTE_BUFFERHIS.TAG IS
'彩信与短信标识彩信与短信标识(null或者0普通短信，1彩信)';

/*==============================================================*/
/* Table: OA_NOTE_DETAIL                                        */
/*==============================================================*/
CREATE TABLE OA_NOTE_DETAIL 
(
   RECV_ID              VARCHAR2(50)         NOT NULL,
   BUFFER_ID            VARCHAR2(50)         NOT NULL,
   PHONE_NUM            VARCHAR2(15)         NOT NULL,
   USER_ID              VARCHAR2(50),
   USER_NAME            VARCHAR2(100),
   ORG_ID               VARCHAR2(50),
   ORG_NAME             VARCHAR2(100),
   CONSTRAINT PK_OA_NOTE_DETAIL PRIMARY KEY (RECV_ID)
);

COMMENT ON TABLE OA_NOTE_DETAIL IS
'短信接收人表';

COMMENT ON COLUMN OA_NOTE_DETAIL.RECV_ID IS
'接收id';

COMMENT ON COLUMN OA_NOTE_DETAIL.BUFFER_ID IS
'短信id';

COMMENT ON COLUMN OA_NOTE_DETAIL.PHONE_NUM IS
'接收号码';

COMMENT ON COLUMN OA_NOTE_DETAIL.USER_ID IS
'接收人id';

COMMENT ON COLUMN OA_NOTE_DETAIL.USER_NAME IS
'接收人姓名';

COMMENT ON COLUMN OA_NOTE_DETAIL.ORG_ID IS
'接收人单位id';

COMMENT ON COLUMN OA_NOTE_DETAIL.ORG_NAME IS
'接收人单位名称';

/*==============================================================*/
/* Table: OA_NOTE_DETAILHIS                                     */
/*==============================================================*/
CREATE TABLE OA_NOTE_DETAILHIS 
(
   RECV_ID              VARCHAR2(50)         NOT NULL,
   BUFFER_ID            VARCHAR2(50)         NOT NULL,
   PHONE_NUM            VARCHAR2(15)         NOT NULL,
   USER_ID              VARCHAR2(50),
   USER_NAME            VARCHAR2(100),
   ORG_ID               VARCHAR2(50),
   ORG_NAME             VARCHAR2(100),
   RESPONSE_ID          VARCHAR2(100),
   RESPONSE_STATUS      VARCHAR2(100),
   STATUS_DATA          DATE,
   RESPONSE_CONTENT     VARCHAR2(4000),
   CONTENT_DATA         DATE,
   CONSTRAINT PK_OA_NOTE_DETAILHIS PRIMARY KEY (RECV_ID)
);

COMMENT ON TABLE OA_NOTE_DETAILHIS IS
'短信接收人历史表';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.RECV_ID IS
'接收id';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.BUFFER_ID IS
'短信id';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.PHONE_NUM IS
'接收号码';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.USER_ID IS
'接收人id';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.USER_NAME IS
'接收人姓名';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.ORG_ID IS
'接收人单位id';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.ORG_NAME IS
'接收人单位名称';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.RESPONSE_ID IS
'短信发送的响应id';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.RESPONSE_STATUS IS
'短信回执状态(已发送，发送成功，发送失败)';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.STATUS_DATA IS
'回执时间';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.RESPONSE_CONTENT IS
'回复短信内容';

COMMENT ON COLUMN OA_NOTE_DETAILHIS.CONTENT_DATA IS
'回复短信时间';

ALTER TABLE OA_NOTE_DETAIL
   ADD CONSTRAINT FK_TD_NOTE_BUFFER FOREIGN KEY (BUFFER_ID)
      REFERENCES OA_NOTE_BUFFER (BUFFER_ID);

ALTER TABLE OA_NOTE_DETAILHIS
   ADD CONSTRAINT FK_TD_NOTE_BUFFERHIS FOREIGN KEY (BUFFER_ID)
      REFERENCES OA_NOTE_BUFFERHIS (BUFFER_ID);

