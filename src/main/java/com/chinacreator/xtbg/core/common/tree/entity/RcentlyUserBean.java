package com.chinacreator.xtbg.core.common.tree.entity;

/**
 * 
 *<p>Title:RcentlyUserBean.java</p>
 *<p>Description:最近处理人实体Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-9-12
 */
public class RcentlyUserBean {

	private String ru_id;		//主键ID
	private String ru_logn;		//操作标识
	private String ru_type;		//数据类型(1人，2机构)
	private String ru_data;		//数据
	private String user_id;		//用户ID
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getRu_id() {
		return ru_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setRu_id(String ru_id) {
		this.ru_id = ru_id;
	}
	/**
	*<b>Summary: 获取操作标识</b>
	*/
	public String getRu_logn() {
		return ru_logn;
	}
	/**
	*<b>Summary: 设置操作标识</b>
	*/
	public void setRu_logn(String ru_logn) {
		this.ru_logn = ru_logn;
	}
	/**
	*<b>Summary: 获取数据类型(1人，2机构)</b>
	*/
	public String getRu_type() {
		return ru_type;
	}
	/**
	*<b>Summary: 设置数据类型(1人，2机构)</b>
	*/
	public void setRu_type(String ru_type) {
		this.ru_type = ru_type;
	}
	/**
	*<b>Summary: 获取数据</b>
	*/
	public String getRu_data() {
		return ru_data;
	}
	/**
	*<b>Summary: 设置数据</b>
	*/
	public void setRu_data(String ru_data) {
		this.ru_data = ru_data;
	}
	/**
	*<b>Summary: 获取用户ID</b>
	*/
	public String getUser_id() {
		return user_id;
	}
	/**
	*<b>Summary: 设置用户ID</b>
	*/
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
}
