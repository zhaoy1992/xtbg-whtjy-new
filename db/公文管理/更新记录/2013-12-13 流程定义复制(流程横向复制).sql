CREATE OR REPLACE PROCEDURE p_oa_flow_definfo_copy(
       v_oa_flow_baseinfo_id_a  in varchar2,--被复制的流程基本信息ID
       v_oa_flow_baseinfo_id_b  in varchar2,--被修改的流程基本信息ID
       v_out_flow_defid         out varchar2,--修改后 新的流程定义ID
       v_out_flow_version       out varchar2,--修改后 新的流程版本
       v_out_package_id         out varchar2,--修改后 新的流程包ID
       v_flag                   out varchar2 --true|false:成功 或 失败
) as
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
 * 流程管理-流程定义横向复制
 * 支持(FlowInfoDaoImpl.copyFlowDefInfo())
 * tuo.zou
 * 2013-12-12
 * 1,将流程v_oa_flow_baseinfo_id_b的有效流程定义数据 设置为无效
 * 2,将流程v_oa_flow_baseinfo_id_a的有效流程定义数据 复制到v_oa_flow_baseinfo_id_b
 * 2,复制流程定义信息
 * 3,获得新老流程定义ID
 * 4,复制活动环节数据
 * 5,赋值
 */
begin
   v_flag := 'false';
   --1
   update oa_flow_definfo
      set is_valid = 'N'
    where flow_id = v_oa_flow_baseinfo_id_b;
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
             v_oa_flow_baseinfo_id_b,
             flow_version,
             package_id,
             is_valid,
             SYSDATE,
             flow_desc
        from oa_flow_definfo ofd
       where flow_id = v_oa_flow_baseinfo_id_a
         and ofd.is_valid = 'Y'
         and rownum = 1;
   --3
   select def_id into v_old_oa_flow_definfo_id from oa_flow_definfo ofd where ofd.flow_id = v_oa_flow_baseinfo_id_a and ofd.is_valid = 'Y';
   select def_id into v_new_oa_flow_definfo_id from oa_flow_definfo ofd where ofd.flow_id = v_oa_flow_baseinfo_id_b and ofd.is_valid = 'Y';

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

       --5
       select ofd.flow_defid
            , ofd.flow_version
            , ofd.package_id
         into v_out_flow_defid
            , v_out_flow_version
            , v_out_package_id
         from oa_flow_definfo ofd
        where ofd.flow_id = v_oa_flow_baseinfo_id_b
          and ofd.is_valid = 'Y';

       v_flag := 'true';
   end if;

end;
/


-- Add/modify columns 
alter table OA_FLOW_INSTANCE add PARENT_INS_ID VARCHAR2(50);
-- Add comments to the columns 
comment on column OA_FLOW_INSTANCE.PARENT_INS_ID
  is '开启该流程的父流程';
