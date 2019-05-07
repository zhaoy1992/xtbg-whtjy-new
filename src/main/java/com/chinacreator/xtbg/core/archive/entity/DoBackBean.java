package com.chinacreator.xtbg.core.archive.entity;

/**
 * 
 *<p>Title:DoBackBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-11-14
 */
public class DoBackBean {

	private String ins_id; //实例ID
	
	private String next_actdefId;//环节定义ID
	
	private String next_actName;//环节显示名称
	
	private String user_id; //用户ID
	
	private String user_rename;//用户中文名称
	
	private String user_name;//用户登陆名称
	
	public String getIns_id() {
		return ins_id;
	}

	public void setIns_id(String ins_id) {
		this.ins_id = ins_id;
	}

	public String getNext_actdefId() {
		return next_actdefId;
	}

	public void setNext_actdefId(String next_actdefId) {
		this.next_actdefId = next_actdefId;
	}

	public String getNext_actName() {
		return next_actName;
	}

	public void setNext_actName(String next_actName) {
		this.next_actName = next_actName;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_rename() {
		return user_rename;
	}

	public void setUser_rename(String user_rename) {
		this.user_rename = user_rename;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	

}
