package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 档案移交明细OA_FILES_DEVOLVE_DETAIL
 *<p>Title:FileFilesDevolveDetailBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Sep 16, 2013
 */
public class FileFilesDevolveDetailBean  extends XtDbBaseBean{
	
	public FileFilesDevolveDetailBean() {
		super("OA_FILES_DEVOLVE_DETAIL", "f_devolve_detail_id");
	}
	private String f_devolve_detail_id;		//移交明细记录ID
	private String f_devolve_id;		//所属移交记录ID
	private String f_files_id;		//关联的案卷ID
	private Object f_start_time;		//档案开始日期
	private Object f_end_time;		//档案结束日期
	private String f_page_num;		//页数
	private String f_state;		//移交状态(0:暂存,1:已移交)
	//VO
	private String f_fondsno;
	private String f_listno;
	private String f_filesno;
	private String f_type_name;
	private String f_files_title;
	private String f_start_end_time;
	private String f_doc_deadline_name;
	/**
	*<b>Summary: 获取移交明细记录ID</b>
	*/
	public String getF_devolve_detail_id() {
		return f_devolve_detail_id;
	}
	/**
	*<b>Summary: 设置移交明细记录ID</b>
	*/
	public void setF_devolve_detail_id(String f_devolve_detail_id) {
		this.f_devolve_detail_id = f_devolve_detail_id;
	}
	/**
	*<b>Summary: 获取所属移交记录ID</b>
	*/
	public String getF_devolve_id() {
		return f_devolve_id;
	}
	/**
	*<b>Summary: 设置所属移交记录ID</b>
	*/
	public void setF_devolve_id(String f_devolve_id) {
		this.f_devolve_id = f_devolve_id;
	}
	/**
	*<b>Summary: 获取关联的案卷ID</b>
	*/
	public String getF_files_id() {
		return f_files_id;
	}
	/**
	*<b>Summary: 设置关联的案卷ID</b>
	*/
	public void setF_files_id(String f_files_id) {
		this.f_files_id = f_files_id;
	}
	/**
	*<b>Summary: 获取档案开始日期</b>
	*/
	public Object getF_start_time() {
		return f_start_time;
	}
	/**
	*<b>Summary: 设置档案开始日期</b>
	*/
	public void setF_start_time(Object f_start_time) {
		this.f_start_time = f_start_time;
	}
	/**
	*<b>Summary: 获取档案结束日期</b>
	*/
	public Object getF_end_time() {
		return f_end_time;
	}
	/**
	*<b>Summary: 设置档案结束日期</b>
	*/
	public void setF_end_time(Object f_end_time) {
		this.f_end_time = f_end_time;
	}
	/**
	*<b>Summary: 获取页数</b>
	*/
	public String getF_page_num() {
		return f_page_num;
	}
	/**
	*<b>Summary: 设置页数</b>
	*/
	public void setF_page_num(String f_page_num) {
		this.f_page_num = f_page_num;
	}
	/**
	*<b>Summary: 获取移交状态(0:暂存,1:已移交)</b>
	*/
	public String getF_state() {
		return f_state;
	}
	/**
	*<b>Summary: 设置移交状态(0:暂存,1:已移交)</b>
	*/
	public void setF_state(String f_state) {
		this.f_state = f_state;
	}
	public String getF_fondsno() {
		return f_fondsno;
	}
	public void setF_fondsno(String f_fondsno) {
		this.f_fondsno = f_fondsno;
	}
	public String getF_listno() {
		return f_listno;
	}
	public void setF_listno(String f_listno) {
		this.f_listno = f_listno;
	}
	public String getF_filesno() {
		return f_filesno;
	}
	public void setF_filesno(String f_filesno) {
		this.f_filesno = f_filesno;
	}
	public String getF_type_name() {
		return f_type_name;
	}
	public void setF_type_name(String f_type_name) {
		this.f_type_name = f_type_name;
	}
	public String getF_files_title() {
		return f_files_title;
	}
	public void setF_files_title(String f_files_title) {
		this.f_files_title = f_files_title;
	}
	public String getF_start_end_time() {
		return f_start_end_time;
	}
	public void setF_start_end_time(String f_start_end_time) {
		this.f_start_end_time = f_start_end_time;
	}
	public String getF_doc_deadline_name() {
		return f_doc_deadline_name;
	}
	public void setF_doc_deadline_name(String f_doc_deadline_name) {
		this.f_doc_deadline_name = f_doc_deadline_name;
	}
}
