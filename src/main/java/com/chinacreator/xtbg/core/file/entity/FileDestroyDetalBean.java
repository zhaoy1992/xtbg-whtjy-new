package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:FileDestroyDetalBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-22
 */
// 档案销毁文件明细表  OA_FILE_DESTROY_DETAIL
public class FileDestroyDetalBean extends XtDbBaseBean{
	public  FileDestroyDetalBean (){
		super("OA_FILE_DESTROY_DETAIL","f_detail_id");
	}
	private String f_detail_id ;//销毁文件ID
	private String f_doc_id ;//文件ID
	private String f_user_id ;//销毁经手人ID
	private String f_user_name ;//销毁经手人姓名
	private Object f_destroy_time ;//销毁日期
	private String f_destroy_state ;//销毁状态
	private String f_destroy_id ;//销毁ID
	private String f_isagree_destroy ;//属否同意销毁
	
	//页面查询参数
	private String title; //标题
	private String stateime ; //销毁开始日期
	private String endtime; //销毁结束日期
	public String getF_destroy_id() {
		return f_destroy_id;
	}
	public void setF_destroy_id(String f_destroy_id) {
		this.f_destroy_id = f_destroy_id;
	}
	public String getF_detail_id() {
		return f_detail_id;
	}
	public void setF_detail_id(String f_detail_id) {
		this.f_detail_id = f_detail_id;
	}
	public String getF_doc_id() {
		return f_doc_id;
	}
	public void setF_doc_id(String f_doc_id) {
		this.f_doc_id = f_doc_id;
	}
	public String getF_user_id() {
		return f_user_id;
	}
	public void setF_user_id(String f_user_id) {
		this.f_user_id = f_user_id;
	}
	public String getF_user_name() {
		return f_user_name;
	}
	public void setF_user_name(String f_user_name) {
		this.f_user_name = f_user_name;
	}
	public Object getF_destroy_time() {
		return f_destroy_time;
	}
	public void setF_destroy_time(Object f_destroy_time) {
		this.f_destroy_time = f_destroy_time;
	}
	public String getF_destroy_state() {
		return f_destroy_state;
	}
	public void setF_destroy_state(String f_destroy_state) {
		this.f_destroy_state = f_destroy_state;
	}
	public String getF_isagree_destroy() {
		return f_isagree_destroy;
	}
	public void setF_isagree_destroy(String f_isagree_destroy) {
		this.f_isagree_destroy = f_isagree_destroy;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStateime() {
		return stateime;
	}
	public void setStateime(String stateime) {
		this.stateime = stateime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	
	
}
