create or replace view m_v_yj_d as
select mid as YJ_ID,
       title as YJ_BT,
       to_char(to_date(createtime, 'yyyy-mm-dd hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss') as YJ_CJSJ, --邮件创建时间
       receivepname as YJ_JSR,
       receivepid as YJ_JSRID,
       sendpname as YJ_FSR,
       sendpid as YJ_FSRID,
       (select count(1) from oa_fc_attach fa where trim(fa.djbh)=trim(attachment_id)) YJ_FJSL,
       attachment_id as YJ_FJID,
       content as YJ_ZW,
       a.state YJ_SFYX
  from (select tt.mid,
               tt.attachment_id,
               tt.createtime,
               tt.dxtzjsr,
               tt.content,
               tt.title,
               t.receivepid,
               t.receivepname,
               tt.sendpid,
               tt.sendpname,
               tt.state
          from ymj_oa_jbxx_mail tt, (select mid,wmsys.wm_concat(receivepid) receivepid,wmsys.wm_concat(receivepname) receivepname from ymj_oa_user_mail group by mid) t
         where 1 = 1
           and tt.mid = t.mid) a;
