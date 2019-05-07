package com.chinacreator.xtbg.core.process.processconfig.entity;
/**
 * 
 *<p>Title:FlowActionTreeConfigBean.java</p>
 *<p>Description:活动树配置表Bean</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-6-13
 */
public class FlowActionTreeConfigBean {
	private static final long serialVersionUID = 1L;

	private String config_id; //配置ID
	private String action_id;	//活动ID
	private String tree_role;	//树的权限
	private String tree_nodetype;	//树的节点类型
	
	public String getConfig_id() {
		return config_id;
	}
	public void setConfig_id(String config_id) {
		this.config_id = config_id;
	}
	public String getAction_id() {
		return action_id;
	}
	public void setAction_id(String action_id) {
		this.action_id = action_id;
	}
	public String getTree_role() {
		return tree_role;
	}
	public void setTree_role(String tree_role) {
		this.tree_role = tree_role;
	}
	public String getTree_nodetype() {
		return tree_nodetype;
	}
	public void setTree_nodetype(String tree_nodetype) {
		this.tree_nodetype = tree_nodetype;
	}
	
	
}
