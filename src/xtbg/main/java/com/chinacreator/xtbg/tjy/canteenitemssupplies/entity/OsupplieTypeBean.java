
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsupplieTypeBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-17   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.canteenitemssupplies.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:OsupplieTypeBean.java</p>
 *<p>Description:办公用品和易耗品类型实体bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-17
 */
public class OsupplieTypeBean extends XtDbBaseBean{

	private String oftype_id;		//类型序号
	private String oftype_name;		//类型名称
	private String oftype_remark;		//说明
	private String oftype_no;		//排序号
	private String oftype_flag;		//状态 1:表示设备 2.表示易耗品
	private String unit_id;           //所属单位ID
	private String unit_name;           //所属单位名称
	  /** 
	  * <b>Summary: </b>
	  *     构造一个 OsupplieTypeBean  
	   * <b>Remarks: </b>
	  *     构造类 OsupplieTypeBean 的构造函数 OsupplieTypeBean
	  * @param tableName 
	  */
	public OsupplieTypeBean() {
		super("TA_OA_CANOSUPPLIETYPE", "oftype_id");
	}
	/**
	*<b>Summary: 获取类型序号</b>
	*/
	public String getOftype_id() {
		return oftype_id;
	}
	/**
	*<b>Summary: 设置类型序号</b>
	*/
	public void setOftype_id(String oftype_id) {
		this.oftype_id = oftype_id;
	}
	/**
	*<b>Summary: 获取类型名称</b>
	*/
	public String getOftype_name() {
		return oftype_name;
	}
	/**
	*<b>Summary: 设置类型名称</b>
	*/
	public void setOftype_name(String oftype_name) {
		this.oftype_name = oftype_name;
	}
	/**
	*<b>Summary: 获取说明</b>
	*/
	public String getOftype_remark() {
		return oftype_remark;
	}
	/**
	*<b>Summary: 设置说明</b>
	*/
	public void setOftype_remark(String oftype_remark) {
		this.oftype_remark = oftype_remark;
	}
	/**
	*<b>Summary: 获取排序号</b>
	*/
	public String getOftype_no() {
		return oftype_no;
	}
	/**
	*<b>Summary: 设置排序号</b>
	*/
	public void setOftype_no(String oftype_no) {
		this.oftype_no = oftype_no;
	}
	/**
	*<b>Summary: 获取状态 1:表示设备 2.表示易耗品</b>
	*/
	public String getOftype_flag() {
		return oftype_flag;
	}
	/**
	*<b>Summary: 设置状态 1:表示设备 2.表示易耗品</b>
	*/
	public void setOftype_flag(String oftype_flag) {
		this.oftype_flag = oftype_flag;
	}
	public String getUnit_id() {
		return unit_id;
	}
	public void setUnit_id(String unit_id) {
		this.unit_id = unit_id;
	}
	public String getUnit_name() {
		return unit_name;
	}
	public void setUnit_name(String unit_name) {
		this.unit_name = unit_name;
	}
	
}
