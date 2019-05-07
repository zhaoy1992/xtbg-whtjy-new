/**复制问卷操作的存储过程
 *作者：戴连春
 *日期：2013-05-23
 *参数：v_paper_id 要被复制的问卷id
 *      v_user_id  复制问卷的用户id
 *      v_user_name  复制问卷的用户名
 *      v_org_id  用户所属机构id
 *      v_org_name  用户所属机构名
 *      v_outPaper_id 新的问卷id(输出参数)
 */
create or replace PROCEDURE copyPaper(v_paper_id    in varchar2,
                                      v_user_id     in varchar2,
                                      v_user_name   in varchar2,
                                      v_org_id      in varchar2,
                                      v_org_name    in varchar2,
                                      v_outPaper_id out varchar2) as
  v_newPaperId    varchar2(40) := sys_guid(); --新的问卷id
  v_newQuestionId varchar2(40); --新的问题id
  --要复制的问卷对应的问题
  CURSOR questionList IS
    select id,
           title,
           direction,
           answer,
           v_newPaperId as paper_id,
           type_id,
           order_no,
           status
      from oa_vote_question
     where paper_id = v_paper_id;

begin

  --首先复制一个问卷,（默认将状态设置为未发布，创建时间设置为当前时间）
  insert into oa_vote_paper
    (id,
     title,
     fu_title,
     stauts,
     direction,
     creatdate,
     startdate,
     enddate,
     istop,
     org_id,
     org_name,
     user_id,
     user_name,
     papaer_type,
     people_names,
     eval_userids,
     eval_usernames,
     people_ids,
     is_send,
     message_content)
    select v_newPaperId as id,
           title,
           fu_title,
           '0' as stauts,
           direction,
           sysdate as creatdate,
           startdate,
           enddate,
           istop,
           v_org_id  as org_id,
            v_org_name as org_name,
           v_user_id as user_id,
           v_user_name as user_name,
           papaer_type,
           people_names,
           eval_userids,
           eval_usernames,
           people_ids,
           is_send,
           message_content
      from oa_vote_paper
     where id = v_paper_id;

  --复制问卷对应的所有被测评人员
  insert into oa_vote_eval_list
    (paper_id, user_id, user_name, order_no)
    select v_newPaperId as paper_id, user_id, user_name, order_no
      from oa_vote_eval_list
     where paper_id = v_paper_id;

  --复制问卷对应的所有投票人员，且将所有投票装填置为“未投票”，投票时间设置为null
  insert into oa_vote_user_contorl
    (id, user_id, paper_id, messages, complete, user_name, answertime)
    select sys_guid() as id,
           user_id,
           v_newPaperId as paper_id,
           messages,
           '0' as complete,
           user_name,
           null as answertime
      from oa_vote_user_contorl
     where paper_id = v_paper_id;

  --循环复制问题及问题选项
  FOR c_question IN questionList LOOP
    --复制新的问题id
    v_newQuestionId := sys_guid();
    insert into oa_vote_question
      (id, title, direction, answer, paper_id, type_id, order_no, status)
    values
      (v_newQuestionId,
       c_question.title,
       c_question.direction,
       c_question.answer,
       c_question.paper_id,
       c_question.type_id,
       c_question.order_no,
       c_question.status);
  
    --复制选项
    insert into oa_vote_question_option
      (id, question_id, content, option_code, check_max)
      select sys_guid() as id,
             v_newQuestionId as question_id,
             content,
             option_code,
             check_max
        from oa_vote_question_option
       where question_id = c_question.id;
  
  end loop;
  v_outPaper_id := v_newPaperId;
end copyPaper;
/