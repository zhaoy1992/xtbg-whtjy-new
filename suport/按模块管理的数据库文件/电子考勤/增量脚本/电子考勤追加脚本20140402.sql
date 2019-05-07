insert into TD_SM_ROLE (ROLE_ID, ROLE_NAME, ROLE_TYPE, ROLE_DESC, ROLE_USAGE, REMARK1, REMARK2, REMARK3, OWNER_ID)
values (SEQ_TD_SM_ROLE.NEXTVAL, '考勤管理员', '1', '考勤管理员', '', '', '', '', 1);


insert into sx_ta_oa_electcheck_state (STATUS_ID, STATUS_NAME)
values ('6', '外勤');


commit;



create or replace function fn_ipTonumber(ip in varchar2) return varchar2 as
  v_ip_1   number;
  v_ip_2   number;
  v_ip_3   number;
  v_ip_4   number;
  v_result number;
begin
  select to_number(substr(ip, 1, instr(ip, '.', 1, 1) - 1)),
         to_number(substr(ip,
                          instr(ip, '.', 1, 1) + 1,
                          instr(ip, '.', 1, 2) - instr(ip, '.', 1, 1) - 1)),
         to_number(substr(ip,
                          instr(ip, '.', 1, 2) + 1,
                          instr(ip, '.', 1, 3) - instr(ip, '.', 1, 2) - 1)),
         to_number(substr(ip,
                          instr(ip, '.', 1, 3) + 1,
                          length(ip) - instr(ip, '.', 1, 3)))
    into v_ip_1, v_ip_2, v_ip_3, v_ip_4
    from dual;
  v_result := v_ip_1 * 256 * 256 * 256 + v_ip_2 * 256 * 256 + v_ip_3 * 256 +
              v_ip_4;
  return v_result;
end;



create table TA_OA_WORKIP 
(
   WORKIP_ID            VARCHAR2(50)                   not null,
   WORKIP_START_IP      VARCHAR2(50)                   null,
   WORKIP_END_IP        VARCHAR2(50)                   null,
   constraint PK_TA_OA_WORKIP primary key clustered (WORKIP_ID)
);

comment on table TA_OA_WORKIP is 
'办公IP表';

comment on column TA_OA_WORKIP.WORKIP_ID is 
'主键ID';

comment on column TA_OA_WORKIP.WORKIP_START_IP is 
'办公起始IP';

comment on column TA_OA_WORKIP.WORKIP_END_IP is 
'办公结束IP';

