package com.chinacreator.xtbg.core.purviewmanager.entity;

import java.sql.Timestamp;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:UserJobOrgBean.java</p>
 *<p>Description:用户岗位实例bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-27
 */
public class UserJobOrgBean extends XtDbBaseBean{

	public UserJobOrgBean() {
		super("td_sm_userjoborg");
	}
	
	private String user_id;		//null
	private String job_id;		//null
	private String org_id;		//null
	private String same_job_user_sn;		//null
	private String job_sn;		//null
	private Timestamp job_starttime;		//null
	private String job_fettle;		//null
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getUser_id() {
		return user_id;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getJob_id() {
		return job_id;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setJob_id(String job_id) {
		this.job_id = job_id;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getOrg_id() {
		return org_id;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getSame_job_user_sn() {
		return same_job_user_sn;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setSame_job_user_sn(String same_job_user_sn) {
		this.same_job_user_sn = same_job_user_sn;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getJob_sn() {
		return job_sn;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setJob_sn(String job_sn) {
		this.job_sn = job_sn;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public Timestamp getJob_starttime() {
		return job_starttime;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setJob_starttime(Timestamp job_starttime) {
		this.job_starttime = job_starttime;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getJob_fettle() {
		return job_fettle;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setJob_fettle(String job_fettle) {
		this.job_fettle = job_fettle;
	}
}
