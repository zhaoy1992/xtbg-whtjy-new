package com.chinacreator.xtbg.core.process.flowprocessing.entity;

/**
 *<p>Title:FlowWfactionExtBean.java</p>
 *<p>Description:流程添加扩展Bean</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-2
 */
public class FlowWfactionExtBean {
	
	private String actionext_id; //活动扩展id
	
	private String isshowuser; //是否动态选择执行人
	
	private String isshowreject; //是否退窗
	
	private String isshowback; //是否回退
	
	private String isdispense;//是否分发
	
	private String autoassignment; //前置活动执行人
	
	private String issignjoinbyorder; //会签方式
	
	
	/**
	 * <b>Summary: </b>
	 *     获取issignjoinbyorder的值
	 * @return issignjoinbyorder 
	 */
	public String getIssignjoinbyorder() {
		return issignjoinbyorder;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 issignjoinbyorder 的值 
	 * @param issignjoinbyorder 
	 */
	public void setIssignjoinbyorder(String issignjoinbyorder) {
		this.issignjoinbyorder = issignjoinbyorder;
	}

	public String getAutoassignment() {
		return autoassignment;
	}

	public void setAutoassignment(String autoassignment) {
		this.autoassignment = autoassignment;
	}

	/**
	 * <b>Summary: </b>
	 *     获取isdispense的值
	 * @return isdispense 
	 */
	public String getIsdispense() {
		return isdispense;
	}

	/** 
	 * <b>Summary: </b>
	 *     设置 isdispense 的值 
	 * @param isdispense 
	 */
	public void setIsdispense(String isdispense) {
		this.isdispense = isdispense;
	}

	public String getActionext_id() {
		return actionext_id;
	}

	public void setActionext_id(String actionext_id) {
		this.actionext_id = actionext_id;
	}

	public String getIsshowuser() {
		return isshowuser;
	}

	public void setIsshowuser(String isshowuser) {
		this.isshowuser = isshowuser;
	}

	public String getIsshowreject() {
		return isshowreject;
	}

	public void setIsshowreject(String isshowreject) {
		this.isshowreject = isshowreject;
	}

	public String getIsshowback() {
		return isshowback;
	}

	public void setIsshowback(String isshowback) {
		this.isshowback = isshowback;
	}
	
	
}
