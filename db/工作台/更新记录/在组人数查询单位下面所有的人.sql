create or replace function oa_getorgalluser(v_orgid varchar2) return varchar2 is
  rs varchar2(4000);
  begin
   select wmsys.wm_concat(ou.user_id) into rs
   from td_sm_orguser ou
  where EXISTS
  (select org_id from (select o.org_id
           from td_sm_organization o
          start with o.org_id = v_orgid
         connect by prior o.org_id = o.parent_id) t where
                 t.org_id = ou.org_id);
  return(rs);
end;
/