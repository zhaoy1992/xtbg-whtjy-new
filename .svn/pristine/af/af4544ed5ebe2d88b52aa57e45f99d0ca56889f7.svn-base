CREATE OR REPLACE PROCEDURE p_oa_flow_baseinfo_copy(
       v_old_oa_flow_baseinfo_id  in varchar2,
       v_out_oa_flow_baseinfo_id out varchar2) as
  v_new_oa_flow_baseinfo_id      varchar2(40) := sys_guid();
  v_old_oa_flow_definfo_id       varchar2(40);
  v_new_oa_flow_definfo_id       varchar2(40);
  v_old_oa_flow_wfaction_id      varchar2(40);
  v_new_oa_flow_wfaction_id      varchar2(40);
  CURSOR c_oa_flow_wfaction IS
    select action_id,
         def_id,
         action_defid,
         action_name,
         action_alias,
         action_limit,
         limit_unit,
         actiontype_code,
         remark,
         create_time
    from oa_flow_wfaction ofw
   where ofw.def_id = v_old_oa_flow_definfo_id;
/**
 * 流程管理-文档模板管理-复制模板
 * 支持(FlowInfoDaoImpl.copyFlowInfo())
 * tuo.zou
 * 2013-11-28
 * 1,复制流程基本信息oa_flow_baseinfo
 * 2,复制流程定义信息
 * 3,获得新老流程定义ID
 * 4,复制活动环节数据 
 */
