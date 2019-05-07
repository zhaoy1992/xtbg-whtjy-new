package com.chinacreator.xtbg.core.kbm.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:KbmDocBssBean.java</p>
 *<p>Description:知识库文档评阅实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-15
 */
public class KbmDocBbsBean extends XtDbBaseBean {

	private String k_id;		//key
	private String k_create_user;		//评论人
	private String k_create_user_name;		//评论人name
	private String k_is_guest;		//是否匿名（1是，0否）
	private String k_doc_id;		//文档主键id
	private String k_title;		//文档标题
	private String k_content;		//评论内容(不超过200个了)
	private Object k_create_time;		//评论时间（设默认值）
	
	public KbmDocBbsBean(){
		super("oa_kbm_doc_bbs","k_id");
	}
	/**
	*<b>Summary: 获取key</b>
	*/
	public String getK_id() {
		return k_id;
	}
	/**
	*<b>Summary: 设置key</b>
	*/
	public void setK_id(String k_id) {
		this.k_id = k_id;
	}
	/**
	*<b>Summary: 获取评论人</b>
	*/
	public String getK_create_user() {
		return k_create_user;
	}
	/**
	*<b>Summary: 设置评论人</b>
	*/
	public void setK_create_user(String k_create_user) {
		this.k_create_user = k_create_user;
	}
	/**
	*<b>Summary: 获取评论人name</b>
	*/
	public String getK_create_user_name() {
		return k_create_user_name;
	}
	/**
	*<b>Summary: 设置评论人name</b>
	*/
	public void setK_create_user_name(String k_create_user_name) {
		this.k_create_user_name = k_create_user_name;
	}
	/**
	*<b>Summary: 获取是否匿名（1是，0否）</b>
	*/
	public String getK_is_guest() {
		return k_is_guest;
	}
	/**
	*<b>Summary: 设置是否匿名（1是，0否）</b>
	*/
	public void setK_is_guest(String k_is_guest) {
		this.k_is_guest = k_is_guest;
	}
	/**
	*<b>Summary: 获取文档主键id</b>
	*/
	public String getK_doc_id() {
		return k_doc_id;
	}
	/**
	*<b>Summary: 设置文档主键id</b>
	*/
	public void setK_doc_id(String k_doc_id) {
		this.k_doc_id = k_doc_id;
	}
	/**
	*<b>Summary: 获取文档标题</b>
	*/
	public String getK_title() {
		return k_title;
	}
	/**
	*<b>Summary: 设置文档标题</b>
	*/
	public void setK_title(String k_title) {
		this.k_title = k_title;
	}
	/**
	*<b>Summary: 获取评论内容(不超过200个了)</b>
	*/
	public String getK_content() {
		return k_content;
	}
	/**
	*<b>Summary: 设置评论内容(不超过200个了)</b>
	*/
	public void setK_content(String k_content) {
		this.k_content = k_content;
	}
	/**
	*<b>Summary: 获取评论时间（设默认值）</b>
	*/
	public Object getK_create_time() {
		return k_create_time;
	}
	/**
	*<b>Summary: 设置评论时间（设默认值）</b>
	*/
	public void setK_create_time(Object k_create_time) {
		this.k_create_time = k_create_time;
	}

}
