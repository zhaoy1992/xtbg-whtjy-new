package com.chinacreator.xtbg.core.task.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:TaskTypeBean.java</p>
 *<p>Description:任务交办字典表映射类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-9
 */
public class TaskTypeBean extends XtDbBaseBean{
	private String type_id;		//主键id
	private String type_name;		//类型名称
	private String type_sort;		//类型分类
	private String type_value;		//类型value
	public TaskTypeBean(){
		super("oa_task_type","type_id");
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getType_id() {
		return type_id;
	}
	/**
	*<b>Summary: 设置id</b>
	*/
	public void setType_id(String type_id) {
		this.type_id = type_id;
	}
	/**
	*<b>Summary: 获取类型名称</b>
	*/
	public String getType_name() {
		return type_name;
	}
	/**
	*<b>Summary: 设置类型名称</b>
	*/
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	/**
	*<b>Summary: 获取类型分类</b>
	*/
	public String getType_sort() {
		return type_sort;
	}
	/**
	*<b>Summary: 设置类型分类</b>
	*/
	public void setType_sort(String type_sort) {
		this.type_sort = type_sort;
	}
	/**
	*<b>Summary: 获取类型value</b>
	*/
	public String getType_value() {
		return type_value;
	}
	/**
	*<b>Summary: 设置类型value</b>
	*/
	public void setType_value(String type_value) {
		this.type_value = type_value;
	}
}
