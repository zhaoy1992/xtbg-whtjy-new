package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 档案查看记录(一人一档案一天一条)
 *<p>Title:FileReadRecodeInfoBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Oct 22, 2013
 */
public class FileReadRecodeInfoBean extends XtDbBaseBean{
	
	public FileReadRecodeInfoBean(){
		super("OA_FILE_READ_RECODE_INFO", "f_id");
	}
	
	private String f_id;		//记录编号
	private String f_user_id;		//用户ID
	private String f_user_name;		//用户名称
	private String f_org_id;		//用户所属机构ID
	private String f_org_name;		//用户所属机构名称
	private String f_dept_id;		//用户所属部门ID
	private String f_dept_name;		//用户所属部门名称
	private String recode_type;		//记录类型:阅读1 
	private String f_doc_id;		//档案ID(文件ID)
	private String f_type_id;		//档案所属类型ID(可能过期)
	private String f_type_name;		//档案所属类型Name(全路径)(可能过期)
	private String f_page_id;		//档案所属页面ID
	private String f_year;		//查看记录所属年份(冗余方便查询)
	private String f_month;		//查看月份(冗余方便查询)
	private String f_date;		//查看日期(冗余方便查询)
	private String read_count;		//单日内查看次数
	private Object f_create_time;		//记录创建时间
	private Object f_update_time;		//记录最近更新时间
	private String f_doc_name;		//档案名称(可能过期)
	private String f_files_id;		//档案所属案卷ID(查看会计是已案卷为单位)
	/**
	*<b>Summary: 获取记录编号</b>
	*/
	public String getF_id() {
		return f_id;
	}
	/**
	*<b>Summary: 设置记录编号</b>
	*/
	public void setF_id(String f_id) {
		this.f_id = f_id;
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
	*<b>Summary: 获取用户名称</b>
	*/
	public String getF_user_name() {
		return f_user_name;
	}
	/**
	*<b>Summary: 设置用户名称</b>
	*/
	public void setF_user_name(String f_user_name) {
		this.f_user_name = f_user_name;
	}
	/**
	*<b>Summary: 获取用户所属机构ID</b>
	*/
	public String getF_org_id() {
		return f_org_id;
	}
	/**
	*<b>Summary: 设置用户所属机构ID</b>
	*/
	public void setF_org_id(String f_org_id) {
		this.f_org_id = f_org_id;
	}
	/**
	*<b>Summary: 获取用户所属机构名称</b>
	*/
	public String getF_org_name() {
		return f_org_name;
	}
	/**
	*<b>Summary: 设置用户所属机构名称</b>
	*/
	public void setF_org_name(String f_org_name) {
		this.f_org_name = f_org_name;
	}
	/**
	*<b>Summary: 获取用户所属部门ID</b>
	*/
	public String getF_dept_id() {
		return f_dept_id;
	}
	/**
	*<b>Summary: 设置用户所属部门ID</b>
	*/
	public void setF_dept_id(String f_dept_id) {
		this.f_dept_id = f_dept_id;
	}
	/**
	*<b>Summary: 获取用户所属部门名称</b>
	*/
	public String getF_dept_name() {
		return f_dept_name;
	}
	/**
	*<b>Summary: 设置用户所属部门名称</b>
	*/
	public void setF_dept_name(String f_dept_name) {
		this.f_dept_name = f_dept_name;
	}
	/**
	*<b>Summary: 获取记录类型:阅读1 </b>
	*/
	public String getRecode_type() {
		return recode_type;
	}
	/**
	*<b>Summary: 设置记录类型:阅读1 </b>
	*/
	public void setRecode_type(String recode_type) {
		this.recode_type = recode_type;
	}
	/**
	*<b>Summary: 获取档案ID(文件ID)</b>
	*/
	public String getF_doc_id() {
		return f_doc_id;
	}
	/**
	*<b>Summary: 设置档案ID(文件ID)</b>
	*/
	public void setF_doc_id(String f_doc_id) {
		this.f_doc_id = f_doc_id;
	}
	/**
	*<b>Summary: 获取档案所属类型ID(可能过期)</b>
	*/
	public String getF_type_id() {
		return f_type_id;
	}
	/**
	*<b>Summary: 设置档案所属类型ID(可能过期)</b>
	*/
	public void setF_type_id(String f_type_id) {
		this.f_type_id = f_type_id;
	}
	/**
	*<b>Summary: 获取档案所属类型Name(全路径)(可能过期)</b>
	*/
	public String getF_type_name() {
		return f_type_name;
	}
	/**
	*<b>Summary: 设置档案所属类型Name(全路径)(可能过期)</b>
	*/
	public void setF_type_name(String f_type_name) {
		this.f_type_name = f_type_name;
	}
	/**
	*<b>Summary: 获取档案所属页面ID</b>
	*/
	public String getF_page_id() {
		return f_page_id;
	}
	/**
	*<b>Summary: 设置档案所属页面ID</b>
	*/
	public void setF_page_id(String f_page_id) {
		this.f_page_id = f_page_id;
	}
	/**
	*<b>Summary: 获取查看记录所属年份(冗余方便查询)</b>
	*/
	public String getF_year() {
		return f_year;
	}
	/**
	*<b>Summary: 设置查看记录所属年份(冗余方便查询)</b>
	*/
	public void setF_year(String f_year) {
		this.f_year = f_year;
	}
	/**
	*<b>Summary: 获取查看月份(冗余方便查询)</b>
	*/
	public String getF_month() {
		return f_month;
	}
	/**
	*<b>Summary: 设置查看月份(冗余方便查询)</b>
	*/
	public void setF_month(String f_month) {
		this.f_month = f_month;
	}
	/**
	*<b>Summary: 获取查看日期(冗余方便查询)</b>
	*/
	public String getF_date() {
		return f_date;
	}
	/**
	*<b>Summary: 设置查看日期(冗余方便查询)</b>
	*/
	public void setF_date(String f_date) {
		this.f_date = f_date;
	}
	/**
	*<b>Summary: 获取单日内查看次数</b>
	*/
	public String getRead_count() {
		return read_count;
	}
	/**
	*<b>Summary: 设置单日内查看次数</b>
	*/
	public void setRead_count(String read_count) {
		this.read_count = read_count;
	}
	/**
	*<b>Summary: 获取记录创建时间</b>
	*/
	public Object getF_create_time() {
		return f_create_time;
	}
	/**
	*<b>Summary: 设置记录创建时间</b>
	*/
	public void setF_create_time(Object f_create_time) {
		this.f_create_time = f_create_time;
	}
	/**
	*<b>Summary: 获取记录最近更新时间</b>
	*/
	public Object getF_update_time() {
		return f_update_time;
	}
	/**
	*<b>Summary: 设置记录最近更新时间</b>
	*/
	public void setF_update_time(Object f_update_time) {
		this.f_update_time = f_update_time;
	}
	/**
	*<b>Summary: 获取档案名称(可能过期)</b>
	*/
	public String getF_doc_name() {
		return f_doc_name;
	}
	/**
	*<b>Summary: 设置档案名称(可能过期)</b>
	*/
	public void setF_doc_name(String f_doc_name) {
		this.f_doc_name = f_doc_name;
	}
	/**
	*<b>Summary: 获取档案所属案卷ID(查看会计是已案卷为单位)</b>
	*/
	public String getF_files_id() {
		return f_files_id;
	}
	/**
	*<b>Summary: 设置档案所属案卷ID(查看会计是已案卷为单位)</b>
	*/
	public void setF_files_id(String f_files_id) {
		this.f_files_id = f_files_id;
	}
}
