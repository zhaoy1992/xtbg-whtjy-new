create table M_T_HY
(
  hy_bt      VARCHAR2(200),
  hy_kssj    VARCHAR2(200),
  hy_jssj    VARCHAR2(200),
  hy_dd      VARCHAR2(200),
  hy_lxbm    VARCHAR2(50),
  hy_lxr     VARCHAR2(50),
  hy_lxdh    VARCHAR2(50),
  hy_cyr     VARCHAR2(4000),
  hy_content VARCHAR2(200),
  hy_sfbm    CHAR(1),
  hy_sqrid   VARCHAR2(200),
  hy_sqr     VARCHAR2(200),
  hy_sqsj    VARCHAR2(200),
  hy_sqrbmid VARCHAR2(200),
  hy_sqrbm   VARCHAR2(200),
  hy_cyrid   VARCHAR2(4000),
  hy_lxrid   VARCHAR2(200),
  hy_lxbmid  VARCHAR2(200)
);

comment on table M_T_HY
  is '会议通知新增';
comment on column M_T_HY.hy_bt
  is '会议标题';
comment on column M_T_HY.hy_kssj
  is '会议开始时间';
comment on column M_T_HY.hy_jssj
  is '会议结束时间';
comment on column M_T_HY.hy_dd
  is '会议地点';
comment on column M_T_HY.hy_lxbm
  is '会议联系部门';
comment on column M_T_HY.hy_lxr
  is '会议联系人';
comment on column M_T_HY.hy_lxdh
  is '会议联系电话';
comment on column M_T_HY.hy_cyr
  is '会议参与人';
comment on column M_T_HY.hy_content
  is '会议正文';
comment on column M_T_HY.hy_sfbm
  is '是否报名     1报名,0不报名';
comment on column M_T_HY.hy_sqrid
  is '申请人id';
comment on column M_T_HY.hy_sqr
  is '申请人';
comment on column M_T_HY.hy_sqsj
  is '申请时间';
comment on column M_T_HY.hy_sqrbmid
  is '申请人部门id';
comment on column M_T_HY.hy_sqrbm
  is '申请人部门';
comment on column M_T_HY.hy_cyrid
  is '会议参与人id';
comment on column M_T_HY.hy_lxrid
  is '会议联系人id';
comment on column M_T_HY.hy_lxbmid
  is '会议联系部门id';
  
 create table M_T_HY_HF
(
  hy_replay VARCHAR2(200),
  hy_cyrid  VARCHAR2(4000),
  hy_cyr    VARCHAR2(4000),
  hy_reason VARCHAR2(200),
  hy_id     VARCHAR2(200),
  hy_bmr    VARCHAR2(200),
  hy_bmrid  VARCHAR2(200),
  hy_hfsj   VARCHAR2(200),
  hy_cyrs   VARCHAR2(200)
);
comment on table M_T_HY_HF
  is '会议通知(阅读/回复)';
comment on column M_T_HY_HF.hy_replay
  is '会议回复情况';
comment on column M_T_HY_HF.hy_cyrid
  is '会议参与人id';
comment on column M_T_HY_HF.hy_cyr
  is '会议报名参与人';
comment on column M_T_HY_HF.hy_reason
  is '会议请假内容';
comment on column M_T_HY_HF.hy_id
  is '会议id';
comment on column M_T_HY_HF.hy_bmr
  is '操作人（会议接收人）';
comment on column M_T_HY_HF.hy_bmrid
  is '会议报名人id';
comment on column M_T_HY_HF.hy_hfsj
  is '回复时间';
comment on column M_T_HY_HF.hy_cyrs
  is '参会人数';
 
  