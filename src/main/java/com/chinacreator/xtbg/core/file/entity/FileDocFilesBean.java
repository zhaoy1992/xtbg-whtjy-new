package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:FileDocFilesBean.java</p>
 *<p>Description:档案与文件的对应关系表映射类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-22
 */
public class FileDocFilesBean extends XtDbBaseBean{
	public FileDocFilesBean(){
		super("oa_file_docfiles","f_docfiles_id");
	}
	private String f_docfiles_id;		//主健ID
	private String f_files_id;		//案卷ID
	private String f_doc_id;		//文件ID
	/**
	*<b>Summary: 获取主健ID</b>
	*/
	public String getF_docfiles_id() {
		return f_docfiles_id;
	}
	/**
	*<b>Summary: 设置主健ID</b>
	*/
	public void setF_docfiles_id(String f_docfiles_id) {
		this.f_docfiles_id = f_docfiles_id;
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
}
