package com.chinacreator.xtbg.core.purviewmanager.entity;

import java.io.Serializable;

/**
 *<p>Title:RoleBean.java</p>
 *<p>Description:系统角色Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-15
 */
public class RoleBean implements Serializable{

	private static final long serialVersionUID = 1L;

	private String role_id; // 角色id
	private String role_name; // 角色名称
	private String role_type; // 角色类型
	private String role_type_id;//角色类型id
	private String role_desc; // 角色描述
	private String role_usage;
	private String remark1;
	private String remark2;
	private String remark3;
	private String owner_id; // 创建人id，默认维系统管理员
	private String owner_user; // 创建人  admin[超级管理员]

	public String getRole_id() {
		return role_id;
	}

	public void setRole_id(String role_id) {
		this.role_id = role_id;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}

	public String getRole_type() {
		return role_type;
	}

	public void setRole_type(String role_type) {
		this.role_type = role_type;
	}

	public String getRole_type_id() {
		return role_type_id;
	}

	public void setRole_type_id(String role_type_id) {
		this.role_type_id = role_type_id;
	}

	public String getRole_desc() {
		return role_desc;
	}

	public void setRole_desc(String role_desc) {
		this.role_desc = role_desc;
	}

	public String getRole_usage() {
		return role_usage;
	}

	public void setRole_usage(String role_usage) {
		this.role_usage = role_usage;
	}

	public String getRemark1() {
		return remark1;
	}

	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}

	public String getRemark2() {
		return remark2;
	}

	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}

	public String getRemark3() {
		return remark3;
	}

	public void setRemark3(String remark3) {
		this.remark3 = remark3;
	}

	public String getOwner_id() {
		return owner_id;
	}

	public void setOwner_id(String owner_id) {
		this.owner_id = owner_id;
	}

	public String getOwner_user() {
		return owner_user;
	}

	public void setOwner_user(String owner_user) {
		this.owner_user = owner_user;
	}
}
