package com.chinacreator.xtbg.core.vote.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:VoteOptionBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-5-8
 */
public class VoteOptionBean extends XtDbBaseBean{
	private static final long serialVersionUID = 1L;
	
	private String id;		//选项ID
	private String question_id;		//问题编号
	private String content;		//选项内容
	private String option_code;	//选项编号
	private String selectCount; //被选次数
	private String check_max ; //最多可选数
	
	public VoteOptionBean(){
		super("oa_vote_question_option","id");
	}
	public String getSelectCount() {
		return selectCount;
	}
	public void setSelectCount(String selectCount) {
		this.selectCount = selectCount;
	}
	/**
	*<b>Summary: 获取选项ID</b>
	*/
	public String getId() {
		return id;
	}
	/**
	*<b>Summary: 设置选项ID</b>
	*/
	public void setId(String id) {
		this.id = id;
	}
	/**
	*<b>Summary: 获取问题编号</b>
	*/
	public String getQuestion_id() {
		return question_id;
	}
	/**
	*<b>Summary: 设置问题编号</b>
	*/
	public void setQuestion_id(String question_id) {
		this.question_id = question_id;
	}
	/**
	*<b>Summary: 获取选项内容</b>
	*/
	public String getContent() {
		return content;
	}
	/**
	*<b>Summary: 设置选项内容</b>
	*/
	public void setContent(String content) {
		this.content = content;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getOption_code() {
		return option_code;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setOption_code(String option_code) {
		this.option_code = option_code;
	}
	public String getCheck_max() {
		return check_max;
	}
	public void setCheck_max(String checkMax) {
		check_max = checkMax;
	}

}
