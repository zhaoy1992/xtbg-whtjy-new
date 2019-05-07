/**
 * 
 */
package com.chinacreator.sysmgrcore.manager.entity;
/**
 * 
 * <p>Title: 标题</p>
 * <p>Description: 类描叙，具体功能</p>
 * <p>Copyright: Copyright (c) 2012</p>
 * <p>Company: chinacreator</p>
 * @author weiwei.liu
 * @version 1.0
 * 2012-4-20
 */

/**
 * @author 123456
 *
 */
public class OrgAndTypeBean {
	private String orgid;
	private String orgtype;
	private String orgtypename;
	private String orgsortid;
	private String orgsortname;
	private String is_offline;
	private String is_leadorg;
	private String is_office; //是否是政府办
	private String five_major_org; //是否是五大机构
	
	private String sendAccount;//发送短信用户帐号
	private String sendPassword;//发送短信用户密码
	private String sendOrgCode;//发送短信用户机构子码
	
	public String getIs_leadorg() {
	    return is_leadorg;
	}
	public void setIs_leadorg(String is_leadorg) {
	    this.is_leadorg = is_leadorg;
	}
	public String getIs_offline() {
		return is_offline;
	}
	public void setIs_offline(String isOffline) {
		is_offline = isOffline;
	}
	public String getOrgsortname() {
		return orgsortname;
	}
	public void setOrgsortname(String orgsortname) {
		this.orgsortname = orgsortname;
	}
	public String getOrgsortid() {
		return orgsortid;
	}
	public void setOrgsortid(String orgsortid) {
		this.orgsortid = orgsortid;
	}
	/**
	 * @return the orgtypename
	 */
	public String getOrgtypename() {
		return orgtypename;
	}
	/**
	 * @param orgtypename the orgtypename to set
	 */
	public void setOrgtypename(String orgtypename) {
		this.orgtypename = orgtypename;
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
	 * @return the orgtype
	 */
	public String getOrgtype() {
		return orgtype;
	}
	/**
	 * @param orgtype the orgtype to set
	 */
	public void setOrgtype(String orgtype) {
		this.orgtype = orgtype;
	}
	public String getIs_office() {
		return is_office;
	}
	public void setIs_office(String is_office) {
		this.is_office = is_office;
	}
	public String getFive_major_org() {
		return five_major_org;
	}
	public void setFive_major_org(String five_major_org) {
		this.five_major_org = five_major_org;
	}
	public String getSendAccount() {
		return sendAccount;
	}
	public void setSendAccount(String sendAccount) {
		this.sendAccount = sendAccount;
	}
	public String getSendPassword() {
		return sendPassword;
	}
	public void setSendPassword(String sendPassword) {
		this.sendPassword = sendPassword;
	}
	public String getSendOrgCode() {
		return sendOrgCode;
	}
	public void setSendOrgCode(String sendOrgCode) {
		this.sendOrgCode = sendOrgCode;
	}
}
