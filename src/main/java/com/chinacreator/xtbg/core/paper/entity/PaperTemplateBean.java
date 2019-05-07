package com.chinacreator.xtbg.core.paper.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:PaperTemplateBean.java</p>
 *<p>Description:信息报送模版管理</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-13
 */
public class PaperTemplateBean extends XtDbBaseBean {
	
	private String p_template_id;		//主键ID
	private String p_template_name;		//模板名称
	private String p_template_typeid;	//模板类型id
	private String p_template_typename;	//模板类型名称
	private String create_userid;		//创建人id
	private String create_username;		//创建人
	private String p_template_unitid;	//使用单位ID
	private String p_template_unit;		//使用单位
	private Object create_time;		//创建时间
	private String content;			//内容
	
	public PaperTemplateBean() {
		super("oa_paper_template", "p_template_id");
	}
	/**
	*<b>Summary: 获取创建人id</b>
	*/
	public String getCreate_userid() {
		return create_userid;
	}
	/**
	*<b>Summary: 设置创建人id</b>
	*/
	public void setCreate_userid(String create_userid) {
		this.create_userid = create_userid;
	}
	/**
	*<b>Summary: 获取创建人</b>
	*/
	public String getCreate_username() {
		return create_username;
	}
	/**
	*<b>Summary: 设置创建人</b>
	*/
	public void setCreate_username(String create_username) {
		this.create_username = create_username;
	}
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getP_template_id() {
		return p_template_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setP_template_id(String p_template_id) {
		this.p_template_id = p_template_id;
	}
	/**
	*<b>Summary: 获取模板名称</b>
	*/
	public String getP_template_name() {
		return p_template_name;
	}
	/**
	*<b>Summary: 设置模板名称</b>
	*/
	public void setP_template_name(String p_template_name) {
		this.p_template_name = p_template_name;
	}
	/**
	*<b>Summary: 获取模板类型id</b>
	*/
	public String getP_template_typeid() {
		return p_template_typeid;
	}
	/**
	*<b>Summary: 设置模板类型id</b>
	*/
	public void setP_template_typeid(String p_template_typeid) {
		this.p_template_typeid = p_template_typeid;
	}
	/**
	*<b>Summary: 获取使用单位ID</b>
	*/
	public String getP_template_unitid() {
		return p_template_unitid;
	}
	/**
	*<b>Summary: 设置使用单位ID</b>
	*/
	public void setP_template_unitid(String p_template_unitid) {
		this.p_template_unitid = p_template_unitid;
	}
	/**
	*<b>Summary: 获取使用单位</b>
	*/
	public String getP_template_unit() {
		return p_template_unit;
	}
	/**
	*<b>Summary: 设置使用单位</b>
	*/
	public void setP_template_unit(String p_template_unit) {
		this.p_template_unit = p_template_unit;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public Object getCreate_time() {
		return create_time;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setCreate_time(Object create_time) {
		this.create_time = create_time;
	}
	/**
	*<b>Summary: 获取内容</b>
	*/
	public String getContent() {
		return content;
	}
	/**
	*<b>Summary: 设置内容</b>
	*/
	public void setContent(String content) {
		this.content = content;
	}
	/**
	*<b>Summary: 获取模版类型名称</b>
	*/
	public String getP_template_typename() {
		return p_template_typename;
	}
	/**
	*<b>Summary: 设置模版类型名称</b>
	*/
	public void setP_template_typename(String p_template_typename) {
		this.p_template_typename = p_template_typename;
	}
	
	
}	
