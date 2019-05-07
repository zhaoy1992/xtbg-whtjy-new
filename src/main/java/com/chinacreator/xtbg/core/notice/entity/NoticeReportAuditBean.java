
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     NoticeReportAuditBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-7-4   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.notice.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:NoticeReportAuditBean.java</p>
 *<p>Description: 公告栏评论实体bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-7-4
 */
public class NoticeReportAuditBean extends XtDbBaseBean{
	
	public NoticeReportAuditBean() {
		//在构造器里面设置好表名和主键，具体进行更新，删除等操作时可以重新设置updateKey，deleteKey，及主键
		super("oa_notice_reportaudit", "report_id");
	}
	
	private String report_id;		//主键ID
	private String notice_id;		//通知公告主表ID
	private String report_view;		//评论意见
	private String report_userid;		//评论人ID
	private String report_username;		//评论人名称
	private String report_unitid;		//评论人单位ID
	private String report_unitname;		//评论人单位名称
	private Object report_time;		//评论时间
	private String remark1;		//备注1
	private String remark2;		//备注2
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getReport_id() {
		return report_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setReport_id(String report_id) {
		this.report_id = report_id;
	}
	/**
	*<b>Summary: 获取通知公告主表ID</b>
	*/
	public String getNotice_id() {
		return notice_id;
	}
	/**
	*<b>Summary: 设置通知公告主表ID</b>
	*/
	public void setNotice_id(String notice_id) {
		this.notice_id = notice_id;
	}
	/**
	*<b>Summary: 获取评论意见</b>
	*/
	public String getReport_view() {
		return report_view;
	}
	/**
	*<b>Summary: 设置评论意见</b>
	*/
	public void setReport_view(String report_view) {
		this.report_view = report_view;
	}
	/**
	*<b>Summary: 获取评论人ID</b>
	*/
	public String getReport_userid() {
		return report_userid;
	}
	/**
	*<b>Summary: 设置评论人ID</b>
	*/
	public void setReport_userid(String report_userid) {
		this.report_userid = report_userid;
	}
	/**
	*<b>Summary: 获取评论人名称</b>
	*/
	public String getReport_username() {
		return report_username;
	}
	/**
	*<b>Summary: 设置评论人名称</b>
	*/
	public void setReport_username(String report_username) {
		this.report_username = report_username;
	}
	/**
	*<b>Summary: 获取评论人单位ID</b>
	*/
	public String getReport_unitid() {
		return report_unitid;
	}
	/**
	*<b>Summary: 设置评论人单位ID</b>
	*/
	public void setReport_unitid(String report_unitid) {
		this.report_unitid = report_unitid;
	}
	/**
	*<b>Summary: 获取评论人单位名称</b>
	*/
	public String getReport_unitname() {
		return report_unitname;
	}
	/**
	*<b>Summary: 设置评论人单位名称</b>
	*/
	public void setReport_unitname(String report_unitname) {
		this.report_unitname = report_unitname;
	}
	/**
	*<b>Summary: 获取评论时间</b>
	*/
	public Object getReport_time() {
		return report_time;
	}
	/**
	*<b>Summary: 设置评论时间</b>
	*/
	public void setReport_time(Object report_time) {
		this.report_time = report_time;
	}
	/**
	*<b>Summary: 获取备注1</b>
	*/
	public String getRemark1() {
		return remark1;
	}
	/**
	*<b>Summary: 设置备注1</b>
	*/
	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}
	/**
	*<b>Summary: 获取备注2</b>
	*/
	public String getRemark2() {
		return remark2;
	}
	/**
	*<b>Summary: 设置备注2</b>
	*/
	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}
	
}
