
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     PersonHolder.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-21   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.personholder.entity;

import java.util.Date;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:PersonHolder.java</p>
 *<p>Description:人员持证信息bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-21
 */
public class PersonHolder extends XtDbBaseBean{
	
	public PersonHolder(){
		super("ta_oa_personholder","hold_id");
	}
	
	private String hold_id;		//持证ID
	private String hold_name;		//持证项目
	private String hold_org;		//审批机构
	private String hold_number;		//证书编号
	private String hold_ratifytime;		//初次取证日期
	private String hold_validtime;		//有效日期
	private String hold_replactime;		//换证日期
	private String hold_level;		//持证级别
	private String hold_state;		//持证状态
	private String register_flag;		//是否注册
	private String creator_time;		//创建日期
	private String hold_usesnid;		//人员信息关联表ID
	private String hold_remark;			//备注
	private String attachment_id;			//附件id
	private String unit_name;               //部门名称
	
	//查询
	private String validStart_time;//有效开始日期
	private String validEtart_time;//有效结束日期
	private String orgIds;//人员持证用户机构ID
	private String orgNames;//人员持证用户机构名称
	/**
	*<b>Summary: 获取持证ID</b>
	*/
	public String getHold_id() {
		return hold_id;
	}
	/**
	*<b>Summary: 设置持证ID</b>
	*/
	public void setHold_id(String hold_id) {
		this.hold_id = hold_id;
	}
	/**
	*<b>Summary: 获取持证项目</b>
	*/
	public String getHold_name() {
		return hold_name;
	}
	/**
	*<b>Summary: 设置持证项目</b>
	*/
	public void setHold_name(String hold_name) {
		this.hold_name = hold_name;
	}
	/**
	*<b>Summary: 获取审批机构</b>
	*/
	public String getHold_org() {
		return hold_org;
	}
	/**
	*<b>Summary: 设置审批机构</b>
	*/
	public void setHold_org(String hold_org) {
		this.hold_org = hold_org;
	}
	/**
	*<b>Summary: 获取证书编号</b>
	*/
	public String getHold_number() {
		return hold_number;
	}
	/**
	*<b>Summary: 设置证书编号</b>
	*/
	public void setHold_number(String hold_number) {
		this.hold_number = hold_number;
	}
	
	/**
	*<b>Summary: 获取持证级别</b>
	*/
	public String getHold_level() {
		return hold_level;
	}
	/**
	*<b>Summary: 设置持证级别</b>
	*/
	public void setHold_level(String hold_level) {
		this.hold_level = hold_level;
	}
	/**
	*<b>Summary: 获取持证状态</b>
	*/
	public String getHold_state() {
		return hold_state;
	}
	/**
	*<b>Summary: 设置持证状态</b>
	*/
	public void setHold_state(String hold_state) {
		this.hold_state = hold_state;
	}
	/**
	*<b>Summary: 获取是否注册</b>
	*/
	public String getRegister_flag() {
		return register_flag;
	}
	/**
	*<b>Summary: 设置是否注册</b>
	*/
	public void setRegister_flag(String register_flag) {
		this.register_flag = register_flag;
	}
	
	/**
	*<b>Summary: 获取人员信息关联表ID</b>
	*/
	public String getHold_usesnid() {
		return hold_usesnid;
	}
	/**
	*<b>Summary: 设置人员信息关联表ID</b>
	*/
	public void setHold_usesnid(String hold_usesnid) {
		this.hold_usesnid = hold_usesnid;
	}
	public String getHold_remark() {
		return hold_remark;
	}
	public void setHold_remark(String hold_remark) {
		this.hold_remark = hold_remark;
	}
	public String getValidStart_time() {
		return validStart_time;
	}
	public void setValidStart_time(String validStart_time) {
		this.validStart_time = validStart_time;
	}
	public String getValidEtart_time() {
		return validEtart_time;
	}
	public void setValidEtart_time(String validEtart_time) {
		this.validEtart_time = validEtart_time;
	}
	public String getOrgIds() {
		return orgIds;
	}
	public void setOrgIds(String orgIds) {
		this.orgIds = orgIds;
	}
	public String getOrgNames() {
		return orgNames;
	}
	public void setOrgNames(String orgNames) {
		this.orgNames = orgNames;
	}
	public String getAttachment_id() {
		return attachment_id;
	}
	public void setAttachment_id(String attachment_id) {
		this.attachment_id = attachment_id;
	}
	public String getUnit_name() {
		return unit_name;
	}
	public void setUnit_name(String unit_name) {
		this.unit_name = unit_name;
	}
	public String getHold_ratifytime() {
		return hold_ratifytime;
	}
	public void setHold_ratifytime(String hold_ratifytime) {
		this.hold_ratifytime = hold_ratifytime;
	}
	public String getHold_validtime() {
		return hold_validtime;
	}
	public void setHold_validtime(String hold_validtime) {
		this.hold_validtime = hold_validtime;
	}
	public String getHold_replactime() {
		return hold_replactime;
	}
	public void setHold_replactime(String hold_replactime) {
		this.hold_replactime = hold_replactime;
	}
	public String getCreator_time() {
		return creator_time;
	}
	public void setCreator_time(String creator_time) {
		this.creator_time = creator_time;
	}
	
	
	
}
