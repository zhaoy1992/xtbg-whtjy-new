--------CMS内容管理脚本开始--------
create or replace  type TYP_ID_NAME as OBJECT
(
    ID NUMBER,
    NAME VARCHAR(100)
);

create or replace  type TYP_ID_NAME_LIST as TABLE of TYP_ID_NAME;

create table TB_CMS_DOC_KIND  (
   ID                   NUMBER                           not null,
   NAME                 VARCHAR2(100)                    not null,
   PARENT_ID            NUMBER,
   ORDER_NO             NUMBER,
   constraint PK_TB_CMS_DOC_KIND primary key (ID)
);
comment on table TB_CMS_DOC_KIND is '文档类别编码表';
comment on column TB_CMS_DOC_KIND.ID is '文档类别编码';
comment on column TB_CMS_DOC_KIND.NAME is '文档类别名称';
comment on column TB_CMS_DOC_KIND.PARENT_ID is '父ID';
comment on column TB_CMS_DOC_KIND.ORDER_NO is '同级节点的排列顺序';

create table TB_CMS_DOC_LEVEL  (
   ID                   NUMBER                           not null,
   NAME                 VARCHAR2(100)                    not null,
   LEVEL_VALUE          NUMBER                           not null,
   constraint PK_TB_CMS_DOC_LEVEL primary key (ID)
);
comment on table TB_CMS_DOC_LEVEL is '文档级别编码表';
comment on column TB_CMS_DOC_LEVEL.ID is '文档级别编码';
comment on column TB_CMS_DOC_LEVEL.NAME is '文档级别名称';
comment on column TB_CMS_DOC_LEVEL.LEVEL_VALUE is '级别，数字越小，级别越高';

create table TB_CMS_DOC_OPER  (
   ID                   NUMBER                           not null,
   NAME                 VARCHAR2(100)                    not null,
   constraint PK_TB_CMS_DOC_OPER primary key (ID)
);

create table TB_CMS_DOC_STATUS  (
   ID                   NUMBER                           not null,
   NAME                 VARCHAR2(20)                     not null,
   TYPE                 NUMBER                           not null,
   constraint PKSTATUS primary key (ID)
);
comment on column TB_CMS_DOC_STATUS.TYPE is '1:开始状态，2：普通状态，3、结束状态';

create table TB_CMS_DOC_STATUS_TRANS  (
   ID                   NUMBER                           not null,
   SRC_STATUS           NUMBER                           not null,
   DEST_STATUS          NUMBER                           not null,
   "DESC"               VARCHAR2(100),
   constraint PK_TB_CMS_DOC_STATUS_TRANS primary key (ID)
);
comment on table TB_CMS_DOC_STATUS_TRANS is '文档状态迁移表';

create unique index IDX_SRC_DEST on TB_CMS_DOC_STATUS_TRANS (
   DEST_STATUS ASC,
   SRC_STATUS ASC
);

create table TB_CMS_FLOW  (
   ID                   NUMBER                           not null,
   NAME                 VARCHAR2(100)                    not null,
   constraint PK_TB_CMS_FLOW primary key (ID)
);

create table TB_CMS_FLOW_DOC_TRANS  (
   FLOW_ID              NUMBER,
   TRANSISION_ID        NUMBER
);

create table TD_CMS_ADDWATERIMAGE  (
   URL                  VARCHAR2(150)                    not null,
   CREATETIME           DATE,
   ISBACKUP             VARCHAR2(2),
   constraint TD_CMS_ADDWATERIMAGE primary key (URL)
);
comment on table TD_CMS_ADDWATERIMAGE is '内容管理图片添加了水印的记录';
comment on column TD_CMS_ADDWATERIMAGE.URL is '被添加水印的图片路径,全路径, 主键';
comment on column TD_CMS_ADDWATERIMAGE.CREATETIME is '图片添加水印的时间';
comment on column TD_CMS_ADDWATERIMAGE.ISBACKUP is '是否备份了原始文件 0:无备份 1: 有备份';

create table TD_CMS_CHANNEL  (
   CHANNEL_ID           NUMBER(10)                       not null,
   NAME                 VARCHAR2(50)                     not null,
   DISPLAY_NAME         VARCHAR2(50),
   PARENT_ID            NUMBER(10),
   CHNL_PATH            VARCHAR2(150)                    not null,
   CREATEUSER           NUMBER                           not null,
   CREATETIME           DATE                             not null,
   ORDER_NO             NUMBER(5)                      default 0  not null,
   SITE_ID              NUMBER(10)                       not null,
   STATUS               NUMBER(1)                      default 0  not null,
   OUTLINE_TPL_ID       NUMBER(10),
   DETAIL_TPL_ID        NUMBER(10),
   WORKFLOW             NUMBER                         default 0  not null,
   CHNL_OUTLINE_DYNAMIC NUMBER                         default 0  not null,
   DOC_DYNAMIC          NUMBER                         default 0  not null,
   CHNL_OUTLINE_PROTECT NUMBER                         default 0  not null,
   DOC_PROTECT          NUMBER                         default 0  not null,
   PARENT_WORKFLOW      CHAR                           default '1'  not null,
   PUB_FILE_NAME        VARCHAR2(100)                  default 'default.htm'  not null,
   INHERITSITEFIELD     NUMBER(1)                      default 0,
   ISNAVIGATOR          NUMBER(1)                      default 0,
   NAVIGATORLEVEL       NUMBER(10),
   MOUSEINIMAGE         VARCHAR2(150),
   MOUSEOUTIMAGE        VARCHAR2(150),
   MOUSECLICKIMAGE      VARCHAR2(150),
   MOUSEUPIMAGE         VARCHAR2(150),
   OUTLINEPICTURE       VARCHAR2(255),
   PAGEFLAG             NUMBER(1),
   INDEXPAGEPATH        VARCHAR2(200),
   COMMENTSWITCH        NUMBER(1),
   COMMENT_TEMPLATE_ID  NUMBER,
   COMMENTPAGEPATH      VARCHAR2(200),
   constraint PK_TD_CMS_CHANNEL183 primary key (CHANNEL_ID)
);
comment on table TD_CMS_CHANNEL is '网站频道：计划包括采集计划（可以指定某人某段时间计划采集数，及可否按照计划自动审核，可以有雷达计划采集,可以指定计划发布时间及内容。文档命名规则(都有哪些规则)';
comment on column TD_CMS_CHANNEL.CHANNEL_ID is 'ID';
comment on column TD_CMS_CHANNEL.NAME is '频道的中文名称';
comment on column TD_CMS_CHANNEL.DISPLAY_NAME is '频道显示名称';
comment on column TD_CMS_CHANNEL.PARENT_ID is '父频道ID';
comment on column TD_CMS_CHANNEL.CHNL_PATH is '存放相对路径';
comment on column TD_CMS_CHANNEL.CREATEUSER is '创建人ID';
comment on column TD_CMS_CHANNEL.CREATETIME is '创建时间';
comment on column TD_CMS_CHANNEL.ORDER_NO is '排列顺序';
comment on column TD_CMS_CHANNEL.SITE_ID is '频道所属的站点';
comment on column TD_CMS_CHANNEL.STATUS is '频道状态 0：正常 1：已回收';
comment on column TD_CMS_CHANNEL.OUTLINE_TPL_ID is '概览模板ID';
comment on column TD_CMS_CHANNEL.DETAIL_TPL_ID is '细览模板ID';
comment on column TD_CMS_CHANNEL.WORKFLOW is '流程ID，为0代表引用站点的流程设置';
comment on column TD_CMS_CHANNEL.CHNL_OUTLINE_DYNAMIC is '发布的频道概览页面是动态还是静态，1：动态 0：静态';
comment on column TD_CMS_CHANNEL.DOC_DYNAMIC is '频道所属文档发布的页面是动态还是静态,1：动态 0：静态';
comment on column TD_CMS_CHANNEL.CHNL_OUTLINE_PROTECT is
'当发布的频道概览页面是动态时，是否进行权限保护
1：保护
0：不保护
当发布的频道概览页面是静态时，暂不支持权限保护，
忽略本属性';
comment on column TD_CMS_CHANNEL.DOC_PROTECT is
'频道所属文档发布的页面是否进行权限保护
1：保护
0：不保护';
comment on column TD_CMS_CHANNEL.PARENT_WORKFLOW is '是否引用父对象的流程,1:引用，0：不引用';
comment on column TD_CMS_CHANNEL.PUB_FILE_NAME is '频道概览文件名(发布使用)';
comment on column TD_CMS_CHANNEL.INHERITSITEFIELD is 
'标识频道是否继承所属站点的扩展字段
0:标识不继承
1:标识继承
缺省不继承';
comment on column TD_CMS_CHANNEL.ISNAVIGATOR is '标识频道是否作为导航频道，0－普通频道，1－导航频道';
comment on column TD_CMS_CHANNEL.NAVIGATORLEVEL is '设置导航频道的级别';
comment on column TD_CMS_CHANNEL.MOUSEINIMAGE is '频道显示图片(鼠标移上去的图片)';
comment on column TD_CMS_CHANNEL.MOUSEOUTIMAGE is '频道显示图片(鼠标移开的图片)';
comment on column TD_CMS_CHANNEL.MOUSECLICKIMAGE is '频道显示图片(鼠标点击的图片)';
comment on column TD_CMS_CHANNEL.MOUSEUPIMAGE is '频道显示图片(鼠标点击后的图片)';
comment on column TD_CMS_CHANNEL.OUTLINEPICTURE is '频道概览图片，在频道概览时可作为概览图片发布';
comment on column TD_CMS_CHANNEL.PAGEFLAG is
'频道首页生成方式控制标识
0－通过概览模版发布生成首页
1－通过指定的页面发布生成首页';
comment on column TD_CMS_CHANNEL.INDEXPAGEPATH is '手动指定的频道首页地址，通过pageflag标识来进行控制';
comment on column TD_CMS_CHANNEL.COMMENTSWITCH is
'频道文档评论是否开通标识:
0-开通
1-关闭
2007年5月14号添加';
comment on column TD_CMS_CHANNEL.COMMENT_TEMPLATE_ID is '评论模版id';
comment on column TD_CMS_CHANNEL.COMMENTPAGEPATH is '文档评论页面路径';

create index TC_TD_CMS_CHANNEL1277 on TD_CMS_CHANNEL (
   PARENT_ID ASC
);

create index TC_TD_CMS_CHANNEL1287 on TD_CMS_CHANNEL (
   SITE_ID ASC
);

create table TD_CMS_CHANNELFIELD  (
   FIELD_ID             NUMBER(10)                       not null,
   CHANNEL_ID           NUMBER(10)                       not null,
   constraint PK_TD_CMS_CHANNELFIELD primary key (FIELD_ID, CHANNEL_ID)
);
comment on table TD_CMS_CHANNELFIELD is '扩展字段和频道的映射关系';
comment on column TD_CMS_CHANNELFIELD.FIELD_ID is '扩展字段主键';
comment on column TD_CMS_CHANNELFIELD.CHANNEL_ID is 'ID';

create index INDEX_4 on TD_CMS_CHANNELFIELD (
   FIELD_ID ASC
);

create index INDEX_5 on TD_CMS_CHANNELFIELD (
   CHANNEL_ID ASC
);

create table TD_CMS_CHNL_REF_DOC  (
   CHNL_ID              NUMBER(10)                       not null,
   DOC_ID               NUMBER                           not null,
   OP_USER_ID           NUMBER                           not null,
   OP_TIME              DATE                             not null,
   CITETYPE             NUMBER(1),
   SITE_ID              NUMBER,
   constraint PK_TD_CMS_CHNL_REF_DOC primary key (CHNL_ID, DOC_ID)
);
comment on table TD_CMS_CHNL_REF_DOC is '频道引用文档表'; 
comment on column TD_CMS_CHNL_REF_DOC.CHNL_ID is '频道ID';
comment on column TD_CMS_CHNL_REF_DOC.DOC_ID is '文档ID';
comment on column TD_CMS_CHNL_REF_DOC.OP_USER_ID is '操作人ID';
comment on column TD_CMS_CHNL_REF_DOC.OP_TIME is '操作时间';
comment on column TD_CMS_CHNL_REF_DOC.CITETYPE is '引用类型标志，0－引用文档；1－引用频道  缺省值为0';
comment on column TD_CMS_CHNL_REF_DOC.SITE_ID is '引用文档、引用频道所属的站点id 对应于不同的频道分库的情况下发布的功能';

create table TD_CMS_COLLECT_ANSWER  (
   ANSWER               CLOB,
   CID                  NUMBER(10),
   WHO_IP               VARCHAR2(100),
   WHEN                 DATE,
   NAME                 VARCHAR2(50),
   STATE                NUMBER(1),
   OPERATORID           VARCHAR2(50),
   OTIME                DATE,
   ANSTIME              DATE,
   ANSWER_ID            NUMBER(10)                       not null,
   PHONE                VARCHAR2(50),
   EMAIL                VARCHAR2(50),
   ADDRESS              VARCHAR2(100),
   CARD                 VARCHAR2(50),
   TITLE                VARCHAR2(100),
   constraint PK_TD_CMS_COLLECT_ANSWER primary key (ANSWER_ID)
);
comment on table TD_CMS_COLLECT_ANSWER is '存放网民意见征集意见表。';
comment on column TD_CMS_COLLECT_ANSWER.ANSWER is '回答内容';
comment on column TD_CMS_COLLECT_ANSWER.CID is '外键，为具体意见征集表主id';
comment on column TD_CMS_COLLECT_ANSWER.WHO_IP is '市民意见征集IP地址';
comment on column TD_CMS_COLLECT_ANSWER.WHEN is '意见征集   ：反馈时间';
comment on column TD_CMS_COLLECT_ANSWER.NAME is '市民称呼';
comment on column TD_CMS_COLLECT_ANSWER.STATE is '0 待审核，1 已处理 2、废件。 在后台对应三种状态，前台只显示已处理意见。';
comment on column TD_CMS_COLLECT_ANSWER.OPERATORID is '意见审核处理人id';
comment on column TD_CMS_COLLECT_ANSWER.OTIME is '处理操作时间。';
comment on column TD_CMS_COLLECT_ANSWER.ANSTIME is '意见征集   ：反馈时间';
comment on column TD_CMS_COLLECT_ANSWER.ANSWER_ID is '回答ID';
comment on column TD_CMS_COLLECT_ANSWER.PHONE is '联系电话';
comment on column TD_CMS_COLLECT_ANSWER.EMAIL is 'email';
comment on column TD_CMS_COLLECT_ANSWER.ADDRESS is '地址';
comment on column TD_CMS_COLLECT_ANSWER.CARD is '身份证号';
comment on column TD_CMS_COLLECT_ANSWER.TITLE is '标题(oylin)';

