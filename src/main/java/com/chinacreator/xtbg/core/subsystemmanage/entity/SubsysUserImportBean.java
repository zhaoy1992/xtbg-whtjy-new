
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     SubsysUserImportBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-26   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.subsystemmanage.entity;

/**
 *<p>Title:SubsysUserImportBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-26
 */
public class SubsysUserImportBean {
	
	//子系统ID
	private String sys_id;
	//导入文件路径
	private String import_file;
	
	public String getSys_id() {
		return sys_id;
	}
	public void setSys_id(String sys_id) {
		this.sys_id = sys_id;
	}
	public String getImport_file() {
		return import_file;
	}
	public void setImport_file(String import_file) {
		this.import_file = import_file;
	}
}
