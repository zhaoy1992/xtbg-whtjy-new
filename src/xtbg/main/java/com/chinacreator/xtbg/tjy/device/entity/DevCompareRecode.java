
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCompareRecode.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:DevCompareRecode.java</p>
 *<p>Description:对比记录实体bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-8
 */
public class DevCompareRecode extends XtDbBaseBean {

	
	  /** 
	  * <b>Summary: </b>
	  *     构造一个 DevCompareRecode  
	   * <b>Remarks: </b>
	  *     构造类 DevCompareRecode 的构造函数 DevCompareRecode
	  * @param tableName 
	  */
	public DevCompareRecode() {
		super("ta_oa_devcomparerecode","comp_id");
	}

	private String comp_id;		//主键ID
	private String t_sb_id;		//设备ID
	private String comp_sb_id;		//对比设备ID
	private String comp_result;		//比对结果
	private String remark;		//备注
	private Object creator_time; //创建时间
	
	private String dev_code; //设备编号
	private String dev_name; //设备名称
	private String com_devcode;//对比设备编号
	private String com_devname;//对比设备名称
	
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getComp_id() {
		return comp_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setComp_id(String comp_id) {
		this.comp_id = comp_id;
	}
	/**
	*<b>Summary: 获取设备ID</b>
	*/
	public String getT_sb_id() {
		return t_sb_id;
	}
	/**
	*<b>Summary: 设置设备ID</b>
	*/
	public void setT_sb_id(String t_sb_id) {
		this.t_sb_id = t_sb_id;
	}
	/**
	*<b>Summary: 获取对比设备ID</b>
	*/
	public String getComp_sb_id() {
		return comp_sb_id;
	}
	/**
	*<b>Summary: 设置对比设备ID</b>
	*/
	public void setComp_sb_id(String comp_sb_id) {
		this.comp_sb_id = comp_sb_id;
	}
	/**
	*<b>Summary: 获取比对结果</b>
	*/
	public String getComp_result() {
		return comp_result;
	}
	/**
	*<b>Summary: 设置比对结果</b>
	*/
	public void setComp_result(String comp_result) {
		this.comp_result = comp_result;
	}
	/**
	*<b>Summary: 获取备注</b>
	*/
	public String getRemark() {
		return remark;
	}
	/**
	*<b>Summary: 设置备注</b>
	*/
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Object getCreator_time() {
		return creator_time;
	}
	public void setCreator_time(Object creator_time) {
		this.creator_time = creator_time;
	}
	public String getDev_code() {
		return dev_code;
	}
	public void setDev_code(String dev_code) {
		this.dev_code = dev_code;
	}
	public String getDev_name() {
		return dev_name;
	}
	public void setDev_name(String dev_name) {
		this.dev_name = dev_name;
	}
	public String getCom_devcode() {
		return com_devcode;
	}
	public void setCom_devcode(String com_devcode) {
		this.com_devcode = com_devcode;
	}
	public String getCom_devname() {
		return com_devname;
	}
	public void setCom_devname(String com_devname) {
		this.com_devname = com_devname;
	}
}
