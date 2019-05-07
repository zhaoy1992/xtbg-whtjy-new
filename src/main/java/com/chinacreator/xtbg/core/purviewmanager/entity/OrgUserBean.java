package com.chinacreator.xtbg.core.purviewmanager.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:OrgUserBean.java</p>
 *<p>Description:机构用户关联实体Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-27
 */
public class OrgUserBean extends XtDbBaseBean {

	public OrgUserBean() {
		super("td_sm_orguser");
	}
	private String org_id;		//机构ID
	private String user_id;		//用户ID
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
}
