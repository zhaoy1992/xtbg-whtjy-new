insert into OA_ORG_TYPE (TYPE_ID, TYPE_NAME, TYPE_CODE)
values ('1', '区域', '1');
insert into OA_ORG_TYPE (TYPE_ID, TYPE_NAME, TYPE_CODE)
values ('2', '单位', '2');
insert into OA_ORG_TYPE (TYPE_ID, TYPE_NAME, TYPE_CODE)
values ('3', '科室', '3');
insert into OA_ORG_TYPE (TYPE_ID, TYPE_NAME, TYPE_CODE)
values ('4', '系统', '4');
commit;

insert into OA_FLOW_STATUS (STATUS_CODE, STATUS_NAME)
values ('05', '已终止');

insert into OA_FLOW_STATUS (STATUS_CODE, STATUS_NAME)
values ('04', '暂存');

insert into OA_FLOW_STATUS (STATUS_CODE, STATUS_NAME)
values ('01', '在办');

insert into OA_FLOW_STATUS (STATUS_CODE, STATUS_NAME)
values ('02', '一般办结');

insert into OA_FLOW_STATUS (STATUS_CODE, STATUS_NAME)
values ('06', '回退');

insert into actproperties (PROPERTY_NAME)
values ('DYNAMICPERFORMER');

insert into actproperties (PROPERTY_NAME)
values ('ACTIVITY_ALIAS');

insert into actproperties (PROPERTY_NAME)
values ('ACTIVITY_LIMIT');

insert into actproperties (PROPERTY_NAME)
values ('ACTIVITY_PARTICIPANT');

insert into actproperties (PROPERTY_NAME)
values ('AUTOASSIGNMENT');

commit;

--add by shuqi.liu　自定义表单初始化脚本
insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('afixlist', '附件列表');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('txt', '正文');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('hide', '隐藏域');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('input', '文本框');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('select', '下拉框');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('textarea', '文本域');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('text', '文本');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('date', '日期');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('viewtext', '意见框');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('afix', '附件');

commit;

insert into oa_document_comidea (IDEA_ID, IDEA_CONTENT, USER_ID)
values ('1', '同意', '');

insert into oa_document_comidea (IDEA_ID, IDEA_CONTENT, USER_ID)
values ('2', '不同意1', '');

insert into oa_tag_type (TAG_TYPE_CODE, TAG_TYPE_NAME)
values ('ismsg', '是否短信通知');

commit;