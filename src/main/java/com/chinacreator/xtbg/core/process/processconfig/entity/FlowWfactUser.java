package com.chinacreator.xtbg.core.process.processconfig.entity;

/**
 * 
 *<p>Title:FlowWfactUser.java</p>
 *<p>Description:流程活动用户</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-22
 */
public class FlowWfactUser {
	private String wfactuser_id;
	private String action_id;
	private String user_id;
	private String user_name;
	private String actuser_type;
	private String create_time;
	private String user_realname;
	
	public String getUser_realname() {
		return user_realname;
	}
	public void setUser_realname(String user_realname) {
		this.user_realname = user_realname;
	}
	public String getWfactuser_id() {
		return wfactuser_id;
	}
	public void setWfactuser_id(String wfactuserId) {
		wfactuser_id = wfactuserId;
	}
	public String getAction_id() {
		return action_id;
	}
	public void setAction_id(String actionId) {
		action_id = actionId;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String userId) {
		user_id = userId;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String userName) {
		user_name = userName;
	}
	public String getActuser_type() {
		return actuser_type;
	}
	public void setActuser_type(String actuserType) {
		actuser_type = actuserType;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String createTime) {
		create_time = createTime;
	}
	
	
}
