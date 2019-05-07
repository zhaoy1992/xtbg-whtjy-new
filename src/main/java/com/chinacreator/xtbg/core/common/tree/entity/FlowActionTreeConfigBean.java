package com.chinacreator.xtbg.core.common.tree.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

public class FlowActionTreeConfigBean extends XtDbBaseBean{

	public FlowActionTreeConfigBean() {
		super("OA_FLOW_ACTIONTREECONFIG", new String[]{"config_id"});
		// TODO Auto-generated constructor stub
	}
	private String config_id;		//配置ID
	private String action_id;		//活动ID
	private String tree_role;		//树的权限
	private String tree_nodetype;		//树的节点类型
	/**
	*<b>Summary: 获取配置ID</b>
	*/
	public String getConfig_id() {
		return config_id;
	}
	/**
	*<b>Summary: 设置配置ID</b>
	*/
	public void setConfig_id(String config_id) {
		this.config_id = config_id;
	}
	/**
	*<b>Summary: 获取活动ID</b>
	*/
	public String getAction_id() {
		return action_id;
	}
	/**
	*<b>Summary: 设置活动ID</b>
	*/
	public void setAction_id(String action_id) {
		this.action_id = action_id;
	}
	/**
	*<b>Summary: 获取树的权限</b>
	*/
	public String getTree_role() {
		return tree_role;
	}
	/**
	*<b>Summary: 设置树的权限</b>
	*/
	public void setTree_role(String tree_role) {
		this.tree_role = tree_role;
	}
	/**
	*<b>Summary: 获取树的节点类型</b>
	*/
	public String getTree_nodetype() {
		return tree_nodetype;
	}
	/**
	*<b>Summary: 设置树的节点类型</b>
	*/
	public void setTree_nodetype(String tree_nodetype) {
		this.tree_nodetype = tree_nodetype;
	}

}
