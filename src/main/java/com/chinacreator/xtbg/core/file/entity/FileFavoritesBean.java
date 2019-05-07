package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:FileFavoritesBean.java</p>
 *<p>Description:收藏文件Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 24, 2013
 */
public class FileFavoritesBean extends XtDbBaseBean{
	
	public FileFavoritesBean(){
		//在构造器里面设置好表名和主键，具体进行更新，删除等操作时可以重新设置updateKey，deleteKey，及主键
		super("oa_file_favorites", "f_favorites_id");
	}
	private String f_favorites_id;		//收藏ID
	private String f_doc_id;		//文件ID
	private String f_user_id;		//用户ID
	private Object f_favorites_time;		//收藏日期
	/**
	*<b>Summary: 获取收藏ID</b>
	*/
	public String getF_favorites_id() {
		return f_favorites_id;
	}
	/**
	*<b>Summary: 设置收藏ID</b>
	*/
	public void setF_favorites_id(String f_favorites_id) {
		this.f_favorites_id = f_favorites_id;
	}
	/**
	*<b>Summary: 获取文件ID</b>
	*/
	public String getF_doc_id() {
		return f_doc_id;
	}
	/**
	*<b>Summary: 设置文件ID</b>
	*/
	public void setF_doc_id(String f_doc_id) {
		this.f_doc_id = f_doc_id;
	}
	/**
	*<b>Summary: 获取用户ID</b>
	*/
	public String getF_user_id() {
		return f_user_id;
	}
	/**
	*<b>Summary: 设置用户ID</b>
	*/
	public void setF_user_id(String f_user_id) {
		this.f_user_id = f_user_id;
	}
	/**
	*<b>Summary: 获取收藏日期</b>
	*/
	public Object getF_favorites_time() {
		return f_favorites_time;
	}
	/**
	*<b>Summary: 设置收藏日期</b>
	*/
	public void setF_favorites_time(Object f_favorites_time) {
		this.f_favorites_time = f_favorites_time;
	}
	
	
}
