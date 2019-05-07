
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevaInfoItemBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:DevaInfoItemBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public class DevInfoItemBean extends XtDbBaseBean{

	  /** 
	  * <b>Summary: </b>
	  *     构造一个 DevInfoItemBean  
	   * <b>Remarks: </b>
	  *     构造类 DevInfoItemBean 的构造函数 DevInfoItemBean
	  * @param tableName 
	  */
	public DevInfoItemBean() {
		super("ta_oa_devainfoitem", "dev_code");
	}
	
	private String id;		//主键ID
	private String dev_code;		//设备编号
	private String parts_name;		//配件名称
	private String parts_type;		//规格
	private String parts_count;		//数量
	private String parts_no;		//排序号
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getId() {
		return id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setId(String id) {
		this.id = id;
	}
	/**
	*<b>Summary: 获取设备编号</b>
	*/
	public String getDev_code() {
		return dev_code;
	}
	/**
	*<b>Summary: 设置设备编号</b>
	*/
	public void setDev_code(String dev_code) {
		this.dev_code = dev_code;
	}
	/**
	*<b>Summary: 获取配件名称</b>
	*/
	public String getParts_name() {
		return parts_name;
	}
	/**
	*<b>Summary: 设置配件名称</b>
	*/
	public void setParts_name(String parts_name) {
		this.parts_name = parts_name;
	}
	/**
	*<b>Summary: 获取规格</b>
	*/
	public String getParts_type() {
		return parts_type;
	}
	/**
	*<b>Summary: 设置规格</b>
	*/
	public void setParts_type(String parts_type) {
		this.parts_type = parts_type;
	}
	/**
	*<b>Summary: 获取数量</b>
	*/
	public String getParts_count() {
		return parts_count;
	}
	/**
	*<b>Summary: 设置数量</b>
	*/
	public void setParts_count(String parts_count) {
		this.parts_count = parts_count;
	}
	/**
	*<b>Summary: 获取排序号</b>
	*/
	public String getParts_no() {
		return parts_no;
	}
	/**
	*<b>Summary: 设置排序号</b>
	*/
	public void setParts_no(String parts_no) {
		this.parts_no = parts_no;
	}
	
	
}
