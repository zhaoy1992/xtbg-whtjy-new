package com.chinacreator.xtbg.core.form.entity;
/**
 * 
 *<p>Title:OaFormconfigBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-6-29
 */
public class OaFormConfigBean {
	private String form_id;		//表单ID
	private String form_name;		//表单名称
	private String form_jsp_name;		//表单JSP名称
	private String form_background;		//表单底色
	private String tag_background;		//元素底色
	private String tag_width;		//元素宽度
	private String tag_height;		//元素高度
	private String tag_margins;		//元素间隔PX
	private String from_ext_parm;		//表单扩展属性
	private String is_text; 	//是否有正文。
	private String form_width;	//表单宽度
	
	public String getForm_width() {
		return form_width;
	}
	public void setForm_width(String form_width) {
		this.form_width = form_width;
	}
	public String getIs_text() {
		return is_text;
	}
	public void setIs_text(String is_text) {
		this.is_text = is_text;
	}
	public String getForm_id() {
		return form_id;
	}
	public void setForm_id(String form_id) {
		this.form_id = form_id;
	}
	public String getForm_name() {
		return form_name;
	}
	public void setForm_name(String form_name) {
		this.form_name = form_name;
	}
	public String getForm_jsp_name() {
		return form_jsp_name;
	}
	public void setForm_jsp_name(String form_jsp_name) {
		this.form_jsp_name = form_jsp_name;
	}
	public String getForm_background() {
		return form_background;
	}
	public void setForm_background(String form_background) {
		this.form_background = form_background;
	}
	public String getTag_background() {
		return tag_background;
	}
	public void setTag_background(String tag_background) {
		this.tag_background = tag_background;
	}
	public String getTag_width() {
		return tag_width;
	}
	public void setTag_width(String tag_width) {
		this.tag_width = tag_width;
	}
	public String getTag_height() {
		return tag_height;
	}
	public void setTag_height(String tag_height) {
		this.tag_height = tag_height;
	}
	public String getTag_margins() {
		return tag_margins;
	}
	public void setTag_margins(String tag_margins) {
		this.tag_margins = tag_margins;
	}
	public String getFrom_ext_parm() {
		return from_ext_parm;
	}
	public void setFrom_ext_parm(String from_ext_parm) {
		this.from_ext_parm = from_ext_parm;
	}
}
