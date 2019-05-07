alter table OA_GWCS_ORG
   drop primary key cascade;

drop table OA_GWCS_ORG cascade constraints;

drop table OA_GWCS_ORG_MAPPING cascade constraints;

/*==============================================================*/
/* Table: GWCS_ORG                                              */
/*==============================================================*/
create table OA_GWCS_ORG 
(
   org_id               VARCHAR2(50)         not null,
   org_name             VARCHAR2(100),
   org_addr             VARCHAR2(20),
   parent_id            VARCHAR2(50),
   isouter              VARCHAR2(1)
);

comment on table OA_GWCS_ORG is
'公文传输系统机构信息';

comment on column OA_GWCS_ORG.org_id is
'机构id';

comment on column OA_GWCS_ORG.org_name is
'机构名称';

comment on column OA_GWCS_ORG.org_addr is
'机构地址码';

comment on column OA_GWCS_ORG.parent_id is
'父机构id';

comment on column OA_GWCS_ORG.isouter is
'是否为外部机构';

alter table OA_GWCS_ORG
   add constraint PK_OA_GWCS_ORG primary key (org_id);

/*==============================================================*/
/* Table: OA_GWCS_ORG_MAPPING                                   */
/*==============================================================*/
create table OA_GWCS_ORG_MAPPING 
(
   OA_ORG_ID            VARCHAR2(50),
   GWCS_ORG_ID          VARCHAR2(50)
);

comment on table OA_GWCS_ORG_MAPPING is
'OA与GWCS机构映射关系表';

comment on column OA_GWCS_ORG_MAPPING.OA_ORG_ID is
'OA机构id';

comment on column OA_GWCS_ORG_MAPPING.GWCS_ORG_ID is
'GWCS机构id';
