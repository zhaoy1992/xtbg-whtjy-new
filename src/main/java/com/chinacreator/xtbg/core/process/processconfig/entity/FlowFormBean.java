package com.chinacreator.xtbg.core.process.processconfig.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:aaaaa.java</p>
 *<p>Description:流程表单表</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-4
 */
public class FlowFormBean extends XtDbBaseBean{
	private String form_path;		//表单路径
	private String form_name;		//表单名称
	private String form_desc;		//表单描述
	private Object creator_time;		//创建时间
	public FlowFormBean(){
		super("oa_flow_form");
	}
	/**
	*<b>Summary: 获取表单路径</b>
	*/
	public String getForm_path() {
		return form_path;
	}
	/**
	*<b>Summary: 设置表单路径</b>
	*/
	public void setForm_path(String form_path) {
		this.form_path = form_path;
	}
	/**
	*<b>Summary: 获取表单名称</b>
	*/
	public String getForm_name() {
		return form_name;
	}
	/**
	*<b>Summary: 设置表单名称</b>
	*/
	public void setForm_name(String form_name) {
		this.form_name = form_name;
	}
	/**
	*<b>Summary: 获取表单描述</b>
	*/
	public String getForm_desc() {
		return form_desc;
	}
	/**
	*<b>Summary: 设置表单描述</b>
	*/
	public void setForm_desc(String form_desc) {
		this.form_desc = form_desc;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public Object getCreator_time() {
		return creator_time;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setCreator_time(Object creator_time) {
		this.creator_time = creator_time;
	}
}
