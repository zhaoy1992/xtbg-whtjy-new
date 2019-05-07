insert into OA_TASK_TYPE (TYPE_ID, TYPE_NAME, TYPE_SORT, TYPE_VALUE)
values ('1', '普通', 'importance', '1');

insert into OA_TASK_TYPE (TYPE_ID, TYPE_NAME, TYPE_SORT, TYPE_VALUE)
values ('2', '重要', 'importance', '2');

insert into OA_TASK_TYPE (TYPE_ID, TYPE_NAME, TYPE_SORT, TYPE_VALUE)
values ('3', '非常重要', 'importance', '3');

insert into OA_TASK_TYPE (TYPE_ID, TYPE_NAME, TYPE_SORT, TYPE_VALUE)
values ('4', '一般任务', 'tasktype', '1');

insert into OA_TASK_TYPE (TYPE_ID, TYPE_NAME, TYPE_SORT, TYPE_VALUE)
values ('5', '其他任务', 'tasktype', '2');

insert into OA_TASK_TYPE (TYPE_ID, TYPE_NAME, TYPE_SORT, TYPE_VALUE)
values ('6', '未办理', 'status', '1');

insert into OA_TASK_TYPE (TYPE_ID, TYPE_NAME, TYPE_SORT, TYPE_VALUE)
values ('7', '办理中', 'status', '2');

insert into OA_TASK_TYPE (TYPE_ID, TYPE_NAME, TYPE_SORT, TYPE_VALUE)
values ('8', '已完成', 'status', '3');
commit;
