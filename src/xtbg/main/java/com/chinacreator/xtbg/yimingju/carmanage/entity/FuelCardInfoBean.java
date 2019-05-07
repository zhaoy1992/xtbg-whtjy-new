
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     FuelCardInfo.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-25   Administrator    最初版本
   */
package com.chinacreator.xtbg.yimingju.carmanage.entity;

import com.chinacreator.xtbg.pub.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:FuelCardInfoBean.java</p>
 *<p>Description:特检院油卡充值/加油 使用记录 实体bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-25
 */
public class FuelCardInfoBean extends XtDbBaseBean {

	  /** 
	  * <b>Summary: </b>
	  *     构造一个 FuelCardInfoBean  
	   * <b>Remarks: </b>
	  *     构造类 FuelCardInfoBean 的构造函数 FuelCardInfoBean
	  * @param tableName 
	  */
	public FuelCardInfoBean() {
		super("ta_oa_cardfuelhistory", "fuelcard_id");
	}
	
	private String fuelcard_id;			//主键ID
	private String fuelcard_money;		//加油\充值金额
	private String fuelcard_type;		//记录类型 0:加油 1:充值 2:初始金额
	private Object fuelcard_time;		//登记时间
	private String card_id;				//车辆ID
	private String fuelcard_remark;		//备注
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getFuelcard_id() {
		return fuelcard_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setFuelcard_id(String fuelcard_id) {
		this.fuelcard_id = fuelcard_id;
	}
	/**
	*<b>Summary: 获取加油\充值金额</b>
	*/
	public String getFuelcard_money() {
		return fuelcard_money;
	}
	/**
	*<b>Summary: 设置加油\充值金额</b>
	*/
	public void setFuelcard_money(String fuelcard_money) {
		this.fuelcard_money = fuelcard_money;
	}
	/**
	*<b>Summary: 获取记录类型 0:加油 1:充值 2:初始金额</b>
	*/
	public String getFuelcard_type() {
		return fuelcard_type;
	}
	/**
	*<b>Summary: 设置记录类型 0:加油 1:充值 2:初始金额</b>
	*/
	public void setFuelcard_type(String fuelcard_type) {
		this.fuelcard_type = fuelcard_type;
	}
	/**
	*<b>Summary: 获取登记时间</b>
	*/
	public Object getFuelcard_time() {
		return fuelcard_time;
	}
	/**
	*<b>Summary: 设置登记时间</b>
	*/
	public void setFuelcard_time(Object fuelcard_time) {
		this.fuelcard_time = fuelcard_time;
	}
	/**
	*<b>Summary: 获取车辆ID</b>
	*/
	public String getCard_id() {
		return card_id;
	}
	/**
	*<b>Summary: 设置车辆ID</b>
	*/
	public void setCard_id(String card_id) {
		this.card_id = card_id;
	}
	/**
	*<b>Summary: 获取备注</b>
	*/
	public String getFuelcard_remark() {
		return fuelcard_remark;
	}
	/**
	*<b>Summary: 设置备注</b>
	*/
	public void setFuelcard_remark(String fuelcard_remark) {
		this.fuelcard_remark = fuelcard_remark;
	}
}
