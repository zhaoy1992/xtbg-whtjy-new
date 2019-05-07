package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 档案移交    OA_FILES_DEVOLVE and OA_FILES_DEVOLVE_DETAIL
 *<p>Title:FileFilesDevolveBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Sep 16, 2013
 */
public class FileFilesDevolveBean extends XtDbBaseBean{
	
	public FileFilesDevolveBean() {
		super("OA_FILES_DEVOLVE", "f_devolve_id");
	}
	/**
	 * 档案移交.移交状态:暂存
	 */
	public static final String STATE_ONE="0";
	/**
	 * 档案移交.移交状态:暂存
	 */
	public static final String STATE_ONE_NAME="暂存";
	/**
	 * 档案移交.移交状态:已移交
	 */
	public static final String STATE_TWO="1";
	/**
	 * 档案移交.移交状态:已移交
	 */
	public static final String STATE_TWO_NAME="已移交";
	
	private String f_devolve_id;		//移交记录ID
	private String f_title;		//移交标题
	private String f_state;		//移交状态(0:暂存,1:已移交)
	private String f_deadline;		//保管期限
	private String f_type;		//档案类型(1234:文书照片视频光盘)
	private String f_receive_org_id;		//档案接收单位ID
	private String f_receive_org_name;		//档案接收单位名称
	private Object f_begin_time;		//起始日期
	private Object f_den_time;		//终止日期
	private String f_num;		//本次移交的卷数(移交卷数)
	private String f_log_user_id;		//登记人ID
	private String f_log_user_name;		//登记人名称
	private Object f_log_time;		//登记日期
	private String f_org_id;		//记录所属机构(单位)ID
	private String f_org_name;		//记录所属机构名称
	private String f_dept_id;		//记录所属部门ID
	private String f_dept_name;		//记录所属部门名称
	private String f_remarks;		//备注
	private String f_attach_id;		//附件ID
	private String f_year;		//移交年份
	private String f_fonds_no;		//全宗号(已经作废)
	private String f_catalog_no;		//目录号(已经作废)
	private String f_files_no;		//案卷号(本次移交的案卷的起止号)(已经作废)
	private String f_begin_end_time;
	public String getF_begin_end_time() {
		return f_begin_end_time;
	}
	public void setF_begin_end_time(String f_begin_end_time) {
		this.f_begin_end_time = f_begin_end_time;
	}
	/**
	*<b>Summary: 获取移交记录ID</b>
	*/
	public String getF_devolve_id() {
		return f_devolve_id;
	}
	/**
	*<b>Summary: 设置移交记录ID</b>
	*/
	public void setF_devolve_id(String f_devolve_id) {
		this.f_devolve_id = f_devolve_id;
	}
	/**
	*<b>Summary: 获取移交标题</b>
	*/
	public String getF_title() {
		return f_title;
	}
	/**
	*<b>Summary: 设置移交标题</b>
	*/
	public void setF_title(String f_title) {
		this.f_title = f_title;
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
	/**
	*<b>Summary: 获取保管期限</b>
	*/
	public String getF_deadline() {
		return f_deadline;
	}
	/**
	*<b>Summary: 设置保管期限</b>
	*/
	public void setF_deadline(String f_deadline) {
		this.f_deadline = f_deadline;
	}
	/**
	*<b>Summary: 获取档案类型(1234:文书照片视频光盘)</b>
	*/
	public String getF_type() {
		return f_type;
	}
	/**
	*<b>Summary: 设置档案类型(1234:文书照片视频光盘)</b>
	*/
	public void setF_type(String f_type) {
		this.f_type = f_type;
	}
	/**
	*<b>Summary: 获取档案接收单位ID</b>
	*/
	public String getF_receive_org_id() {
		return f_receive_org_id;
	}
	/**
	*<b>Summary: 设置档案接收单位ID</b>
	*/
	public void setF_receive_org_id(String f_receive_org_id) {
		this.f_receive_org_id = f_receive_org_id;
	}
	/**
	*<b>Summary: 获取档案接收单位名称</b>
	*/
	public String getF_receive_org_name() {
		return f_receive_org_name;
	}
	/**
	*<b>Summary: 设置档案接收单位名称</b>
	*/
	public void setF_receive_org_name(String f_receive_org_name) {
		this.f_receive_org_name = f_receive_org_name;
	}
	/**
	*<b>Summary: 获取起始日期</b>
	*/
	public Object getF_begin_time() {
		return f_begin_time;
	}
	/**
	*<b>Summary: 设置起始日期</b>
	*/
	public void setF_begin_time(Object f_begin_time) {
		this.f_begin_time = f_begin_time;
	}
	/**
	*<b>Summary: 获取终止日期</b>
	*/
	public Object getF_den_time() {
		return f_den_time;
	}
	/**
	*<b>Summary: 设置终止日期</b>
	*/
	public void setF_den_time(Object f_den_time) {
		this.f_den_time = f_den_time;
	}
	/**
	*<b>Summary: 获取本次移交的卷数(移交卷数)</b>
	*/
	public String getF_num() {
		return f_num;
	}
	/**
	*<b>Summary: 设置本次移交的卷数(移交卷数)</b>
	*/
	public void setF_num(String f_num) {
		this.f_num = f_num;
	}
	/**
	*<b>Summary: 获取登记人ID</b>
	*/
	public String getF_log_user_id() {
		return f_log_user_id;
	}
	/**
	*<b>Summary: 设置登记人ID</b>
	*/
	public void setF_log_user_id(String f_log_user_id) {
		this.f_log_user_id = f_log_user_id;
	}
	/**
	*<b>Summary: 获取登记人名称</b>
	*/
	public String getF_log_user_name() {
		return f_log_user_name;
	}
	/**
	*<b>Summary: 设置登记人名称</b>
	*/
	public void setF_log_user_name(String f_log_user_name) {
		this.f_log_user_name = f_log_user_name;
	}
	/**
	*<b>Summary: 获取登记日期</b>
	*/
	public Object getF_log_time() {
		return f_log_time;
	}
	/**
	*<b>Summary: 设置登记日期</b>
	*/
	public void setF_log_time(Object f_log_time) {
		this.f_log_time = f_log_time;
	}
	/**
	*<b>Summary: 获取记录所属机构(单位)ID</b>
	*/
	public String getF_org_id() {
		return f_org_id;
	}
	/**
	*<b>Summary: 设置记录所属机构(单位)ID</b>
	*/
	public void setF_org_id(String f_org_id) {
		this.f_org_id = f_org_id;
	}
	/**
	*<b>Summary: 获取记录所属机构名称</b>
	*/
	public String getF_org_name() {
		return f_org_name;
	}
	/**
	*<b>Summary: 设置记录所属机构名称</b>
	*/
	public void setF_org_name(String f_org_name) {
		this.f_org_name = f_org_name;
	}
	/**
	*<b>Summary: 获取记录所属部门ID</b>
	*/
	public String getF_dept_id() {
		return f_dept_id;
	}
	/**
	*<b>Summary: 设置记录所属部门ID</b>
	*/
	public void setF_dept_id(String f_dept_id) {
		this.f_dept_id = f_dept_id;
	}
	/**
	*<b>Summary: 获取记录所属部门名称</b>
	*/
	public String getF_dept_name() {
		return f_dept_name;
	}
	/**
	*<b>Summary: 设置记录所属部门名称</b>
	*/
	public void setF_dept_name(String f_dept_name) {
		this.f_dept_name = f_dept_name;
	}
	/**
	*<b>Summary: 获取备注</b>
	*/
	public String getF_remarks() {
		return f_remarks;
	}
	/**
	*<b>Summary: 设置备注</b>
	*/
	public void setF_remarks(String f_remarks) {
		this.f_remarks = f_remarks;
	}
	/**
	*<b>Summary: 获取附件ID</b>
	*/
	public String getF_attach_id() {
		return f_attach_id;
	}
	/**
	*<b>Summary: 设置附件ID</b>
	*/
	public void setF_attach_id(String f_attach_id) {
		this.f_attach_id = f_attach_id;
	}
	/**
	*<b>Summary: 获取移交年份</b>
	*/
	public String getF_year() {
		return f_year;
	}
	/**
	*<b>Summary: 设置移交年份</b>
	*/
	public void setF_year(String f_year) {
		this.f_year = f_year;
	}
	/**
	*<b>Summary: 获取全宗号(已经作废)</b>
	*/
	public String getF_fonds_no() {
		return f_fonds_no;
	}
	/**
	*<b>Summary: 设置全宗号(已经作废)</b>
	*/
	public void setF_fonds_no(String f_fonds_no) {
		this.f_fonds_no = f_fonds_no;
	}
	/**
	*<b>Summary: 获取目录号(已经作废)</b>
	*/
	public String getF_catalog_no() {
		return f_catalog_no;
	}
	/**
	*<b>Summary: 设置目录号(已经作废)</b>
	*/
	public void setF_catalog_no(String f_catalog_no) {
		this.f_catalog_no = f_catalog_no;
	}
	/**
	*<b>Summary: 获取案卷号(本次移交的案卷的起止号)(已经作废)</b>
	*/
	public String getF_files_no() {
		return f_files_no;
	}
	/**
	*<b>Summary: 设置案卷号(本次移交的案卷的起止号)(已经作废)</b>
	*/
	public void setF_files_no(String f_files_no) {
		this.f_files_no = f_files_no;
	}
}