create table TD_CMS_COLLECT_IPCTRL2  (
   ID                   NUMBER(10)                       not null,
   TITLE_ID             NUMBER(10),
   IP_START             VARCHAR2(100),
   IP_END               VARCHAR2(100),
   constraint PK_TD_CMS_COLLECT_IPCTRL2 primary key (ID)
);
comment on table TD_CMS_COLLECT_IPCTRL2 is 'ip段控制';
comment on column TD_CMS_COLLECT_IPCTRL2.TITLE_ID is '主题ID';
comment on column TD_CMS_COLLECT_IPCTRL2.IP_START is 'IP开始段';
comment on column TD_CMS_COLLECT_IPCTRL2.IP_END is 'IP结束段';

create table TD_CMS_COLLECT_TIMECTRL2  (
   ID                   NUMBER(10)                       not null,
   TITLE_ID             NUMBER(10),
   TIME_START           DATE,
   TIME_END             DATE,
   constraint PK_TD_CMS_COLLECT_TIMECTRL2 primary key (ID)
);
comment on table TD_CMS_COLLECT_TIMECTRL2 is '时间段控制';
comment on column TD_CMS_COLLECT_TIMECTRL2.TITLE_ID is '主题ID';
comment on column TD_CMS_COLLECT_TIMECTRL2.TIME_START is '开始时间';
comment on column TD_CMS_COLLECT_TIMECTRL2.TIME_END is '结束时间';

create table TD_CMS_COLLECT_TITLE  (
   NAME                 VARCHAR2(200),
   CONTENT              CLOB,
   ID                   NUMBER(10)                       not null,
   SITEID               NUMBER(10),
   IP_REPEAT            NUMBER(1),
   TIME_GAP             NUMBER,
   FOUNDER_ID           NUMBER,
   CTIME                DATE,
   ISTOP                NUMBER(1),
   DEPART               VARCHAR2(50),
   STIME                DATE,
   ETIME                DATE,
   STATE                NUMBER(1),
   constraint PK_TD_CMS_COLLECT_TITLE primary key (ID)
);
comment on table TD_CMS_COLLECT_TITLE is '意见征集主表';
comment on column TD_CMS_COLLECT_TITLE.NAME is '主题名称';
comment on column TD_CMS_COLLECT_TITLE.CONTENT is '主题内容';
comment on column TD_CMS_COLLECT_TITLE.ID is '主题主键';
comment on column TD_CMS_COLLECT_TITLE.SITEID is '站点ID';
comment on column TD_CMS_COLLECT_TITLE.IP_REPEAT is '0：IP不可以重复 1：IP可以重复';
comment on column TD_CMS_COLLECT_TITLE.TIME_GAP is '时间间隔以小时为单位';
comment on column TD_CMS_COLLECT_TITLE.FOUNDER_ID is '创建人ID';
comment on column TD_CMS_COLLECT_TITLE.CTIME is '创建时间';
comment on column TD_CMS_COLLECT_TITLE.ISTOP is '0：非置顶 1：置顶';
comment on column TD_CMS_COLLECT_TITLE.DEPART is '征集部门';
comment on column TD_CMS_COLLECT_TITLE.STIME is '意见征集 开始时间';
comment on column TD_CMS_COLLECT_TITLE.ETIME is '意见征集  结束时间';
comment on column TD_CMS_COLLECT_TITLE.STATE is
'0 -待审核 1 已发布  2、已征集 （时间段结束，可自动修改其状态。）3、已归档。     前台 征集中，只显示 已发布正在征集的意见。
已征集 显示状态为已征集意见内容。';

create table TD_CMS_CUSTOM_FORM  (
   TARGET_ID            NUMBER(10)                       not null,
   TARGET_TYPE          CHAR                             not null,
   FORM_TYPE            CHAR                             not null,
   FILE_NAME            VARCHAR2(1000)                   not null,
   DESCRIPTION          VARCHAR2(100),
   constraint PK_TD_CMS_CUSTOM_FORM primary key (TARGET_ID, TARGET_TYPE, FORM_TYPE)
);
comment on column TD_CMS_CUSTOM_FORM.TARGET_ID is '1:siteId;2:channelId';
comment on column TD_CMS_CUSTOM_FORM.TARGET_TYPE is '1:siteId;2:channelId';
comment on column TD_CMS_CUSTOM_FORM.FORM_TYPE is '1:采集,2:修改，3：列表';

create table TD_CMS_DBTSEARCH_DETAIL  (
   ID                   NUMBER                           not null,
   DB_NAME              VARCHAR2(50)                     not null,
   TABLE_NAME           VARCHAR2(50)                     not null,
   CONTENT_FIELDS       VARCHAR2(200)                    not null,
   TITLE_FIELD          VARCHAR2(40),
   DESCRIPTION_FIELD    VARCHAR2(40),
   KEYWORD_FIELD        VARCHAR2(40),
   PUBLISHTIME_FIELD    VARCHAR2(40),
   ACCESS_URL           VARCHAR2(100),
   WHERES               VARCHAR2(200),
   PRIMARYS             VARCHAR2(200),
   CONTENT_TYPES        VARCHAR2(100),
   CONTENT_PATH         VARCHAR2(100),
   constraint TD_CMS_DBTSEARCH_DETAIL_ID primary key (ID)
);
comment on table TD_CMS_DBTSEARCH_DETAIL is '全文检索－数据库索引－索引记录详细信息';
comment on column TD_CMS_DBTSEARCH_DETAIL.ID is '关键字';
comment on column TD_CMS_DBTSEARCH_DETAIL.DB_NAME is '数据库名';
comment on column TD_CMS_DBTSEARCH_DETAIL.TABLE_NAME is '表名';
comment on column TD_CMS_DBTSEARCH_DETAIL.CONTENT_FIELDS is '内容域类型为(text)存内容域字段';
comment on column TD_CMS_DBTSEARCH_DETAIL.TITLE_FIELD is '标题域，多个用,分隔';
comment on column TD_CMS_DBTSEARCH_DETAIL.DESCRIPTION_FIELD is '描述域，多个用,分隔';
comment on column TD_CMS_DBTSEARCH_DETAIL.KEYWORD_FIELD is '关键字域，多个用,分隔';
comment on column TD_CMS_DBTSEARCH_DETAIL.PUBLISHTIME_FIELD is '发布时间域，多个用,分隔';
comment on column TD_CMS_DBTSEARCH_DETAIL.ACCESS_URL is '访问地址';
comment on column TD_CMS_DBTSEARCH_DETAIL.WHERES is '查询条件';
comment on column TD_CMS_DBTSEARCH_DETAIL.PRIMARYS is '表的主键，多个字段用,分隔';
comment on column TD_CMS_DBTSEARCH_DETAIL.CONTENT_TYPES is '内容域的类型，分文本(text)和文件(file)、Blog(blog)三种方式';
comment on column TD_CMS_DBTSEARCH_DETAIL.CONTENT_PATH is '内容域类型为(file)存文件路径字段，内容域类型为(blog)存Blog字段';

create table TD_CMS_DOCCOMMENT_DICT  (
   ID                   NUMBER                           not null,
   WORD                 VARCHAR2(50)                     not null,
   DESCRIPTION          VARCHAR2(200),
   SITEID               NUMBER(10)                       not null,
   constraint PK_TD_CMS_DOCCOMMENT_DICT primary key (ID)
);
comment on table TD_CMS_DOCCOMMENT_DICT is '评论字典，以过滤不符合要求的评论';
comment on column TD_CMS_DOCCOMMENT_DICT.ID is '评论要过滤的词汇ID';
comment on column TD_CMS_DOCCOMMENT_DICT.WORD is '要过滤的词汇';
comment on column TD_CMS_DOCCOMMENT_DICT.DESCRIPTION is '过滤词汇描述';
comment on column TD_CMS_DOCCOMMENT_DICT.SITEID is '站点id，不设外键，默认为0，表示通用';

create table TD_CMS_DOCCOM_IMPEACHINFO  (
   ID                   NUMBER                           not null,
   COMMENT_ID           NUMBER                           not null,
   IMPEACHER            VARCHAR2(50)                     not null,
   EMAIL                VARCHAR2(30),
   REASON               NUMBER(1)                        not null,
   DESCRIPTIONINFO      VARCHAR2(200),
   COMTIME              DATE                             not null,
   REPLYED              NUMBER(1),
   constraint PK_TD_CMS_DOCCOM_IMPEACHINFO primary key (ID)
);
comment on table TD_CMS_DOCCOM_IMPEACHINFO is '文档评论的举报信息';
comment on column TD_CMS_DOCCOM_IMPEACHINFO.ID is '举报信息ID，';
comment on column TD_CMS_DOCCOM_IMPEACHINFO.COMMENT_ID is '评论ID';
comment on column TD_CMS_DOCCOM_IMPEACHINFO.IMPEACHER is '举报人姓名';
comment on column TD_CMS_DOCCOM_IMPEACHINFO.EMAIL is '举报人邮箱';
comment on column TD_CMS_DOCCOM_IMPEACHINFO.REASON is '举报原因：0－反动；1－色情；2－暴力；3－侵权；4－其他';
comment on column TD_CMS_DOCCOM_IMPEACHINFO.DESCRIPTIONINFO is '举报信息描述';
comment on column TD_CMS_DOCCOM_IMPEACHINFO.COMTIME is '举报时间';
comment on column TD_CMS_DOCCOM_IMPEACHINFO.REPLYED is '该举报是否已回复标志，0－未回复，1－已回复 缺省值为0';

create table TD_CMS_DOCSOURCE  (
   SRCNAME              VARCHAR2(200)                    not null,
   SRCDESC              VARCHAR2(200),
   SRCLINK              VARCHAR2(200),
   CRUSER               NUMBER(5),
   CRTIME               DATE,
   DOCSOURCE_ID         NUMBER(10)                       not null,
   constraint PK_TD_CMS_DOCSOURCE177 primary key (DOCSOURCE_ID)
);
comment on table TD_CMS_DOCSOURCE is '文档来源(稿源)';
comment on column TD_CMS_DOCSOURCE.SRCNAME is '来源名称';
comment on column TD_CMS_DOCSOURCE.SRCDESC is '来源说明';
comment on column TD_CMS_DOCSOURCE.SRCLINK is '来源链接';
comment on column TD_CMS_DOCSOURCE.CRUSER is '创建者';
comment on column TD_CMS_DOCSOURCE.CRTIME is '创建时间';

create table TD_CMS_DOCUMENT  (
   DOCUMENT_ID          NUMBER                           not null,
   TITLE                VARCHAR2(400)                    not null,
   SUBTITLE             VARCHAR2(300)                    not null,
   AUTHOR               VARCHAR2(255),
   CONTENT              CLOB,
   CHANNEL_ID           NUMBER(10)                       not null,
   STATUS               NUMBER                           not null,
   KEYWORDS             VARCHAR2(500),
   DOCABSTRACT          VARCHAR2(2000),
   DOCTYPE              NUMBER                           not null,
   DOCWTIME             DATE                             not null,
   TITLECOLOR           VARCHAR2(7),
   CREATETIME           DATE                             not null,
   CREATEUSER           NUMBER(10)                       not null,
   DOCSOURCE_ID         NUMBER(10)                       not null,
   DETAILTEMPLATE_ID    NUMBER(10),
   LINKTARGET           VARCHAR2(100),
   FLOW_ID              NUMBER,
   DOC_LEVEL            NUMBER,
   DOC_KIND             NUMBER,
   PARENT_DETAIL_TPL    CHAR                           default '1'  not null,
   ISDELETED            NUMBER(5)                      default 0,
   AUDITTIME            DATE,
   PUBLISHTIME          DATE,
   GUIDANGTIME          DATE,
   RECYCLETIME          DATE,
   GUIDANGMAN           NUMBER(10),
   RECYCLEMAN           NUMBER(10),
   VERSION              NUMBER(4)                      default 1,
   PIC_PATH             VARCHAR2(200),
   MEDIAPATH            VARCHAR2(200),
   PUBLISHFILENAME      VARCHAR2(100),
   COMMENT_TEMPLATE_ID  NUMBER,
   COMMENTSWITCH        NUMBER(1)                      default 0 ,
   SECONDTITLE          VARCHAR2(300),
   ISNEW                NUMBER(1)                      default 0,
   NEWPIC_PATH          VARCHAR2(200),
   ORDERTIME            DATE,
   constraint PK_TD_CMS_DOCUMENT174 primary key (DOCUMENT_ID)
);
comment on column TD_CMS_DOCUMENT.DOCUMENT_ID is '文档ID';
comment on column TD_CMS_DOCUMENT.TITLE is '标题';
comment on column TD_CMS_DOCUMENT.SUBTITLE is '显示标题';
comment on column TD_CMS_DOCUMENT.AUTHOR is '作者';
comment on column TD_CMS_DOCUMENT.CONTENT is '文档内容';
comment on column TD_CMS_DOCUMENT.CHANNEL_ID is '频道id';
comment on column TD_CMS_DOCUMENT.STATUS is '状态';
comment on column TD_CMS_DOCUMENT.KEYWORDS is '关键词';
comment on column TD_CMS_DOCUMENT.DOCABSTRACT is '摘要内容';
comment on column TD_CMS_DOCUMENT.DOCTYPE is '文档类型,0:普通文档，1：外部链接， 2、外部文件(暂不处理),3:聚合文档';
comment on column TD_CMS_DOCUMENT.DOCWTIME is '撰写时间';
comment on column TD_CMS_DOCUMENT.TITLECOLOR is '标题颜色';
comment on column TD_CMS_DOCUMENT.CREATETIME is '编稿时间';
comment on column TD_CMS_DOCUMENT.CREATEUSER is '用户id';
comment on column TD_CMS_DOCUMENT.DOCSOURCE_ID is '文档来源';
comment on column TD_CMS_DOCUMENT.DETAILTEMPLATE_ID is '文档关联的模板';
comment on column TD_CMS_DOCUMENT.LINKTARGET is '打开目标';
comment on column TD_CMS_DOCUMENT.FLOW_ID is '工作流程';
comment on column TD_CMS_DOCUMENT.DOC_LEVEL is '文档级别编码';
comment on column TD_CMS_DOCUMENT.DOC_KIND is '文档类别编码';
comment on column TD_CMS_DOCUMENT.PARENT_DETAIL_TPL is '是否引用父对象的细览模板设置，1：是，0：否';
comment on column TD_CMS_DOCUMENT.ISDELETED is '标识文档是否已经回收，0-未回收，1－回收';
comment on column TD_CMS_DOCUMENT.AUDITTIME is '文档审核时间，2007-3-21添加';
comment on column TD_CMS_DOCUMENT.PUBLISHTIME is '文档发布时间，2007-3-21添加';
comment on column TD_CMS_DOCUMENT.GUIDANGTIME is '归档时间，2007-3-21添加';
comment on column TD_CMS_DOCUMENT.RECYCLETIME is '回收时间，2007-3-21添加';
comment on column TD_CMS_DOCUMENT.GUIDANGMAN is '归档人id，对应td_sm_user表中的user_id字段';
comment on column TD_CMS_DOCUMENT.RECYCLEMAN is '回收人id，对应td_sm_user表中的user_id字段';
comment on column TD_CMS_DOCUMENT.VERSION is '文档版本号';
comment on column TD_CMS_DOCUMENT.PIC_PATH is '概览图片路径';
comment on column TD_CMS_DOCUMENT.MEDIAPATH is '多媒体文件路径'; 
comment on column TD_CMS_DOCUMENT.PUBLISHFILENAME is '发布文件名称';
comment on column TD_CMS_DOCUMENT.COMMENT_TEMPLATE_ID is '评论模版id';
comment on column TD_CMS_DOCUMENT.COMMENTSWITCH is 
'频道文档评论是否开通标识:0-开通
1-关闭
2007年5月14号添加';
comment on column TD_CMS_DOCUMENT.SECONDTITLE is '文档副标题';
comment on column TD_CMS_DOCUMENT.ISNEW is '是否要标记为new文档，1：是，0：否 ，缺省为0，add by xinwang.jiao 2007.09.19';
comment on column TD_CMS_DOCUMENT.NEWPIC_PATH is 'new标记图片路径，add by xinwang.jiao 2007.09.19';
comment on column TD_CMS_DOCUMENT.ORDERTIME is '文档排序时间';

