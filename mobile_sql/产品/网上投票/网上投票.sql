create or replace view m_v_tp_r as
select a.id  TP_ID,
       a.title TP_BT,
       c.name TP_LX,
       a.user_name TP_CJR,
       a.org_name TP_CJRDW,
       to_char(a.creatdate,'yyyy-mm-dd hh24:mi:ss') TP_CJSJ,
       to_char(a.enddate,'yyyy-mm-dd hh24:mi:ss') TP_JZSJ,
       decode(b.complete, 0, '未投票', '已投票') TP_ZT,
       b.user_id TP_JRSID,
       (select count(1) from oa_vote_user_contorl c where a.id = c.paper_id ) as  TP_CYRS
  from oa_vote_paper a left join oa_vote_paper_type c on a.papaer_type=c.id, oa_vote_user_contorl b
 where a.id = b.paper_id and a.stauts = '1';
/

create or replace view M_V_TP_T as
select a.paper_id TP_ID,
       a.id TP_TMID,
       a.title TP_TMMC,
       decode(b.name,'多项选择','C','R') TP_TYPE,
       decode(a.answer, '1', 'Y', 'N') TP_SFBD,
       a.order_no TP_PXH
  from oa_vote_question a left join oa_vote_question_type b on a.type_id=b.id
 where a.status = '1';
 /
 create or replace view M_V_TP_X as
select a.id TP_TMXXID,
       a.question_id TP_TMID,
       a.option_code TP_TMXX,
       a.content     TP_TMXXMS,
       ((select count(1) from oa_vote_question_answer b where b.selectid=a.id)
         /(select decode(count(1),0,1,count(1)) from oa_vote_question_answer c where c.question_id=a.question_id))*100 TP_TMXXBFB,
       CHECK_MAX TP_ZDKXS
  from oa_vote_question_option a ;
  /
  
  create or replace trigger mobile_M_T_TP after insert or update
/**
*类型:网上投票添加触发器
*作者:戴连春
**/
ON M_T_TP
FOR EACH ROW
  
declare question_ids varchar(1000) := :new.TP_TMXXID;--选项id
          v_id varchar(50) ;
BEGIN
    IF INSERTING  THEN --新增
        loop --循环解析选项(多选放到一个里面用逗号隔开的)
        if instr(question_ids,',')>0 then
          v_id := substr(question_ids,0,instr(question_ids,',')-1);
          question_ids := substr(question_ids,instr(question_ids,',')+1,length(question_ids)-1);
          if v_id is not null then
             insert into oa_vote_question_answer
                 (id, uesr_id, paper_id, question_id, eval_user_id, selectid, answer_content)
               values
                 (sys_guid(), :new.YH_ID, :new.TP_ID, :new.TP_TMID, '', v_id, '');
               --更新用户的投票状态，已经进行了投票
              update oa_vote_user_contorl b set b.complete='1' ,b.answertime = sysdate
                 where b.paper_id=:new.TP_ID and b.user_id=:new.YH_ID  and b.complete='0';
          end if;

        else --只填写了一个选项，或最后一个选项，则直接插入
          if question_ids is not null then
               insert into oa_vote_question_answer
                 (id, uesr_id, paper_id, question_id, eval_user_id, selectid, answer_content)
               values
                 (sys_guid(), :new.YH_ID, :new.TP_ID, :new.TP_TMID, '', question_ids, '');
               --更新用户的投票状态，已经进行了投票
               update oa_vote_user_contorl b set b.complete='1' ,b.answertime = sysdate
                 where b.paper_id=:new.TP_ID and b.user_id=:new.YH_ID and b.complete='0';
          end if;
          exit;

        end if;


        end loop;

    end if;
END mobile_M_T_TP;
/

create or replace trigger mobile_oa_vote_paper after insert or update
/**
*类型:网上投票添加触发器
*作者:戴连春
**/
ON oa_vote_paper
FOR EACH ROW
declare v_wait_id varchar2(50);
BEGIN
    select  sys_guid() into v_wait_id from dual;
    IF INSERTING  THEN --新增
       if :new.stauts = '1'then --如果是发布，则插入数据
          insert into M_AA_WAIT (wait_id, business_id, business_type, content,CREATE_TIME,  curd_type)
              values(v_wait_id ,:new.id,'toupiao',:new.title,sysdate,'c');
         -- insert into M_AA_UF (WAIT_ID,USER_ID) values(v_wait_id,:new.USER_ID);
       end if;
    end if;
    if updating then
       --由暂存更改为发布，插入数据
       if :old.stauts <>'1' and :new.stauts ='1' then
           insert into M_AA_WAIT (wait_id, business_id, business_type, content,CREATE_TIME,  curd_type)
              values(v_wait_id ,:new.id,'toupiao',:new.title,sysdate,'c');
          --insert into M_AA_UF (WAIT_ID,USER_ID) values(v_wait_id,:new.USER_ID);
       end if;
    end if;

END mobile_oa_vote_paper;
/
create or replace trigger mobile_oa_vote_user_contorl after insert or update
/**
*类型:网上投票添加触发器
*作者:戴连春
**/
ON oa_vote_user_contorl
FOR EACH ROW
declare v_wait_id varchar2(50);
BEGIN
    select  max(wait_id) into v_wait_id from M_AA_WAIT where business_id=:new.paper_id;
    IF INSERTING  THEN --新增
       --if v_wait_id is not null then    --只有业务表中已经存在数据，才触发
          insert into M_AA_UF (WAIT_ID,USER_ID) values(v_wait_id,:new.USER_ID);
      -- end if;
    end if;
END mobile_oa_vote_user_contorl;
/