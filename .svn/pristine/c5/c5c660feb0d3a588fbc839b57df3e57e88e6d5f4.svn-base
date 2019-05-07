package com.chinacreator.xtbg.core.file.entity;


import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 待归档文件信息
 *<p>Title:FileDocBeforeArchiveBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Oct 8, 2013
 */
public class FileDocBeforeArchiveBean extends XtDbBaseBean{
	public FileDocBeforeArchiveBean(){
		super("oa_file_before_archive_info", "t_id");
	}
	private String f_id;		//信息ID
	private String f_title;		//标题
	private String f_file_no;		//文号
	private String f_archive_type;		//归档类型 1: 公文归档(目前只有公文归档)
	private String f_org_id;		//信息所属机构ID
	private String f_org_name;		//信息所属机构名
	private String f_dept_id;		//信息所属部门ID
	private String f_dept_name;		//所属部门=归档部门
	private String f_oldfile_content;		//原文内容
	private String f_oldfile_type;		//原文文件类型
	private String f_mainfile_content;		//正文内容
	private String f_mainfile_type;		//正文文件类型
	public String getPageType() {
		return pageType;
	}


	public void setPageType(String pageType) {
		this.pageType = pageType;
	}
	private String f_attach_id;		//附件ID
	private String f_create_user_id;		//创建人
	private Object f_create_date;		//创建时间
	private String f_archive_user_id;		//归档人
	private Object f_archive_date;		//归档时间
	private String f_is_archived;		//是否已经归档0:否,1:是
	