create table TD_CMS_DOCUMENT_TEMP  (
   DOCUMENT_ID          NUMBER                           not null,
   TITLE                VARCHAR2(400)                    not null,
   SUBTITLE             VARCHAR2(300)                    not null,
   AUTHOR               VARCHAR2(255),
   CONTENT              CLOB,
   CHANNEL_ID           NUMBER(10)                       not null,
   STATUS               NUMBER                           not null,
   KEYWORDS             VARCHAR2(500),
   DOCABSTRACT          VARCHAR2(2000),
   DOCTYPE              NUMBER                           not null,
   DOCWTIME             DATE                             not null,
   TITLECOLOR           VARCHAR2(7),
   CREATETIME           DATE                             not null,
   CREATEUSER           NUMBER(10)                       not null,
   DOCSOURCE_ID         NUMBER(10)                       not null,
   DETAILTEMPLATE_ID    NUMBER(10),
   LINKTARGET           VARCHAR2(100),
   FLOW_ID              NUMBER                           not null,
   DOC_LEVEL            NUMBER,
   DOC_KIND             NUMBER,
   PARENT_DETAIL_TPL    CHAR                             not null,
   ISDELETED            NUMBER(5),
   AUDITTIME            DATE,
   PUBLISHTIME          DATE,
   GUIDANGTIME          DATE,
   RECYCLETIME          DATE,
   GUIDANGMAN           NUMBER(10),
   RECYCLEMAN           NUMBER(10),
   VERSION              NUMBER(4)
);

create table TD_CMS_DOC_AGGREGATION  (
   AGGR_DOC_ID          NUMBER                           not null,
   SEQ                  NUMBER                           not null,
   ID_BY_AGGR           NUMBER                           not null,
   TITLE                VARCHAR2(100)                    not null,
   TYPE                 CHAR                             not null,
   constraint PK_TD_CMS_DOC_AGGREGATION primary key (AGGR_DOC_ID, SEQ)
);
comment on column TD_CMS_DOC_AGGREGATION.AGGR_DOC_ID is '聚合文档ID';
comment on column TD_CMS_DOC_AGGREGATION.SEQ is '序号';
comment on column TD_CMS_DOC_AGGREGATION.ID_BY_AGGR is '被聚合的内容ID';
comment on column TD_CMS_DOC_AGGREGATION.TITLE is '内容标题';
comment on column TD_CMS_DOC_AGGREGATION.TYPE is '1:文档 2：频道';

create table TD_CMS_DOC_ARRANGE  (
   DOCUMENT_ID          NUMBER                           not null,
   START_TIME           VARCHAR2(100)                    not null,
   END_TIME             VARCHAR2(100)                    not null,
   ORDER_NO             NUMBER                           not null,
   OP_USER              NUMBER                           not null,
   OP_TIME              DATE                             not null,
   constraint PK_TD_CMS_DOC_ARRANGE primary key (DOCUMENT_ID)
);
comment on column TD_CMS_DOC_ARRANGE.DOCUMENT_ID is '文档ID';
comment on column TD_CMS_DOC_ARRANGE.OP_USER is '用户ID';

create table TD_CMS_DOC_ATTACH  (
   ID                   NUMBER(10)                       not null,
   DOCUMENT_ID          NUMBER(10)                       not null,
   URL                  VARCHAR2(500)                    not null,
   TYPE                 NUMBER(2)                        not null,
   DESCRIPTION          VARCHAR2(500),
   ORIGINAL_FILENAME    VARCHAR2(500)                    not null,
   VALID                CHAR                             default 1 not null,
   constraint PK_TD_CMS_ATTACHDOCUMENT175 primary key (ID)
);
comment on table TD_CMS_DOC_ATTACH is '文档的附件';
comment on column TD_CMS_DOC_ATTACH.URL is '文档附件的URL';
comment on column TD_CMS_DOC_ATTACH.TYPE is 
'附件类型:
1:编辑器中加的附件
2:文档相关附件
3:文档相关图片';
comment on column TD_CMS_DOC_ATTACH.DESCRIPTION is '附件说明';
comment on column TD_CMS_DOC_ATTACH.ORIGINAL_FILENAME is '附件原文件名';
comment on column TD_CMS_DOC_ATTACH.VALID is '有效标记：1：有效，0：无效';

create table TD_CMS_DOC_COMMENT  (
   COMMENT_ID           NUMBER(10)                       not null,
   DOC_ID               NUMBER(10),
   DOC_COMMENT          CLOB                             not null,
   USER_NAME            VARCHAR2(100),
   COMTIME              DATE,
   USER_IP              VARCHAR2(100),
   SRC_COMMENT_ID       NUMBER(10),
   STATUS               NUMBER,
   constraint PK_TD_CMS_DOC_COMMENT primary key (COMMENT_ID)
);
comment on table TD_CMS_DOC_COMMENT is '文档评论表';
comment on column TD_CMS_DOC_COMMENT.COMMENT_ID is '文档评论ID';
comment on column TD_CMS_DOC_COMMENT.DOC_ID is '对应的文档ID';
comment on column TD_CMS_DOC_COMMENT.DOC_COMMENT is '评论内容，不许发表空评论';
comment on column TD_CMS_DOC_COMMENT.USER_NAME is '发表评论的人。';
comment on column TD_CMS_DOC_COMMENT.COMTIME is '发表评论时间';
comment on column TD_CMS_DOC_COMMENT.USER_IP is '评论发表人的IP地址';
comment on column TD_CMS_DOC_COMMENT.SRC_COMMENT_ID is '源评论ID，当再现有的评论的基础上进行评论时，需填写源评论ID';
comment on column TD_CMS_DOC_COMMENT.STATUS is '评论状态：0－未审；1－发布；2－撤发。用户只能看到发布的评论';

create table TD_CMS_DOC_DIST_MANNER  (
   DOCUMENT_ID          NUMBER                           not null,
   DIST_MANNER_ID       NUMBER                           not null,
   constraint PK_TD_CMS_DOC_PUB_MANNER primary key (DOCUMENT_ID, DIST_MANNER_ID)
);
comment on table TD_CMS_DOC_DIST_MANNER is '文档发布方式表';
comment on column TD_CMS_DOC_DIST_MANNER.DOCUMENT_ID is '文档ID';
comment on column TD_CMS_DOC_DIST_MANNER.DIST_MANNER_ID is '发布方式ID';

create table TD_CMS_DOC_PUBLISHING  (
   DOCUMENT_ID          NUMBER                           not null,
   OLD_STATUS           NUMBER(10)                       not null,
   PUBLISHER            VARCHAR2(100),
   PUB_START_TIME       DATE,
   constraint PK_DOC_PUBLISHING primary key (DOCUMENT_ID)
);
comment on table TD_CMS_DOC_PUBLISHING is '处于发布中的文档';
comment on column TD_CMS_DOC_PUBLISHING.DOCUMENT_ID is '文档id';
comment on column TD_CMS_DOC_PUBLISHING.OLD_STATUS is '发布前的状态';
comment on column TD_CMS_DOC_PUBLISHING.PUBLISHER is '记录发布人姓名';
comment on column TD_CMS_DOC_PUBLISHING.PUB_START_TIME is '发布动作开始时间';

create table TD_CMS_DOC_RELATED  (
   DOC_ID               NUMBER                           not null,
   RELATED_DOC_ID       NUMBER                           not null,
   OP_USER_ID           NUMBER                           not null,
   OP_TIME              DATE                             not null,
   constraint PK_TD_CMS_DOC_RELATED primary key (DOC_ID, RELATED_DOC_ID)
);
comment on table TD_CMS_DOC_RELATED is '相关文档表';
comment on column TD_CMS_DOC_RELATED.DOC_ID is '主文档ID';
comment on column TD_CMS_DOC_RELATED.RELATED_DOC_ID is '相关的文档ID';
comment on column TD_CMS_DOC_RELATED.OP_USER_ID is '操作人ID';
comment on column TD_CMS_DOC_RELATED.OP_TIME is '操作时间';

create table TD_CMS_DOC_TASK  (
   TASK_ID              NUMBER(10)                       not null,
   PRE_TASK_ID          NUMBER(10),
   DOCUMENT_ID          NUMBER                           not null,
   PRE_STATUS           NUMBER,
   SUBMIT_ID            NUMBER                           not null,
   SUBMIT_TIME          DATE                             not null,
   constraint PK_TD_CMS_DOC_TASK primary key (TASK_ID)
);
comment on table TD_CMS_DOC_TASK is '文档审核任务表';
comment on column TD_CMS_DOC_TASK.TASK_ID is '实例ID';
comment on column TD_CMS_DOC_TASK.PRE_TASK_ID is '前驱任务ID';
comment on column TD_CMS_DOC_TASK.DOCUMENT_ID is '文档ID';
comment on column TD_CMS_DOC_TASK.PRE_STATUS is '完成任务前状态';
comment on column TD_CMS_DOC_TASK.SUBMIT_ID is '提交人ID';
comment on column TD_CMS_DOC_TASK.SUBMIT_TIME is '提交日期';

create table TD_CMS_DOC_TASK_DETAIL  (
   TASK_ID              NUMBER(10)                       not null,
   PERFORMER            NUMBER                           not null,
   AFTER_STATUS         NUMBER,
   VALID                NUMBER                         default 1,
   COMPLETE_TIME        DATE,
   OPINION              VARCHAR2(500),
   constraint PK_TD_CMS_DOC_TASK_DETAIL primary key (TASK_ID, PERFORMER)
);
comment on table TD_CMS_DOC_TASK_DETAIL is '文档审核任务审核人表';
comment on column TD_CMS_DOC_TASK_DETAIL.TASK_ID is '实例ID';
comment on column TD_CMS_DOC_TASK_DETAIL.PERFORMER is '执行人ID';
comment on column TD_CMS_DOC_TASK_DETAIL.AFTER_STATUS is '完成任务后状态';
comment on column TD_CMS_DOC_TASK_DETAIL.VALID is '1:有效，0：无效';
comment on column TD_CMS_DOC_TASK_DETAIL.COMPLETE_TIME is '完成时间';
comment on column TD_CMS_DOC_TASK_DETAIL.OPINION is '意见';

create table TD_CMS_DOC_TEMPLATE  (
   ID                   NUMBER(10)                       not null,
   TPLNAME              VARCHAR2(50)                     not null,
   TPLCODE              CLOB                             not null,
   CHANNEL_ID           NUMBER(10)                       not null,
   CREATOR              NUMBER(10)                       not null,
   DESCRIPTION          VARCHAR2(200),
   CREATTIME            DATE                             not null,
   constraint PK_TD_CMS_DOC_TEMPLATE primary key (ID)
);
comment on table TD_CMS_DOC_TEMPLATE is '文档模板表';
comment on column TD_CMS_DOC_TEMPLATE.ID is '文档模板id';
comment on column TD_CMS_DOC_TEMPLATE.TPLNAME is '文档模板名';
comment on column TD_CMS_DOC_TEMPLATE.TPLCODE is '文档模板代码';
comment on column TD_CMS_DOC_TEMPLATE.CHANNEL_ID is '所属站点id';
comment on column TD_CMS_DOC_TEMPLATE.CREATOR is '文档模板创建人';
comment on column TD_CMS_DOC_TEMPLATE.DESCRIPTION is '文档模板描述';
comment on column TD_CMS_DOC_TEMPLATE.CREATTIME is '文档模板创建时间';

