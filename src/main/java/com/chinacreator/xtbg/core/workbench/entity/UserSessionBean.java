package com.chinacreator.xtbg.core.workbench.entity;

import java.io.Serializable;
/**
 *<p>Title:UserSessionBean.java</p>
 *<p>Description:用户登录session实体</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-26
 */
public class UserSessionBean implements Serializable{

	private static final long serialVersionUID = 1L;

	private String user_id;//用户id
	
	private String user_name;//用户名
	
	private String login_ip;//登陆ip
	
	private String session_id;//登陆sessionid
	
	private String user_realname;//用户中文名
	
	public String getLogin_time() {
		return login_time;
	}

	public void setLogin_time(String login_time) {
		this.login_time = login_time;
	}

	private String login_time;//登陆时间

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getLogin_ip() {
		return login_ip;
	}

	public void setLogin_ip(String login_ip) {
		this.login_ip = login_ip;
	}

	public String getSession_id() {
		return session_id;
	}

	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}

	public String getUser_realname() {
		return user_realname;
	}

	public void setUser_realname(String user_realname) {
		this.user_realname = user_realname;
	}
	
}
