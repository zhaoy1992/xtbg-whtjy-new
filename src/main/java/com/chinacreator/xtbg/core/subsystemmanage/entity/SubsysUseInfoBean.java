package com.chinacreator.xtbg.core.subsystemmanage.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:SubsysUseInfoBean.java</p>
 *<p>Description:子系统使用信息bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-28
 */
public class SubsysUseInfoBean extends XtDbBaseBean{
	public SubsysUseInfoBean() {
		super("OA_SUBSYS_USEINFO", new String[]{"info_id"}, new String[]{"info_id"});
	}
	
	private String info_id;		//信息主键
	private String sys_id;		//子系统主键
	private String user_id;		//用户id
	private String sys_user_id;		//子系统对应用户id
	private String sys_user_password;		//子系统对应用户密码
	/**
	*<b>Summary: 获取信息主键</b>
	*/
	public String getInfo_id() {
		return info_id;
	}
	/**
	*<b>Summary: 设置信息主键</b>
	*/
	public void setInfo_id(String info_id) {
		this.info_id = info_id;
	}
	/**
	*<b>Summary: 获取子系统主键</b>
	*/
	public String getSys_id() {
		return sys_id;
	}
	/**
	*<b>Summary: 设置子系统主键</b>
	*/
	public void setSys_id(String sys_id) {
		this.sys_id = sys_id;
	}
	/**
	*<b>Summary: 获取用户id</b>
	*/
	public String getUser_id() {
		return user_id;
	}
	/**
	*<b>Summary: 设置用户id</b>
	*/
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	/**
	*<b>Summary: 获取子系统对应用户id</b>
	*/
	public String getSys_user_id() {
		return sys_user_id;
	}
	/**
	*<b>Summary: 设置子系统对应用户id</b>
	*/
	public void setSys_user_id(String sys_user_id) {
		this.sys_user_id = sys_user_id;
	}
	/**
	*<b>Summary: 获取子系统对应用户密码</b>
	*/
	public String getSys_user_password() {
		return sys_user_password;
	}
	/**
	*<b>Summary: 设置子系统对应用户密码</b>
	*/
	public void setSys_user_password(String sys_user_password) {
		this.sys_user_password = sys_user_password;
	}
}
