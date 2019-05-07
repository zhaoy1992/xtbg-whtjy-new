
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsuserTypeItemBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.canteenitemssupplies.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:OsuserTypeItemBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public class OsuserTypeItemBean extends XtDbBaseBean{

	
  /** 
  * <b>Summary: </b>
  *     构造一个 OsuserTypeItemBean  
   * <b>Remarks: </b>
  *     构造类 OsuserTypeItemBean 的构造函数 OsuserTypeItemBean
  * @param tableName 
  */
	public OsuserTypeItemBean() {
		super("TA_OA_CANOSUSERTYPEITEM", "it_id");
	}
	
	private String it_id;		//主键ID
	private String it_name;		//物品规格名称
	private String it_no;		//排序号
	private String it_remark;	//备注
	private String it_typeid;	//物品ID
	private String unit_id;           //所属单位ID
	private String unit_name;           //所属单位名称
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getIt_id() {
		return it_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setIt_id(String it_id) {
		this.it_id = it_id;
	}
	/**
	*<b>Summary: 获取物品规格名称</b>
	*/
	public String getIt_name() {
		return it_name;
	}
	/**
	*<b>Summary: 设置物品规格名称</b>
	*/
	public void setIt_name(String it_name) {
		this.it_name = it_name;
	}
	/**
	*<b>Summary: 获取排序号</b>
	*/
	public String getIt_no() {
		return it_no;
	}
	/**
	*<b>Summary: 设置排序号</b>
	*/
	public void setIt_no(String it_no) {
		this.it_no = it_no;
	}
	/**
	*<b>Summary: 获取备注</b>
	*/
	public String getIt_remark() {
		return it_remark;
	}
	/**
	*<b>Summary: 设置备注</b>
	*/
	public void setIt_remark(String it_remark) {
		this.it_remark = it_remark;
	}
	public String getIt_typeid() {
		return it_typeid;
	}
	public void setIt_typeid(String it_typeid) {
		this.it_typeid = it_typeid;
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
