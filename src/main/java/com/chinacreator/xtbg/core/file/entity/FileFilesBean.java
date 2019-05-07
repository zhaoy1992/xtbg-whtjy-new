package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:FileFilesBean.java</p>
 *<p>Description:档案管理-档案bean</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-15
 */
public class FileFilesBean extends XtDbBaseBean{	
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     构造一个 FileFilesBean  
	   * <b>Remarks: </b>
	  *     构造类 FileFilesBean 的构造函数 FileFilesBean
	 */
	public  FileFilesBean (){
		super("oa_file_files","f_files_id");
	}
	private String f_files_id;		//案卷ID
	private String f_files_title;		//案卷标题
	private String f_type_name;		//所属分类名称(全称)
	private String f_files_no;		//档号
	private String f_typeno;		//分类号
	private String f_fondsno;		//全宗号
	private String f_filesno;		//案卷号(盒号)
	private String f_storage_fullname;		//存放位置
	private String f_doc_year;		//档案年份
	private String f_secrecy_id;		//密级ID
	private String f_secrecy_name;		//密级名称
	private String f_doc_deadline;		//保管期限
	private String f_org_id;		//所属的单位ID
	private String f_org_name;		//所属单位名称
	private String f_dept_id;		//所属部门ID
	private String f_dept_name;		//所属部门名
	private String f_doc_blname;		//责任者
	private String f_files_num;		//盒内卷数（卷内张数）
	private String f_files_content;		//内容
	private String f_files_state;		//案卷状态(0：待归档    1、已归档（正常状态）   8、已移交（移交到档案局）   9. 已销毁)
	private String f_file_userid;		//归档人ID
	private String f_file_username;		//归档人姓名
	private Object f_file_time;		//归档日期（档案的最早正式归档日期）
	private String f_listno;		//目录号
	private String f_doc_deadline_name;		//保管期限名
	private String f_entity_type_name;		//实物类型name
	private String f_entity_type;		//实物类型
	private String f_files_state_name;		//案卷状态名
	private Object f_start_time;		//起始日期（档案的最早形成日期）
	private Object f_end_time;		//终止日期（档案的最后修改日期）
	private String f_doc_blid;		//责任者id
	private String f_type_id;		//所属分类id
	
