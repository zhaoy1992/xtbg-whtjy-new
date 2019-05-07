package com.chinacreator.xtbg.core.common.cache.entity;

/**
 * 
 *<p>Title:OrgCacheBean.java</p>
 *<p>Description:机构缓存实体Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-17
 */
public class OrgCacheBean {

	private String org_id;//部门ID
	private String parent_id;//部门父ID
	private String org_name;//机构名称
	private String org_name_other;//机构别名
	private String chargeorgid;
	private String org_level;//机构类型
	private String org_sn;//排序号
	private String unit_id;//单位ID
	private String unit_name;//单位名称
	private String dept_type_id;//机关类型
	private String dept_org;//单位分类，用来过滤单位树
	
	public String getDept_org() {
		return dept_org;
	}
	public void setDept_org(String dept_org) {
		this.dept_org = dept_org;
	}
	public String getUnit_id() {
		return unit_id;
	}
	public void setUnit_id(String unit_id) {
		this.unit_id = unit_id;
	}
	public String getUnit_name() {
		return unit_name;
	}
	public void setUnit_name(String unit_name) {
		this.unit_name = unit_name;
	}
	
	public String getOrg_id() {
		return org_id;
	}
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getOrg_name() {
		return org_name;
	}
	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	public String getChargeorgid() {
		return chargeorgid;
	}
	public void setChargeorgid(String chargeorgid) {
		this.chargeorgid = chargeorgid;
	}
	public String getOrg_level() {
		return org_level;
	}
	public void setOrg_level(String org_level) {
		this.org_level = org_level;
	}
	public String getOrg_sn() {
		return org_sn;
	}
	public void setOrg_sn(String org_sn) {
		this.org_sn = org_sn;
	}
	public String getOrg_name_other() {
		return org_name_other;
	}
	public void setOrg_name_other(String orgNameOther) {
		org_name_other = orgNameOther;
	}
	public String getDept_type_id() {
		return dept_type_id;
	}
	public void setDept_type_id(String dept_type_id) {
		this.dept_type_id = dept_type_id;
	}
	
}
