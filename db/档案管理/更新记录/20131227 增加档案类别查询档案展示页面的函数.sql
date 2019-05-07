CREATE OR REPLACE FUNCTION OA_FILE_GET_DETAIL_PAGE(
V_FILE_TYPE_ID IN VARCHAR2,
V_TYPE IN VARCHAR2
)
/**
  * 通过档案类型获得展示改档案的页面
  * tuo.zou
  * V_FILE_TYPE_ID 档案类型id
  V_TYPE:1文件page 2 案卷page
  */
 RETURN VARCHAR2 AS
  V_PAGE VARCHAR2(50);
BEGIN
  IF  V_TYPE = '1' THEN
  select f_file_detail
    INTO V_PAGE
    from oa_file_program_page
   where f_program_id in
         (select f_program_id
            from oa_file_type
           where f_type_id = V_FILE_TYPE_ID);
  ELSE
    select f_files_detail
    INTO V_PAGE
    from oa_file_program_page
   where f_program_id in
         (select f_program_id
            from oa_file_type
           where f_type_id = V_FILE_TYPE_ID);
  END IF;
  RETURN V_PAGE;
END;
/