alter table OA_DATA_DATA add d_data_content1 clob;

comment on column OA_DATA_DATA.d_data_content1
  is '资料内容';

update oa_data_data set d_data_content1=oa_data_data.d_data_content;

alter table OA_DATA_DATA drop column d_data_content;

alter table OA_DATA_DATA rename column d_data_content1 to D_DATA_CONTENT;