create table TD_CMS_DOC_VER  (
   DOCUMENT_ID          NUMBER                           not null,
   VERSION              NUMBER                           not null,
   TITLE                VARCHAR2(400)                    not null,
   SUBTITLE             VARCHAR2(300)                    not null,
   AUTHOR               VARCHAR2(255),
   CONTENT              CLOB,
   CHANNEL_ID           NUMBER(10)                       not null,
   KEYWORDS             VARCHAR2(500),
   DOCABSTRACT          VARCHAR2(2000),
   DOCTYPE              NUMBER                           not null,
   DOCWTIME             DATE                             not null,
   TITLECOLOR           VARCHAR2(7),
   DOCSOURCE_NAME       VARCHAR2(100)                      not null,
   DETAILTEMPLATE_ID    NUMBER(10),
   LINKTARGET           VARCHAR2(100),
   FLOW_ID              NUMBER                           not null,
   DOC_LEVEL            NUMBER,
   DOC_KIND             NUMBER,
   PARENT_DETAIL_TPL    CHAR                             not null,
   OP_USER              NUMBER                           not null,
   OP_TIME              DATE                             not null,
   LABEL                VARCHAR2(100),
   VERSIONDESCRIPTION   VARCHAR2(100),
   PIC_PATH             VARCHAR2(100),
   MEDIAPATH            VARCHAR2(200),
   PUBLISHFILENAME      VARCHAR2(50),
   SECONDTITLE          VARCHAR2(300),
   ISNEW                NUMBER(1),
   NEWPIC_PATH          VARCHAR2(200),
   constraint PK_TD_CMS_DOC_VER primary key (DOCUMENT_ID, VERSION)
);
comment on column TD_CMS_DOC_VER.DOCUMENT_ID is '文档ID';
comment on column TD_CMS_DOC_VER.VERSION is '版本号';
comment on column TD_CMS_DOC_VER.TITLE is '标题';
comment on column TD_CMS_DOC_VER.SUBTITLE is '显示标题';
comment on column TD_CMS_DOC_VER.AUTHOR is '作者';
comment on column TD_CMS_DOC_VER.CONTENT is '文档内容';
comment on column TD_CMS_DOC_VER.CHANNEL_ID is '频道id';
comment on column TD_CMS_DOC_VER.KEYWORDS is '关键词';
comment on column TD_CMS_DOC_VER.DOCABSTRACT is '摘要内容';
comment on column TD_CMS_DOC_VER.DOCTYPE is '文档类型,0:普通文档，1：外部链接，2、外部文件(暂不处理)';
comment on column TD_CMS_DOC_VER.DOCWTIME is '撰写时间';
comment on column TD_CMS_DOC_VER.TITLECOLOR is '标题颜色';
comment on column TD_CMS_DOC_VER.DOCSOURCE_NAME is '文档来源';
comment on column TD_CMS_DOC_VER.DETAILTEMPLATE_ID is '模板ID';
comment on column TD_CMS_DOC_VER.LINKTARGET is '打开目标';
comment on column TD_CMS_DOC_VER.FLOW_ID is '工作流程';
comment on column TD_CMS_DOC_VER.DOC_LEVEL is '文档级别编码';
comment on column TD_CMS_DOC_VER.DOC_KIND is '文档类别编码';
comment on column TD_CMS_DOC_VER.PARENT_DETAIL_TPL is '是否引用父对象的细览模板设置，1：是，0：否';
comment on column TD_CMS_DOC_VER.OP_USER is '操作人ID';
comment on column TD_CMS_DOC_VER.OP_TIME is '操作时间';
comment on column TD_CMS_DOC_VER.LABEL is '版本label';
comment on column TD_CMS_DOC_VER.VERSIONDESCRIPTION is '版本描述';
comment on column TD_CMS_DOC_VER.PIC_PATH is '概览图片路径';
comment on column TD_CMS_DOC_VER.MEDIAPATH is '多媒体文件路径';
comment on column TD_CMS_DOC_VER.PUBLISHFILENAME is '文档发布名称';
comment on column TD_CMS_DOC_VER.SECONDTITLE is '文档副标题，add by xinwang.jiao 2007.07.08';
comment on column TD_CMS_DOC_VER.ISNEW is '是否要标记为new文档，1：是，0：否 ，缺省为0，add by xinwang.jiao 2007.09.19';
comment on column TD_CMS_DOC_VER.NEWPIC_PATH is 'new标记图片路径，add by xinwang.jiao 2007.09.19';

create table TD_CMS_DOC_VER_ATTACH  (
   DOCUMENT_ID          NUMBER                           not null,
   VERSION              NUMBER                           not null,
   ATTACH_ID            NUMBER(10)                       not null,
   constraint PK_TD_CMS_DOC_VER_ATTACH primary key (DOCUMENT_ID, VERSION, ATTACH_ID)
);
comment on column TD_CMS_DOC_VER_ATTACH.DOCUMENT_ID is '文档ID';

create table TD_CMS_EXTFIELD  (
   FIELD_ID             NUMBER(10)                       not null,
   FIELDNAME            VARCHAR2(100)                    not null,
   FIELDLABEL           VARCHAR2(100)                    not null,
   FIELDDESC            VARCHAR2(500),
   FIELDTYPE            VARCHAR2(100),
   MAXLEN               NUMBER(4),
   INPUTTYPE            NUMBER(10),
   constraint PK_TD_CMS_EXTFIELD primary key (FIELD_ID)
);
comment on table TD_CMS_EXTFIELD is '文档扩展字段表';
comment on column TD_CMS_EXTFIELD.FIELD_ID is '扩展字段主键';
comment on column TD_CMS_EXTFIELD.FIELDNAME is '字段名称';
comment on column TD_CMS_EXTFIELD.FIELDLABEL is '字段label';
comment on column TD_CMS_EXTFIELD.FIELDDESC is '字段描述';
comment on column TD_CMS_EXTFIELD.FIELDTYPE is '字段类型';
comment on column TD_CMS_EXTFIELD.MAXLEN is '字段最大长度';
comment on column TD_CMS_EXTFIELD.INPUTTYPE is '字段对应的输入框类型';

create table TD_CMS_EXTFIELDVALUE  (
   FIELD_ID             NUMBER(10)                       not null,
   DOCUMENT_ID          NUMBER                           not null,
   FIELDVALUE           VARCHAR2(4000),
   NUMBERVALUE          NUMBER(10),
   CLOBVALUE            CLOB,
   DATEVALUE            DATE,
   constraint PK_TD_CMS_EXTFIELDVALUE primary key (FIELD_ID, DOCUMENT_ID)
);
comment on table TD_CMS_EXTFIELDVALUE is '存放文档对应的扩展字段的值表';
comment on column TD_CMS_EXTFIELDVALUE.FIELD_ID is '扩展字段主键';
comment on column TD_CMS_EXTFIELDVALUE.DOCUMENT_ID is '文档ID';
comment on column TD_CMS_EXTFIELDVALUE.FIELDVALUE is '字段值';
comment on column TD_CMS_EXTFIELDVALUE.NUMBERVALUE is '数字值';
comment on column TD_CMS_EXTFIELDVALUE.CLOBVALUE is 'clob字段值';
comment on column TD_CMS_EXTFIELDVALUE.DATEVALUE is '日期值';

create index INDEX_1 on TD_CMS_EXTFIELDVALUE (
   DOCUMENT_ID ASC
);

create index INDEX_2 on TD_CMS_EXTFIELDVALUE (
   FIELD_ID ASC
);

create table TD_CMS_EXTVALUESCOPE  (
   FIELD_ID             NUMBER(10),
   VALUE                VARCHAR2(100),
   ID                   NUMBER(10)                       not null,
   DESCRIPTION          VARCHAR2(100),
   MINVALUE             NUMBER(10),
   MAXVALUE             NUMBER(10),
   constraint PK_TD_CMS_EXTVALUESCOPE primary key (ID)
);
comment on column TD_CMS_EXTVALUESCOPE.FIELD_ID is '扩展字段主键';
comment on column TD_CMS_EXTVALUESCOPE.VALUE is '枚举类型扩展字段枚举值';
comment on column TD_CMS_EXTVALUESCOPE.DESCRIPTION is '枚举类型扩展字段描述';
comment on column TD_CMS_EXTVALUESCOPE.MINVALUE is '连续类型扩展字段的取值的起点';
comment on column TD_CMS_EXTVALUESCOPE.MAXVALUE is '连续的扩展字段的最大值';

create table TD_CMS_FILE_CHANGE_LOG  (
   SITE_ID              VARCHAR2(40)                     not null,
   URI                  VARCHAR2(510)                    not null,
   VERSION              NUMBER                         default 1.0  not null,
   USER_ID              VARCHAR2(40)                     not null,
   CHANGE_TIME          DATE                             not null,
   BAK_FILE_NAME        VARCHAR2(510),
   CHANGE_REMARK        VARCHAR2(510)
);
comment on table TD_CMS_FILE_CHANGE_LOG is '文件改变历史记录';
comment on column TD_CMS_FILE_CHANGE_LOG.SITE_ID is '站点id';
comment on column TD_CMS_FILE_CHANGE_LOG.URI is '文件的路径';
comment on column TD_CMS_FILE_CHANGE_LOG.VERSION is '版本号';
comment on column TD_CMS_FILE_CHANGE_LOG.USER_ID is '改变的用户';
comment on column TD_CMS_FILE_CHANGE_LOG.CHANGE_TIME is '改变的时间';
comment on column TD_CMS_FILE_CHANGE_LOG.BAK_FILE_NAME is '这个版本对应的备份文件';
comment on column TD_CMS_FILE_CHANGE_LOG.CHANGE_REMARK is '改变时添加的一些备注';

create table TD_CMS_FILE_STATUS  (
   SITE_ID              VARCHAR2(40)                     not null,
   URI                  VARCHAR2(510)                    not null,
   VERSION              NUMBER(6,1),
   CHECKOUT_USER        VARCHAR2(40),
   CHECKOUT_TIME        DATE,
   constraint TD_CMS_FILE_STATUS_PK primary key (SITE_ID, URI)
);
comment on table TD_CMS_FILE_STATUS is '文件的最新的状态';
comment on column TD_CMS_FILE_STATUS.SITE_ID is '站点id';
comment on column TD_CMS_FILE_STATUS.URI is '文件的相对路径';
comment on column TD_CMS_FILE_STATUS.VERSION is '版本';
comment on column TD_CMS_FILE_STATUS.CHECKOUT_USER is '现在别谁check out了';
comment on column TD_CMS_FILE_STATUS.CHECKOUT_TIME is 'check out的起始时间';

create table TD_CMS_MAILSERVERINFO  (
   ID                   NUMBER                           not null,
   SMTP_SERVER          VARCHAR2(200),
   MAIL_SENDER          VARCHAR2(200),
   MAIL_SENDERNAME      VARCHAR2(200),
   MAIL_DESC            VARCHAR2(500),
   SERVER_NAME          VARCHAR2(100),
   MAIL_DOMAIN          VARCHAR2(500),
   MAIL_USERNAME        VARCHAR2(100),
   MAIL_PASSWORD        VARCHAR2(100),
   SMTP_PORT            VARCHAR2(100)                  default '25',
   constraint PK_TD_CMS_MAILSERVERINFO primary key (ID)
);
comment on column TD_CMS_MAILSERVERINFO.SMTP_SERVER is '发送邮件服务器,比如chinacreator.com';
comment on column TD_CMS_MAILSERVERINFO.MAIL_SENDER is '发送邮件地址,必须和发送邮件服务保持一致的域名';
comment on column TD_CMS_MAILSERVERINFO.MAIL_SENDERNAME is '邮件发送者在邮件中显示的名称';
comment on column TD_CMS_MAILSERVERINFO.MAIL_DESC is '描述信息';
comment on column TD_CMS_MAILSERVERINFO.SERVER_NAME is '服务器的名字';
comment on column TD_CMS_MAILSERVERINFO.MAIL_DOMAIN is '邮件服务器域名';
comment on column TD_CMS_MAILSERVERINFO.MAIL_USERNAME is '帐户名';
comment on column TD_CMS_MAILSERVERINFO.MAIL_PASSWORD is '密码';
comment on column TD_CMS_MAILSERVERINFO.SMTP_PORT is 'smtp邮件服务器的端口,默认为25';

create table TD_CMS_PUBOBJECT_RELATION  (
   PUBLISHOBJECT        VARCHAR2(200)                    not null,
   REFERENCEOBJECT      VARCHAR2(200)                    not null,
   PUBLISHTYPE          NUMBER                           not null,
   PUBLISH_SITE         VARCHAR2(200)                    not null,
   REFERENCETYPE        NUMBER                           not null,
   REFERENCE_SITE       VARCHAR2(100)                    not null,
   COUNTER              NUMBER,
   constraint PK_TD_CMS_PUBOBJECT_RELATION primary key (PUBLISHOBJECT, REFERENCEOBJECT, PUBLISHTYPE, PUBLISH_SITE, REFERENCETYPE, REFERENCE_SITE)
);
comment on table TD_CMS_PUBOBJECT_RELATION is '记录发布对象与其他关联的界面元素，比如频道，调查等等之间的关系，如果相关频道的内容发生变化，系统自动发布其影响发布对象';
comment on column TD_CMS_PUBOBJECT_RELATION.PUBLISHOBJECT is '页面元素相关的发布对象，发布对象的类型通过字段PUBLISHTYPE来决定';
comment on column TD_CMS_PUBOBJECT_RELATION.REFERENCEOBJECT is '被发布对象引用的页面元素对象，其类型由字段REFERENCETYPE决定';
comment on column TD_CMS_PUBOBJECT_RELATION.PUBLISHTYPE is 
'发布对象类型，有以下值：
0-站点首页   如果引用的对象发生变化就发布站点首页
1-频道首页   如果引用的对象发布变化就发布频道首页
2-页面发布   如果引用的对象发布变化就重新发布页面
3-频道文档引用频道概览   如果频道的文档发生变化就发布同频道下所有已发布的其他文档
4-其他';
comment on column TD_CMS_PUBOBJECT_RELATION.PUBLISH_SITE is '发布对象对应的站点id';
comment on column TD_CMS_PUBOBJECT_RELATION.REFERENCETYPE is '引用对象类型 主要是文档0，频道1，以后还需扩展';
comment on column TD_CMS_PUBOBJECT_RELATION.REFERENCE_SITE is '引用元素对应的站点';
comment on column TD_CMS_PUBOBJECT_RELATION.COUNTER is
'频道文档之间关联的数目，添加一个时就+1
减少一个就减一，当计数器为0时就删除这条记录';

