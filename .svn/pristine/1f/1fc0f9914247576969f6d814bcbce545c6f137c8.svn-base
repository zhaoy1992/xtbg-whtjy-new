-------1 文件表 增加两列，并且 维护老数据的这两列数据
-- Add/modify columns 
alter table OA_FILE_DOC add F_ZIHAO_TYPE_NAME VARCHAR2(100);
alter table OA_FILE_DOC add F_WENHAO VARCHAR2(100);
-- Add comments to the columns 
comment on column OA_FILE_DOC.F_ZIHAO_TYPE_NAME
  is '字号类型';
comment on column OA_FILE_DOC.F_WENHAO
  is '文号(文件字号的后面部分)';
  
insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('6bba06f0-34bb-41cf-9779-0ff8901a627b', 'wj', 'F_WENHAO', '文号', 101, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('6bba06f0-34bb-41cf-9779-0ff8901a627a', 'wj', 'F_ZIHAO_TYPE_NAME', '字号类型', 100, '0');

insert into oa_md_columns (COLUMN_ID, TABLE_ID, COLUMN_CODE, COLUMN_NAME, COLUMN_SN, ISVIEW)
values ('6bba06f0-34bb-41cf-9779-0ff8901a627c', 'wj', 'F_DESTROY_STATE', '销毁状态', 99, '0');

 
 
update
oa_file_doc
set F_ZIHAO_TYPE_NAME = REGEXP_SUBSTR(f_doc_fontsize,'^.*\[')
where regexp_like(f_doc_fontsize,'\[\d{4}\]') and F_ZIHAO_TYPE_NAME is null;
update
oa_file_doc
set F_ZIHAO_TYPE_NAME = trim(substr(F_ZIHAO_TYPE_NAME,1,length(F_ZIHAO_TYPE_NAME)-1))
where regexp_like(f_doc_fontsize,'\[\d{4}\]') and F_ZIHAO_TYPE_NAME like '%[';

update
oa_file_doc
set f_wenhao = REGEXP_SUBSTR(f_doc_fontsize,'\].*$')
where regexp_like(f_doc_fontsize,'\[\d{4}\]') and f_wenhao is null;
update
oa_file_doc
set f_wenhao = trim(substr(f_wenhao,2,length(f_wenhao)))
where regexp_like(f_doc_fontsize,'\[\d{4}\]') and f_wenhao like ']%';

commit;

-----2 调整数据顺序
delete oa_dict_data where dict_id = '1';
delete oa_dict_data where DICTDATA_ID in ('1','2','3','4');
insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('1', '1', '0', '绝密', '1', '绝密级别', '1', 4);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('2', '1', '0', '机密', '2', '机密级别', '1', 3);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('3', '1', '0', '秘密', '3', '秘密级别', '1', 2);

insert into oa_dict_data (DICTDATA_ID, DICT_ID, DICTDATA_PARENT_ID, DICTDATA_NAME, DICTDATA_VALUE, DICTDATA_REMARK, DICTDATA_IS_VALID, DICTDATA_ORDER)
values ('4', '1', '0', '普通', '4', '普通级别', '1', 1);

commit;