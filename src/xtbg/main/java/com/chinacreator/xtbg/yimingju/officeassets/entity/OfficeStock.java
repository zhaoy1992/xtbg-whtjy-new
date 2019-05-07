package com.chinacreator.xtbg.yimingju.officeassets.entity;

/**
 * 办公室设备库存信息 Title:OfficeStock.java Description: Copyright:Copyright (c) 2012
 * Company:湖南科创
 * 
 * @author QIULIAN
 * @version 1.0
 * @date 2012-3-7
 */
public class OfficeStock {
	// 库存ID
	private String stock_id;
	//入库人ID
	private String stock_applyer;
	//入库人名字
	private String stock_applyerName;
	//入库时间
	private String stock_data;
	//申请开始时间
	private String stock_startTime;
	//申请结束时间
	private String stock_endTime;
	//类别ID
	private String type_id;
	//类别名称
	private String type_name;
	//设备名称
	private String equipment_name;
	//设备编号
	private String equipment_no;
	//设备型号
	private String equipment_model;
	//设备价格
	private String equipment_price;
	//供货厂商
	private String suppliers;
	//售后电话
	private String service_phone;
	//备注
	private String remark;
	//库存状态
	private String state;
	//领用人
	private String collar_user;
	//领用名称
	private String collar_userName;
	//操作人
	private String action_name;
	//操作
	private String action;
	//设备采购编号
	private String goodsid;
	
	
		
	public String getGoodsid() {
		return goodsid;
	}
	public void setGoodsid(String goodsid) {
		this.goodsid = goodsid;
	}
	public String getStock_id() {
		return stock_id;
	}
	public void setStock_id(String stock_id) {
		this.stock_id = stock_id;
	}
	public String getStock_applyer() {
		return stock_applyer;
	}
	public void setStock_applyer(String stock_applyer) {
		this.stock_applyer = stock_applyer;
	}
	public String getStock_applyerName() {
		return stock_applyerName;
	}
	public void setStock_applyerName(String stock_applyerName) {
		this.stock_applyerName = stock_applyerName;
	}
	public String getStock_data() {
		return stock_data;
	}
	public void setStock_data(String stock_data) {
		this.stock_data = stock_data;
	}
	public String getType_id() {
		return type_id;
	}
	public void setType_id(String type_id) {
		this.type_id = type_id;
	}
	public String getType_name() {
		return type_name;
	}
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	public String getEquipment_name() {
		return equipment_name;
	}
	public void setEquipment_name(String equipment_name) {
		this.equipment_name = equipment_name;
	}
	public String getEquipment_no() {
		return equipment_no;
	}
	public void setEquipment_no(String equipment_no) {
		this.equipment_no = equipment_no;
	}
	public String getEquipment_model() {
		return equipment_model;
	}
	public void setEquipment_model(String equipment_model) {
		this.equipment_model = equipment_model;
	}
	public String getEquipment_price() {
		return equipment_price;
	}
	public void setEquipment_price(String equipment_price) {
		this.equipment_price = equipment_price;
	}
	public String getSuppliers() {
		return suppliers;
	}
	public void setSuppliers(String suppliers) {
		this.suppliers = suppliers;
	}
	public String getService_phone() {
		return service_phone;
	}
	public void setService_phone(String service_phone) {
		this.service_phone = service_phone;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCollar_user() {
		return collar_user;
	}
	public void setCollar_user(String collar_user) {
		this.collar_user = collar_user;
	}
	public String getCollar_userName() {
		return collar_userName;
	}
	public void setCollar_userName(String collar_userName) {
		this.collar_userName = collar_userName;
	}
	public String getStock_startTime() {
		return stock_startTime;
	}
	public void setStock_startTime(String stock_startTime) {
		this.stock_startTime = stock_startTime;
	}
	public String getStock_endTime() {
		return stock_endTime;
	}
	public void setStock_endTime(String stock_endTime) {
		this.stock_endTime = stock_endTime;
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
}