create table TD_CMS_SITE  (
   SITE_ID              NUMBER(10)                       not null,
   NAME                 VARCHAR2(100)                    not null,
   SECOND_NAME          VARCHAR2(100),
   MAINSITE_ID          NUMBER(10),
   SITEDESC             VARCHAR2(150),
   DBNAME               VARCHAR2(40),
   SITEDIR              VARCHAR2(500)                    not null,
   STATUS               NUMBER(1),
   FTPIP                VARCHAR2(17),
   FTPPORT              VARCHAR2(4),
   FTPUSER              VARCHAR2(20),
   FTPPASSWORD          VARCHAR2(20),
   FTPFOLDER            VARCHAR2(20),
   WEBHTTP              VARCHAR2(100),
   SITEORDER            NUMBER(5),
   CREATETIME           DATE                             not null,
   CREATEUSER           NUMBER                           not null,
   PUBLISHDESTINATION   NUMBER(1),
   INDEXFILENAME        VARCHAR2(50),
   INDEXTEMPLATE_ID     NUMBER(10),
   FLOW_ID              NUMBER,
   PARENT_WORKFLOW      CHAR                           default '1'  not null,
   LOCALPUBLISHPATH     VARCHAR2(510),
   DISTRIBUTEMANNERS    VARCHAR2(50),
   SITEENCODEING        VARCHAR2(100),
   constraint PK_TD_CMS_SITE173 primary key (SITE_ID)
);
comment on table TD_CMS_SITE is '站点基本信息';
comment on column TD_CMS_SITE.SITE_ID is '站点ID';
comment on column TD_CMS_SITE.NAME is '内容管理站点名称';
comment on column TD_CMS_SITE.SECOND_NAME is '站点第二名称(目前即为站点英文名称)';
comment on column TD_CMS_SITE.MAINSITE_ID is '父站点ID';
comment on column TD_CMS_SITE.SITEDESC is '站点说明';
comment on column TD_CMS_SITE.DBNAME is '站点对应的数据库名称';
comment on column TD_CMS_SITE.SITEDIR is '站点对应的目录';
comment on column TD_CMS_SITE.STATUS is 
'站点状态
0：开通
1：未开通
2：停用
-1：已删除';
comment on column TD_CMS_SITE.FTPIP is 'ftp服务器IP';
comment on column TD_CMS_SITE.FTPPORT is 'ftp服务器端口号';
comment on column TD_CMS_SITE.FTPUSER is 'ftp服务器用户名';
comment on column TD_CMS_SITE.FTPPASSWORD is 'ftp服务器密码';
comment on column TD_CMS_SITE.FTPFOLDER is 'ftp服务器目录';
comment on column TD_CMS_SITE.WEBHTTP is '站点的http';
comment on column TD_CMS_SITE.SITEORDER is '站点排序的序号,默认为0';
comment on column TD_CMS_SITE.CREATETIME is '创建时间';
comment on column TD_CMS_SITE.CREATEUSER is '谁创建的';
comment on column TD_CMS_SITE.PUBLISHDESTINATION is 
'定义发布目的地:
0:本地
1:远程
2:远程本地';
comment on column TD_CMS_SITE.INDEXFILENAME is '首页文件名';
comment on column TD_CMS_SITE.INDEXTEMPLATE_ID is '首页模板ID';
comment on column TD_CMS_SITE.FLOW_ID is '流程ID';
comment on column TD_CMS_SITE.LOCALPUBLISHPATH is '本地发布路径';
comment on column TD_CMS_SITE.DISTRIBUTEMANNERS is '分发方式，以逗号分割的数字值:0表示html,1表示rss，2表示mail,缺省为0';
comment on column TD_CMS_SITE.SITEENCODEING is 
'站点发布页面模板编码设置，可以取以下几个值：
	ISO-8859-1
	US-ASCII
	GBK
	UTF-8
	gb2312';

create index TC_TD_CMS_SITE1260 on TD_CMS_SITE (
   MAINSITE_ID ASC
);

create index TC_TD_CMS_SITE1273 on TD_CMS_SITE (
   INDEXTEMPLATE_ID ASC
);

create table TD_CMS_SITEAPPS  (
   SITE_ID              NUMBER                           not null,
   APP_ID               VARCHAR2(200)                    not null,
   APP_PATH             VARCHAR2(500),
   constraint PK_TD_CMS_SITEAPPS primary key (SITE_ID, APP_ID)
);
comment on table TD_CMS_SITEAPPS is
'站点应用映射关系，对站点拥有的应用进行配置
在内容管理的应用管理中只显示和站点相关的应用
同时站点应用的授权直接和站点关联起来
同时在删除站点时，需要删除本表中站点对应的数据';
comment on column TD_CMS_SITEAPPS.APP_PATH is 
'应用路径,类似于
module:menu//sysmenu$root/....';

create table TD_CMS_SITEFIELD  (
   FILE_ID              NUMBER(10)                       not null,
   SITE_ID              NUMBER(10)                       not null,
   constraint PK_TD_CMS_SITEFIELD primary key (FILE_ID, SITE_ID)
);
comment on table TD_CMS_SITEFIELD is '扩展字段和站点的映射关系';
comment on column TD_CMS_SITEFIELD.FILE_ID is '扩展字段主键';
comment on column TD_CMS_SITEFIELD.SITE_ID is '站点ID';

create index INDEX_6 on TD_CMS_SITEFIELD (
   FILE_ID ASC
);

create index INDEX_7 on TD_CMS_SITEFIELD (
   SITE_ID ASC
);

create table TD_CMS_SITEUSER  (
   SITE_ID              NUMBER                           not null,
   USER_ID              NUMBER                           not null,
   constraint PK_SITEUSER primary key (SITE_ID, USER_ID)
);

create table TD_CMS_SITE_SEARCH  (
   SITE_ID              NUMBER(10)                       not null,
   CHNL_OR_DOMAIN       VARCHAR2(100),
   LEVER                NUMBER(1)                      default 0,
   DAY                  NUMBER(2)                      default 1,
   TIME                 NUMBER(2)                      default 0,
   SEARCH_TYPE          NUMBER(1)                      default 0  not null,
   START_URL            VARCHAR2(100),
   ID                   NUMBER                           not null,
   NAME                 VARCHAR2(30)                     not null,
   SITE_IDS             VARCHAR2(100),
   constraint PK_TD_CMS_SITE_SEARCH primary key (ID)
);
comment on table TD_CMS_SITE_SEARCH is '站内检索的相关配置，主要配置要检索的频道，检索时间等';
comment on column TD_CMS_SITE_SEARCH.SITE_ID is '站点id';
comment on column TD_CMS_SITE_SEARCH.CHNL_OR_DOMAIN is '频道id,或者域名（范围），多个域名用逗号隔开';
comment on column TD_CMS_SITE_SEARCH.LEVER is '建索引频率，0－每周一次；1－每月一次；2每天一次；';
comment on column TD_CMS_SITE_SEARCH.DAY is 
'建索引的日期，
lever为0时，day值可为1－7，表示星期一到星期天
lever为1时，day值可为1－31，表示从1号到31号
lever为2时，day值可为1，表示当天';
comment on column TD_CMS_SITE_SEARCH.TIME is '建索引的具体时间，值为0－23，表示一天中00:00点到23:00点';
comment on column TD_CMS_SITE_SEARCH.SEARCH_TYPE is '索引类型，0－站内频道搜索；1－站外搜索,2-整站检索,3-站群索引,4-数据库表索引';
comment on column TD_CMS_SITE_SEARCH.START_URL is '站外搜索时爬的起始页面，多个用逗号隔开';
comment on column TD_CMS_SITE_SEARCH.NAME is 
'NAME来标志索引库的所在的文件夹目录名。
站内搜索：D:\workspace\cms\creatorcms\WEB-INF\search\NAME
站外搜索：D:\workspace\cms\creatorcms\cms\siteResource\site200\search\NAME';
comment on column TD_CMS_SITE_SEARCH.SITE_IDS is '站群索引时存站点群的id,多个id用,分隔';

create table TD_CMS_SITE_TPL  (
   SITE_ID              NUMBER(10)                       not null,
   TEMPLATE_ID          NUMBER(10)                       not null,
   constraint PK_TD_CMS_SITE_TPL primary key (SITE_ID, TEMPLATE_ID)
);

create table TD_CMS_TEMPLATE  (
   TEMPLATE_ID          NUMBER(10)                       not null,
   NAME                 VARCHAR2(255)                    not null,
   DESCRIPTION          VARCHAR2(255),
   HEADER               VARCHAR2(3000)                   not null,
   TEXT                 CLOB,
   TYPE                 NUMBER(5)                        not null,
   CREATEUSER           NUMBER                           not null,
   CREATETIME           DATE                             not null,
   INC_PUB_FLAG         CHAR                           default '0'  not null,
   PERSISTTYPE          NUMBER(5)                      default 0,
   TEMPLATEFILENAME     VARCHAR2(100),
   TEMPLATEPATH         VARCHAR2(255),
   TEMPLATE_STYLE   NUMBER(5) default -1,
   constraint PK_TD_CMS_TEMPLATE182 primary key (TEMPLATE_ID)
);
comment on table TD_CMS_TEMPLATE is
'系统模版
由模版生成设计页面和预览页面时可以展示预先设置的模拟数据.
如果模版已经对应了实际的频道,可以展示频道实际数据';
comment on column TD_CMS_TEMPLATE.TEMPLATE_ID is '模板ID';
comment on column TD_CMS_TEMPLATE.NAME is '模版名称';
comment on column TD_CMS_TEMPLATE.DESCRIPTION is '模板说明';
comment on column TD_CMS_TEMPLATE.HEADER is '模版头';
comment on column TD_CMS_TEMPLATE.TEXT is '模板正文内容';
comment on column TD_CMS_TEMPLATE.TYPE is 
'模版类型
0:站点首页模版
1：频道概览模板
2：文档细览模板 3：文档评论模板';
comment on column TD_CMS_TEMPLATE.CREATEUSER is '创建者';
comment on column TD_CMS_TEMPLATE.CREATETIME is '模板创建时间';
comment on column TD_CMS_TEMPLATE.INC_PUB_FLAG is
'增量发布标志，1：需要进行增量发布(new)， 
0：不需要进行增量发布(old)';
comment on column TD_CMS_TEMPLATE.PERSISTTYPE is
'模版存储类型
	  0-数据库存储类型
	  1-文件存储类型';
comment on column TD_CMS_TEMPLATE.TEMPLATEFILENAME is
'模版对应的文件名称，只有以文件的方式存放模版的时候才有含义';
comment on column TD_CMS_TEMPLATE.TEMPLATEPATH is
'模版对应的附件目录（如果模版是以文件的模式存放，同时也对应了模版文件的存放目录）';
comment on column TD_CMS_TEMPLATE.TEMPLATE_STYLE is
'模板风格，对不同的模板进行细分类';

create table TD_CMS_TEMPLATE_STYLE  (
   STYLE_ID             NUMBER(5)                        not null,
   STYLE_NAME           VARCHAR(200),
   STYLE_DESC           VARCHAR(500),
   STYLE_ORDER NUMBER(5),
   constraint PK_TD_CMS_TEMPLATE_STYLE primary key (STYLE_ID)
);
comment on table TD_CMS_TEMPLATE_STYLE is '模板风格表';
comment on column TD_CMS_TEMPLATE_STYLE.STYLE_NAME is '模板风格名称，保证唯一性';
comment on column TD_CMS_TEMPLATE_STYLE.STYLE_DESC is '模板风格描述';
comment on column TD_CMS_TEMPLATE_STYLE.STYLE_ORDER is '排序字段';

create table TD_CMS_TMPL_EXPORT  (
   TMPLNAME             VARCHAR2(50)                     not null,
   TMPLDESC             VARCHAR2(400),
   EXPORTDATE           DATE,
   EXPORTERID           NUMBER,
   FLAG                 VARCHAR2(2),
   SITEID               NUMBER,
   constraint TD_CMS_TMPL_EXPORT_TMPLNAME primary key (TMPLNAME)
);
comment on column TD_CMS_TMPL_EXPORT.TMPLNAME is '模板名称';
comment on column TD_CMS_TMPL_EXPORT.TMPLDESC is '模板描述';
comment on column TD_CMS_TMPL_EXPORT.EXPORTDATE is '导出时间';
comment on column TD_CMS_TMPL_EXPORT.EXPORTERID is '导出人ID';
comment on column TD_CMS_TMPL_EXPORT.FLAG is '0-:公有 无需指定siteid属性，如果填了标识从哪个站点导出，如果没填就标识系统自带;1:私有  需要填充siteid属性用来区分备份包所属的站点';
comment on column TD_CMS_TMPL_EXPORT.SITEID is '私有模板所属站点';

