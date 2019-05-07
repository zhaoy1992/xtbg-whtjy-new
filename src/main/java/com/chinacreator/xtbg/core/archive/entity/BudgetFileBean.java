package com.chinacreator.xtbg.core.archive.entity;
/**
 * 
 *<p>Title:BudgetFileBean.java</p>
 *<p>Description:指标文拆分-指标文总信息</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Nov 12, 2013
 */
public class BudgetFileBean {
	private String id;		//ID
	private String file_code;		//文号
	private String bus_id;		//流程实例id
	private String ins_name;		//流程实例名称
	
	private String file_name;		//名称
	private String amount;		//金额
	private String branch_id;		//归口处室
	private String org_name;		//归口处室名称
	
	private String user_id;		//操作人
	private String user_name;	//操作人
	private String op_date;		//操作时间
	private String status;		//处理状态(0:未处理完;1:已处理完;)
	
	private String annual;		//年份
	
	public String getAnnual() {
		return annual;
	}
	public void setAnnual(String annual) {
		this.annual = annual;
	}
	public String getIns_name() {
		return ins_name;
	}
	public void setIns_name(String ins_name) {
		this.ins_name = ins_name;
	}
	public String getOrg_name() {
		return org_name;
	}
	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	/**
	*<b>Summary: 获取ID</b>
	*/
	public String getId() {
		return id;
	}
	/**
	*<b>Summary: 设置ID</b>
	*/
	public void setId(String id) {
		this.id = id;
	}
	/**
	*<b>Summary: 获取文号</b>
	*/
	public String getFile_code() {
		return file_code;
	}
	/**
	*<b>Summary: 设置文号</b>
	*/
	public void setFile_code(String file_code) {
		this.file_code = file_code;
	}
	/**
	*<b>Summary: 获取流程实例id</b>
	*/
	public String getBus_id() {
		return bus_id;
	}
	/**
	*<b>Summary: 设置流程实例id</b>
	*/
	public void setBus_id(String bus_id) {
		this.bus_id = bus_id;
	}
	/**
	*<b>Summary: 获取名称</b>
	*/
	public String getFile_name() {
		return file_name;
	}
	/**
	*<b>Summary: 设置名称</b>
	*/
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	/**
	*<b>Summary: 获取金额</b>
	*/
	public String getAmount() {
		return amount;
	}
	/**
	*<b>Summary: 设置金额</b>
	*/
	public void setAmount(String amount) {
		this.amount = amount;
	}
	/**
	*<b>Summary: 获取归口处室</b>
	*/
	public String getBranch_id() {
		return branch_id;
	}
	/**
	*<b>Summary: 设置归口处室</b>
	*/
	public void setBranch_id(String branch_id) {
		this.branch_id = branch_id;
	}
	/**
	*<b>Summary: 获取操作人</b>
	*/
	public String getUser_id() {
		return user_id;
	}
	/**
	*<b>Summary: 设置操作人</b>
	*/
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	/**
	*<b>Summary: 获取操作时间</b>
	*/
	public String getOp_date() {
		return op_date;
	}
	/**
	*<b>Summary: 设置操作时间</b>
	*/
	public void setOp_date(String op_date) {
		this.op_date = op_date;
	}
	/**
	*<b>Summary: 获取处理状态(0:未处理完;1:已处理完;)</b>
	*/
	public String getStatus() {
		return status;
	}
	/**
	*<b>Summary: 设置处理状态(0:未处理完;1:已处理完;)</b>
	*/
	public void setStatus(String status) {
		this.status = status;
	}
}
