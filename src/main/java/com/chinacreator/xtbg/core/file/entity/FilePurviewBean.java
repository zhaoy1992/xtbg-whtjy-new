package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:FilePurviewBean.java</p>
 *<p>Description:档案分类权限Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 18, 2013
 */
public class FilePurviewBean extends XtDbBaseBean{
	public FilePurviewBean() {
		super("oa_file_purview", "f_purview_id");
	}
	
	private String f_purview_id;		//阅读权限ID
	private String f_type_id;		//所属档案分类ID
	private String f_secrecy_id;		//密级ID
	private String f_secrecy_name;		//密级名称
	private String f_read_all_user;		//所有人读取权限
	private String f_download_all_user;		//所有人下载权限
	private String f_read_dept_user;		//部门读取权限
	private String f_download_dept_user;		//部门下载权限
	private String f_read_user_groupid;		//可读取权限的组ID
	private String f_read_user_groupname;		//可读取权限的组名称
	private String f_download_user_groupid;		//可下载权限的组ID
	private String f_download_user_groupname;		//可下载权限的组名称
	
	private String read_role;
	private String down_role;
	public String getRead_role() {
		return read_role;
	}
	public void setRead_role(String read_role) {
		this.read_role = read_role;
	}
	public String getDown_role() {
		return down_role;
	}
	public void setDown_role(String down_role) {
		this.down_role = down_role;
	}
	/**
	*<b>Summary: 获取阅读权限ID</b>
	*/
	public String getF_purview_id() {
		return f_purview_id;
	}
	/**
	*<b>Summary: 设置阅读权限ID</b>
	*/
	public void setF_purview_id(String f_purview_id) {
		this.f_purview_id = f_purview_id;
	}
	/**
	*<b>Summary: 获取所属档案分类ID</b>
	*/
	public String getF_type_id() {
		return f_type_id;
	}
	/**
	*<b>Summary: 设置所属档案分类ID</b>
	*/
	public void setF_type_id(String f_type_id) {
		this.f_type_id = f_type_id;
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
	*<b>Summary: 获取所有人读取权限</b>
	*/
	public String getF_read_all_user() {
		return f_read_all_user;
	}
	/**
	*<b>Summary: 设置所有人读取权限</b>
	*/
	public void setF_read_all_user(String f_read_all_user) {
		this.f_read_all_user = f_read_all_user;
	}
	/**
	*<b>Summary: 获取所有人下载权限</b>
	*/
	public String getF_download_all_user() {
		return f_download_all_user;
	}
	/**
	*<b>Summary: 设置所有人下载权限</b>
	*/
	public void setF_download_all_user(String f_download_all_user) {
		this.f_download_all_user = f_download_all_user;
	}
	/**
	*<b>Summary: 获取部门读取权限</b>
	*/
	public String getF_read_dept_user() {
		return f_read_dept_user;
	}
	/**
	*<b>Summary: 设置部门读取权限</b>
	*/
	public void setF_read_dept_user(String f_read_dept_user) {
		this.f_read_dept_user = f_read_dept_user;
	}
	/**
	*<b>Summary: 获取部门下载权限</b>
	*/
	public String getF_download_dept_user() {
		return f_download_dept_user;
	}
	/**
	*<b>Summary: 设置部门下载权限</b>
	*/
	public void setF_download_dept_user(String f_download_dept_user) {
		this.f_download_dept_user = f_download_dept_user;
	}
	/**
	*<b>Summary: 获取可读取权限的组ID</b>
	*/
	public String getF_read_user_groupid() {
		return f_read_user_groupid;
	}
	/**
	*<b>Summary: 设置可读取权限的组ID</b>
	*/
	public void setF_read_user_groupid(String f_read_user_groupid) {
		this.f_read_user_groupid = f_read_user_groupid;
	}
	/**
	*<b>Summary: 获取可读取权限的组名称</b>
	*/
	public String getF_read_user_groupname() {
		return f_read_user_groupname;
	}
	/**
	*<b>Summary: 设置可读取权限的组名称</b>
	*/
	public void setF_read_user_groupname(String f_read_user_groupname) {
		this.f_read_user_groupname = f_read_user_groupname;
	}
	/**
	*<b>Summary: 获取可下载权限的组ID</b>
	*/
	public String getF_download_user_groupid() {
		return f_download_user_groupid;
	}
	/**
	*<b>Summary: 设置可下载权限的组ID</b>
	*/
	public void setF_download_user_groupid(String f_download_user_groupid) {
		this.f_download_user_groupid = f_download_user_groupid;
	}
	/**
	*<b>Summary: 获取可下载权限的组名称</b>
	*/
	public String getF_download_user_groupname() {
		return f_download_user_groupname;
	}
	/**
	*<b>Summary: 设置可下载权限的组名称</b>
	*/
	public void setF_download_user_groupname(String f_download_user_groupname) {
		this.f_download_user_groupname = f_download_user_groupname;
	}
	/**
	 * 有权限
	 */
	public final static String CAN_DO = "1";
	/**
	 * 无权限
	 */
	public final static String CAN_NOT_DO = "0";
	/**
	 * 存在OA_DICT_DATA中的[密级]的字典主键
	 */
	public final static String DICT_ID = "1";
}
