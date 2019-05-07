delete OA_SYS_PARAM d where d.p_code ='tmpisok';
commit;
insert into OA_SYS_PARAM
  (p_id,
   p_type,
   p_code,
   p_name,
   p_content,
   p_valid,
   p_creator_time,
   p_isupdate,
   dictdata_id,
   p_remark)
values
  ('ca8910ee-9822-4bb7-862b-c4ebd9573c97',
   '1',
   'tmpisok',
   '会议暂存是否为预约成功',
   '0',
   '1',
   to_date('30-07-2013 10:23:03', 'dd-mm-yyyy hh24:mi:ss'),
   '1',
   '21',
   '0暂存的会议时间段不会占用，可以允许使用' || chr(13) || '1暂存的会议时间段会被占用，不允许再被使用。');
commit;