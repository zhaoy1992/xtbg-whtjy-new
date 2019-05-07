package com.chinacreator.xtbg.core.purviewmanager.entity;

import java.io.Serializable;

/**
 *<p>Title:RoleTypeBean.java</p>
 *<p>Description:角色类型实体</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-17
 */
public class RoleTypeBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private String type_name; // 角色类型名称
	private String type_desc; // 角色类型描述
	private String type_id; // 角色类型id
	private String creator_user_id; // 创建人ID
	private String creator_user;//角色类型创建人
	private String creator_org_id; // 创建机构ID

	/**
	 * <b>Summary: 获取角色类型名称</b>
	 */
	public String getType_name() {
		return type_name;
	}

	/**
	 * <b>Summary: 设置角色类型名称</b>
	 */
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}

	/**
	 * <b>Summary: 获取角色类型描述</b>
	 */
	public String getType_desc() {
		return type_desc;
	}

	/**
	 * <b>Summary: 设置角色类型描述</b>
	 */
	public void setType_desc(String type_desc) {
		this.type_desc = type_desc;
	}

	/**
	 * <b>Summary: 获取角色类型id</b>
	 */
	public String getType_id() {
		return type_id;
	}

	/**
	 * <b>Summary: 设置角色类型id</b>
	 */
	public void setType_id(String type_id) {
		this.type_id = type_id;
	}

	/**
	 * <b>Summary: 获取创建人ID</b>
	 */
	public String getCreator_user_id() {
		return creator_user_id;
	}

	/**
	 * <b>Summary: 设置创建人ID</b>
	 */
	public void setCreator_user_id(String creator_user_id) {
		this.creator_user_id = creator_user_id;
	}

	/**
	 * <b>Summary: 获取创建机构ID</b>
	 */
	public String getCreator_org_id() {
		return creator_org_id;
	}

	public String getCreator_user() {
		return creator_user;
	}

	public void setCreator_user(String creator_user) {
		this.creator_user = creator_user;
	}

	/**
	 * <b>Summary: 设置创建机构ID</b>
	 */
	public void setCreator_org_id(String creator_org_id) {
		this.creator_org_id = creator_org_id;
	}

}
