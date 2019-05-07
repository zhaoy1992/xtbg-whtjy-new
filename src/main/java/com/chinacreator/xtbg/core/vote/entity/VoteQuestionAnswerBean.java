package com.chinacreator.xtbg.core.vote.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:VoteQuestionAnswerBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-5-9
 */
public class VoteQuestionAnswerBean extends XtDbBaseBean{
	private static final long serialVersionUID = 1L;
	private String id;		//null
	private String uesr_id;		//用户ID
	private String paper_id;		//问卷ID
	private String question_id;		//问题ID
	private String eval_user_id;		//评测人员ID
	private String selectid;		//选项ID
	private String answer_content;		//回答内容
	private String answerCount;        //改选项选择次数（统计EXCEL时用到）
	
	public String getAnswerCount() {
		return answerCount;
	}
	public void setAnswerCount(String answerCount) {
		this.answerCount = answerCount;
	}
	public VoteQuestionAnswerBean(){
		super("oa_vote_question_answer","id");
	}
	public VoteQuestionAnswerBean(String uesr_id,String paper_id, String question_id){
		super("oa_vote_question_answer","id");
		this.uesr_id = uesr_id;
		this.paper_id = paper_id;
		this.question_id = question_id;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getId() {
		return id;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setId(String id) {
		this.id = id;
	}
	/**
	*<b>Summary: 获取用户ID</b>
	*/
	public String getUesr_id() {
		return uesr_id;
	}
	/**
	*<b>Summary: 设置用户ID</b>
	*/
	public void setUesr_id(String uesr_id) {
		this.uesr_id = uesr_id;
	}
	/**
	*<b>Summary: 获取问卷ID</b>
	*/
	public String getPaper_id() {
		return paper_id;
	}
	/**
	*<b>Summary: 设置问卷ID</b>
	*/
	public void setPaper_id(String paper_id) {
		this.paper_id = paper_id;
	}
	/**
	*<b>Summary: 获取问题ID</b>
	*/
	public String getQuestion_id() {
		return question_id;
	}
	/**
	*<b>Summary: 设置问题ID</b>
	*/
	public void setQuestion_id(String question_id) {
		this.question_id = question_id;
	}
	/**
	*<b>Summary: 获取评测人员ID</b>
	*/
	public String getEval_user_id() {
		return eval_user_id;
	}
	/**
	*<b>Summary: 设置评测人员ID</b>
	*/
	public void setEval_user_id(String eval_user_id) {
		this.eval_user_id = eval_user_id;
	}
	/**
	*<b>Summary: 获取选项ID</b>
	*/
	public String getSelectid() {
		return selectid;
	}
	/**
	*<b>Summary: 设置选项ID</b>
	*/
	public void setSelectid(String selectid) {
		this.selectid = selectid;
	}
	/**
	*<b>Summary: 获取回答内容</b>
	*/
	public String getAnswer_content() {
		return answer_content;
	}
	/**
	*<b>Summary: 设置回答内容</b>
	*/
	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}
}
