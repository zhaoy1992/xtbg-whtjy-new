package com.chinacreator.xtbg.core.kbm.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:KbmDocSuggestBean.java</p>
 *<p>Description:知识库文档推荐实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-16
 */
public class KbmDocSuggestBean extends XtDbBaseBean {

	private String k_id;		//主键
	private String k_user;		//被推荐用户id
	private String k_user_name;		//被推荐用户name
	private String k_is_read;		//是否已阅读
	private Object k_read_time;		//阅读时间
	private String k_create_user;		//推荐人
	private String k_create_user_name;		//推荐人name
	private Object k_create_time;		//推荐j时间
	private String k_type;		//所属分类
	private String k_type_name;		//所属分类name
	private String k_doc_id;		//知识库id
	private String k_title;		//标题
	private String k_unit;		//来源
	private String k_unit_name;		//来源name
	
	public KbmDocSuggestBean(){
		super("oa_kbm_doc_suggest","k_id");
	}
	/**
	*<b>Summary: 获取主键</b>
	*/
	public String getK_id() {
		return k_id;
	}
	/**
	*<b>Summary: 设置主键</b>
	*/
	public void setK_id(String k_id) {
		this.k_id = k_id;
	}
	/**
	*<b>Summary: 获取被推荐用户id</b>
	*/
	public String getK_user() {
		return k_user;
	}
	/**
	*<b>Summary: 设置被推荐用户id</b>
	*/
	public void setK_user(String k_user) {
		this.k_user = k_user;
	}
	/**
	*<b>Summary: 获取被推荐用户name</b>
	*/
	public String getK_user_name() {
		return k_user_name;
	}
	/**
	*<b>Summary: 设置被推荐用户name</b>
	*/
	public void setK_user_name(String k_user_name) {
		this.k_user_name = k_user_name;
	}
	/**
	*<b>Summary: 获取是否已阅读</b>
	*/
	public String getK_is_read() {
		return k_is_read;
	}
	/**
	*<b>Summary: 设置是否已阅读</b>
	*/
	public void setK_is_read(String k_is_read) {
		this.k_is_read = k_is_read;
	}
	/**
	*<b>Summary: 获取阅读时间</b>
	*/
	public Object getK_read_time() {
		return k_read_time;
	}
	/**
	*<b>Summary: 设置阅读时间</b>
	*/
	public void setK_read_time(Object k_read_time) {
		this.k_read_time = k_read_time;
	}
	/**
	*<b>Summary: 获取推荐人</b>
	*/
	public String getK_create_user() {
		return k_create_user;
	}
	/**
	*<b>Summary: 设置推荐人</b>
	*/
	public void setK_create_user(String k_create_user) {
		this.k_create_user = k_create_user;
	}
	/**
	*<b>Summary: 获取推荐人name</b>
	*/
	public String getK_create_user_name() {
		return k_create_user_name;
	}
	/**
	*<b>Summary: 设置推荐人name</b>
	*/
	public void setK_create_user_name(String k_create_user_name) {
		this.k_create_user_name = k_create_user_name;
	}
	/**
	*<b>Summary: 获取推荐j时间</b>
	*/
	public Object getK_create_time() {
		return k_create_time;
	}
	/**
	*<b>Summary: 设置推荐j时间</b>
	*/
	public void setK_create_time(Object k_create_time) {
		this.k_create_time = k_create_time;
	}
	/**
	*<b>Summary: 获取所属分类</b>
	*/
	public String getK_type() {
		return k_type;
	}
	/**
	*<b>Summary: 设置所属分类</b>
	*/
	public void setK_type(String k_type) {
		this.k_type = k_type;
	}
	/**
	*<b>Summary: 获取所属分类name</b>
	*/
	public String getK_type_name() {
		return k_type_name;
	}
	/**
	*<b>Summary: 设置所属分类name</b>
	*/
	public void setK_type_name(String k_type_name) {
		this.k_type_name = k_type_name;
	}
	/**
	*<b>Summary: 获取知识库id</b>
	*/
	public String getK_doc_id() {
		return k_doc_id;
	}
	/**
	*<b>Summary: 设置知识库id</b>
	*/
	public void setK_doc_id(String k_doc_id) {
		this.k_doc_id = k_doc_id;
	}
	/**
	*<b>Summary: 获取标题</b>
	*/
	public String getK_title() {
		return k_title;
	}
	/**
	*<b>Summary: 设置标题</b>
	*/
	public void setK_title(String k_title) {
		this.k_title = k_title;
	}
	/**
	*<b>Summary: 获取来源</b>
	*/
	public String getK_unit() {
		return k_unit;
	}
	/**
	*<b>Summary: 设置来源</b>
	*/
	public void setK_unit(String k_unit) {
		this.k_unit = k_unit;
	}
	/**
	*<b>Summary: 获取来源name</b>
	*/
	public String getK_unit_name() {
		return k_unit_name;
	}
	/**
	*<b>Summary: 设置来源name</b>
	*/
	public void setK_unit_name(String k_unit_name) {
		this.k_unit_name = k_unit_name;
	}
}
