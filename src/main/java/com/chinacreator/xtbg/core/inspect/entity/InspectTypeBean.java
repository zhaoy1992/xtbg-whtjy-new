package com.chinacreator.xtbg.core.inspect.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:InspectTypeBean.java</p>
 *<p>Description:督查督办任务类别bean</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-10-29
 */
public class InspectTypeBean extends XtDbBaseBean{
    public InspectTypeBean(){
    	super("oa_inspect_type","type_id");
    }	
	private String type_id;		//类别主键
	private String type_name;		//类别名称
	private String type_remark;		//说明
	private String type_template;		//督办内容模板
	private String type_order;     //排序号
	/**
	*<b>Summary: 获取类别主键</b>
	*/
	public String getType_id() {
		return type_id;
	}
	/**
	*<b>Summary: 设置类别主键</b>
	*/
	public void setType_id(String type_id) {
		this.type_id = type_id;
	}
	/**
	*<b>Summary: 获取类别名称</b>
	*/
	public String getType_name() {
		return type_name;
	}
	/**
	*<b>Summary: 设置类别名称</b>
	*/
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	/**
	*<b>Summary: 获取说明</b>
	*/
	public String getType_remark() {
		return type_remark;
	}
	/**
	*<b>Summary: 设置说明</b>
	*/
	public void setType_remark(String type_remark) {
		this.type_remark = type_remark;
	}
	/**
	*<b>Summary: 获取督办内容模板</b>
	*/
	public String getType_template() {
		return type_template;
	}
	/**
	*<b>Summary: 设置督办内容模板</b>
	*/
	public void setType_template(String type_template) {
		this.type_template = type_template;
	}
	public String getType_order() {
		return type_order;
	}
	public void setType_order(String typeOrder) {
		type_order = typeOrder;
	}

}
