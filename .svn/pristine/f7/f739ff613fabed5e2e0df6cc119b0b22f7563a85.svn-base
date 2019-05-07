create or replace view m_v_jd_1 as
select gi.grinfo_titile,
       gi.grinfo_receptionorg,
       gi.grinfo_dutyofficer,
       gi.grinfo_dutyofficerid,
       to_char(gi.grinfo_startime, 'yyyy-MM-dd HH24:mi') as grinfo_startime,
       to_char(gi.grinfo_endtime, 'yyyy-MM-dd HH24:mi') as grinfo_endtime,
       gi.grinfo_tel,
       gi.grinfo_guestcontact,
       gi.grinfo_content,
       gi.grinfo_guestphone,
       gi.grinfo_id
  from ta_oa_guestreception_info gi;

  
  
  create or replace view m_v_jd_2 as
select gt.grinfo_id,
         gt.tstarttime||' '||gt.ttstarttime tstarttime,
         gt.fromcontent,
         gt.place,
         gt.accompany,
         gt.accompanyid,
         gt.remark1
          from ta_oa_guesttravel gt
         order by gt.tstarttime asc;

         
         
 create or replace view m_v_jd_3 as
select "PID","GRINFO_ID","PTUSERNAME","PTUSERID","PTSEX","PTPOST","REMARK1","REMARK2","CREATTIME" from TA_OA_GUESTRECEIVE t where t.ptusername is not null
and t.ptuserid is not null and t.ptsex is not null and t.ptpost is not null;





create or replace view m_v_jd_r as
select distinct a.grinfo_id as jd_id,--接待id
                a.grinfo_titile as jd_zt,--接待主题
                a.grinfo_createtime as jd_cjsj,--接待主题
                a.grinfo_startime as jd_kssj,
                a.grinfo_endtime as jd_jssj,
                c.userid as jd_jsr--接收人
  from ta_oa_guestreception_info  a,
       ta_oa_guestreception_type  b,
       ta_oa_guestinforeceivelist c,
       td_sm_user                 u
 where a.grinfo_id = c.grinfo_id
   and b.grstatus_id = c.static
   and a.grinfo_sendpersonid = u.user_id
 order by a.grinfo_createtime desc;

 
 
 
 create or replace trigger PTMX_CZ_LB_BASEINFO
after insert or delete or update
/**
 * 原触发器:PTMX_CZ_LB_BASEINFO  郴州 来宾接待 主表推送
 * QIU.LIAN
 * 2013-9-9
 */
ON ta_oa_guestreception_info
  FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
BEGIN
select seq_android_wait.nextval into new_wait_id from dual;
   --新增与更新
    if INSERTING or UPDATING  then
       --pc端草稿列表的数据发布直接发布
       if :new.grstatus_id='2' then
        insert into m_aa_wait(wait_id, business_id, business_type,title,content,create_time,curd_type)
                values(new_wait_id, :new.grinfo_id,'jiedai','',:new.grinfo_titile,sysdate,'c');
      end if;
    end if;
END PTMX_CZ_LB_BASEINFO;



create or replace trigger PTMX_CZ_LB_AUDIT
after insert or delete or update
/**
 * 原触发器:PTMX_CZ_LB_AUDIT  郴州来宾接待  从表推送
 * QIU.LIAN
 * 2013-9-9
 */
ON ta_oa_guestreceive
  FOR EACH ROW
DECLARE
  new_wait_id VARCHAR(50);
BEGIN
select max(wait_id) wait_id into new_wait_id from m_aa_wait where business_id = :new.grinfo_id;

     if INSERTING then
        insert into m_aa_uf(user_id,wait_id)
        values(trim(:new.PTUSERID) ,new_wait_id );
    end if;
END PTMX_CZ_LB_AUDIT;
