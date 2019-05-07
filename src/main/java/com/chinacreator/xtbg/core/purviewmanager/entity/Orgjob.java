package com.chinacreator.xtbg.core.purviewmanager.entity;

/**
 * 
 *<p>Title:Orgjob.java</p>
 *<p>Description:岗位实体bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-17
 */
public class Orgjob {

	private String org_id;		//机构ID
	private String job_id;		//岗位ID
	private Integer job_sn;		//岗位顺序
	/**
	*<b>Summary: 获取机构ID</b>
	*/
	public String getOrg_id() {
		return org_id;
	}
	/**
	*<b>Summary: 设置机构ID</b>
	*/
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}
	/**
	*<b>Summary: 获取岗位ID</b>
	*/
	public String getJob_id() {
		return job_id;
	}
	/**
	*<b>Summary: 设置岗位ID</b>
	*/
	public void setJob_id(String job_id) {
		this.job_id = job_id;
	}
	/**
	*<b>Summary: 获取岗位顺序</b>
	*/
	public Integer getJob_sn() {
		return job_sn;
	}
	/**
	*<b>Summary: 设置岗位顺序</b>
	*/
	public void setJob_sn(Integer job_sn) {
		this.job_sn = job_sn;
	}
}