	private String f_archive_user_name;
	private String f_create_user_name;
	
	
	private String pageType;
	/**
	 * 未归档
	 */
	public static final String F_IS_ARCHIVED_NO = "0";
	/**
	 * 已归档
	 */
	public static final String F_IS_ARCHIVED_YES = "1";
	/**
	 * 归档类型公文归档
	 */
	public static final String F_ARCHIVE_TYPE_ONE = "1";
	/**
	 * 归档类型公文归档
	 */
	public static final String F_ARCHIVE_TYPE_ONE_PAGE_NAME = "filedocdetailforarchive.jsp";
	/**
	 * 公文-->文书(文书程序界面信息ID,关系所有文书类型档案)
	 * SELECT * FROM OA_FILE_PROGRAM_PAGE WHERE F_PROGRAM_ID = 'f0fe0a05-e472-45da-a5e9-94dbbffe6e6c'
	 * 是初始化数据
	 */
	public static final String F_ARCHIVE_TYPE_ONE_PAGE_ID = "f0fe0a05-e472-45da-a5e9-94dbbffe6e6c";
	/**
	 * 通过归档类型 获得 归档页面
	 *<b>Summary: </b>
	 * getArchivePageName(通过归档类型 获得 归档页面)
	 * @param str
	 * @return
	 */
	public static String getArchivePageName(String str){
		if(F_ARCHIVE_TYPE_ONE.equals(str)){
			return "filedocdetailforarchive.jsp";
		}
		return "filedocdetailforarchive.jsp";
	}
	
	
	/**
	*<b>Summary: 获取信息ID</b>
	*/
	public String getF_id() {
		return f_id;
	}
	/**
	*<b>Summary: 设置信息ID</b>
	*/
	public void setF_id(String f_id) {
		this.f_id = f_id;
	}
	/**
	*<b>Summary: 获取标题</b>
	*/
	public String getF_title() {
		return f_title;
	}
	/**
	*<b>Summary: 设置标题</b>
	*/
	public void setF_title(String f_title) {
		this.f_title = f_title;
	}
	/**
	*<b>Summary: 获取文号</b>
	*/
	public String getF_file_no() {
		return f_file_no;
	}
	/**
	*<b>Summary: 设置文号</b>
	*/
	public void setF_file_no(String f_file_no) {
		this.f_file_no = f_file_no;
	}
	/**
	*<b>Summary: 获取信息所属机构ID</b>
	*/
	public String getF_org_id() {
		return f_org_id;
	}
	/**
	*<b>Summary: 设置信息所属机构ID</b>
	*/
	public void setF_org_id(String f_org_id) {
		this.f_org_id = f_org_id;
	}
	/**
	*<b>Summary: 获取信息所属机构名</b>
	*/
	public String getF_org_name() {
		return f_org_name;
	}
	/**
	*<b>Summary: 设置信息所属机构名</b>
	*/
	public void setF_org_name(String f_org_name) {
		this.f_org_name = f_org_name;
	}
	/**
	*<b>Summary: 获取信息所属部门ID</b>
	*/
	public String getF_dept_id() {
		return f_dept_id;
	}
	/**
	*<b>Summary: 设置信息所属部门ID</b>
	*/
	public void setF_dept_id(String f_dept_id) {
		this.f_dept_id = f_dept_id;
	}
	/**
	*<b>Summary: 获取所属部门=归档部门</b>
	*/
	public String getF_dept_name() {
		return f_dept_name;
	}
	/**
	*<b>Summary: 设置所属部门=归档部门</b>
	*/
	public void setF_dept_name(String f_dept_name) {
		this.f_dept_name = f_dept_name;
	}
	/**
	*<b>Summary: 获取原文内容</b>
	*/
	public String getF_oldfile_content() {
		return f_oldfile_content;
	}
	/**
	*<b>Summary: 设置原文内容</b>
	*/
	public void setF_oldfile_content(String f_oldfile_content) {
		this.f_oldfile_content = f_oldfile_content;
	}
	/**
	*<b>Summary: 获取原文文件类型</b>
	*/
	public String getF_oldfile_type() {
		return f_oldfile_type;
	}
	/**
	*<b>Summary: 设置原文文件类型</b>
	*/
	public void setF_oldfile_type(String f_oldfile_type) {
		this.f_oldfile_type = f_oldfile_type;
	}
	/**
	*<b>Summary: 获取正文内容</b>
	*/
	public String getF_mainfile_content() {
		return f_mainfile_content;
	}
	/**
	*<b>Summary: 设置正文内容</b>
	*/
	public void setF_mainfile_content(String f_mainfile_content) {
		this.f_mainfile_content = f_mainfile_content;
	}
	/**
	*<b>Summary: 获取正文文件类型</b>
	*/
	public String getF_mainfile_type() {
		return f_mainfile_type;
	}
	/**
	*<b>Summary: 设置正文文件类型</b>
	*/
	public void setF_mainfile_type(String f_mainfile_type) {
		this.f_mainfile_type = f_mainfile_type;
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
	*<b>Summary: 获取创建人</b>
	*/
	public String getF_create_user_id() {
		return f_create_user_id;
	}
	/**
	*<b>Summary: 设置创建人</b>
	*/
	public void setF_create_user_id(String f_create_user_id) {
		this.f_create_user_id = f_create_user_id;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public Object getF_create_date() {
		return f_create_date;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setF_create_date(Object f_create_date) {
		this.f_create_date = f_create_date;
	}
	/**
	*<b>Summary: 获取归档人</b>
	*/
	public String getF_archive_user_id() {
		return f_archive_user_id;
	}
	/**
	*<b>Summary: 设置归档人</b>
	*/
	public void setF_archive_user_id(String f_archive_user_id) {
		this.f_archive_user_id = f_archive_user_id;
	}
	/**
	*<b>Summary: 获取归档时间</b>
	*/
	public Object getF_archive_date() {
		return f_archive_date;
	}
	/**
	*<b>Summary: 设置归档时间</b>
	*/
	public void setF_archive_date(Object f_archive_date) {
		this.f_archive_date = f_archive_date;
	}
	/**
	*<b>Summary: 获取是否已经归档0:否,1:是</b>
	*/
	public String getF_is_archived() {
		return f_is_archived;
	}
	/**
	*<b>Summary: 设置是否已经归档0:否,1:是</b>
	*/
	public void setF_is_archived(String f_is_archived) {
		this.f_is_archived = f_is_archived;
	}
}
