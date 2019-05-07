package com.chinacreator.xtbg.core.archive.entity;

/**
 * 
 *<p>Title:SplitLog.java</p>
 *<p>Description:指标文拆分bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Sep 16, 2013
 */
public class SplitLogBean {
	private String split_log_id; 	//编号
	private String buss_id; 		//文件拆分业务ID
	private String parent_id; 		//父ID
	private String parent_name; 	//父文件
	private String unit_id; 		//拆分单位ID
	private String unit_name; 		//拆分单位名称
	private String gwcs_org_id; 	//公文传输机构id
	private String gwcs_org_name; 	//公文传输机构name
	private String file_name; 		//拆分的文件名
	private String file_path; 		//文件相对路径
	private long file_size; 		//文件大小(单位：字节)
	private String created;			//拆分时间
	private String user_id;			//操作人员
	private String user_name;			//操作人员姓名
	
	
	public String getGwcs_org_id() {
		return gwcs_org_id;
	}
	public void setGwcs_org_id(String gwcs_org_id) {
		this.gwcs_org_id = gwcs_org_id;
	}
	public String getGwcs_org_name() {
		return gwcs_org_name;
	}
	public void setGwcs_org_name(String gwcs_org_name) {
		this.gwcs_org_name = gwcs_org_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getParent_name() {
		return parent_name;
	}
	public void setParent_name(String parent_name) {
		this.parent_name = parent_name;
	}
	public String getUnit_name() {
		return unit_name;
	}
	public void setUnit_name(String unit_name) {
		this.unit_name = unit_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getSplit_log_id() {
		return split_log_id;
	}
	public void setSplit_log_id(String split_log_id) {
		this.split_log_id = split_log_id;
	}
	public String getBuss_id() {
		return buss_id;
	}
	public void setBuss_id(String buss_id) {
		this.buss_id = buss_id;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getUnit_id() {
		return unit_id;
	}
	public void setUnit_id(String unit_id) {
		this.unit_id = unit_id;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	
	
}
