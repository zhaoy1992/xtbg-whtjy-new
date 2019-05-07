create or replace view m_v_jb_d as
select t.submittedinfo_id as JB_ID, --简报id
         t.submittedinfo_title as JB_BT,--简报标题
         t.submit_content as JB_ZW, --简报正文
         to_char(t.input_date,'yyyy-mm-dd hh24:mi:ss') as JB_SJ --简报发送时间
    from sx_ta_oa_infre_submitinfo t
    left join sx_ta_oa_infre_info_type e on e.infotype_id = t.infotype_id
   inner join td_sm_organization o on o.org_id = t.department_id

/**
* 描述:[苏仙 工作简报的视图  单位简报详细列表]
* 参数列表:
* 1  JB_ID      简报id
* 2  JB_BT      简报标题
* 3  JB_SJ      简报时间
* 4  JB_ZW      简报正文
* 时间:2013-9-03
* 作者:qiul.ian
*/;




create or replace view m_v_jb_r as
select distinct (t.submittedinfo_id) as JB_ID,         --简报id
                            t.submittedinfo_title as JB_BT,--简报标题
                            to_char(t.input_date,'yyyy-mm-dd hh24:mi:ss') as JB_SJ, --简报时间
                            p.infotype_name as JB_LX,        --简报类型
                            b.submittedinfo_typename as JB_ZT, --简报状态
                            u.andit_person_id as JB_JSRID,  --简报接收人id
                            t.inputuser_id,
                            t.inputuser_name,
                            t.department_id,
                            t.infotype_id,
                            o.org_name,
                            t.is_recommend,
                            u.andit_state,
                            u.audit_id
              from sx_ta_oa_infre_submitinfo t
             inner join sx_ta_oa_infre_audit u on u.submittedinfo_id =
                                                  t.submittedinfo_id
             inner join sx_ta_oa_infre_info_type p on t.infotype_id =
                                                      p.infotype_id
             inner join sx_ta_oa_infre_submitinfo_type b on b.submittedinfo_typecode =
                                                            to_number(u.andit_state)
             inner join td_sm_organization o on o.org_id = t.department_id
             where  (u.is_valid <> '1' or u.is_valid is null)
               and ((t.is_valid <> '1') or (t.is_valid is null))
               and u.andit_state in ('7', '8', '9')
     order by JB_SJ desc
/**
* 描述:[苏仙 工作简报的视图  单位简报接收列表]
* 参数列表:
* 1  JB_ID      简报id
* 2  JB_BT      简报标题
* 3  JB_SJ      简报时间
* 4  JB_LX      简报类型
* 5  JB_ZT      简报状态
* 6  JB_JSRID   简报接收人id
* 时间:2013-9-03
* 作者:qiul.ian
*/;


create or replace view m_v_jb_s as
select distinct (t.submittedinfo_id) as JB_ID,  --简报id
                          t.submittedinfo_title as JB_BT, --简报标题
                          to_char(t.input_date,'yyyy-mm-dd hh24:mi:ss') as JB_SJ,--简报时间
                          t1.infotype_name as JB_LX,      --简报类型
                          b.submittedinfo_typename as JB_ZT,--简报状态
                           t.inputuser_id as JB_FSRID       --简报发送人id

            from sx_ta_oa_infre_submitinfo t
           inner join sx_ta_oa_infre_audit u on u.submittedinfo_id =
                                                t.submittedinfo_id
           inner join sx_ta_oa_infre_submitinfo_type b on b.submittedinfo_typecode =
                                                          to_number(u.andit_state)
           inner join td_sm_organization o on o.org_id = t.department_id
           inner join sx_ta_oa_infre_info_type t1 on t1.infotype_id =
                                                     t.infotype_id
           where u.andit_person_id = t.inputuser_id
             and ((t.is_valid <> '1') or (t.is_valid is null))
             and u.andit_state in ('6')
   order by JB_SJ desc

/**
* 描述:[苏仙 工作简报的视图  单位简报已发送列表]
* 参数列表:
* 1  JB_ID      简报id
* 2  JB_BT      简报标题
* 3  JB_SJ      简报时间
* 4  JB_LX      简报类型
* 5  JB_ZT      简报状态
* 6  JB_FSRID   简报发送人id
* 时间:2013-9-03
* 作者:qiul.ian
*/;




create or replace trigger PTMX_SX_JB_BASEINFO
after insert or delete or update
/**
 * 原触发器:PTMX_SX_JB_BASEINFO 苏仙工作简报 主表推送
 * QIU.LIAN
 * 2013-9-9
 */
ON sx_ta_oa_infre_submitinfo
  FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
BEGIN
select seq_android_wait.nextval into new_wait_id from dual;
   --新增与更新
    if INSERTING or UPDATING  then
       --pc端草稿列表的数据发布直接发布
       if :new.SUBMITTEDINFO_TYPECODE='7' or :new.SUBMITTEDINFO_TYPECODE='6' then
        insert into m_aa_wait(wait_id, business_id, business_type,title,content,create_time,curd_type)
                values(new_wait_id, :new.SUBMITTEDINFO_ID,'jianbao','',:new.SUBMITTEDINFO_TITLE,sysdate,'c');
      end if;
    end if;
END PTMX_SX_JB_BASEINFO;



create or replace trigger PTMX_SX_JB_AUDIT
after insert or delete or update
/**
 * 原触发器:PTMX_SX_JB_AUDIT  苏仙工作简报  从表推送
 * QIU.LIAN
 * 2013-9-9
 */
ON sx_ta_oa_infre_audit
  FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
BEGIN
select max(wait_id) wait_id into new_wait_id from m_aa_wait where business_id = :new.submittedinfo_id;

     if INSERTING then
        insert into m_aa_uf(user_id,wait_id)
        values(:new.andit_person_id ,new_wait_id );
    end if;
END PTMX_SX_JB_AUDIT;
