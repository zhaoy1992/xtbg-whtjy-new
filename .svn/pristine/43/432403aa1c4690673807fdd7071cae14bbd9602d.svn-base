create or replace view m_v_bs_a as
select
       t.submittedinfo_id as bs_id,--报送ID
       t.andit_person as BS_PSR,--批示人
       t.andit_opinion as BS_PSYJ,--意见
       o.submittedinfo_typename as zt,--状态
       t.andit_person_id as BS_PSRID,--批示人ID
       to_char(t.andit_time,'yyyy-mm-dd hh24:mi:ss') BS_PSSJ --批示时间(fu  改)
  from ta_oa_infre_audit t
 inner join ta_oa_infre_submittedinfo_type o on to_number(t.andit_state) =
                                                to_number(o.submittedinfo_typecode)
 where t.andit_opinion is not null
 order by t.andit_time desc

/**
* 描述:[张家界 信息报送的视图  批示列表]
* 参数列表:
* 1  bs_id     报送ID
* 2  BS_PSR    批示人
* 3  BS_PSYJ   批示意见
* 4  zt        状态
* 5  BS_PSRID  批示人ID
* 6  BS_PSSJ   批示时间
* 时间:2013-8-30
* 作者:qiul.ian
*/;




create or replace view m_v_bs_d as
select  t.submittedinfo_id as bs_id,--报送id
         o.org_name as bs_fsdw,    --报送发送单位
         to_char(t.input_date, 'yyyy-mm-dd hh24:mi') as bs_sj,--报送时间
         t.submit_content as bs_zw, --报送正文
         e.infotype_name as bs_xxlx--报送类型
    from ta_oa_infre_submitted_info t
    left join ta_oa_infre_info_type e on e.infotype_id = t.infotype_id
   inner join td_sm_organization o on o.org_id = t.department_id

/**
* 描述:[张家界 信息报送的视图  报送详情]
* 参数列表:
* 1  bs_id     报送id
* 2  bs_fsdw   报送发送单位
* 3  bs_sj     报送时间
* 4  bs_xxlx   报送类型
* 5  bs_zw     报送正文
* 时间:2013-9-04
* 作者:qiul.ian
*/;




create or replace view m_v_bs_p as
select
       t.submittedinfo_id as bs_id,--报送ID
       t.andit_person_id as jsr_id,--接收人ID
       t.andit_person as jsr,--接收人
       t.andit_opinion as yj,--意见
       o.submittedinfo_typename as zt,--状态
       to_char(t.andit_time,'yyyy-mm-dd hh24:mi:ss') pssj --批示时间
  from ta_oa_infre_audit t
 inner join ta_oa_infre_submittedinfo_type o on to_number(t.andit_state) =
                                                to_number(o.submittedinfo_typecode)
 where t.andit_opinion is not null
 order by t.andit_time desc

/**
* 描述:[张家界 信息报送的视图  批示列表]
* 参数列表:
* 1  bs_id     报送ID
* 2  jsr_id    接收人ID
* 3  jsr       接收人
* 4  yj        意见
* 5  zt        状态
* 6  pssj      批示时间
* 时间:2013-8-30
* 作者:qiul.ian
*/;

create or replace view m_v_bs_r as
select distinct (t.submittedinfo_id) as bs_id, --报送id
                        t.submittedinfo_title as bs_bt,--报送标题
                        t.input_date as input_date, --录入时间
                        o.org_name as bs_jg,       --报送机构
                          b.submittedinfo_typename as bs_zt,    --报送状态
                        (select to_char(max(a.andit_time),'yyyy-mm-dd hh24:mi:ss')
                           from ta_oa_infre_audit a
                          where a.submittedinfo_id = t.submittedinfo_id
                            and a.andit_state = '6'
                          group by a.submittedinfo_id) as bs_sj ,--报送时间
                        info_type.infotype_name as bs_lx, --报送类型
                        t.inputuser_name as bs_bsr, --报送发起人
                        u.andit_person_id as bs_jsrid,--报送接收人id
                      ( select count(*)  from ta_oa_infre_audit audits
                                      inner join ta_oa_infre_submittedinfo_type o on to_number(audits.andit_state) =
                                                                    to_number(o.submittedinfo_typecode)
                                                where audits.submittedinfo_id = t.submittedinfo_id
                                                  and audits.andit_opinion is not null
                                                  and audits.andit_person_id = u.andit_person_id ) as pssl  --批示条数
          from ta_oa_infre_submitted_info t
         inner join ta_oa_infre_audit u on u.submittedinfo_id =
                                           t.submittedinfo_id
         inner join ta_oa_infre_submittedinfo_type b on b.submittedinfo_typecode =
                                                        to_number(u.andit_state)
         inner join td_sm_organization o on o.org_id = t.department_id
         inner join ta_oa_infre_info_type info_type on t.infotype_id = info_type.infotype_id
         where  u.andit_state in ('7', '8', '9')
 order by input_date desc