    public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	private String userRole;
	private String f_type;
	public String getF_type() {
		return f_type;
	}
	public void setF_type(String f_type) {
		this.f_type = f_type;
	}
	/**
	*<b>Summary: 获取案卷ID</b>
	*/
	public String getF_files_id() {
		return f_files_id;
	}
	/**
	*<b>Summary: 设置案卷ID</b>
	*/
	public void setF_files_id(String f_files_id) {
		this.f_files_id = f_files_id;
	}
	/**
	*<b>Summary: 获取案卷标题</b>
	*/
	public String getF_files_title() {
		return f_files_title;
	}
	/**
	*<b>Summary: 设置案卷标题</b>
	*/
	public void setF_files_title(String f_files_title) {
		this.f_files_title = f_files_title;
	}
	/**
	*<b>Summary: 获取所属分类名称(全称)</b>
	*/
	public String getF_type_name() {
		return f_type_name;
	}
	/**
	*<b>Summary: 设置所属分类名称(全称)</b>
	*/
	public void setF_type_name(String f_type_name) {
		this.f_type_name = f_type_name;
	}
	/**
	*<b>Summary: 获取档号</b>
	*/
	public String getF_files_no() {
		return f_files_no;
	}
	/**
	*<b>Summary: 设置档号</b>
	*/
	public void setF_files_no(String f_files_no) {
		this.f_files_no = f_files_no;
	}
	/**
	*<b>Summary: 获取分类号</b>
	*/
	public String getF_typeno() {
		return f_typeno;
	}
	/**
	*<b>Summary: 设置分类号</b>
	*/
	public void setF_typeno(String f_typeno) {
		this.f_typeno = f_typeno;
	}
	/**
	*<b>Summary: 获取全宗号</b>
	*/
	public String getF_fondsno() {
		return f_fondsno;
	}
	/**
	*<b>Summary: 设置全宗号</b>
	*/
	public void setF_fondsno(String f_fondsno) {
		this.f_fondsno = f_fondsno;
	}
	/**
	*<b>Summary: 获取案卷号</b>
	*/
	public String getF_filesno() {
		return f_filesno;
	}
	/**
	*<b>Summary: 设置案卷号</b>
	*/
	public void setF_filesno(String f_filesno) {
		this.f_filesno = f_filesno;
	}
	/**
	*<b>Summary: 获取存放位置</b>
	*/
	public String getF_storage_fullname() {
		return f_storage_fullname;
	}
	/**
	*<b>Summary: 设置存放位置</b>
	*/
	public void setF_storage_fullname(String f_storage_fullname) {
		this.f_storage_fullname = f_storage_fullname;
	}
	/**
	*<b>Summary: 获取档案年份</b>
	*/
	public String getF_doc_year() {
		return f_doc_year;
	}
	/**
	*<b>Summary: 设置档案年份</b>
	*/
	public void setF_doc_year(String f_doc_year) {
		this.f_doc_year = f_doc_year;
	}
	/**
	*<b>Summary: 获取密级ID</b>
	*/
	public String getF_secrecy_id() {
		return f_secrecy_id;
	}
	/**
	*<b>Summary: 设置密级ID</b>
	*/
	public void setF_secrecy_id(String f_secrecy_id) {
		this.f_secrecy_id = f_secrecy_id;
	}
	/**
	*<b>Summary: 获取密级名称</b>
	*/
	public String getF_secrecy_name() {
		return f_secrecy_name;
	}
	/**
	*<b>Summary: 设置密级名称</b>
	*/
	public void setF_secrecy_name(String f_secrecy_name) {
		this.f_secrecy_name = f_secrecy_name;
	}
	/**
	*<b>Summary: 获取保管期限</b>
	*/
	public String getF_doc_deadline() {
		return f_doc_deadline;
	}
	/**
	*<b>Summary: 设置保管期限</b>
	*/
	public void setF_doc_deadline(String f_doc_deadline) {
		this.f_doc_deadline = f_doc_deadline;
	}
	/**
	*<b>Summary: 获取所属的单位ID</b>
	*/
	public String getF_org_id() {
		return f_org_id;
	}
	/**
	*<b>Summary: 设置所属的单位ID</b>
	*/
	public void setF_org_id(String f_org_id) {
		this.f_org_id = f_org_id;
	}
	/**
	*<b>Summary: 获取所属单位名称</b>
	*/
	public String getF_org_name() {
		return f_org_name;
	}
	/**
	*<b>Summary: 设置所属单位名称</b>
	*/
	public void setF_org_name(String f_org_name) {
		this.f_org_name = f_org_name;
	}
	/**
	*<b>Summary: 获取所属部门ID</b>
	*/
	public String getF_dept_id() {
		return f_dept_id;
	}
	/**
	*<b>Summary: 设置所属部门ID</b>
	*/
	public void setF_dept_id(String f_dept_id) {
		this.f_dept_id = f_dept_id;
	}
	/**
	*<b>Summary: 获取所属部门名</b>
	*/
	public String getF_dept_name() {
		return f_dept_name;
	}
	/**
	*<b>Summary: 设置所属部门名</b>
	*/
	public void setF_dept_name(String f_dept_name) {
		this.f_dept_name = f_dept_name;
	}
	/**
	*<b>Summary: 获取责任者</b>
	*/
	public String getF_doc_blname() {
		return f_doc_blname;
	}
	/**
	*<b>Summary: 设置责任者</b>
	*/
	public void setF_doc_blname(String f_doc_blname) {
		this.f_doc_blname = f_doc_blname;
	}
	/**
	*<b>Summary: 获取卷内件数</b>
	*/
	public String getF_files_num() {
		return f_files_num;
	}
	/**
	*<b>Summary: 设置卷内件数</b>
	*/
	public void setF_files_num(String f_files_num) {
		this.f_files_num = f_files_num;
	}
	/**
	*<b>Summary: 获取内容</b>
	*/
	public String getF_files_content() {
		return f_files_content;
	}
	/**
	*<b>Summary: 设置内容</b>
	*/
	public void setF_files_content(String f_files_content) {
		this.f_files_content = f_files_content;
	}
	/**
	*<b>Summary: 获取案卷状态(0：待归档    1、已归档（正常状态）   8、已移交（移交到档案局）   9. 已销毁)</b>
	*/
	public String getF_files_state() {
		return f_files_state;
	}
	/**
	*<b>Summary: 设置案卷状态(0：待归档    1、已归档（正常状态）   8、已移交（移交到档案局）   9. 已销毁)</b>
	*/
	public void setF_files_state(String f_files_state) {
		this.f_files_state = f_files_state;
	}
	/**
	*<b>Summary: 获取归档人ID</b>
	*/
	public String getF_file_userid() {
		return f_file_userid;
	}
	/**
	*<b>Summary: 设置归档人ID</b>
	*/
	public void setF_file_userid(String f_file_userid) {
		this.f_file_userid = f_file_userid;
	}
	/**
	*<b>Summary: 获取归档人姓名</b>
	*/
	public String getF_file_username() {
		return f_file_username;
	}
	/**
	*<b>Summary: 设置归档人姓名</b>
	*/
	public void setF_file_username(String f_file_username) {
		this.f_file_username = f_file_username;
	}
	/**
	*<b>Summary: 获取归档日期（档案的最早正式归档日期）</b>
	*/
	public Object getF_file_time() {
		return f_file_time;
	}
	/**
	*<b>Summary: 设置归档日期（档案的最早正式归档日期）</b>
	*/
	public void setF_file_time(Object f_file_time) {
		this.f_file_time = f_file_time;
	}
	/**
	*<b>Summary: 获取目录号</b>
	*/
	public String getF_listno() {
		return f_listno;
	}
	/**
	*<b>Summary: 设置目录号</b>
	*/
	public void setF_listno(String f_listno) {
		this.f_listno = f_listno;
	}
	/**
	*<b>Summary: 获取保管期限id</b>
	*/
	public String getF_doc_deadline_name() {
		return f_doc_deadline_name;
	}
	/**
	*<b>Summary: 设置保管期限id</b>
	*/
	public void setF_doc_deadline_name(String f_doc_deadline_name) {
		this.f_doc_deadline_name = f_doc_deadline_name;
	}
	/**
	*<b>Summary: 获取实物类型name</b>
	*/
	public String getF_entity_type_name() {
		return f_entity_type_name;
	}
	/**
	*<b>Summary: 设置实物类型name</b>
	*/
	public void setF_entity_type_name(String f_entity_type_name) {
		this.f_entity_type_name = f_entity_type_name;
	}
	/**
	*<b>Summary: 获取实物类型</b>
	*/
	public String getF_entity_type() {
		return f_entity_type;
	}
	/**
	*<b>Summary: 设置实物类型</b>
	*/
	public void setF_entity_type(String f_entity_type) {
		this.f_entity_type = f_entity_type;
	}
	/**
	*<b>Summary: 获取案卷状态名</b>
	*/
	public String getF_files_state_name() {
		return f_files_state_name;
	}
	/**
	*<b>Summary: 设置案卷状态名</b>
	*/
	public void setF_files_state_name(String f_files_state_name) {
		this.f_files_state_name = f_files_state_name;
	}
	/**
	*<b>Summary: 获取起始日期（档案的最早形成日期）</b>
	*/
	public Object getF_start_time() {
		return f_start_time;
	}
	/**
	*<b>Summary: 设置起始日期（档案的最早形成日期）</b>
	*/
	public void setF_start_time(Object f_start_time) {
		this.f_start_time = f_start_time;
	}
	/**
	*<b>Summary: 获取终止日期（档案的最后修改日期）</b>
	*/
	public Object getF_end_time() {
		return f_end_time;
	}
	/**
	*<b>Summary: 设置终止日期（档案的最后修改日期）</b>
	*/
	public void setF_end_time(Object f_end_time) {
		this.f_end_time = f_end_time;
	}
	/**
	*<b>Summary: 获取责任者id</b>
	*/
	public String getF_doc_blid() {
		return f_doc_blid;
	}
	/**
	*<b>Summary: 设置责任者id</b>
	*/
	public void setF_doc_blid(String f_doc_blid) {
		this.f_doc_blid = f_doc_blid;
	}
	/**
	*<b>Summary: 获取所属分类id</b>
	*/
	public String getF_type_id() {
		return f_type_id;
	}
	/**
	*<b>Summary: 设置所属分类id</b>
	*/
	public void setF_type_id(String f_type_id) {
		this.f_type_id = f_type_id;
	}
}
