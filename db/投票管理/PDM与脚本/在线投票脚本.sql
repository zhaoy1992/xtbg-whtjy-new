--删除表
drop table oa_vote_eval_list cascade constraints;
drop table oa_vote_user_contorl cascade constraints;
drop table oa_vote_question_answer cascade constraints;
drop table oa_vote_question_option cascade constraints;
drop table oa_vote_question cascade constraints;
drop table oa_vote_paper cascade constraints;
drop table oa_vote_paper_type cascade constraints;
drop table oa_vote_question_type cascade constraints;



-- Create 问卷类型表
create table OA_VOTE_PAPER_TYPE
(
  ID   VARCHAR2(40) not null,
  NAME VARCHAR2(40) not null,
  CODE VARCHAR2(40) not null
);
-- Add comments to the table 
comment on table OA_VOTE_PAPER_TYPE
  is '问卷类型表';
-- Add comments to the columns 
comment on column OA_VOTE_PAPER_TYPE.ID
  is 'ID';
comment on column OA_VOTE_PAPER_TYPE.NAME
  is '问卷类型名称';
comment on column OA_VOTE_PAPER_TYPE.CODE
  is '问卷类型编码';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_VOTE_PAPER_TYPE
  add constraint PK_OA_VOTE_PAPER_TYPE primary key (ID);
  
  
-- Create 问卷表
create table OA_VOTE_PAPER
(
  ID              VARCHAR2(40) not null,
  TITLE           VARCHAR2(200) not null,
  FU_TITLE        VARCHAR2(200),
  STAUTS          CHAR(1),
  DIRECTION       VARCHAR2(1024),
  CREATDATE       DATE not null,
  STARTDATE       DATE not null,
  ENDDATE         DATE not null,
  ISTOP           VARCHAR2(40),
  ORG_ID          VARCHAR2(40) not null,
  ORG_NAME        VARCHAR2(200) not null,
  USER_ID         VARCHAR2(40) not null,
  USER_NAME       VARCHAR2(40) not null,
  PAPAER_TYPE     VARCHAR2(40) not null,
  PEOPLE_NAMES    CLOB,
  EVAL_USERIDS    CLOB,
  EVAL_USERNAMES  CLOB,
  PEOPLE_IDS      CLOB,
  IS_SEND         CHAR(1),
  MESSAGE_CONTENT VARCHAR2(2048)
);
-- Add comments to the table 
comment on table OA_VOTE_PAPER
  is '问卷表';
-- Add comments to the columns 
comment on column OA_VOTE_PAPER.ID
  is 'id';
comment on column OA_VOTE_PAPER.TITLE
  is '标题';
comment on column OA_VOTE_PAPER.FU_TITLE
  is '副标题';
comment on column OA_VOTE_PAPER.STAUTS
  is '状态';
comment on column OA_VOTE_PAPER.DIRECTION
  is '投票说明';
comment on column OA_VOTE_PAPER.CREATDATE
  is '创建时间';
comment on column OA_VOTE_PAPER.STARTDATE
  is '开始时间';
comment on column OA_VOTE_PAPER.ENDDATE
  is '结束时间';
comment on column OA_VOTE_PAPER.ISTOP
  is '是否置顶';
comment on column OA_VOTE_PAPER.ORG_ID
  is '机构ID';
comment on column OA_VOTE_PAPER.ORG_NAME
  is '机构名称';
comment on column OA_VOTE_PAPER.USER_ID
  is '用户ID';
comment on column OA_VOTE_PAPER.USER_NAME
  is '用户名称';
comment on column OA_VOTE_PAPER.PAPAER_TYPE
  is '问卷类型';
comment on column OA_VOTE_PAPER.PEOPLE_NAMES
  is '投票人员名';
comment on column OA_VOTE_PAPER.EVAL_USERIDS
  is '被测评人员id';
comment on column OA_VOTE_PAPER.EVAL_USERNAMES
  is '被测评人员名';
comment on column OA_VOTE_PAPER.PEOPLE_IDS
  is '投票人员id';
comment on column OA_VOTE_PAPER.IS_SEND
  is '是否发送短信 0:否，1：是';
