package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:FileLendingDetailBean.java</p>
 *<p>Description:借阅明细Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 24, 2013
 */
public class FileLendingDetailBean extends XtDbBaseBean{
	
	public FileLendingDetailBean(){
		//在构造器里面设置好表名和主键，具体进行更新，删除等操作时可以重新设置updateKey，deleteKey，及主键
		super("oa_file_lending_detail", "f_detail_id");
	}
	private String f_detail_id;		//借阅文件详细 ID
	private String f_doc_id;		//文件ID
	private String f_lending_type;		//借阅类型
	private String f_isagree;		//是否同意借阅
	private String f_islending;		//是否已借阅
	private Object f_lending_time;		//借阅日期
	private String f_lending_day;		//借阅天数
	private String f_user_id;		//借出经手人ID
	private String f_user_name;		//借出经手人姓名
	private String f_isback;		//是否已归还
	private Object f_reback_time;		//计划归还日期
	private String f_back_userid;		//归还经手人ID
	private String f_back_username;		//归还经手人姓名
	private String f_read_purview;		//申请的阅读权限
	private String f_read_approve;		//批准的阅读权限
	private String f_lending_userid;		//借阅人ID
	private Object f_back_time;		//归还日期
	
	private String f_lending_id;		//借阅ID
	private String f_docname;		//文件标题 页面查询参数 
	private String f_creator_state_time;		//开始日期 查询参数
	private String f_creator_end_time;		//结束日期 查询参数
	private String f_dep_name;		//所属部门
	private String f_file_no;		//挡号f_file_no
	
	private String jsp_type; //3也列表页面 指向一个LIST 用jsptype 来区分执行哪条sql
	
	private String f_lending_type_name;
	//for 档案借阅管理--待借阅查询 begin
	private String f_doc_num;
	private String f_files_no;
	private String f_doc_name;
	private String f_file_num;
	private String f_lending_username;
	private String f_dept_name;
	private String f_type_name;
	//for 档案借阅管理--待借阅查询 end
	
	//for 档案借阅申请--申请中 begin
	private String f_lending_reason;
	private String f_creator_time;
	private String status_code;
	private String action_name;
	private String ins_id;
	private String accepter_id;
	//for 档案借阅申请--申请中 end
	
	public String getF_lending_reason() {
		return f_lending_reason;
	}
	public void setF_lending_reason(String f_lending_reason) {
		this.f_lending_reason = f_lending_reason;
	}
	public String getF_creator_time() {
		return f_creator_time;
	}
	public void setF_creator_time(String f_creator_time) {
		this.f_creator_time = f_creator_time;
	}
	public String getStatus_code() {
		return status_code;
	}
	public void setStatus_code(String status_code) {
		this.status_code = status_code;
	}
	public String getAction_name() {
		return action_name;
	}
	public void setAction_name(String action_name) {
		this.action_name = action_name;
	}
	public String getIns_id() {
		return ins_id;
	}
	public void setIns_id(String ins_id) {
		this.ins_id = ins_id;
	}
	public String getF_type_name() {
		return f_type_name;
	}
	public void setF_type_name(String f_type_name) {
		this.f_type_name = f_type_name;
	}
	
