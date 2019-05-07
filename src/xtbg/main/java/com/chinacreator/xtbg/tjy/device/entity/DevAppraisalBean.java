
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAppraisalBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:DevAppraisalBean.java</p>
 *<p>Description:设备检定记录实体bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-8
 */
public class DevAppraisalBean extends XtDbBaseBean{
	
	  /** 
	  * <b>Summary: </b>
	  *     构造一个 DevAppraisalBean  
	   * <b>Remarks: </b>
	  *     构造类 DevAppraisalBean 的构造函数 DevAppraisalBean
	  * @param tableName 
	  */
	public DevAppraisalBean() {
		super("ta_oa_devappraisal","appr_id");
	}
	
	private String appr_id;		//主键ID
	private String t_sb_id;		//设备ID
	private String appr_no;		//检定/校准证书编号
	private String appr_org_id;		//检定/校准单位ID
	private String appr_org_name;		//检定/校准单位名称
	private Object appr_time;		//检定/校准日期
	private Object appr_valitime;		//有效期
	private String appr_parrange;		//参数范围
	
	private String dev_code;	//设备编号
	private String dev_name;	//设备名称
	private String dev_type;	// 规格型号
	
	private String appr_method_id;//检定方式id
	private String appr_method;//检定方式
	private String appr_result;//检定结果
	private Object next_appr_time;//下次检定日期
	
	
	public Object getNext_appr_time() {
		return next_appr_time;
	}
	public void setNext_appr_time(Object nextApprTime) {
		next_appr_time = nextApprTime;
	}
	public String getAppr_method_id() {
		return appr_method_id;
	}
	public void setAppr_method_id(String apprMethodId) {
		appr_method_id = apprMethodId;
	}
	public String getAppr_method() {
		return appr_method;
	}
	public void setAppr_method(String apprMethod) {
		appr_method = apprMethod;
	}
	public String getAppr_result() {
		return appr_result;
	}
	public void setAppr_result(String apprResult) {
		appr_result = apprResult;
	}
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getAppr_id() {
		return appr_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setAppr_id(String appr_id) {
		this.appr_id = appr_id;
	}
	/**
	*<b>Summary: 获取设备ID</b>
	*/
	public String getT_sb_id() {
		return t_sb_id;
	}
	/**
	*<b>Summary: 设置设备ID</b>
	*/
	public void setT_sb_id(String t_sb_id) {
		this.t_sb_id = t_sb_id;
	}
	/**
	*<b>Summary: 获取检定/校准证书编号</b>
	*/
	public String getAppr_no() {
		return appr_no;
	}
	/**
	*<b>Summary: 设置检定/校准证书编号</b>
	*/
	public void setAppr_no(String appr_no) {
		this.appr_no = appr_no;
	}
	/**
	*<b>Summary: 获取检定/校准单位ID</b>
	*/
	public String getAppr_org_id() {
		return appr_org_id;
	}
	/**
	*<b>Summary: 设置检定/校准单位ID</b>
	*/
	public void setAppr_org_id(String appr_org_id) {
		this.appr_org_id = appr_org_id;
	}
	/**
	*<b>Summary: 获取检定/校准单位名称</b>
	*/
	public String getAppr_org_name() {
		return appr_org_name;
	}
	/**
	*<b>Summary: 设置检定/校准单位名称</b>
	*/
	public void setAppr_org_name(String appr_org_name) {
		this.appr_org_name = appr_org_name;
	}
	/**
	*<b>Summary: 获取检定/校准日期</b>
	*/
	public Object getAppr_time() {
		return appr_time;
	}
	/**
	*<b>Summary: 设置检定/校准日期</b>
	*/
	public void setAppr_time(Object appr_time) {
		this.appr_time = appr_time;
	}
	/**
	*<b>Summary: 获取有效期</b>
	*/
	public Object getAppr_valitime() {
		return appr_valitime;
	}
	/**
	*<b>Summary: 设置有效期</b>
	*/
	public void setAppr_valitime(Object appr_valitime) {
		this.appr_valitime = appr_valitime;
	}
	/**
	*<b>Summary: 获取参数范围</b>
	*/
	public String getAppr_parrange() {
		return appr_parrange;
	}
	/**
	*<b>Summary: 设置参数范围</b>
	*/
	public void setAppr_parrange(String appr_parrange) {
		this.appr_parrange = appr_parrange;
	}
	public String getDev_code() {
		return dev_code;
	}
	public void setDev_code(String dev_code) {
		this.dev_code = dev_code;
	}
	public String getDev_name() {
		return dev_name;
	}
	public void setDev_name(String dev_name) {
		this.dev_name = dev_name;
	}
	public String getDev_type() {
		return dev_type;
	}
	public void setDev_type(String dev_type) {
		this.dev_type = dev_type;
	}

}