comment on column OA_VOTE_PAPER.MESSAGE_CONTENT
  is '发送短信的内容';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_VOTE_PAPER
  add constraint PK_OA_VOTE_PAPER primary key (ID);
alter table OA_VOTE_PAPER
  add constraint FK_OA_VOTE_OA_VOTE_2 foreign key (PAPAER_TYPE)
  references OA_VOTE_PAPER_TYPE (ID);  
  
-- Create 被测评人员表
create table OA_VOTE_EVAL_LIST
(
  PAPER_ID  VARCHAR2(40) not null,
  USER_ID   VARCHAR2(40) not null,
  USER_NAME VARCHAR2(40) not null,
  ORDER_NO  NUMBER
);
-- Add comments to the table 
comment on table OA_VOTE_EVAL_LIST
  is '测评人员表';
-- Add comments to the columns 
comment on column OA_VOTE_EVAL_LIST.PAPER_ID
  is '问卷ID';
comment on column OA_VOTE_EVAL_LIST.USER_ID
  is '用户ID';
comment on column OA_VOTE_EVAL_LIST.USER_NAME
  is '用户中文名';
comment on column OA_VOTE_EVAL_LIST.ORDER_NO
  is '排序号';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_VOTE_EVAL_LIST
  add constraint FK_OA_VOTE_OA_VOTE_1 foreign key (PAPER_ID)
  references OA_VOTE_PAPER (ID);
  
  
-- Create 投票人员表
create table OA_VOTE_USER_CONTORL
(
  ID         VARCHAR2(40) not null,
  USER_ID    VARCHAR2(40) not null,
  PAPER_ID   VARCHAR2(40) not null,
  MESSAGES   CHAR(1),
  COMPLETE   CHAR(1),
  USER_NAME  VARCHAR2(40) not null,
  ANSWERTIME DATE
);
-- Add comments to the table 
comment on table OA_VOTE_USER_CONTORL
  is '用户权限表';
-- Add comments to the columns 
comment on column OA_VOTE_USER_CONTORL.ID
  is 'ID';
comment on column OA_VOTE_USER_CONTORL.USER_ID
  is '用户ID';
comment on column OA_VOTE_USER_CONTORL.PAPER_ID
  is '问卷ID';
comment on column OA_VOTE_USER_CONTORL.MESSAGES
  is '短信提醒';
comment on column OA_VOTE_USER_CONTORL.COMPLETE
  is '是否已经填完0:未完成；1：已完成';
comment on column OA_VOTE_USER_CONTORL.USER_NAME
  is '用户姓名';    
comment on column OA_VOTE_USER_CONTORL.ANSWERTIME
  is '答题时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_VOTE_USER_CONTORL
  add constraint PK_OA_VOTE_USER_CONTORL primary key (ID);
alter table OA_VOTE_USER_CONTORL
  add constraint FK_OA_VOTE_OA_VOTE_8 foreign key (PAPER_ID)
  references OA_VOTE_PAPER (ID);




-- Create 题型表
create table OA_VOTE_QUESTION_TYPE
(
  ID   VARCHAR2(40) not null,
  NAME VARCHAR2(40) not null,
  CODE VARCHAR2(40) not null
);
-- Add comments to the table 
comment on table OA_VOTE_QUESTION_TYPE
  is '题型表';
-- Add comments to the columns 
comment on column OA_VOTE_QUESTION_TYPE.ID
  is 'ID';
comment on column OA_VOTE_QUESTION_TYPE.NAME
  is '题型名称';
comment on column OA_VOTE_QUESTION_TYPE.CODE
  is '题型编码';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_VOTE_QUESTION_TYPE
  add constraint PK_OA_VOTE_QUESTION_TYPE primary key (ID);
  
  
  -- Create 问题表
create table OA_VOTE_QUESTION
(
  ID        VARCHAR2(40) not null,
  TITLE     VARCHAR2(1024) not null,
  DIRECTION VARCHAR2(1024),
  ANSWER    CHAR(1),
  PAPER_ID  VARCHAR2(40) not null,
  TYPE_ID   VARCHAR2(40) not null,
  ORDER_NO  NUMBER,
  STATUS    CHAR(1)
);
-- Add comments to the table 
comment on table OA_VOTE_QUESTION
  is '问题表';
