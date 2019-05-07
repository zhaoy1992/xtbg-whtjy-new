package com.chinacreator.xtbg.pub.wordtemplate.entity;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-5-29
 */
public class WordVarBean {
	
	private String var_id;//变量主键
	private String template_id;//模板主键
	private String var_name;//变量名称
	private String var_value;//变量取值
	private String var_defaultvalue;//默认值
	private String var_desc;//描述
	
	public String getVar_id() {
		return var_id;
	}
	public void setVar_id(String var_id) {
		this.var_id = var_id;
	}
	public String getTemplate_id() {
		return template_id;
	}
	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}
	public String getVar_name() {
		return var_name;
	}
	public void setVar_name(String var_name) {
		this.var_name = var_name;
	}
	public String getVar_value() {
		return var_value;
	}
	public void setVar_value(String var_value) {
		this.var_value = var_value;
	}
	public String getVar_defaultvalue() {
		return var_defaultvalue;
	}
	public void setVar_defaultvalue(String var_defaultvalue) {
		this.var_defaultvalue = var_defaultvalue;
	}
	public String getVar_desc() {
		return var_desc;
	}
	public void setVar_desc(String var_desc) {
		this.var_desc = var_desc;
	}
	
	
}
