alter table oa_data_resources
   drop primary key cascade;

drop table oa_data_resources cascade constraints;

/*==============================================================*/
/* Table: oa_data_resources                                     */
/*==============================================================*/
create table oa_data_resources 
(
   resources_id         VARCHAR2(50)         not null,
   resources_parent_id  VARCHAR2(50),
   resources_name       VARCHAR2(50)         not null,
   resources_logo       VARCHAR2(50)         not null,
   resources_desc       VARCHAR2(500),
   creator_time         DATE                 default SYSDATE,
   resources_type       VARCHAR2(2),
   tree_type            VARCHAR2(2),
   is_view              VARCHAR2(2)          default 'N'
);

comment on table oa_data_resources is
'数据资源表';

comment on column oa_data_resources.resources_id is
'资源ID';

comment on column oa_data_resources.resources_parent_id is
'资源父ID';

comment on column oa_data_resources.resources_name is
'资源名称';

comment on column oa_data_resources.resources_logo is
'资源标识';

comment on column oa_data_resources.resources_desc is
'资源描述';

comment on column oa_data_resources.creator_time is
'创建时间';

comment on column oa_data_resources.resources_type is
'资源类型(1表示人员权限,2单位接收人权限)';

comment on column oa_data_resources.tree_type is
'1.人员类型树,2.单位类型树, 3.部门类型树';

comment on column oa_data_resources.is_view is
'1.显示,0不显示';

alter table oa_data_resources
   add constraint PK_OA_DATA_RESOURCE primary key (resources_id);

alter table oa_dataresources_config
   drop primary key cascade;

drop table oa_dataresources_config cascade constraints;

/*==============================================================*/
/* Table: oa_dataresources_config                               */
/*==============================================================*/
create table oa_dataresources_config 
(
   config_id            VARCHAR2(50)         not null,
   resources_id         VARCHAR2(50)         not null,
   config_type          CHAR(1)              default '1' not null,
   config_typeid        VARCHAR2(50)         not null,
   config_range         CHAR(1),
   creator_time         DATE                 default SYSDATE,
   tree_jsondata        CLOB,
   config_ids           CLOB
);

comment on table oa_dataresources_config is
'资源配置表';

comment on column oa_dataresources_config.config_id is
'主键id';

comment on column oa_dataresources_config.resources_id is
'资源ID';

comment on column oa_dataresources_config.config_type is
'资源配置类型';

comment on column oa_dataresources_config.config_typeid is
'资源配置类型id';

comment on column oa_dataresources_config.config_range is
'资源配置范围';

comment on column oa_dataresources_config.creator_time is
'创建时间';

comment on column oa_dataresources_config.tree_jsondata is
'树json对像';

comment on column oa_dataresources_config.config_ids is
'用户或单位ID集合';

alter table oa_dataresources_config
   add constraint PK_OA_DATARESOURCES_CONFIG primary key (config_id);

drop function OA_USERPROPERTY
/


create or replace function OA_USERPROPERTY(v_orgid   IN VARCHAR2,
                                           v_seltype IN VARCHAR2)
RETURN VARCHAR2 AS
  RS varchar2(4000);
begin
  IF v_seltype = '1' THEN
    select org_name as unit_name
      into RS
      from (select a.org_id, a.org_name, a.org_level
              from td_sm_organization a
             start with a.org_id = v_orgid
            connect by prior a.parent_id = a.org_id)
     where org_level = '2'
       and rownum = 1;
  ELSIF v_seltype = '2' THEN
    select org_id as unit_id
      into RS
      from (select a.org_id, a.org_name, a.org_level
              from td_sm_organization a
             start with a.org_id = v_orgid
            connect by prior a.parent_id = a.org_id)
     where org_level = '2'
       and rownum = 1;
  ELSIF v_seltype = '3' THEN
     select replace(wmsys.wm_concat(a.org_name), ',', '->')
      into RS
      from td_sm_organization a
     start with a.org_id = v_orgid
    connect by prior a.parent_id = a.org_id;
   ELSE
    select wmsys.wm_concat(a.org_id)
      into RS
      from td_sm_organization a
     start with a.org_id = v_orgid
    connect by prior a.parent_id = a.org_id;
  END IF;
  RETURN(RS);
END;
/
