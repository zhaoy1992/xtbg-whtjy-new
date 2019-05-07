package com.chinacreator.xtbg.core.vote.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:VoteEvalUserBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-5-10
 */
public class VoteEvalUserBean extends XtDbBaseBean{

	private String paper_id;		//问卷ID
	private String user_id;		//用户ID
	private String user_name;		//用户中文名
	private String order_no;		//排序号
	
	public  VoteEvalUserBean(){
		super("oa_vote_eval_list");
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
	*<b>Summary: 获取用户ID</b>
	*/
	public String getUser_id() {
		return user_id;
	}
	/**
	*<b>Summary: 设置用户ID</b>
	*/
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	/**
	*<b>Summary: 获取用户中文名</b>
	*/
	public String getUser_name() {
		return user_name;
	}
	/**
	*<b>Summary: 设置用户中文名</b>
	*/
	public void setUser_name(String user_name) {
		this.user_name = user_name;
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
}