create table TD_CMS_VOTE_TITLE
(
  NAME       VARCHAR2(200),
  CONTENT    CLOB,
  ID         NUMBER(10) not null,
  SITEID     NUMBER(10) default 1,
  IP_REPEAT  NUMBER(1),
  TIME_GAP   NUMBER,
  FOUNDER_ID NUMBER,
  ACTIVE     NUMBER(1) default 0,
  SEETYPE    NUMBER(1),
  CTIME      DATE,
  ISTOP      NUMBER(1) default 0,
  PICPATH    VARCHAR2(500),
  DEPART_ID  VARCHAR2(20),
  ISLOOK     NUMBER default 1,
  MODULE_NAME VARCHAR2(100),
  constraint PK_TD_CMS_VOTE_TITLE primary key (ID)
);
comment on table TD_CMS_VOTE_TITLE is '调查大主题';
comment on column TD_CMS_VOTE_TITLE.NAME is '主题名称';
comment on column TD_CMS_VOTE_TITLE.CONTENT is '主题内容';
comment on column TD_CMS_VOTE_TITLE.ID is '主题主键';
comment on column TD_CMS_VOTE_TITLE.SITEID is '站点ID';
comment on column TD_CMS_VOTE_TITLE.IP_REPEAT is '0：IP不可以重复 1：IP可以重复';
comment on column TD_CMS_VOTE_TITLE.TIME_GAP is '时间间隔以小时为单位'; 
comment on column TD_CMS_VOTE_TITLE.FOUNDER_ID is '创建人ID';
comment on column TD_CMS_VOTE_TITLE.ACTIVE is '1：活动问卷 0：非活动问卷';
comment on column TD_CMS_VOTE_TITLE.SEETYPE is '1:用户查看结果时显示自由问答的回答项 0:用户查看结果时不显示自由问答的回答项';
comment on column TD_CMS_VOTE_TITLE.CTIME is '创建时间';
comment on column TD_CMS_VOTE_TITLE.ISTOP is '0：非置顶 1：置顶';
comment on column TD_CMS_VOTE_TITLE.PICPATH is '主题图片路径';
comment on column TD_CMS_VOTE_TITLE.DEPART_ID is '部门ID';
comment on column TD_CMS_VOTE_TITLE.ISLOOK is '是否可以在前台查看投票结果';
comment on column TD_CMS_VOTE_TITLE.MODULE_NAME is '所属模块名称';

create table TD_CMS_VOTE_QUESTIONS
(
  ID        NUMBER not null,
  TITLE     VARCHAR2(200),
  STYLE     NUMBER(1),
  VOTECOUNT NUMBER default 0,
  ACTIVE    NUMBER(1) default 1,
  ISTOP     NUMBER(1) default 0,
  constraint VOTE_QUESTIONS_PK primary key (ID)
);
comment on column TD_CMS_VOTE_QUESTIONS.ID is '主题ID';
comment on column TD_CMS_VOTE_QUESTIONS.TITLE is '小主题名';
comment on column TD_CMS_VOTE_QUESTIONS.STYLE is '0:单选方式 1:多选方式 2:自由问答';
comment on column TD_CMS_VOTE_QUESTIONS.VOTECOUNT is '小主题所得投票总数';
comment on column TD_CMS_VOTE_QUESTIONS.ACTIVE is '0：不活动小主题 1：活动小主题';
comment on column TD_CMS_VOTE_QUESTIONS.ISTOP  is '0：非置顶 1：置顶';

create table TD_CMS_VOTE_ANSWER
(
  ANSER_ID   NUMBER(10) not null,
  QID        NUMBER(10),
  TYPE       NUMBER(1) default 0,
  ITEM_ID    NUMBER,
  WHO_IP     VARCHAR2(100),
  WHEN       DATE,
  ISBIGTITLE NUMBER(1),
  STATE      NUMBER(1) default 0,
  ANSWER     CLOB ,
  constraint PK_TD_CMS_VOTE_ANSWER primary key (ANSER_ID)
);
comment on table TD_CMS_VOTE_ANSWER is '保存对于自由问答的问题答案';
comment on column TD_CMS_VOTE_ANSWER.ANSER_ID is '回答ID';
comment on column TD_CMS_VOTE_ANSWER.QID is '所属小主题的ID';
comment on column TD_CMS_VOTE_ANSWER.TYPE is '0：选项 1：自由式回答';
comment on column TD_CMS_VOTE_ANSWER.ITEM_ID is '选项ID';
comment on column TD_CMS_VOTE_ANSWER.WHO_IP is '回答人IP';
comment on column TD_CMS_VOTE_ANSWER.WHEN is '投票人回答时间';
comment on column TD_CMS_VOTE_ANSWER.ISBIGTITLE is '是否是大主题：0-是 1-否';
comment on column TD_CMS_VOTE_ANSWER.STATE is '0、待审核，1 已审核，';
comment on column TD_CMS_VOTE_ANSWER.ANSWER is '回答内容';

create table TD_CMS_VOTE_IPCTRL
(
  ID       NUMBER(10) not null,
  TITLE_ID NUMBER(10),
  IP_START VARCHAR2(100),
  IP_END   VARCHAR2(100),
  constraint PK_TD_CMS_VOTE_IPCTRL primary key (ID)
) ;
comment on table TD_CMS_VOTE_IPCTRL is 'ip段控制' ;
comment on column TD_CMS_VOTE_IPCTRL.TITLE_ID is '主题ID' ;
comment on column TD_CMS_VOTE_IPCTRL.IP_START is 'IP开始段' ;
comment on column TD_CMS_VOTE_IPCTRL.IP_END is 'IP结束段' ;

create table TD_CMS_VOTE_ITEMS
(
  ID      NUMBER not null,
  QID     NUMBER,
  OPTIONS VARCHAR2(200),
  COUNT   NUMBER default 0 ,
  constraint PK_QITEMS primary key (ID) 
);
comment on column TD_CMS_VOTE_ITEMS.ID is '选项的ID';
comment on column TD_CMS_VOTE_ITEMS.QID is '所属于小主题的ID';
comment on column TD_CMS_VOTE_ITEMS.OPTIONS is '选项的内容';
comment on column TD_CMS_VOTE_ITEMS.COUNT is '每个选项的票数';

create table TD_CMS_VOTE_TIMECTRL
(
  ID         NUMBER(10) not null,
  TITLE_ID   NUMBER(10),
  TIME_START DATE,
  TIME_END   DATE,
  constraint PK_TD_CMS_VOTE_TIMECTRL primary key (ID)
) ;
comment on table TD_CMS_VOTE_TIMECTRL is '时间段控制' ;
comment on column TD_CMS_VOTE_TIMECTRL.TITLE_ID is '主题ID' ;
comment on column TD_CMS_VOTE_TIMECTRL.TIME_START is '开始时间' ;
comment on column TD_CMS_VOTE_TIMECTRL.TIME_END is '结束时间' ;

create table TD_CMS_VOTE_TQ
(
  TITLE_ID    NUMBER(10) not null,
  QUESIONT_ID NUMBER(10) not null,
  constraint PK_TD_CMS_VOTE_TQ primary key (TITLE_ID, QUESIONT_ID)
) ;
comment on table TD_CMS_VOTE_TQ is '调查主题和调查问题的映射关系' ;

create table TL_CMS_DOC_OPER_LOG  (
   ID                   NUMBER(10)                       not null,
   USER_ID              NUMBER                           not null,
   DOC_ID               NUMBER                           not null,
   DOC_OPER_ID          NUMBER                           not null,
   DOC_TRANS_ID         NUMBER,
   OPER_TIME            DATE                             not null,
   OPER_CONTENT         VARCHAR2(1000),
   constraint PK_TL_CMS_DOC_OPER_LOG primary key (ID)
);

create table TL_CMS_SITE_FLOW_HIS  (
   SITE_ID              NUMBER(10)                       not null,
   OLD_FLOW_ID          NUMBER,
   NEW_FLOW_ID          NUMBER                           not null,
   OP_USER_ID           NUMBER                           not null,
   OP_TIME              DATE
);
comment on table TL_CMS_SITE_FLOW_HIS is '站点流程改变历史表';
comment on column TL_CMS_SITE_FLOW_HIS.SITE_ID is '站点ID';
comment on column TL_CMS_SITE_FLOW_HIS.OLD_FLOW_ID is '改变前流程ID';
comment on column TL_CMS_SITE_FLOW_HIS.NEW_FLOW_ID is '改变后流程ID';
comment on column TL_CMS_SITE_FLOW_HIS.OP_USER_ID is '操作人';
comment on column TL_CMS_SITE_FLOW_HIS.OP_TIME is '操作时间';

create or replace view V_DOC_FLOW_TRANS as
select a.*,b.src_status,b.dest_status 
from TB_CMS_FLOW_DOC_TRANS a inner join TB_CMS_DOC_STATUS_TRANS b on a.transision_id = b.id;

alter table TB_CMS_DOC_STATUS_TRANS
   add constraint FK_REFERENCE_19 foreign key (SRC_STATUS)
      references TB_CMS_DOC_STATUS (ID) not deferrable;

alter table TB_CMS_DOC_STATUS_TRANS
   add constraint FK_REFERENCE_20 foreign key (DEST_STATUS)
      references TB_CMS_DOC_STATUS (ID) not deferrable;

alter table TB_CMS_FLOW_DOC_TRANS
   add constraint FK_REFERENCE_25 foreign key (FLOW_ID)
      references TB_CMS_FLOW (ID) not deferrable;

alter table TB_CMS_FLOW_DOC_TRANS
   add constraint FK_REFERENCE_26 foreign key (TRANSISION_ID)
      references TB_CMS_DOC_STATUS_TRANS (ID) not deferrable;

alter table TD_CMS_CHANNEL
   add constraint FK_REFERENCE_17 foreign key (OUTLINE_TPL_ID)
      references TD_CMS_TEMPLATE (TEMPLATE_ID) not deferrable;

alter table TD_CMS_CHANNEL
   add constraint FK_REFERENCE_55 foreign key (PARENT_ID)
      references TD_CMS_CHANNEL (CHANNEL_ID) not deferrable;

alter table TD_CMS_CHANNEL
   add constraint FK_TD_CMS_C_REFERENCE_TB_CMS_F foreign key (WORKFLOW)
      references TB_CMS_FLOW (ID) not deferrable;

alter table TD_CMS_CHANNELFIELD
   add constraint FK_TD_CMS_C_REFERENCE_TD_CMS_C foreign key (CHANNEL_ID)
      references TD_CMS_CHANNEL (CHANNEL_ID) not deferrable;

alter table TD_CMS_CHANNELFIELD
   add constraint FK_TD_CMS_C_REFERENCE_TD_CMS_E foreign key (FIELD_ID)
      references TD_CMS_EXTFIELD (FIELD_ID) not deferrable;

alter table TD_CMS_CHNL_REF_DOC
   add constraint FK_REFERENCE_24 foreign key (CHNL_ID)
      references TD_CMS_CHANNEL (CHANNEL_ID) not deferrable;

alter table TD_CMS_COLLECT_TIMECTRL2
   add constraint FK_COLLECT_TIME_CTRL foreign key (TITLE_ID)
      references TD_CMS_COLLECT_TITLE (ID) not deferrable;

alter table TD_CMS_DBTSEARCH_DETAIL
   add constraint TD_CMS_DBTSEARCH_DETAIL_F_ID foreign key (ID)
      references TD_CMS_SITE_SEARCH (ID) not deferrable;

alter table TD_CMS_DOCCOM_IMPEACHINFO
   add constraint FK_TD_DOCIMPEACH foreign key (COMMENT_ID)
      references TD_CMS_DOC_COMMENT (COMMENT_ID) not deferrable;

alter table TD_CMS_DOCUMENT
   add constraint FK_REFERENCE_18 foreign key (STATUS)
      references TB_CMS_DOC_STATUS (ID) not deferrable;

alter table TD_CMS_DOCUMENT
   add constraint FK_REFERENCE_23 foreign key (DOCSOURCE_ID)
      references TD_CMS_DOCSOURCE (DOCSOURCE_ID) not deferrable;

alter table TD_CMS_DOCUMENT
   add constraint FK_REFERENCE_34 foreign key (FLOW_ID)
      references TB_CMS_FLOW (ID) not deferrable;

alter table TD_CMS_DOCUMENT
   add constraint FK_REFERENCE_48 foreign key (DOC_LEVEL)
      references TB_CMS_DOC_LEVEL (ID) not deferrable;

alter table TD_CMS_DOCUMENT
   add constraint FK_REFERENCE_49 foreign key (DOC_KIND)
      references TB_CMS_DOC_KIND (ID) not deferrable;

