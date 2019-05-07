package com.chinacreator.xtbg.core.kbm.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:KbmDocRssBean.java</p>
 *<p>Description:文档订阅实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-13
 */
public class KbmDocRssBean extends XtDbBaseBean {

	private String k_rss_id;		//主键
	private String k_rss_user;		//订阅用户
	private String k_rss_user_name;		//订阅用户name
	private Object k_create_time;		//订阅时间
	private String k_type_id;		//订阅的分类
	private String k_type_name;		//订阅的分类name
	private String k_key;		//订阅的关键字（界面提示逗号分开）
	
	public KbmDocRssBean(){
		super("oa_kbm_doc_rss","k_rss_id");
	}
	/**
	*<b>Summary: 获取主键</b>
	*/
	public String getK_rss_id() {
		return k_rss_id;
	}
	/**
	*<b>Summary: 设置主键</b>
	*/
	public void setK_rss_id(String k_rss_id) {
		this.k_rss_id = k_rss_id;
	}
	/**
	*<b>Summary: 获取订阅用户</b>
	*/
	public String getK_rss_user() {
		return k_rss_user;
	}
	/**
	*<b>Summary: 设置订阅用户</b>
	*/
	public void setK_rss_user(String k_rss_user) {
		this.k_rss_user = k_rss_user;
	}
	/**
	*<b>Summary: 获取订阅用户name</b>
	*/
	public String getK_rss_user_name() {
		return k_rss_user_name;
	}
	/**
	*<b>Summary: 设置订阅用户name</b>
	*/
	public void setK_rss_user_name(String k_rss_user_name) {
		this.k_rss_user_name = k_rss_user_name;
	}
	/**
	*<b>Summary: 获取订阅时间</b>
	*/
	public Object getK_create_time() {
		return k_create_time;
	}
	/**
	*<b>Summary: 设置订阅时间</b>
	*/
	public void setK_create_time(Object k_create_time) {
		this.k_create_time = k_create_time;
	}
	/**
	*<b>Summary: 获取订阅的分类</b>
	*/
	public String getK_type_id() {
		return k_type_id;
	}
	/**
	*<b>Summary: 设置订阅的分类</b>
	*/
	public void setK_type_id(String k_type_id) {
		this.k_type_id = k_type_id;
	}
	/**
	*<b>Summary: 获取订阅的分类name</b>
	*/
	public String getK_type_name() {
		return k_type_name;
	}
	/**
	*<b>Summary: 设置订阅的分类name</b>
	*/
	public void setK_type_name(String k_type_name) {
		this.k_type_name = k_type_name;
	}
	/**
	*<b>Summary: 获取订阅的关键字（界面提示逗号分开）</b>
	*/
	public String getK_key() {
		return k_key;
	}
	/**
	*<b>Summary: 设置订阅的关键字（界面提示逗号分开）</b>
	*/
	public void setK_key(String k_key) {
		this.k_key = k_key;
	}
}
