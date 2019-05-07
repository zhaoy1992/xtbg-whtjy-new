declare
  countt integer;
begin
    select count(1) into countt from oa_dict_type where dict_code = 'wenjianzihao';
    if countt=0 then
         insert into oa_dict_type (DICT_ID, DICT_PARENT_ID, DICT_NAME, DICT_CODE, DICT_REMARK, DICT_IS_VALID, DICT_ORDER, DICT_TYPE)
         values ('d29a95a5-dfdd-44cc-9495-cb8bb860c4f4', '0', '文件字号', 'wenjianzihao', '', '1', 1, '1');
    end if;
end;