alter table TD_CMS_DOC_AGGREGATION
   add constraint FK_REFERENCE104 foreign key (AGGR_DOC_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_DOC_ARRANGE
   add constraint REFERENCE_64 foreign key (DOCUMENT_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_DOC_ATTACH
   add constraint FK_REFERENCE_21 foreign key (DOCUMENT_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_DOC_COMMENT
   add constraint FK_COMMENTDOCID foreign key (DOC_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_DOC_COMMENT
   add constraint FK_PARENTCOMMENT foreign key (SRC_COMMENT_ID)
      references TD_CMS_DOC_COMMENT (COMMENT_ID) not deferrable;

alter table TD_CMS_DOC_DIST_MANNER
   add constraint FK_REFERENCE_52 foreign key (DOCUMENT_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_DOC_PUBLISHING
   add constraint FK_DOC_PUBLISHING foreign key (DOCUMENT_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_DOC_RELATED
   add constraint FK_REFERENCE_41 foreign key (DOC_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_DOC_RELATED
   add constraint FK_REFERENCE_42 foreign key (RELATED_DOC_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_DOC_TASK
   add constraint FK_REFERENCE_44 foreign key (DOCUMENT_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_DOC_TASK
   add constraint FK_REFERENCE_62 foreign key (PRE_STATUS)
      references TB_CMS_DOC_STATUS (ID) not deferrable;

alter table TD_CMS_DOC_TASK_DETAIL
   add constraint FK_REFERENCE_63 foreign key (AFTER_STATUS)
      references TB_CMS_DOC_STATUS (ID) not deferrable;

alter table TD_CMS_DOC_TEMPLATE
   add constraint FK_TD_CMS_D_TPL_CHNL foreign key (CHANNEL_ID)
      references TD_CMS_CHANNEL (CHANNEL_ID) not deferrable;

alter table TD_CMS_DOC_VER
   add constraint FK_REFERENCE_58 foreign key (DOCUMENT_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_DOC_VER_ATTACH
   add constraint FK_REFERENCE_54 foreign key (DOCUMENT_ID, VERSION)
      references TD_CMS_DOC_VER (DOCUMENT_ID, VERSION) not deferrable;

alter table TD_CMS_DOC_VER_ATTACH
   add constraint FK_REFERENCE_56 foreign key (ATTACH_ID)
      references TD_CMS_DOC_ATTACH (ID) not deferrable;

alter table TD_CMS_EXTFIELDVALUE
   add constraint FK_TD_CMS_E_REFERENCE_TD_CMS_D foreign key (DOCUMENT_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TD_CMS_EXTFIELDVALUE
   add constraint FK_TD_CMS_E_REFERENCE_TD_CMS_E foreign key (FIELD_ID)
      references TD_CMS_EXTFIELD (FIELD_ID) not deferrable;

alter table TD_CMS_EXTVALUESCOPE
   add constraint FK_EXTFILED_DEXTVALUE foreign key (FIELD_ID)
      references TD_CMS_EXTFIELD (FIELD_ID) not deferrable;

alter table TD_CMS_SITE
   add constraint FK_TD_CMS_SITE447 foreign key (MAINSITE_ID)
      references TD_CMS_SITE (SITE_ID) not deferrable;

alter table TD_CMS_SITE
   add constraint FK_TD_CMS_S_REFERENCE_TB_CMS_F foreign key (FLOW_ID)
      references TB_CMS_FLOW (ID) not deferrable;

alter table TD_CMS_SITEAPPS
   add constraint PK_TD_CMS_SITEAPPS_ foreign key (SITE_ID)
      references TD_CMS_SITE (SITE_ID) not deferrable
     ;

alter table TD_CMS_SITEFIELD
   add constraint FK_TD_CMS_F_REF_TD_CMS_E foreign key (FILE_ID)
      references TD_CMS_EXTFIELD (FIELD_ID) not deferrable;

alter table TD_CMS_SITEFIELD
   add constraint FK_TD_CMS_S_REFERENCE_TD_CMS_S foreign key (SITE_ID)
      references TD_CMS_SITE (SITE_ID) not deferrable;

alter table TD_CMS_SITEUSER
   add constraint FK_SITEUSER_SITEID foreign key (SITE_ID)
      references TD_CMS_SITE (SITE_ID);

alter table TD_CMS_SITE_TPL
   add constraint FK_TD_SITETPLID foreign key (TEMPLATE_ID)
      references TD_CMS_TEMPLATE (TEMPLATE_ID);

alter table TD_CMS_SITE_TPL
   add constraint FK_TD_CMS_SITE_TPL_SITEID foreign key (SITE_ID)
      references TD_CMS_SITE (SITE_ID);

alter table TD_CMS_VOTE_IPCTRL
   add constraint FK_VOTE_IPCTRL foreign key (TITLE_ID)
      references TD_CMS_VOTE_TITLE (ID) not deferrable;

alter table TD_CMS_VOTE_ITEMS
   add constraint FK_QITEMS foreign key (QID)
      references TD_CMS_VOTE_QUESTIONS (ID) not deferrable;

alter table TD_CMS_VOTE_TIMECTRL
   add constraint FK_VOTE_TIME_CTRL foreign key (TITLE_ID)
      references TD_CMS_VOTE_TITLE (ID) not deferrable;

alter table TD_CMS_VOTE_TQ
   add constraint FK_QUESTIONOFTITLE foreign key (TITLE_ID)
      references TD_CMS_VOTE_TITLE (ID);

alter table TD_CMS_VOTE_TQ
   add constraint TD_CMS_VOTE_QUESTIONS foreign key (QUESIONT_ID)
      references TD_CMS_VOTE_QUESTIONS (ID);

alter table TL_CMS_DOC_OPER_LOG
   add constraint FK_REFERENCE_36 foreign key (DOC_ID)
      references TD_CMS_DOCUMENT (DOCUMENT_ID) not deferrable;

alter table TL_CMS_DOC_OPER_LOG
   add constraint FK_REFERENCE_37 foreign key (DOC_OPER_ID)
      references TB_CMS_DOC_OPER (ID) not deferrable;

alter table TL_CMS_DOC_OPER_LOG
   add constraint FK_TL_CMS_D_REFERENCE_TB_CMS_D foreign key (DOC_TRANS_ID)
      references TB_CMS_DOC_STATUS_TRANS (ID) not deferrable;

alter table TL_CMS_SITE_FLOW_HIS
   add constraint FK_REFERENCE100 foreign key (OLD_FLOW_ID)
      references TB_CMS_FLOW (ID) not deferrable;

alter table TL_CMS_SITE_FLOW_HIS
   add constraint FK_REFERENCE101 foreign key (NEW_FLOW_ID)
      references TB_CMS_FLOW (ID) not deferrable;

alter table TL_CMS_SITE_FLOW_HIS
   add constraint FK_TL_CMS_S_REFERENCE_TD_CMS_S foreign key (SITE_ID)
      references TD_CMS_SITE (SITE_ID) not deferrable;

create table X_TD_CMS_PUBLISHSCHEDULAR  (
   SCHEDULERTYPE        NUMBER(5),
   STARTTIME            DATE,
   PUBLISHTIMES         NUMBER(5),
   PUBLISHINTERVAL      NUMBER(5),
   ENDTIME              DATE,
   PUBLISHSCHEDULAR_ID  NUMBER(10)                       not null,
   SITE_ID              NUMBER(10),
   DOCUMENT_ID          NUMBER(10)                       not null,
   CHANNEL_ID           NUMBER(10)
);
comment on table X_TD_CMS_PUBLISHSCHEDULAR is '计划发布（暂不实现）';
comment on column X_TD_CMS_PUBLISHSCHEDULAR.SCHEDULERTYPE is '每天发布 每周发布 每月发布';
comment on column X_TD_CMS_PUBLISHSCHEDULAR.STARTTIME is
'发布计划开始时间,
如果是每天发布,记录发布日期
如果是按周发布,记录发布的周日期,用逗号分隔多个日期';
comment on column X_TD_CMS_PUBLISHSCHEDULAR.PUBLISHTIMES is '发布次数';
comment on column X_TD_CMS_PUBLISHSCHEDULAR.PUBLISHINTERVAL is '发布时间间隔';
comment on column X_TD_CMS_PUBLISHSCHEDULAR.ENDTIME is '计划结束时间';
alter table X_TD_CMS_PUBLISHSCHEDULAR
   add constraint FK_TD_CMS_PUBLISHSCHEDULAR foreign key (CHANNEL_ID)
      references TD_CMS_CHANNEL (CHANNEL_ID);

--start
create or replace function site_flow_id(a_site_id int) return int
is
  l_parent_workflow char(1);
  l_parent_id number(10);
  l_workflow int;
begin
  select PARENT_WORKFLOW,mainsite_id,flow_id
    into l_parent_workflow,l_parent_id,l_workflow 
  from td_cms_site where site_id = a_site_id;
  
  if l_parent_workflow = '0' then 
    return l_workflow;
  end if;
   
  if l_parent_workflow = '1' then 
    return site_flow_id(l_parent_id);
  end if;
  
  return -1;
end;
--end;

--start
create or replace function channel_flow_id(ch_id int) return int
is
  l_parent_workflow char(1);
  l_parent_id number(10);
  l_site_id number(10);
  l_workflow int;
begin
  select PARENT_WORKFLOW,parent_id,site_id,workflow 
    into l_parent_workflow,l_parent_id,l_site_id,l_workflow 
  from td_cms_channel where channel_id = ch_id;
  
  if l_parent_workflow = '0' then 
    return l_workflow;
  end if;
   
  if l_parent_workflow = '1' then 
    if l_parent_id is null then
	   --select flow_id into l_workflow from td_cms_site where site_id = l_site_id;
	   --return l_workflow;
	   return site_flow_id(l_site_id);
	end if;
	
	return channel_flow_id(l_parent_id);
  end if;
  
  return -1;
end;
--end;

--start
create or replace function f_site_flow(a_site_id int) return typ_id_name_list
is
  l_parent_workflow char(1);
  l_parent_id number(10);
  l_workflow int;
  l_workflow_name varchar(100);
  ret_list typ_id_name_list := typ_id_name_list(); --返回结果集变量
begin
  select PARENT_WORKFLOW,mainsite_id,flow_id,b.name
    into l_parent_workflow,l_parent_id,l_workflow,l_workflow_name 
  from td_cms_site a left join tb_cms_flow b on a.flow_id=b.id
  where site_id = a_site_id;
  
  if l_parent_workflow = '0' then 
    ret_list.extend;
    ret_list(1) := new TYP_ID_NAME(l_workflow,l_workflow_name);
    return ret_list;
  end if;
   
  if l_parent_workflow = '1' then 
    return f_site_flow(l_parent_id);
  end if;
  
  return null;
end;
--end;

--start
create or replace function f_channel_flow(ch_id int) return typ_id_name_list
is
  l_parent_workflow char(1);
  l_parent_id number(10);
  l_site_id number(10);
  l_workflow int;
  l_workflow_name varchar(100);
  ret_list typ_id_name_list := typ_id_name_list(); --返回结果集变量
begin
  select PARENT_WORKFLOW,parent_id,site_id,workflow,b.name 
    into l_parent_workflow,l_parent_id,l_site_id,l_workflow,l_workflow_name 
  from td_cms_channel a left join tb_cms_flow b on a.workflow = b.id
  where channel_id = ch_id;
  
  if l_parent_workflow = '0' then 
    ret_list.extend;
    ret_list(1) := new TYP_ID_NAME(l_workflow,l_workflow_name);
    
	return ret_list;
  end if;
   
  if l_parent_workflow = '1' then 
    if l_parent_id is null then
      return f_site_flow(l_site_id);
 	end if;
 
 	return f_channel_flow(l_parent_id);
  end if;
  
  return null;
end;
--end;

--start
create or replace procedure recordpubrelation_proc (pubobject in varchar2,
                  refobject in varchar2, 
                  pubtype in  number,
                  pubsite in varchar2,
                  reftype in number,
                  refsite in varchar2) AS num NUMBER;
 BEGIN
    select count(PUBLISHOBJECT) into num from td_cms_pubobject_relation where 
  PUBLISHOBJECT=pubobject and REFERENCEOBJECT=refobject and PUBLISHTYPE=pubtype 
  and PUBLISH_SITE=pubsite and REFERENCETYPE=reftype and REFERENCE_SITE=refsite;
  DBMS_OUTPUT.PUT_LINE('Value is not exact because pi is 
irrational.');

  if(num = 0) then 
   insert into td_cms_pubobject_relation
   (PUBLISHOBJECT,REFERENCEOBJECT,PUBLISHTYPE,PUBLISH_SITE,REFERENCETYPE,REFERENCE_SITE)
   values( pubobject,refobject,pubtype,pubsite,reftype,refsite );
   commit;
  end if;
 END;
--end;

ALTER TABLE TD_CMS_DOCUMENT ADD FILECONTENT BLOB;

comment on column TD_CMS_DOCUMENT.FILECONTENT is '存放文档对应的word/excel文件内容';

alter table TD_CMS_DOCUMENT drop constraint FK_REFERENCE_23;
alter table TD_CMS_DOCUMENT drop column DOCSOURCE_ID;
alter table TD_CMS_DOCUMENT add DOCSOURCE_NAME varchar2(100) default '未知来源';
comment on column TD_CMS_DOCUMENT.DOCSOURCE_NAME  is '文档来源名称';

create or replace view V_TD_CMS_DOCUMENT as
 select a.*, 
	case when parent_detail_tpl='0' then detailtemplate_id 
	else (select detail_tpl_id from td_cms_channel b where b.channel_id=a.channel_id) 
end detail_tpl_id 
from td_cms_document a;

create table TD_CMS_ORDERPUBLISH
(
  SITE_ID    NUMBER not null,
  CHANNEL_ID NUMBER not null,
  CONTENT    VARCHAR2(20),
  INCREAMENT NUMBER,
  LEVER      NUMBER,
  DAY        NUMBER,
  TIME       NUMBER,
  ID         NUMBER not null
);
alter table TD_CMS_ORDERPUBLISH add primary key (ID);

comment on table TD_CMS_ORDERPUBLISH is '定时发布站点ID';
comment on column TD_CMS_ORDERPUBLISH.SITE_ID is '定时发布站点ID';
comment on column TD_CMS_ORDERPUBLISH.CHANNEL_ID is '定时发布频道ID';
comment on column TD_CMS_ORDERPUBLISH.CONTENT is '发布内容';
comment on column TD_CMS_ORDERPUBLISH.INCREAMENT is '增量发布还是完全发布';
comment on column TD_CMS_ORDERPUBLISH.LEVER is '发布频率, 0 -每周一次,1 每天一次';
comment on column TD_CMS_ORDERPUBLISH.DAY is '当lever =0时, 表示1-7天';
comment on column TD_CMS_ORDERPUBLISH.TIME is '发布具体时间，值为0－23，表示一天中00:00点到23:00点';
comment on column TD_CMS_ORDERPUBLISH.ID is '主键ID';

create table TD_CMS_CRAWL_DOCUMENT
(
  DOCUMENT_ID       NUMBER not null,
  TITLE             VARCHAR2(400) not null,
  SUBTITLE          VARCHAR2(300) not null,
  CONTENT           CLOB,
  CHANNEL_ID        NUMBER(10) not null,
  STATUS            NUMBER not null,
  KEYWORDS          VARCHAR2(500),
  DOCABSTRACT       VARCHAR2(2000),
  DOCTYPE           NUMBER not null,
  DOCWTIME          DATE not null,
  TITLECOLOR        VARCHAR2(7),
  CREATETIME        DATE not null,
  CREATEUSER        NUMBER(10) not null,
  DETAILTEMPLATE_ID NUMBER(10),
  LINKTARGET        VARCHAR2(100),
  FLOW_ID           NUMBER,
  DOC_LEVEL         NUMBER,
  ORDERTIME         DATE,
  DOCSOURCE_NAME    VARCHAR2(100) default '未知来源',
  IMPORTSTATUS      NUMBER,
  EXTENDSITE        VARCHAR2(50)
);
alter table TD_CMS_CRAWL_DOCUMENT add primary key (DOCUMENT_ID) ;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_CRAWL_DOCUMENT', 'DOCUMENT_ID', 1, 0, NULL, 'int', NULL);
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_collect_ipctrl2', 'id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_collect_answer', 'answer_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_collect_title', 'id', 1, 0, NULL, 'int', NULL);
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_remindinfo', 'id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_template', 'template_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_site', 'site_id', 1, 0, NULL, 'int', NULL);
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_docsource', 'docsource_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_channel', 'channel_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_extfield', 'field_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'tl_cms_doc_oper_log
', 'id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_doc_task', 'task_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_doc_attach', 'id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_document', 'document_id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_vote_items', 'id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_vote_questions', 'id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_VOTE_TITLE', 'id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_VOTE_TIMECTRL', 'id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_VOTE_IPCTRL', 'id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_VOTE_ANSWER', 'ANSER_ID', 1, 0, NULL, 'int', NULL);
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_doc_template', 'id', 1, 0, NULL, 'iny', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_DOC_COMMENT', 'COMMENT_ID', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_DOCCOMMENT_DICT', 'id', 1, 0, NULL, 'int', NULL); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TB_CMS_FLOW', 'id', 1, 0, NULL, 'int', NULL); 
COMMIT;

--TB_CMS_DOC_KIND
INSERT INTO TB_CMS_DOC_KIND ( ID, NAME, ORDER_NO ) VALUES ( 
1, '一级分类1', 1); 
INSERT INTO TB_CMS_DOC_KIND ( ID, NAME, ORDER_NO ) VALUES ( 
100, '一级分类2', 2); 
INSERT INTO TB_CMS_DOC_KIND ( ID, NAME, PARENT_ID, ORDER_NO ) VALUES ( 
10, 'x', 1, 1); 
INSERT INTO TB_CMS_DOC_KIND ( ID, NAME, PARENT_ID, ORDER_NO ) VALUES ( 
101, 'Y1', 100, 1); 
INSERT INTO TB_CMS_DOC_KIND ( ID, NAME, PARENT_ID, ORDER_NO ) VALUES ( 
102, 'Y2', 100, 2); 
COMMIT;

--TB_CMS_DOC_LEVEL
INSERT INTO TB_CMS_DOC_LEVEL ( ID, NAME, LEVEL_VALUE ) VALUES ( 
1, '普通', 1); 
INSERT INTO TB_CMS_DOC_LEVEL ( ID, NAME, LEVEL_VALUE ) VALUES ( 
5, '内部', 2); 
COMMIT;

--TB_CMS_DOC_OPER
INSERT INTO TB_CMS_DOC_OPER ( ID, NAME ) VALUES ( 
1, '送审'); 
INSERT INTO TB_CMS_DOC_OPER ( ID, NAME ) VALUES ( 
5, '审核'); 
INSERT INTO TB_CMS_DOC_OPER ( ID, NAME ) VALUES ( 
10, '回收'); 
INSERT INTO TB_CMS_DOC_OPER ( ID, NAME ) VALUES ( 
20, '发布'); 
INSERT INTO TB_CMS_DOC_OPER ( ID, NAME ) VALUES ( 
30, '归档'); 
INSERT INTO TB_CMS_DOC_OPER ( ID, NAME ) VALUES ( 
2, '撤销呈送'); 
INSERT INTO TB_CMS_DOC_OPER ( ID, NAME ) VALUES ( 
40, '版本恢复'); 
INSERT INTO TB_CMS_DOC_OPER ( ID, NAME ) VALUES ( 
3, '回收恢复'); 
COMMIT;

--TB_CMS_DOC_STATUS
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
1, '新稿', 2); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
2, '待审', 2); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
3, '已审', 2); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
4, '返工', 2); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
5, '已发', 2); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
6, '已撤发', 2); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
7, '已归档', 2); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
8, '已回收', 2); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
12, '发布中', 2); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
10, '正在发布', 2); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
20, '开始状态', 1); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
100, '结束状态', 3); 
INSERT INTO TB_CMS_DOC_STATUS ( ID, NAME, TYPE ) VALUES ( 
11, '待发布', 2); 
COMMIT;

