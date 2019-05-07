package com.chinacreator.xtbg.yimingju.officeassets.entity;
/**
 *<p>CollarBean.java</p>
 *<p>Description:办公室设备bean</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author QIULIAN
 *@version 1.0
 *@date 2012-11-5
 */
public class CollarBean {
	//领用ID
	private String collar_id;
	//领用人
	private String collar_user;
	//领用人名称
	private String collar_userName;
	//领用部门
	private String collar_depart;
	//领用部门名称
	private String collar_departName;
	//领用开始时间
	private String collar_startTime;
	//领用结束时间
	private String collar_endTime;
	//领用时间
	private String collar_date;
	//设备名称
	private String eq_name;
	//类别名称
	private String eq_type;
	//类别ID
	private String eq_typeId;
	//设备编号
	private String eq_no;
	//设备型号
	private String eq_model;
	//设备价格
	private String eq_price;
	//库存ID
	private String stock_Id;
	//备注
	private String remark;
	//状态
	private String state;
	//领用状态
	private String collarState;
	//供货厂商
	private String suppliers;
	//售后电话
	private String eq_phone;
	//入库时间
	private String stock_data;
	//操作人名称
	private String action_name;
	//操作
	private String action;
	
 	public String getCollar_id() {
		return collar_id;
	}
	public void setCollar_id(String collar_id) {
		this.collar_id = collar_id;
	}
	public String getCollar_user() {
		return collar_user;
	}
	public void setCollar_user(String collar_user) {
		this.collar_user = collar_user;
	}
	public String getCollar_depart() {
		return collar_depart;
	}
	public void setCollar_depart(String collar_depart) {
		this.collar_depart = collar_depart;
	}
	public String getCollar_date() {
		return collar_date;
	}
	public void setCollar_date(String collar_date) {
		this.collar_date = collar_date;
	}
	public String getEq_name() {
		return eq_name;
	}
	public void setEq_name(String eq_name) {
		this.eq_name = eq_name;
	}
	public String getEq_type() {
		return eq_type;
	}
	public void setEq_type(String eq_type) {
		this.eq_type = eq_type;
	}
	public String getEq_no() {
		return eq_no;
	}
	public void setEq_no(String eq_no) {
		this.eq_no = eq_no;
	}
	public String getEq_model() {
		return eq_model;
	}
	public void setEq_model(String eq_model) {
		this.eq_model = eq_model;
	}
	public String getCollar_startTime() {
		return collar_startTime;
	}
	public void setCollar_startTime(String collar_startTime) {
		this.collar_startTime = collar_startTime;
	}
	public String getCollar_endTime() {
		return collar_endTime;
	}
	public void setCollar_endTime(String collar_endTime) {
		this.collar_endTime = collar_endTime;
	}
	public String getCollar_userName() {
		return collar_userName;
	}
	public void setCollar_userName(String collar_userName) {
		this.collar_userName = collar_userName;
	}
	public String getCollar_departName() {
		return collar_departName;
	}
	public void setCollar_departName(String collar_departName) {
		this.collar_departName = collar_departName;
	}
	public String getStock_Id() {
		return stock_Id;
	}
	public void setStock_Id(String stock_Id) {
		this.stock_Id = stock_Id;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getEq_price() {
		return eq_price;
	}
	public void setEq_price(String eq_price) {
		this.eq_price = eq_price;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getSuppliers() {
		return suppliers;
	}
	public void setSuppliers(String suppliers) {
		this.suppliers = suppliers;
	}
	public String getEq_phone() {
		return eq_phone;
	}
	public void setEq_phone(String eq_phone) {
		this.eq_phone = eq_phone;
	}
	public String getStock_data() {
		return stock_data;
	}
	public void setStock_data(String stock_data) {
		this.stock_data = stock_data;
	}
	public String getCollarState() {
		return collarState;
	}
	public void setCollarState(String collarState) {
		this.collarState = collarState;
	}
	public String getAction_name() {
		return action_name;
	}
	public void setAction_name(String action_name) {
		this.action_name = action_name;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getEq_typeId() {
		return eq_typeId;
	}
	public void setEq_typeId(String eq_typeId) {
		this.eq_typeId = eq_typeId;
	}
	
}
