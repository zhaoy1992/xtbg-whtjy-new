-- Add/modify columns 
alter table OA_VOTE_QUESTION add QUESTION_NUMBER VARCHAR2(10);
-- Add comments to the columns 
comment on column OA_VOTE_QUESTION.QUESTION_NUMBER
  is '答案长度(问答题)';
  
-- Add/modify columns 
alter table oa_vote_question_option add QUESTION_NUMBER VARCHAR2(10);
-- Add comments to the columns 
comment on column oa_vote_question_option.QUESTION_NUMBER
  is '答案长度(问答题)';