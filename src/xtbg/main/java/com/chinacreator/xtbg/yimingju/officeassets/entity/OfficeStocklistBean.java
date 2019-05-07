package com.chinacreator.xtbg.yimingju.officeassets.entity;

/**
 * 办公室设备库存明细信息 Title:OfficeStocklistBean.java Description: Copyright:Copyright (c) 2012
 * Company:湖南科创
 * @author QIULIAN
 * @version 1.0
 * @date 2012-3-7
 */
public class OfficeStocklistBean {
	//类别ID
	private String type_id;
	//领用人
	private String collar_name;
	//操作人
	private String action_name;
	//操作
	private String action;
	//设备类别名称
	private String ty_name;
	//设备类别
	private String ty_id;
	//设备编号
	private String eq_no;
	//设备名称
	private String eq_name;
	//日期
	private String s_date;
	//开始时间
	private String start_time;
	//结束时间
	private String end_time;
	//ID
	private String id;
	//库存ID
	private String stock_Id;
	
	public String getCollar_name() {
		return collar_name;
	}
	public void setCollar_name(String collar_name) {
		this.collar_name = collar_name;
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
	public String getTy_name() {
		return ty_name;
	}
	public void setTy_name(String ty_name) {
		this.ty_name = ty_name;
	}
	public String getEq_no() {
		return eq_no;
	}
	public void setEq_no(String eq_no) {
		this.eq_no = eq_no;
	}
	public String getEq_name() {
		return eq_name;
	}
	public void setEq_name(String eq_name) {
		this.eq_name = eq_name;
	}
	public String getS_date() {
		return s_date;
	}
	public void setS_date(String s_date) {
		this.s_date = s_date;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType_id() {
		return type_id;
	}
	public void setType_id(String type_id) {
		this.type_id = type_id;
	}
	public String getTy_id() {
		return ty_id;
	}
	public void setTy_id(String ty_id) {
		this.ty_id = ty_id;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getStock_Id() {
		return stock_Id;
	}
	public void setStock_Id(String stock_Id) {
		this.stock_Id = stock_Id;
	}
	
}
