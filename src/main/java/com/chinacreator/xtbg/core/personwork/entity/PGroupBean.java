
package com.chinacreator.xtbg.core.personwork.entity;

/**
 * 
 *<p>Title:PGroupBean.java</p>
 *<p>Description:通讯录分组信息</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-14
 */
public class PGroupBean {
	private String groupName;
	private String rownum;
	private String loginUserID;
	private String groupID;
	private String is_public_group;
	
	/**
	 * <b>Summary: </b>
	 *     获取is_public_group的值
	 * @return is_public_group 
	 */
	public String getIs_public_group() {
		return is_public_group;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_public_group 的值 
	 * @param is_public_group 
	 */
	public void setIs_public_group(String is_public_group) {
		this.is_public_group = is_public_group;
	}
	/**
	 * @return the groupID
	 */
	public String getGroupID() {
		return groupID;
	}
	/**
	 * @param groupID the groupID to set
	 */
	public void setGroupID(String groupID) {
		this.groupID = groupID;
	}
	/**
	 * @return the loginUserID
	 */
	public String getLoginUserID() {
		return loginUserID;
	}
	/**
	 * @param loginUserID the loginUserID to set
	 */
	public void setLoginUserID(String loginUserID) {
		this.loginUserID = loginUserID;
	}
	/**
	 * @return the groupName
	 */
	public String getGroupName() {
		return groupName;
	}
	/**
	 * @param groupName the groupName to set
	 */
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	/**
	 * @return the rownum
	 */
	public String getRownum() {
		return rownum;
	}
	/**
	 * @param rownum the rownum to set
	 */
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	
	
}
