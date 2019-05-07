delete from OA_DATA_RESOURCES where RESOURCES_ID in ('36','37');
insert into OA_DATA_RESOURCES (RESOURCES_ID, RESOURCES_PARENT_ID, RESOURCES_NAME, RESOURCES_LOGO, RESOURCES_DESC, CREATOR_TIME, RESOURCES_TYPE, TREE_TYPE, IS_VIEW)
values ('36', '0', '督察督办', 'inspect', '督察督办', sysdate, '1', null, '1');
insert into OA_DATA_RESOURCES (RESOURCES_ID, RESOURCES_PARENT_ID, RESOURCES_NAME, RESOURCES_LOGO, RESOURCES_DESC, CREATOR_TIME, RESOURCES_TYPE, TREE_TYPE, IS_VIEW)
values ('37', '36', '督察督办单位接收人', 'inspect_recept_user', '督察督办单位接收人', sysdate, '2', null, '1');
commit;