package com.chinacreator.xtbg.core.vote.entity;

import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:OAVoteQuestionBean.java</p>
 *<p>Description:在线投票_问题表bean</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-5-8
 */
public class OAVoteQuestionBean extends XtDbBaseBean {
	private String id; // 问题编号
	private String title; // 标题
	private String direction; // 说明
	private String answer; // 是否必答
	private String paper_id; // 问卷编号
	private String type_id; // 题型编号
	private String order_no; // 排序号
    private String status; //问题状态  0：未发布；1：已发布
    private String question_number;//答案长度（问答题）
	private List<VoteOptionBean> optionList = new ArrayList<VoteOptionBean>();//问卷对应的问题
	public OAVoteQuestionBean() {
		super("oa_vote_question", "id");
	}
	public OAVoteQuestionBean(String id) {
		super("oa_vote_question", "id");
		this.id = id;
	}
		
	public String getQuestion_number() {
		return question_number;
	}
	public void setQuestion_number(String question_number) {
		this.question_number = question_number;
	}
	/**
	 *<b>Summary: 获取问题编号</b>
	 */
	public String getId() {
		return id;
	}

	/**
	 *<b>Summary: 设置问题编号</b>
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 *<b>Summary: 获取标题</b>
	 */
	public String getTitle() {
		return title;
	}

	/**
	 *<b>Summary: 设置标题</b>
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 *<b>Summary: 获取说明</b>
	 */
	public String getDirection() {
		return direction;
	}

	/**
	 *<b>Summary: 设置说明</b>
	 */
	public void setDirection(String direction) {
		this.direction = direction;
	}

	/**
	 *<b>Summary: 获取是否必答</b>
	 */
	public String getAnswer() {
		return answer;
	}

	/**
	 *<b>Summary: 设置是否必答</b>
	 */
	public void setAnswer(String answer) {
		this.answer = answer;
	}

	/**
	 *<b>Summary: 获取问卷编号</b>
	 */
	public String getPaper_id() {
		return paper_id;   
	}

	/**
	 *<b>Summary: 设置问卷编号</b>
	 */
	public void setPaper_id(String paper_id) {
		this.paper_id = paper_id;
	}

	/**
	 *<b>Summary: 获取题型编号</b>
	 */
	public String getType_id() {
		return type_id;
	}

	/**
	 *<b>Summary: 设置题型编号</b>
	 */
	public void setType_id(String type_id) {
		this.type_id = type_id;
	}

	/**
	 *<b>Summary: 获取排序号</b>
	 */
	public String getOrder_no() {
		return order_no;
	}

	/**
	 *<b>Summary: 设置排序号</b>
	 */
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	public List<VoteOptionBean> getOptionList() {
		return optionList;
	}
	public void setOptionList(List<VoteOptionBean> optionList) {
		this.optionList = optionList;
	}
	
}
