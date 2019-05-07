

insert into oa_data_resources (RESOURCES_ID, RESOURCES_PARENT_ID, RESOURCES_NAME, RESOURCES_LOGO, RESOURCES_DESC, CREATOR_TIME, RESOURCES_TYPE, TREE_TYPE, IS_VIEW)
values ('10', '4', '通知公告审核接收人', 'noticereson', '通知公告审核接收人', to_date('20-11-2013', 'dd-mm-yyyy'), '1', '1', '1');
commit;

insert into oa_sys_param (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('7559961e-0f64-4a76-bf5e-91deedb340f5', 'notice_show_hiden', 'audit_show', '通知公告审核', '0', '1', to_date('27-11-2013 19:55:09', 'dd-mm-yyyy hh24:mi:ss'), '1', '568cb209-97c7-47d4-b532-2ca0b30717a7', '通知公告审核是否显示0：显示1：不显示');

insert into oa_sys_param (P_ID, P_TYPE, P_CODE, P_NAME, P_CONTENT, P_VALID, P_CREATOR_TIME, P_ISUPDATE, DICTDATA_ID, P_REMARK)
values ('6113d722-8e16-489b-b67d-76eff5910b37', 'publish_show_hiden', 'publish_show', '通知公告发布', '1', '1', to_date('27-11-2013 19:58:39', 'dd-mm-yyyy hh24:mi:ss'), '1', '568cb209-97c7-47d4-b532-2ca0b30717a7', '通知公告发布按钮0：显示，1：隐藏');
commit;


-- Add/modify columns 
alter table OA_NOTICE_BASEINFO add N_AUDIT_NAME VARCHAR2(50);
alter table OA_NOTICE_BASEINFO add N_AUDIT_ID VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_NOTICE_BASEINFO.N_AUDIT_NAME
  is '审核接收人名字';
comment on column OA_NOTICE_BASEINFO.N_AUDIT_ID
  is '审核接收人编号';

-- Add/modify columns 
alter table OA_NOTICE_BASEINFO add N_AUDIT_STATE VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_NOTICE_BASEINFO.N_AUDIT_STATE
  is '审核状态(1未审核，2已审核)';


--审核意见表
-- Create table
create table OA_NOTICE_AUDIT
(
  ID                 VARCHAR2(50) not null,
  NOTICE_ID          VARCHAR2(50),
  N_AUDIT_STATE_VIEW VARCHAR2(50),
  N_VIEW             VARCHAR2(1000)
);
-- Add comments to the table 
comment on table OA_NOTICE_AUDIT
  is '审核状态表';
-- Add comments to the columns 
comment on column OA_NOTICE_AUDIT.ID
  is '主键';
comment on column OA_NOTICE_AUDIT.NOTICE_ID
  is '主表编号';
comment on column OA_NOTICE_AUDIT.N_AUDIT_STATE_VIEW
  is '状态';
comment on column OA_NOTICE_AUDIT.N_VIEW
  is '意见';




