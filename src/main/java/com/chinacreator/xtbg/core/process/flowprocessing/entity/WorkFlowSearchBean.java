package com.chinacreator.xtbg.core.process.flowprocessing.entity;

/**
 * 
 *<p>Title:WorkFlowSearchBean.java</p>
 *<p>Description:公文查询参数Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-22
 */
public class WorkFlowSearchBean {
	private String username;
	private String ins_code;
	private String busitype_code;
	private String ins_name;
	private String accepter;
	private String startSlTime;
	private String endSlTime;
	private String status_code;
	private String busitype_name;
	private String pageType;
	private String unit_id;
	private String is_open;
	private String info_type;//信息分类
	private String orgId;
	private String orgName;
	private String userId;
	private String userKey;
	private String userName;
	private String org_name;//机构名称
	
	public String getOrg_name() {
		return org_name;
	}
	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	public String getUnit_id() {
		return unit_id;
	}
	public void setUnit_id(String unit_id) {
		this.unit_id = unit_id;
	}
	public String getIs_open() {
		return is_open;
	}
	public void setIs_open(String is_open) {
		this.is_open = is_open;
	}
	public String getPageType() {
		return pageType;
	}
	public void setPageType(String pageType) {
		this.pageType = pageType;
	}
	public String getBusitype_name() {
		return busitype_name;
	}
	public void setBusitype_name(String busitypeName) {
		busitype_name = busitypeName;
	}
	public String getStatus_code() {
		return status_code;
	}
	public void setStatus_code(String status_code) {
		this.status_code = status_code;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getIns_code() {
		return ins_code;
	}
	public void setIns_code(String insCode) {
		ins_code = insCode;
	}
	
	public String getBusitype_code() {
		return busitype_code;
	}
	public void setBusitype_code(String busitypeCode) {
		busitype_code = busitypeCode;
	}
	public String getIns_name() {
		return ins_name;
	}
	public void setIns_name(String insName) {
		ins_name = insName;
	}
	public String getAccepter() {
		return accepter;
	}
	public void setAccepter(String accepter) {
		this.accepter = accepter;
	}
	public String getStartSlTime() {
		return startSlTime;
	}
	public void setStartSlTime(String startSlTime) {
		this.startSlTime = startSlTime;
	}
	public String getEndSlTime() {
		return endSlTime;
	}
	public void setEndSlTime(String endSlTime) {
		this.endSlTime = endSlTime;
	}
	/**
	 * <b>Summary: </b>
	 *     获取info_type的值
	 * @return info_type 
	 */
	public String getInfo_type() {
		return info_type;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 info_type 的值 
	 * @param info_type 
	 */
	public void setInfo_type(String info_type) {
		this.info_type = info_type;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserKey() {
		return userKey;
	}
	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}