	public String getF_lending_type_name() {
		return f_lending_type_name;
	}
	public void setF_lending_type_name(String f_lending_type_name) {
		this.f_lending_type_name = f_lending_type_name;
	}
	public String getF_file_no() {
		return f_file_no;
	}
	public void setF_file_no(String f_file_no) {
		this.f_file_no = f_file_no;
	}
	public String getF_dep_name() {
		return f_dep_name;
	}
	public void setF_dep_name(String f_dep_name) {
		this.f_dep_name = f_dep_name;
	}
	public String getJsp_type() {
		return jsp_type;
	}
	public void setJsp_type(String jsp_type) {
		this.jsp_type = jsp_type;
	}
	public String getF_docname() {
		return f_docname;
	}
	public void setF_docname(String f_docname) {
		this.f_docname = f_docname;
	}
	public Object getF_back_time() {
		return f_back_time;
	}
	public void setF_back_time(Object f_back_time) {
		this.f_back_time = f_back_time;
	}
	public String getF_lending_id() {
		return f_lending_id;
	}
	public void setF_lending_id(String f_lending_id) {
		this.f_lending_id = f_lending_id;
	}
	public String getF_creator_state_time() {
		return f_creator_state_time;
	}
	public void setF_creator_state_time(String f_creator_state_time) {
		this.f_creator_state_time = f_creator_state_time;
	}
	public String getF_creator_end_time() {
		return f_creator_end_time;
	}
	public void setF_creator_end_time(String f_creator_end_time) {
		this.f_creator_end_time = f_creator_end_time;
	}
	/**
	*<b>Summary: 获取借阅文件详细 ID</b>
	*/
	public String getF_detail_id() {
		return f_detail_id;
	}
	/**
	*<b>Summary: 设置借阅文件详细 ID</b>
	*/
	public void setF_detail_id(String f_detail_id) {
		this.f_detail_id = f_detail_id;
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
	*<b>Summary: 获取借阅类型</b>
	*/
	public String getF_lending_type() {
		return f_lending_type;
	}
	/**
	*<b>Summary: 设置借阅类型</b>
	*/
	public void setF_lending_type(String f_lending_type) {
		this.f_lending_type = f_lending_type;
	}
	/**
	*<b>Summary: 获取是否同意借阅</b>
	*/
	public String getF_isagree() {
		return f_isagree;
	}
	/**
	*<b>Summary: 设置是否同意借阅</b>
	*/
	public void setF_isagree(String f_isagree) {
		this.f_isagree = f_isagree;
	}
	/**
	*<b>Summary: 获取是否已借阅</b>
	*/
	public String getF_islending() {
		return f_islending;
	}
	/**
	*<b>Summary: 设置是否已借阅</b>
	*/
	public void setF_islending(String f_islending) {
		this.f_islending = f_islending;
	}
	/**
	*<b>Summary: 获取借阅日期</b>
	*/
	public Object getF_lending_time() {
		return f_lending_time;
	}
	/**
	*<b>Summary: 设置借阅日期</b>
	*/
	public void setF_lending_time(Object f_lending_time) {
		this.f_lending_time = f_lending_time;
	}
	/**
	*<b>Summary: 获取借阅天数</b>
	*/
	public String getF_lending_day() {
		return f_lending_day;
	}
	/**
	*<b>Summary: 设置借阅天数</b>
	*/
	public void setF_lending_day(String f_lending_day) {
		this.f_lending_day = f_lending_day;
	}
	/**
	*<b>Summary: 获取借出经手人ID</b>
	*/
	public String getF_user_id() {
		return f_user_id;
	}
	/**
	*<b>Summary: 设置借出经手人ID</b>
	*/
	public void setF_user_id(String f_user_id) {
		this.f_user_id = f_user_id;
	}
	/**
	*<b>Summary: 获取借出经手人姓名</b>
	*/
	public String getF_user_name() {
		return f_user_name;
	}
	/**
	*<b>Summary: 设置借出经手人姓名</b>
	*/
	public void setF_user_name(String f_user_name) {
		this.f_user_name = f_user_name;
	}
	/**
	*<b>Summary: 获取是否已归还</b>
	*/
	public String getF_isback() {
		return f_isback;
	}
	/**
	*<b>Summary: 设置是否已归还</b>
	*/
	public void setF_isback(String f_isback) {
		this.f_isback = f_isback;
	}
	/**
	*<b>Summary: 获取计划归还日期</b>
	*/
	public Object getF_reback_time() {
		return f_reback_time;
	}
	/**
	*<b>Summary: 设置计划归还日期</b>
	*/
	public void setF_reback_time(Object f_reback_time) {
		this.f_reback_time = f_reback_time;
	}
	/**
	*<b>Summary: 获取归还经手人ID</b>
	*/
	public String getF_back_userid() {
		return f_back_userid;
	}
	/**
	*<b>Summary: 设置归还经手人ID</b>
	*/
	public void setF_back_userid(String f_back_userid) {
		this.f_back_userid = f_back_userid;
	}
	/**
	*<b>Summary: 获取归还经手人姓名</b>
	*/
	public String getF_back_username() {
		return f_back_username;
	}
	/**
	*<b>Summary: 设置归还经手人姓名</b>
	*/
	public void setF_back_username(String f_back_username) {
		this.f_back_username = f_back_username;
	}
	/**
	*<b>Summary: 获取申请的阅读权限</b>
	*/
	public String getF_read_purview() {
		return f_read_purview;
	}
	/**
	*<b>Summary: 设置申请的阅读权限</b>
	*/
	public void setF_read_purview(String f_read_purview) {
		this.f_read_purview = f_read_purview;
	}
	/**
	*<b>Summary: 获取批准的阅读权限</b>
	*/
	public String getF_read_approve() {
		return f_read_approve;
	}
	/**
	*<b>Summary: 设置批准的阅读权限</b>
	*/
	public void setF_read_approve(String f_read_approve) {
		this.f_read_approve = f_read_approve;
	}
	/**
	*<b>Summary: 获取借阅人ID</b>
	*/
	public String getF_lending_userid() {
		return f_lending_userid;
	}
	/**
	*<b>Summary: 设置借阅人ID</b>
	*/
	public void setF_lending_userid(String f_lending_userid) {
		this.f_lending_userid = f_lending_userid;
	}
	/**
	 * 没借阅
	 */
	public static final String F_ISLENDING_NO = "0";
	public String getF_doc_num() {
		return f_doc_num;
	}
	public void setF_doc_num(String f_doc_num) {
		this.f_doc_num = f_doc_num;
	}
	public String getF_files_no() {
		return f_files_no;
	}
	public void setF_files_no(String f_files_no) {
		this.f_files_no = f_files_no;
	}
	public String getF_doc_name() {
		return f_doc_name;
	}
	public void setF_doc_name(String f_doc_name) {
		this.f_doc_name = f_doc_name;
	}
	public String getF_file_num() {
		return f_file_num;
	}
	public void setF_file_num(String f_file_num) {
		this.f_file_num = f_file_num;
	}
	public String getF_lending_username() {
		return f_lending_username;
	}
	public void setF_lending_username(String f_lending_username) {
		this.f_lending_username = f_lending_username;
	}
	public String getF_dept_name() {
		return f_dept_name;
	}
	public void setF_dept_name(String f_dept_name) {
		this.f_dept_name = f_dept_name;
	}
	public String getAccepter_id() {
		return accepter_id;
	}
	public void setAccepter_id(String accepter_id) {
		this.accepter_id = accepter_id;
	}
}
