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
         '政策法规单位管理员',
         '1',
         '政策法规单位管理员',
         null,
         null,
         null,
         null,
         1
    from dual t
   where not EXISTS
   (select '' from TD_SM_ROLE where role_name = '政策法规单位管理员');
   

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
         '政策法规部门管理员',
         '1',
         '政策法规部门管理员',
         null,
         null,
         null,
         null,
         1
    from dual t
   where not EXISTS
   (select '' from TD_SM_ROLE where role_name = '政策法规部门管理员');
commit;