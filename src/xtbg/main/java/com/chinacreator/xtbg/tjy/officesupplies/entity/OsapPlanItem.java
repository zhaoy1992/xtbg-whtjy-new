
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsapPlanItem.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-20   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.officesupplies.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:OsapPlanItem.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-20
 */
public class OsapPlanItem extends XtDbBaseBean{

	
  /** 
  * <b>Summary: </b>
  *     构造一个 OsapPlanItem  
   * <b>Remarks: </b>
  *     构造类 OsapPlanItem 的构造函数 OsapPlanItem
  * @param tableName 
  */
	public OsapPlanItem() {
		super("ta_oa_osapplanitem", "it_id");
	}
	
	private String it_id;			//主键ID
	private String it_planid;		//申购计划ID
	private String it_osusetype_id;		//常用物品ID
	private String it_osusetype_name;		//常用物品名称
	private String it_osustitem_id;		//规格型号ID
	private String it_osustitem_name;		//规格型号名称
	private String it_count;		//数量
	private String it_remark;		//备注
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
	*<b>Summary: 获取申购计划ID</b>
	*/
	public String getIt_planid() {
		return it_planid;
	}
	/**
	*<b>Summary: 设置申购计划ID</b>
	*/
	public void setIt_planid(String it_planid) {
		this.it_planid = it_planid;
	}
	/**
	*<b>Summary: 获取常用物品ID</b>
	*/
	public String getIt_osusetype_id() {
		return it_osusetype_id;
	}
	/**
	*<b>Summary: 设置常用物品ID</b>
	*/
	public void setIt_osusetype_id(String it_osusetype_id) {
		this.it_osusetype_id = it_osusetype_id;
	}
	/**
	*<b>Summary: 获取常用物品名称</b>
	*/
	public String getIt_osusetype_name() {
		return it_osusetype_name;
	}
	/**
	*<b>Summary: 设置常用物品名称</b>
	*/
	public void setIt_osusetype_name(String it_osusetype_name) {
		this.it_osusetype_name = it_osusetype_name;
	}
	/**
	*<b>Summary: 获取规格型号ID</b>
	*/
	public String getIt_osustitem_id() {
		return it_osustitem_id;
	}
	/**
	*<b>Summary: 设置规格型号ID</b>
	*/
	public void setIt_osustitem_id(String it_osustitem_id) {
		this.it_osustitem_id = it_osustitem_id;
	}
	/**
	*<b>Summary: 获取规格型号名称</b>
	*/
	public String getIt_osustitem_name() {
		return it_osustitem_name;
	}
	/**
	*<b>Summary: 设置规格型号名称</b>
	*/
	public void setIt_osustitem_name(String it_osustitem_name) {
		this.it_osustitem_name = it_osustitem_name;
	}
	/**
	*<b>Summary: 获取数量</b>
	*/
	public String getIt_count() {
		return it_count;
	}
	/**
	*<b>Summary: 设置数量</b>
	*/
	public void setIt_count(String it_count) {
		this.it_count = it_count;
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

	

}
