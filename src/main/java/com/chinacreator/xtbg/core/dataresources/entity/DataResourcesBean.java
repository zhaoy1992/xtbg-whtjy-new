package com.chinacreator.xtbg.core.dataresources.entity;


public class DataResourcesBean {

	private String resources_id;		//资源ID
	private String resources_parent_id;		//资源父ID
	private String resources_name;		//资源名称
	private String resources_logo;		//资源标识
	private String resources_desc;		//资源描述
	private String creator_time;		//创建时间
	private String resources_type;		//资源类型(1表示人员权限,2单位接收人权限)
	private String tree_type;		//1.人员类型树,2.单位类型树, 3.部门类型树
	private String is_view;		//1.显示,0不显示
	/**
	*<b>Summary: 获取资源ID</b>
	*/
	public String getResources_id() {
		return resources_id;
	}
	/**
	*<b>Summary: 设置资源ID</b>
	*/
	public void setResources_id(String resources_id) {
		this.resources_id = resources_id;
	}
	/**
	*<b>Summary: 获取资源父ID</b>
	*/
	public String getResources_parent_id() {
		return resources_parent_id;
	}
	/**
	*<b>Summary: 设置资源父ID</b>
	*/
	public void setResources_parent_id(String resources_parent_id) {
		this.resources_parent_id = resources_parent_id;
	}
	/**
	*<b>Summary: 获取资源名称</b>
	*/
	public String getResources_name() {
		return resources_name;
	}
	/**
	*<b>Summary: 设置资源名称</b>
	*/
	public void setResources_name(String resources_name) {
		this.resources_name = resources_name;
	}
	/**
	*<b>Summary: 获取资源标识</b>
	*/
	public String getResources_logo() {
		return resources_logo;
	}
	/**
	*<b>Summary: 设置资源标识</b>
	*/
	public void setResources_logo(String resources_logo) {
		this.resources_logo = resources_logo;
	}
	/**
	*<b>Summary: 获取资源描述</b>
	*/
	public String getResources_desc() {
		return resources_desc;
	}
	/**
	*<b>Summary: 设置资源描述</b>
	*/
	public void setResources_desc(String resources_desc) {
		this.resources_desc = resources_desc;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public String getCreator_time() {
		return creator_time;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setCreator_time(String creator_time) {
		this.creator_time = creator_time;
	}
	/**
	*<b>Summary: 获取资源类型(1表示人员权限,2单位接收人权限)</b>
	*/
	public String getResources_type() {
		return resources_type;
	}
	/**
	*<b>Summary: 设置资源类型(1表示人员权限,2单位接收人权限)</b>
	*/
	public void setResources_type(String resources_type) {
		this.resources_type = resources_type;
	}
	/**
	*<b>Summary: 获取1.人员类型树,2.单位类型树, 3.部门类型树</b>
	*/
	public String getTree_type() {
		return tree_type;
	}
	/**
	*<b>Summary: 设置1.人员类型树,2.单位类型树, 3.部门类型树</b>
	*/
	public void setTree_type(String tree_type) {
		this.tree_type = tree_type;
	}
	/**
	*<b>Summary: 获取1.显示,0不显示</b>
	*/
	public String getIs_view() {
		return is_view;
	}
	/**
	*<b>Summary: 设置1.显示,0不显示</b>
	*/
	public void setIs_view(String is_view) {
		this.is_view = is_view;
	}
}