--TB_CMS_DOC_STATUS_TRANS
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
1, 1, 2); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
2, 1, 8); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
3, 1, 5); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
4, 11, 5); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
13, 3, 11); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
15, 3, 12); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
8, 2, 3); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
9, 2, 4); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
30, 1, 11); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
20, 5, 5); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
12, 5, 7); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
16, 5, 8); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
17, 7, 8); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
18, 2, 8); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
21, 3, 5); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
10, 4, 2); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
11, 4, 8); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
31, 3, 2); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS, "DESC" ) VALUES ( 
5, 20, 1, '起始路径'); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
6, 2, 1); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
14, 2, 2); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
19, 11, 8); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
40, 5, 6); 
INSERT INTO TB_CMS_DOC_STATUS_TRANS ( ID, SRC_STATUS, DEST_STATUS ) VALUES ( 
41, 6, 5); 
COMMIT;

--TB_CMS_FLOW
INSERT INTO TB_CMS_FLOW ( ID, NAME ) VALUES ( 
0, '引用站点流程'); 
INSERT INTO TB_CMS_FLOW ( ID, NAME ) VALUES ( 
1, '采-审-发'); 
INSERT INTO TB_CMS_FLOW ( ID, NAME ) VALUES ( 
2, '采-发'); 
INSERT INTO TB_CMS_FLOW ( ID, NAME ) VALUES ( 
200, 'X流程'); 
COMMIT;

--TB_CMS_FLOW_DOC_TRANS
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 40); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 41); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 1); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 2); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 17); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 4); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 13); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 16); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 31); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 21); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 12); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 30); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
2, 2); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 20); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 10); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 11); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 19); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
2, 30); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
2, 4); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 8); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 9); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
2, 3); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
2, 16); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
2, 17); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
2, 12); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
2, 19); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 6); 
INSERT INTO TB_CMS_FLOW_DOC_TRANS ( FLOW_ID, TRANSISION_ID ) VALUES ( 
1, 18); 
COMMIT;

INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE
, TABLE_ID_TYPE ) VALUES ( 
'td_cms_site_search', 'id', 1, 0, 'int'); 
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'td_cms_mailserverinfo', 'id', 1, 0, NULL, 'int', NULL); 
COMMIT;

--文档表的文档内容字段的全文索引
CREATE  INDEX doc_content_idx ON TD_CMS_DOCUMENT(content) INDEXTYPE IS ctxsys.CONTEXT;
COMMIT;

-- 2009-1-6 添加的表信息
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_TEMPLATE_STYLE', 'STYLE_ID', 1, 0, null, 'int', NULL) ;
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_EXTVALUESCOPE', 'ID', 1, 0, null, 'int', NULL) ;
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_DOCCOM_IMPEACHINFO', 'ID', 1, 0, null, 'int', NULL) ;

-- 2009-2-24 添加
INSERT INTO TABLEINFO ( TABLE_NAME, TABLE_ID_NAME, TABLE_ID_INCREMENT, TABLE_ID_VALUE,
TABLE_ID_GENERATOR, TABLE_ID_TYPE, TABLE_ID_PREFIX ) VALUES ( 
'TD_CMS_ORDERPUBLISH', 'id', 1, 0, NULL, 'int', NULL); 
commit ;

insert into td_cms_template_style(style_id,style_name,style_desc,style_order) values(-1,'通用','被默认的通用风格',0);
commit;

comment on column TD_CMS_DOCUMENT.FILECONTENT is '存放文档对应的word/excel文件内容';

--在频道表中添加专题报道标记,已下为添加标记的脚本:
ALTER TABLE TD_CMS_CHANNEL
ADD (specialflag NUMBER(1) DEFAULT 0);
COMMENT ON COLUMN 
TD_CMS_CHANNEL.specialflag IS 
'频道专题报道标记 0-不是专题报道 1-专题报道';
ALTER TABLE TD_CMS_DOCUMENT ADD seq   NUMBER default 9999;
comment on column TD_CMS_DOCUMENT.seq is '文档排序号';

-- 后来增加的
alter table TD_CMS_DOCUMENT add EXT_CLASS varchar2(300);
alter table TD_CMS_DOCUMENT add EXT_ORG varchar2(200);
alter table TD_CMS_DOCUMENT add EXT_WH varchar2(100);
alter table TD_CMS_DOCUMENT add EXT_INDEX varchar2(50);
alter table TD_CMS_DOCUMENT add EXT_DJH varchar2(100);
alter table TD_CMS_DOCUMENT add COUNT number default 0;
alter table TD_CMS_DOCUMENT
   add constraint FK_REFERENCE_channel foreign key (channel_id)
      references Td_CMS_channel (channel_ID) not deferrable;


CREATE SEQUENCE SEQ_TD_CMS_COLLECT_IPCTRL2
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_COLLECT_IPCTRL2',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_collect_ipctrl2');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from td_cms_collect_ipctrl2;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_COLLECT_IPCTRL2.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_COLLECT_ANSWER
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;

UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_COLLECT_ANSWER',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_collect_answer');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(answer_id || '')) into maxseq from td_cms_collect_answer;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_COLLECT_ANSWER.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_REMINDINFO
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_REMINDINFO',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_remindinfo');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from td_remindinfo;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_REMINDINFO.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_TEMPLATE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_TEMPLATE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_template');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(template_id || '')) into maxseq from td_cms_template;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_TEMPLATE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_SITE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_SITE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_site');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(site_id || '')) into maxseq from td_cms_site;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_SITE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_DOCSOURCE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_DOCSOURCE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_docsource');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(docsource_id || '')) into maxseq from td_cms_docsource;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_DOCSOURCE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_CHANNEL
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_CHANNEL',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_channel');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(channel_id || '')) into maxseq from td_cms_channel;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_CHANNEL.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_EXTFIELD
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_EXTFIELD',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_extfield');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(field_id || '')) into maxseq from td_cms_extfield;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_EXTFIELD.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TL_CMS_DOC_OPER_LOG
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TL_CMS_DOC_OPER_LOG
',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('tl_cms_doc_oper_log
');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from tl_cms_doc_oper_log
;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TL_CMS_DOC_OPER_LOG
.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_DOC_TASK
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_DOC_TASK',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_doc_task');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(task_id || '')) into maxseq from td_cms_doc_task;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_DOC_TASK.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_DOC_ATTACH
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_DOC_ATTACH',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_doc_attach');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from td_cms_doc_attach;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_DOC_ATTACH.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_DOCUMENT
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  ;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_DOCUMENT',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_document');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(document_id || '')) into maxseq from td_cms_document;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_DOCUMENT.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_VOTE_ITEMS
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_VOTE_ITEMS',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_vote_items');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from td_cms_vote_items;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_VOTE_ITEMS.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_VOTE_QUESTIONS
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_VOTE_QUESTIONS',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_vote_questions');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from td_cms_vote_questions;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_VOTE_QUESTIONS.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_VOTE_TITLE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_VOTE_TITLE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_CMS_VOTE_TITLE');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from TD_CMS_VOTE_TITLE;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_VOTE_TITLE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_VOTE_TIMECTRL
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_VOTE_TIMECTRL',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_CMS_VOTE_TIMECTRL');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from TD_CMS_VOTE_TIMECTRL;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_VOTE_TIMECTRL.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_VOTE_IPCTRL
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_VOTE_IPCTRL',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_CMS_VOTE_IPCTRL');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from TD_CMS_VOTE_IPCTRL;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_VOTE_IPCTRL.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_VOTE_ANSWER
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_VOTE_ANSWER',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_CMS_VOTE_ANSWER');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(ANSER_ID || '')) into maxseq from TD_CMS_VOTE_ANSWER;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_VOTE_ANSWER.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_COLLECT_TITLE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_COLLECT_TITLE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_collect_title');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from td_cms_collect_title;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_COLLECT_TITLE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_DOC_TEMPLATE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_DOC_TEMPLATE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_doc_template');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from td_cms_doc_template;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_DOC_TEMPLATE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_DOC_COMMENT
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_DOC_COMMENT',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_CMS_DOC_COMMENT');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(COMMENT_ID || '')) into maxseq from TD_CMS_DOC_COMMENT;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_DOC_COMMENT.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_DOCCOMMENT_DICT
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_DOCCOMMENT_DICT',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_CMS_DOCCOMMENT_DICT');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from TD_CMS_DOCCOMMENT_DICT;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_DOCCOMMENT_DICT.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_SITE_SEARCH
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_SITE_SEARCH',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_site_search');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from td_cms_site_search;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_SITE_SEARCH.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_MAILSERVERINFO
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_MAILSERVERINFO',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('td_cms_mailserverinfo');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(id || '')) into maxseq from td_cms_mailserverinfo;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_MAILSERVERINFO.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_TEMPLATE_STYLE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_TEMPLATE_STYLE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_CMS_TEMPLATE_STYLE');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(STYLE_ID || '')) into maxseq from TD_CMS_TEMPLATE_STYLE;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_TEMPLATE_STYLE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_EXTVALUESCOPE
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_EXTVALUESCOPE',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_CMS_EXTVALUESCOPE');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(ID || '')) into maxseq from TD_CMS_EXTVALUESCOPE;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_EXTVALUESCOPE.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_DOCCOM_IMPEACHINFO
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_DOCCOM_IMPEACHINFO',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_CMS_DOCCOM_IMPEACHINFO');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(ID || '')) into maxseq from TD_CMS_DOCCOM_IMPEACHINFO;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_DOCCOM_IMPEACHINFO.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TB_CMS_FLOW
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TB_CMS_FLOW',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TB_CMS_FLOW');
COMMIT;

--start
  declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(ID || '')) into maxseq from TB_CMS_FLOW;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TB_CMS_FLOW.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;

CREATE SEQUENCE SEQ_TD_CMS_ORDERPUBLISH
  START WITH 1
  MAXVALUE 99999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
UPDATE TABLEINFO SET TABLE_ID_GENERATOR='SEQ_TD_CMS_ORDERPUBLISH',TABLE_ID_TYPE='sequence'  WHERE upper(table_name)=upper('TD_CMS_ORDERPUBLISH');
COMMIT;

--start
declare
	maxseq number :=1;
	currentvalue number;
begin
	select max(to_number(ID || '')) into maxseq from TD_CMS_ORDERPUBLISH;
	if(maxseq > 0)
	then
	  for i in 1..(maxseq-0) loop
		 select SEQ_TD_CMS_ORDERPUBLISH.nextval into currentvalue from dual;
	  end loop;
	end if;
exception
	when others
	then
		 null;
end;
--end;
--------CMS内容管理脚本结束--------