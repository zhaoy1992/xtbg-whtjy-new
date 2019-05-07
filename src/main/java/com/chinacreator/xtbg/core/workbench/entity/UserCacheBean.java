package com.chinacreator.xtbg.core.workbench.entity;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *<p>Title:UserCacheBean.java</p>
 *<p>Description:工作台用户缓存信息</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
 */
public class UserCacheBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private String username; // 用户名
	private String userid; // 用户id
	private int loginnumber; // 登录次数
	private Timestamp lastlogin; // 最后登录时间
	private Timestamp lastout; // 最后退出时间
	private String lastloginip; // 最后登录ip
	private String remark; // 备用
	private String action;//操作类型

	/**
	 * <b>Summary: 获取用户名</b>
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * <b>Summary: 设置用户名</b>
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * <b>Summary: 获取用户id</b>
	 */
	public String getUserid() {
		return userid;
	}

	/**
	 * <b>Summary: 设置用户id</b>
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}

	/**
	 * <b>Summary: 获取登录次数</b>
	 */
	public int getLoginnumber() {
		return loginnumber;
	}

	/**
	 * <b>Summary: 设置登录次数</b>
	 */
	public void setLoginnumber(int loginnumber) {
		this.loginnumber = loginnumber;
	}

	/**
	 * <b>Summary: 获取最后登录时间</b>
	 */
	public Timestamp getLastlogin() {
		return lastlogin;
	}

	/**
	 * <b>Summary: 设置最后登录时间</b>
	 */
	public void setLastlogin(Timestamp lastlogin) {
		this.lastlogin = lastlogin;
	}

	/**
	 * <b>Summary: 获取最后退出时间</b>
	 */
	public Timestamp getLastout() {
		return lastout;
	}

	/**
	 * <b>Summary: 设置最后退出时间</b>
	 */
	public void setLastout(Timestamp lastout) {
		this.lastout = lastout;
	}

	/**
	 * <b>Summary: 获取最后登录ip</b>
	 */
	public String getLastloginip() {
		return lastloginip;
	}

	/**
	 * <b>Summary: 设置最后登录ip</b>
	 */
	public void setLastloginip(String lastloginip) {
		this.lastloginip = lastloginip;
	}

	/**
	 * <b>Summary: 获取备用</b>
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * <b>Summary: 设置备用</b>
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

}
