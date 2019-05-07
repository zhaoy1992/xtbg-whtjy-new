package com.chinacreator.xtbg.tjy.officesupplies.entity;
/**
 * 固定资产bean
 * @author 王淑滨
 *
 */
public class OsAccountBean {
	   private String id;//主键id
	   private String internal_no;//内部编号
	   private String num;//编号
	   private String name;//名称
	   private String type_id;//分类id
	   private String type_name;//分类
	   private String address;//地址
	   private String area;//面积
	   private String ownership_no;//权属证号
	   private String fazheng_date;//发证时间
	   private String it;//规格型号
	   private String manufacturer;//生产厂家
	   private String body_no;//机身号
	   private String bar_code;//条形码
	   private String finance_no;//财政编号
	   private String original_value;//原值
	   private String buy_time;//购买时间
	   private String user_id;//借用人、管理人、领用人id
	   private String user_name;//借用人、管理人、领用人
	   private String org_id;//借用部门、管理部门、领用部门id
	   private String org_name;//借用部门、管理部门、领用部门
	   private String use_date;//借用时间、管理时间、领用时间
	   private String location_place;//公用物资放置地点
	   private String this_calibration_time;//本次校准日期
	   private String next_calibration_time;//下次校准日期
	   private String is_allocation;//是否调拨0.否  1.是
	   private String is_lease;//是否出租 0.否 1.是
	   private String allocation_place;//调拨地点
	   private String lease_place;//出租地点
	   private String allocation_date;//调拨时间
	   private String lease_date;//出租时间
	   private String state;//状态 在库正常/在库维修/借用/领用/出租/调拨
	   private String state_id;//状态 在库正常/在库维修/借用/领用/出租/调拨
	   private String dealt;//处置方式
	   private String dealt_date;//处置时间
	   private String location_id;//所在地id
	   private String location_name;//所在地  院本部/分院
	   private String location_org_id;//所在部门id
	   private String location_org;//所在部门
	   private String classify;//类别1.办公设备、2.仪器设备、3.土地房屋、4.电器、5.公用物资、6.家具、7.车辆
	
	   private String color;//颜色
	   private String vin_number;//车架号
	   private String engine_number;//发动机号
	   private String car_number;//车牌号
	   private String displacement;//排量
	   
	   private String is_fenyuan;//是不是分院 做分院本部隔离用 0.是 1.否
	   private String show_baofei;//显示报废资产  0.是 1.否
	   private String start_time;//查询开始时间
	   private String end_time;//查询结束时间
	   
	   private String t_trsynx;//使用年限
	   
	   
	 
