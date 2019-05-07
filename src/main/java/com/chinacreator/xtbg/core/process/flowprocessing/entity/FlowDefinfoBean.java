package com.chinacreator.xtbg.core.process.flowprocessing.entity;

/**
 *<p>Title:FlowDefinfoBean.java</p>
 *<p>Description:流程定义Bean</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-2-2
 */
public class FlowDefinfoBean {
	
	private String flow_id;  //流程ID
	
	private String flow_defid;  //流程定义ID
	
	private String flow_version; //流程版本
	
	private String package_id; //流程包
	
	private String action_form; //环节表单
	
	private String action_defid;  //活动定义ID
	
	private String def_id; //流程定义主键
	
	private String insname_rule; //实例名称生成规则
	
	public String getInsname_rule() {
		return insname_rule;
	}

	public void setInsname_rule(String insname_rule) {
		this.insname_rule = insname_rule;
	}

	public String getDef_id() {
		return def_id;
	}

	public void setDef_id(String def_id) {
		this.def_id = def_id;
	}

	public String getAction_defid() {
		return action_defid;
	}

	public void setAction_defid(String action_defid) {
		this.action_defid = action_defid;
	}

	public String getAction_form() {
		return action_form;
	}

	public void setAction_form(String action_form) {
		this.action_form = action_form;
	}

	public String getFlow_id() {
		return flow_id;
	}

	public void setFlow_id(String flow_id) {
		this.flow_id = flow_id;
	}

	public String getFlow_defid() {
		return flow_defid;
	}

	public void setFlow_defid(String flow_defid) {
		this.flow_defid = flow_defid;
	}

	public String getFlow_version() {
		return flow_version;
	}

	public void setFlow_version(String flow_version) {
		this.flow_version = flow_version;
	}

	public String getPackage_id() {
		return package_id;
	}

	public void setPackage_id(String package_id) {
		this.package_id = package_id;
	}

}
