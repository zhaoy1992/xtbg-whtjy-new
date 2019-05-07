insert into TD_SM_ROLE
  (role_id,
   role_name,
   role_type,
   role_desc,
   role_usage,
   remark1,
   remark2,
   remark3,
   owner_id)
  select SEQ_TD_SM_ROLE.NEXTVAL,
         '会议系统管理员',
         '1',
         '会议系统管理员：只有会议系统管理员才能删除会议',
         null,
         null,
         null,
         null,
         1
    from dual t
   where not EXISTS
   (select '' from TD_SM_ROLE where role_name = '会议系统管理员');
   commit;