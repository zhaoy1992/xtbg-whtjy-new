package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:FilePanExtBean.java</p>
 *<p>Description:文件扩展信息表</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-9-30
 */
public class FilePanExtBean extends XtDbBaseBean{
	public FilePanExtBean(){
		super("oa_file_pan_ext","f_pan_id");
	}
	private String f_pan_id;		//文件扩充属性ID
	private String f_doc_id;		//文件ID
	private String f_specification;		//规格
	private String f_shooting_user;		//拍摄人
	private String f_add;		//null
	private String f_person;		//null
	private String f_background;		//null
	private String f_save_format;		//存储格式
	/**
	*<b>Summary: 获取文件扩充属性ID</b>
	*/
	public String getF_pan_id() {
		return f_pan_id;
	}
	/**
	*<b>Summary: 设置文件扩充属性ID</b>
	*/
	public void setF_pan_id(String f_pan_id) {
		this.f_pan_id = f_pan_id;
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
	*<b>Summary: 获取规格</b>
	*/
	public String getF_specification() {
		return f_specification;
	}
	/**
	*<b>Summary: 设置规格</b>
	*/
	public void setF_specification(String f_specification) {
		this.f_specification = f_specification;
	}
	/**
	*<b>Summary: 获取拍摄人</b>
	*/
	public String getF_shooting_user() {
		return f_shooting_user;
	}
	/**
	*<b>Summary: 设置拍摄人</b>
	*/
	public void setF_shooting_user(String f_shooting_user) {
		this.f_shooting_user = f_shooting_user;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getF_add() {
		return f_add;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setF_add(String f_add) {
		this.f_add = f_add;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getF_person() {
		return f_person;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setF_person(String f_person) {
		this.f_person = f_person;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getF_background() {
		return f_background;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setF_background(String f_background) {
		this.f_background = f_background;
	}
	/**
	*<b>Summary: 获取存储格式</b>
	*/
	public String getF_save_format() {
		return f_save_format;
	}
	/**
	*<b>Summary: 设置存储格式</b>
	*/
	public void setF_save_format(String f_save_format) {
		this.f_save_format = f_save_format;
	}

}