/**
* 描述:[张家界 信息报送的视图  收到的信息报送列表]
* 参数列表:
* 1  BS_ID     报送id
* 2  BS_BT     报送标题
* 3  BS_JG     报送机构
* 4  BS_ZT     报送状态
* 5  BS_SJ     报送时间
* 6  BS_LX     报送类型
* 7  BS_BSR    报送发起人
* 8  BS_JSRID  报送接收人id
* 时间:2013-8-30
* 作者:qiul.ian
*/;



create or replace trigger MTP_ZZJ_INFOREPORTED_PISHI
  after insert
/**
* 张家界  信息报送 批示回复新增
  描述:手机端中间表(M_T_BS_HF)触发==>PC端 会议管理 批示(ta_oa_infre_submitted_info)
**/
ON M_T_BS_HF
  FOR EACH ROW
DECLARE
  bs_zt varchar2(50);--信息报送状态
  submittedinfo varchar2(10);--临时信息报送状态
BEGIN
  --新增
  IF INSERTING  THEN
    --查询信息报送状态
    select andit_state into bs_zt  from ta_oa_infre_audit t where t.submittedinfo_id=:new.BS_ID and t.andit_person_id=:new.BS_HFRID;
     --信息报送  未查看改为已查看
     if (bs_zt =7 ) then
        submittedinfo:='8';
        
         update ta_oa_infre_submitted_info
             set  submittedinfo_typecode = submittedinfo
            where submittedinfo_id =:new.BS_ID;
        --意见信息表
       insert into ta_oa_infre_audit
          (audit_id,
           submittedinfo_id,
           andit_source,
           andit_person,
           andit_opinion,
           andit_state,
           andit_time,
           andit_person_id)
        values
          (seq_infre_audit.nextval,
           :new.BS_ID,
           '01',
           (select t.user_realname
              from td_sm_user t
             where t.user_id = :new.BS_HFRID),
           :new.BS_NR,
           submittedinfo,
           sysdate,
           :new.BS_HFRID);
           
         --删除意见信息
         delete ta_oa_infre_audit  where andit_state = '7' and submittedinfo_id = :new.BS_ID and andit_person_id = :new.BS_HFRID;
     end if;
      --信息报送  已查看改为已批示
     if (bs_zt=8 and :new.BS_NR is not null) then
        submittedinfo:='9';    
        
         update ta_oa_infre_submitted_info
             set  submittedinfo_typecode = submittedinfo
            where submittedinfo_id =:new.BS_ID;
       --意见信息表
       insert into ta_oa_infre_audit
          (audit_id,
           submittedinfo_id,
           andit_source,
           andit_person,
           andit_opinion,
           andit_state,
           andit_time,
           andit_person_id)
        values
          (seq_infre_audit.nextval,
           :new.BS_ID,
           '01',
           (select t.user_realname
              from td_sm_user t
             where t.user_id = :new.BS_HFRID),
           :new.BS_NR,
           submittedinfo,
           sysdate,
           :new.BS_HFRID);
           
         --删除意见信息
         delete ta_oa_infre_audit  where andit_state = '8' and submittedinfo_id = :new.BS_ID and andit_person_id = :new.BS_HFRID;
     end if;

   end if;
   
END MTP_ZZJ_INFOREPORTED_PISHI;







create or replace trigger "PTMX_ZJJ_INOREPORTED_BASEINFO"
after insert or delete or update
/**
 * 原触发器:PTMX_ZJJ_INOREPORTED_BASEINFO  张家界信息报送  主表推送
 * QIU.LIAN
 * 2013-9-9
 */
ON ta_oa_infre_submitted_info
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
                values(new_wait_id, :new.SUBMITTEDINFO_ID,'baosong','',:new.SUBMITTEDINFO_TITLE,sysdate,'c');
      end if;
    end if;
END PTMX_ZJJ_INOREPORTED_BASEINFO;




create or replace trigger PTMX_ZJJ_INOREPORTED_AUDIT
after insert or delete or update
/**
 * 原触发器:PTMX_ZJJ_INOREPORTED_AUDIT  张家界信息报送  从表推送
 * QIU.LIAN
 * 2013-9-9
 */
ON ta_oa_infre_audit
  FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
BEGIN
select max(wait_id) wait_id into new_wait_id from m_aa_wait where business_id = :new.SUBMITTEDINFO_ID;

     if INSERTING then
        insert into m_aa_uf(user_id,wait_id)
        values(:new.ANDIT_PERSON_ID ,new_wait_id );
    end if;
END PTMX_ZJJ_INOREPORTED_AUDIT;



