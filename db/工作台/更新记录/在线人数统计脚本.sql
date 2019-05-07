create or replace function oa_getorgalluser(v_orgid varchar2,v_online_userids varchar2) return number is
  rs number;
   rscount    number := 0; 
   CURSOR userlist IS
   select ou.user_id as userid
   from td_sm_orguser ou
  where EXISTS
  (select org_id from (select o.org_id
           from td_sm_organization o
          start with o.org_id = v_orgid
         connect by prior o.org_id = o.parent_id) t where
                 t.org_id = ou.org_id);
  begin             
    --循环复制问题及问题选项
  FOR c_userlist IN userlist LOOP             
      if instr(v_online_userids, ','||c_userlist.userid||',') > 0 then
         rscount := rscount + 1;
       end if;
  end loop;
  rs := rscount;
  return(rs);
end;
/