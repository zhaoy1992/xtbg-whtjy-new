package com.chinacreator.xtbg.core.common.cache.entity;

/**
 * 
 *<p>Title:UserCacheBean.java</p>
 *<p>Description:用户缓存实体Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-16
 */
public class UserCacheBean {
	private String org_id; //部门ID
	private String user_id; //用户ID
	private String user_name; //用户登陆名称
	private String user_realname; //用户名称
	private String org_name; //部门名称
	private String user_mobiletel1;//电话号码
	private String user_worktel;//单位电话
	private String user_email;//邮箱
	private String unit_name;//单位名称
	private String unit_id;//单位
	private String unit_names;//从上到下单位名称
	private String unit_ids;//所有单位ID
	private String user_sex;//姓别
	private String user_password;//密码
	private String dept_org; //机构分类
	
	public String getDept_org() {
		return dept_org;
	}
	public void setDept_org(String dept_org) {
		this.dept_org = dept_org;
	}
	public String getUser_sex() {
		return user_sex;
	}
	public void setUser_sex(String user_sex) {
		this.user_sex = user_sex;
	}
	public String getOrg_id() {
		return org_id;
	}
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_realname() {
		return user_realname;
	}
	public void setUser_realname(String user_realname) {
		this.user_realname = user_realname;
	}
	public String getOrg_name() {
		return org_name;
	}
	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	public String getUser_mobiletel1() {
		return user_mobiletel1;
	}
	public void setUser_mobiletel1(String user_mobiletel1) {
		this.user_mobiletel1 = user_mobiletel1;
	}
	public String getUser_worktel() {
		return user_worktel;
	}
	public void setUser_worktel(String user_worktel) {
		this.user_worktel = user_worktel;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUnit_name() {
		return unit_name;
	}
	public void setUnit_name(String unit_name) {
		this.unit_name = unit_name;
	}
	public String getUnit_id() {
		return unit_id;
	}
	public void setUnit_id(String unit_id) {
		this.unit_id = unit_id;
	}
	public String getUnit_names() {
		return unit_names;
	}
	public void setUnit_names(String unit_names) {
		this.unit_names = unit_names;
	}
	public String getUnit_ids() {
		return unit_ids;
	}
	public void setUnit_ids(String unit_ids) {
		this.unit_ids = unit_ids;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
}
