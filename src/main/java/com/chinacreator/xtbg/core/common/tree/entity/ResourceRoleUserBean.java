/**
 * 
 */
package com.chinacreator.xtbg.core.common.tree.entity;
/**
 * 
 * <p>Title: ResourceRoleUserBean</p>
 * <p>Description: Bean</p>
 * <p>Copyright: Copyright (c) 2012</p>
 * <p>Company: chinacreator</p>
 * @author weiwei.liu
 * @version 1.0
 * 2012-4-13
 */


public class ResourceRoleUserBean {
	private String username;//用户名称
	private String userid;//用户ID
	private String orgid;//用户对应的部门ID
	private String orgname;//用户对应的部门名称
	private String remark4;//机构编码
	private String isLeadOrg;//是否是领导机构
	private String parentId;//父机构ID
	private String deptCode;//用户对应的部门编码
	
	
	
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public String getParentId() {
	    return parentId;
	}
	public void setParentId(String parentId) {
	    this.parentId = parentId;
	}
	public String getRemark4() {
	    return remark4;
	}
	public void setRemark4(String remark4) {
	    this.remark4 = remark4;
	}
	public String getIsLeadOrg() {
	    return isLeadOrg;
	}
	public void setIsLeadOrg(String isLeadOrg) {
	    this.isLeadOrg = isLeadOrg;
	}
	/**
	 * @return the orgname
	 */
	public String getOrgname() {
		return orgname;
	}
	/**
	 * @param orgname the orgname to set
	 */
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	/**
	 * @return the orgid
	 */
	public String getOrgid() {
		return orgid;
	}
	/**
	 * @param orgid the orgid to set
	 */
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * @return the userid
	 */
	public String getUserid() {
		return userid;
	}
	/**
	 * @param userid the userid to set
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
}
