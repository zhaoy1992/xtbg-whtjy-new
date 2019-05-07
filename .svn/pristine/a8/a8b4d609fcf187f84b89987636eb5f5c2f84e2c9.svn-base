---修复 存放位置数据
declare
  v_id   varchar2(500);
  v_name varchar2(500);
  CURSOR c_oa_file_storage_location IS
    select a.f_storage_id, f_perant_id from oa_file_storage_location a;
begin
  for onerow in c_oa_file_storage_location loop
    select TO_CHAR(WM_CONCAT(f_storage_id)),
           REPLACE(REPLACE(TO_CHAR(WM_CONCAT('!@#$%^&*()' ||
                                             f_storage_shotname)),
                           ',!@#$%^&*()',
                           '->'),
                   '!@#$%^&*()',
                   '')
      into v_id, v_name
      from (select a.f_storage_id, a.f_storage_shotname
              from oa_file_storage_location a
            connect by prior a.f_perant_id = a.f_storage_id
             start with a.f_storage_id = onerow.f_storage_id
             order by ROWNUM desc);
    update oa_file_storage_location
       set oa_file_storage_location.f_storage_urlid   = v_id,
           oa_file_storage_location.f_storage_urlname = v_name
     where oa_file_storage_location.f_storage_id = onerow.f_storage_id;
  end loop;
  commit;
end;
/