	public String getT_trsynx() {
		return t_trsynx;
	}
	public void setT_trsynx(String tTrsynx) {
		t_trsynx = tTrsynx;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getVin_number() {
		return vin_number;
	}
	public void setVin_number(String vinNumber) {
		vin_number = vinNumber;
	}
	public String getEngine_number() {
		return engine_number;
	}
	public void setEngine_number(String engineNumber) {
		engine_number = engineNumber;
	}
	public String getCar_number() {
		return car_number;
	}
	public void setCar_number(String carNumber) {
		car_number = carNumber;
	}
	public String getDisplacement() {
		return displacement;
	}
	public void setDisplacement(String displacement) {
		this.displacement = displacement;
	}
	public String getState_id() {
		return state_id;
	}
	public void setState_id(String stateId) {
		state_id = stateId;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String startTime) {
		start_time = startTime;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String endTime) {
		end_time = endTime;
	}
	public String getShow_baofei() {
		return show_baofei;
	}
	public void setShow_baofei(String showBaofei) {
		show_baofei = showBaofei;
	}
	public String getIs_fenyuan() {
		return is_fenyuan;
	}
	public void setIs_fenyuan(String isFenyuan) {
		is_fenyuan = isFenyuan;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getInternal_no() {
		return internal_no;
	}
	public void setInternal_no(String internalNo) {
		internal_no = internalNo;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType_id() {
		return type_id;
	}
	public void setType_id(String typeId) {
		type_id = typeId;
	}
	public String getType_name() {
		return type_name;
	}
	public void setType_name(String typeName) {
		type_name = typeName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getOwnership_no() {
		return ownership_no;
	}
	public void setOwnership_no(String ownershipNo) {
		ownership_no = ownershipNo;
	}
	public String getFazheng_date() {
		return fazheng_date;
	}
	public void setFazheng_date(String fazhengDate) {
		fazheng_date = fazhengDate;
	}
	public String getIt() {
		return it;
	}
	public void setIt(String it) {
		this.it = it;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getBody_no() {
		return body_no;
	}
	public void setBody_no(String bodyNo) {
		body_no = bodyNo;
	}
	public String getBar_code() {
		return bar_code;
	}
	public void setBar_code(String barCode) {
		bar_code = barCode;
	}
	public String getFinance_no() {
		return finance_no;
	}
	public void setFinance_no(String financeNo) {
		finance_no = financeNo;
	}
	public String getOriginal_value() {
		return original_value;
	}
	public void setOriginal_value(String originalValue) {
		original_value = originalValue;
	}
	public String getBuy_time() {
		return buy_time;
	}
	public void setBuy_time(String buyTime) {
		buy_time = buyTime;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String userId) {
		user_id = userId;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String userName) {
		user_name = userName;
	}
	public String getOrg_id() {
		return org_id;
	}
	public void setOrg_id(String orgId) {
		org_id = orgId;
	}
	public String getOrg_name() {
		return org_name;
	}
	public void setOrg_name(String orgName) {
		org_name = orgName;
	}
	public String getUse_date() {
		return use_date;
	}
	public void setUse_date(String useDate) {
		use_date = useDate;
	}
	public String getLocation_place() {
		return location_place;
	}
	public void setLocation_place(String locationPlace) {
		location_place = locationPlace;
	}
	public String getThis_calibration_time() {
		return this_calibration_time;
	}
	public void setThis_calibration_time(String thisCalibrationTime) {
		this_calibration_time = thisCalibrationTime;
	}
	public String getNext_calibration_time() {
		return next_calibration_time;
	}
	public void setNext_calibration_time(String nextCalibrationTime) {
		next_calibration_time = nextCalibrationTime;
	}
	public String getIs_allocation() {
		return is_allocation;
	}
	public void setIs_allocation(String isAllocation) {
		is_allocation = isAllocation;
	}
	public String getIs_lease() {
		return is_lease;
	}
	public void setIs_lease(String isLease) {
		is_lease = isLease;
	}
	public String getAllocation_place() {
		return allocation_place;
	}
	public void setAllocation_place(String allocationPlace) {
		allocation_place = allocationPlace;
	}
	public String getLease_place() {
		return lease_place;
	}
	public void setLease_place(String leasePlace) {
		lease_place = leasePlace;
	}
	public String getAllocation_date() {
		return allocation_date;
	}
	public void setAllocation_date(String allocationDate) {
		allocation_date = allocationDate;
	}
	public String getLease_date() {
		return lease_date;
	}
	public void setLease_date(String leaseDate) {
		lease_date = leaseDate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getDealt() {
		return dealt;
	}
	public void setDealt(String dealt) {
		this.dealt = dealt;
	}
	public String getDealt_date() {
		return dealt_date;
	}
	public void setDealt_date(String dealtDate) {
		dealt_date = dealtDate;
	}
	public String getLocation_id() {
		return location_id;
	}
	public void setLocation_id(String locationId) {
		location_id = locationId;
	}
	public String getLocation_name() {
		return location_name;
	}
	public void setLocation_name(String locationName) {
		location_name = locationName;
	}
	public String getLocation_org_id() {
		return location_org_id;
	}
	public void setLocation_org_id(String locationOrgId) {
		location_org_id = locationOrgId;
	}
	public String getLocation_org() {
		return location_org;
	}
	public void setLocation_org(String locationOrg) {
		location_org = locationOrg;
	}
	public String getClassify() {
		return classify;
	}
	public void setClassify(String classify) {
		this.classify = classify;
	}
	   
	   
	   
	   
}
