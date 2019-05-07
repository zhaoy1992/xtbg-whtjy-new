package com.chinacreator.xtbg.yimingju.carmanage.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 车辆加油管理实体类
 * @author huangdi
 *
 */
public class CarManageRefuelmanageBean extends XtDbBaseBean  {
	
	/** 
	 * <b>Summary:重写构造器，调用父类的构造器，赋值表名 </b> 构造一个 CarManageRefuelmanageBean <b>Remarks:
	 * </b> 构造类 CarManageRefuelmanageBean 的构造函数 CarManageRefuelmanageBean
	 */
	public CarManageRefuelmanageBean() {
		// 构造方法传入该bean对应的表名,更新的字段名，删除的字段名
		super("TA_OA_REFUELMANAGE", new String[] { "fuel_id" },
				new String[] { "fuel_id" });
	}
	
	private String fuel_id;//id
	
	private String license_number;//车牌号码
	
	private String fuel_type;//加油类型
	
	private String unit_cost;//单价(元/升)
	
	private String refuel_point;//加油地点
	
	private String invoice_number;//发票号码
	
	private String more_detail;//其他信息
	
	private String refuel_time;//加油时间
	
	private String total_price;//总价
	
	private String fuel_charge;//加油量
	
	private String fuel_person;//加油人id
	
	private String fuel_name;//加油人id
	
	private String car_num;//加油人id
	
	private String start_time;//查询开始时间
	
	private String end_time;//查询结束时间
	
	
	public String getFuel_id() {
		return fuel_id;
	}

	public void setFuel_id(String fuel_id) {
		this.fuel_id = fuel_id;
	}

	public String getLicense_number() {
		return license_number;
	}

	public void setLicense_number(String license_number) {
		this.license_number = license_number;
	}

	public String getFuel_type() {
		return fuel_type;
	}

	public void setFuel_type(String fuel_type) {
		this.fuel_type = fuel_type;
	}

	public String getUnit_cost() {
		return unit_cost;
	}

	public void setUnit_cost(String unit_cost) {
		this.unit_cost = unit_cost;
	}

	public String getRefuel_point() {
		return refuel_point;
	}

	public void setRefuel_point(String refuel_point) {
		this.refuel_point = refuel_point;
	}

	public String getInvoice_number() {
		return invoice_number;
	}

	public void setInvoice_number(String invoice_number) {
		this.invoice_number = invoice_number;
	}

	public String getMore_detail() {
		return more_detail;
	}

	public void setMore_detail(String more_detail) {
		this.more_detail = more_detail;
	}

	public String getRefuel_time() {
		return refuel_time;
	}

	public void setRefuel_time(String refuel_time) {
		this.refuel_time = refuel_time;
	}

	public String getTotal_price() {
		return total_price;
	}

	public void setTotal_price(String total_price) {
		this.total_price = total_price;
	}

	public String getFuel_charge() {
		return fuel_charge;
	}

	public void setFuel_charge(String fuel_charge) {
		this.fuel_charge = fuel_charge;
	}

	public String getFuel_person() {
		return fuel_person;
	}

	public void setFuel_person(String fuel_person) {
		this.fuel_person = fuel_person;
	}

	public String getFuel_name() {
		return fuel_name;
	}

	public void setFuel_name(String fuel_name) {
		this.fuel_name = fuel_name;
	}

	public String getCar_num() {
		return car_num;
	}

	public void setCar_num(String car_num) {
		this.car_num = car_num;
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

	
}