-- Add comments to the columns 
comment on column OA_VOTE_QUESTION.ID
  is '问题编号';
comment on column OA_VOTE_QUESTION.TITLE
  is '标题';
comment on column OA_VOTE_QUESTION.DIRECTION
  is '说明';
comment on column OA_VOTE_QUESTION.ANSWER
  is '是否必答';
comment on column OA_VOTE_QUESTION.PAPER_ID
  is '问卷编号';
comment on column OA_VOTE_QUESTION.TYPE_ID
  is '题型编号';
comment on column OA_VOTE_QUESTION.ORDER_NO
  is '排序号';
comment on column OA_VOTE_QUESTION.STATUS
  is '问题状态  0：未发布；1：已发布';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_VOTE_QUESTION
  add constraint PK_OA_VOTE_QUESTION primary key (ID);
alter table OA_VOTE_QUESTION
  add constraint FK_OA_VOTE_OA_VOTE_4 foreign key (TYPE_ID)
  references OA_VOTE_QUESTION_TYPE (ID);

   
  
-- Create 问题选项表
create table OA_VOTE_QUESTION_OPTION
(
  ID          VARCHAR2(40) not null,
  QUESTION_ID VARCHAR2(40) not null,
  CONTENT     VARCHAR2(200) not null,
  OPTION_CODE VARCHAR2(4) not null,
  CHECK_MAX   VARCHAR2(10)
);
-- Add comments to the table 
comment on table OA_VOTE_QUESTION_OPTION
  is '选项表';
-- Add comments to the columns 
comment on column OA_VOTE_QUESTION_OPTION.ID
  is '选项ID';
comment on column OA_VOTE_QUESTION_OPTION.QUESTION_ID
  is '问题编号';
comment on column OA_VOTE_QUESTION_OPTION.CONTENT
  is '选项内容';
comment on column OA_VOTE_QUESTION_OPTION.CHECK_MAX
  is '最多可选择的选项数，为空或为''''则表示不限制';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_VOTE_QUESTION_OPTION
  add constraint PK_OA_VOTE_QUESTION_OPTION primary key (ID);
alter table OA_VOTE_QUESTION_OPTION
  add constraint FK_OA_VOTE_OA_VOTE_7 foreign key (QUESTION_ID)
  references OA_VOTE_QUESTION (ID);



-- Create 回答表
create table OA_VOTE_QUESTION_ANSWER
(
  ID             VARCHAR2(40) not null,
  UESR_ID        VARCHAR2(40) not null,
  PAPER_ID       VARCHAR2(40) not null,
  QUESTION_ID    VARCHAR2(40) not null,
  EVAL_USER_ID   VARCHAR2(40),
  SELECTID       VARCHAR2(40),
  ANSWER_CONTENT VARCHAR2(400)
);
-- Add comments to the table 
comment on table OA_VOTE_QUESTION_ANSWER
  is '回答表';
-- Add comments to the columns 
comment on column OA_VOTE_QUESTION_ANSWER.UESR_ID
  is '用户ID';
comment on column OA_VOTE_QUESTION_ANSWER.PAPER_ID
  is '问卷ID';
comment on column OA_VOTE_QUESTION_ANSWER.QUESTION_ID
  is '问题ID';
comment on column OA_VOTE_QUESTION_ANSWER.EVAL_USER_ID
  is '评测人员ID';
comment on column OA_VOTE_QUESTION_ANSWER.SELECTID
  is '选项ID';
comment on column OA_VOTE_QUESTION_ANSWER.ANSWER_CONTENT
  is '回答内容';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OA_VOTE_QUESTION_ANSWER
  add constraint PK_OA_VOTE_QUESTION_ANSWER primary key (ID);
alter table OA_VOTE_QUESTION_ANSWER
  add constraint FK_OA_VOTE_OA_VOTE_5 foreign key (QUESTION_ID)
  references OA_VOTE_QUESTION (ID);


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