begin
   --1
   insert into oa_flow_baseinfo
      (flow_id,
       busitype_code,
       business_id,
       flow_name,
       org_id,
       is_indivi,
       is_valid,
       flow_limit,
       limit_unit,
       create_time,
       from_path,
       is_text,
       insname_rule,
       flow_tyle,
       template_id,
       form_image_id,
       attach_id)
      select v_new_oa_flow_baseinfo_id,
             NULL,--copy busitype_code is null
             business_id,
             case when regexp_like(flow_name,'Copy\d{14}$')
                then substr(flow_name,0,instr(flow_name,'Copy',-1,1)-1)||'Copy'||(to_char(SYSDATE,'yyyyMMddhh24miss'))
                else substr(flow_name||'Copy'||(to_char(SYSDATE,'yyyyMMddhh24miss')),0,100)
             end,
             org_id,
             is_indivi,
             is_valid,
             flow_limit,
             limit_unit,
             SYSDATE,
             from_path,
             is_text,
             insname_rule,
             flow_tyle,
             template_id,
             NULL,
             sys_guid()
        from oa_flow_baseinfo ofb
       where ofb.flow_id = v_old_oa_flow_baseinfo_id;
   --2
   insert into oa_flow_definfo
      (flow_defid,
       def_id,
       flow_id,
       flow_version,
       package_id,
       is_valid,
       create_time,
       flow_desc)
      select flow_defid,
             sys_guid(),
             v_new_oa_flow_baseinfo_id,
             flow_version,
             package_id,
             is_valid,
             SYSDATE,
             flow_desc
        from oa_flow_definfo ofd
       where flow_id = v_old_oa_flow_baseinfo_id
         and ofd.is_valid = 'Y'
         and rownum = 1;

   --3
   select def_id into v_old_oa_flow_definfo_id from oa_flow_definfo ofd where ofd.flow_id = v_old_oa_flow_baseinfo_id and ofd.is_valid = 'Y';
   select def_id into v_new_oa_flow_definfo_id from oa_flow_definfo ofd where ofd.flow_id = v_new_oa_flow_baseinfo_id;

   --4
   if (v_new_oa_flow_definfo_id is not null
      and v_old_oa_flow_definfo_id is not null)
     then
       for onerow in c_oa_flow_wfaction loop
         --4.1
         v_old_oa_flow_wfaction_id := onerow.action_id;
         v_new_oa_flow_wfaction_id := sys_guid();
          insert into oa_flow_wfaction
            (action_id,
             def_id,
             action_defid,
             action_name,
             action_alias,
             action_limit,
             limit_unit,
             actiontype_code,
             remark,
             create_time)
          values
            (v_new_oa_flow_wfaction_id,
             v_new_oa_flow_definfo_id,
             onerow.action_defid,
             onerow.action_name,
             onerow.action_alias,
             onerow.action_limit,
             onerow.limit_unit,
             onerow.actiontype_code,
             onerow.remark,
             SYSDATE);
         --4.2 oa_act_col_stauts
          insert into oa_act_col_stauts
            (id,
             action_id,
             table_id,
             table_code,
             column_id,
             column_code,
             readonly,
             hidden,
             disable,
             required)
            select sys_guid(),
                   v_new_oa_flow_wfaction_id,
                   table_id,
                   table_code,
                   column_id,
                   column_code,
                   readonly,
                   hidden,
                   disable,
                   required
              from oa_act_col_stauts
             where action_id = v_old_oa_flow_wfaction_id;

         --4.3 oa_act_text_stauts
          insert into oa_act_text_stauts
            (id,
             action_id,
             is_trace,
             is_red,
             is_readonly,
             extend_attribute,
             extend_methods,
             msg_txt,
             is_msg,
             is_sign,
             is_keeptrace,
             is_attachment,
             is_serialnumber,
             is_gwzl,
             is_ckcg,
             is_ckzw,
             is_ckmq,
             is_singname,
             is_affix,
             remark1,
             is_xd,
             is_gwff,
             is_cd,
             is_cklc,
             is_newflow,
             is_gk,
             is_print,
             is_split,
             is_infotype,
             is_nbfs,
             is_doback)
            select sys_guid(),
                   v_new_oa_flow_wfaction_id,
                   is_trace,
                   is_red,
                   is_readonly,
                   extend_attribute,
                   extend_methods,
                   msg_txt,
                   is_msg,
                   is_sign,
                   is_keeptrace,
                   is_attachment,
                   is_serialnumber,
                   is_gwzl,
                   is_ckcg,
                   is_ckzw,
                   is_ckmq,
                   is_singname,
                   is_affix,
                   remark1,
                   is_xd,
                   is_gwff,
                   is_cd,
                   is_cklc,
                   is_newflow,
                   is_gk,
                   is_print,
                   is_split,
                   is_infotype,
                   is_nbfs,
                   is_doback
              from oa_act_text_stauts
             where action_id = v_old_oa_flow_wfaction_id;
         --4.4 OA_FLOW_WFACTUSER
          insert into oa_flow_wfactuser
            (wfactuser_id, action_id, user_id, user_name, actuser_type, create_time)
            select sys_guid(),
                   v_new_oa_flow_wfaction_id,
                   user_id,
                   user_name,
                   actuser_type,
                   create_time
              from oa_flow_wfactuser
             where action_id = v_old_oa_flow_wfaction_id;
         --4.5 OA_FLOW_ACTIONFROMDEFID
          insert into oa_flow_actionfromdefid
            (form_id, action_id, action_form)
            select sys_guid(), v_new_oa_flow_wfaction_id, action_form
              from oa_flow_actionfromdefid
             where action_id = v_old_oa_flow_wfaction_id;
         --4.6 OA_FLOW_ACTIONTREECONFIG
          insert into oa_flow_actiontreeconfig
            (config_id, action_id, tree_role, tree_nodetype)
            select sys_guid(), v_new_oa_flow_wfaction_id, tree_role, tree_nodetype
              from oa_flow_actiontreeconfig
             where action_id = v_old_oa_flow_wfaction_id;
         --4.7 OA_FLOW_WFACTIONEXT
          insert into oa_flow_wfactionext
            (actionext_id,
             action_id,
             isshowuser,
             isshowreject,
             create_time,
             isshowback,
             autoassignment,
             issignjoinbyorder,
             isdispense)
            select sys_guid(),
                   v_new_oa_flow_wfaction_id,
                   isshowuser,
                   isshowreject,
                   create_time,
                   isshowback,
                   autoassignment,
                   issignjoinbyorder,
                   isdispense
              from oa_flow_wfactionext
             where action_id = v_old_oa_flow_wfaction_id;
       end loop;
   end if;
   
   v_out_oa_flow_baseinfo_id := v_new_oa_flow_baseinfo_id;
end;
/