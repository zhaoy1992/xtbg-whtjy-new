
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevRepairBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:DevRepairBean.java</p>
 *<p>Description:设备维修表实体bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-8
 */
public class DevRepairBean extends XtDbBaseBean {

	
	  /** 
	  * <b>Summary: </b>
	  *     构造一个 DevRepairBean  
	   * <b>Remarks: </b>
	  *     构造类 DevRepairBean 的构造函数 DevRepairBean
	  * @param tableName 
	  */
	public DevRepairBean() {
		super("ta_oa_devrepair", "t_id");
	}
	
	private String t_id;		//主键
	private String t_fj_id;		//附件id
	private String t_zw_id;		//正文id
	private String t_sb_id;		//设备ID
	private String t_wxfys;		//维修费用预算
	private String t_wxnr;		//维修内容
	private String t_sbsyr_id;		//设备使用人ID
	private String t_sbsyr_mc;		//设备使用人名称
	private String t_fgldsh;		//分管领导审核
	private String t_ycsh;		//院长审核
	private String t_wxysqk;		//维修验收情况
	private String t_wbdwr;		//维保单位人
	private Object t_sqr_sj;		//申请人时间
	private String t_title;		//标题
	/**
	*<b>Summary: 获取主键</b>
	*/
	public String getT_id() {
		return t_id;
	}
	/**
	*<b>Summary: 设置主键</b>
	*/
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	/**
	*<b>Summary: 获取附件id</b>
	*/
	public String getT_fj_id() {
		return t_fj_id;
	}
	/**
	*<b>Summary: 设置附件id</b>
	*/
	public void setT_fj_id(String t_fj_id) {
		this.t_fj_id = t_fj_id;
	}
	/**
	*<b>Summary: 获取正文id</b>
	*/
	public String getT_zw_id() {
		return t_zw_id;
	}
	/**
	*<b>Summary: 设置正文id</b>
	*/
	public void setT_zw_id(String t_zw_id) {
		this.t_zw_id = t_zw_id;
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
	*<b>Summary: 获取维修费用预算</b>
	*/
	public String getT_wxfys() {
		return t_wxfys;
	}
	/**
	*<b>Summary: 设置维修费用预算</b>
	*/
	public void setT_wxfys(String t_wxfys) {
		this.t_wxfys = t_wxfys;
	}
	/**
	*<b>Summary: 获取维修内容</b>
	*/
	public String getT_wxnr() {
		return t_wxnr;
	}
	/**
	*<b>Summary: 设置维修内容</b>
	*/
	public void setT_wxnr(String t_wxnr) {
		this.t_wxnr = t_wxnr;
	}
	/**
	*<b>Summary: 获取设备使用人ID</b>
	*/
	public String getT_sbsyr_id() {
		return t_sbsyr_id;
	}
	/**
	*<b>Summary: 设置设备使用人ID</b>
	*/
	public void setT_sbsyr_id(String t_sbsyr_id) {
		this.t_sbsyr_id = t_sbsyr_id;
	}
	/**
	*<b>Summary: 获取设备使用人名称</b>
	*/
	public String getT_sbsyr_mc() {
		return t_sbsyr_mc;
	}
	/**
	*<b>Summary: 设置设备使用人名称</b>
	*/
	public void setT_sbsyr_mc(String t_sbsyr_mc) {
		this.t_sbsyr_mc = t_sbsyr_mc;
	}
	/**
	*<b>Summary: 获取分管领导审核</b>
	*/
	public String getT_fgldsh() {
		return t_fgldsh;
	}
	/**
	*<b>Summary: 设置分管领导审核</b>
	*/
	public void setT_fgldsh(String t_fgldsh) {
		this.t_fgldsh = t_fgldsh;
	}
	/**
	*<b>Summary: 获取院长审核</b>
	*/
	public String getT_ycsh() {
		return t_ycsh;
	}
	/**
	*<b>Summary: 设置院长审核</b>
	*/
	public void setT_ycsh(String t_ycsh) {
		this.t_ycsh = t_ycsh;
	}
	/**
	*<b>Summary: 获取维修验收情况</b>
	*/
	public String getT_wxysqk() {
		return t_wxysqk;
	}
	/**
	*<b>Summary: 设置维修验收情况</b>
	*/
	public void setT_wxysqk(String t_wxysqk) {
		this.t_wxysqk = t_wxysqk;
	}
	/**
	*<b>Summary: 获取维保单位人</b>
	*/
	public String getT_wbdwr() {
		return t_wbdwr;
	}
	/**
	*<b>Summary: 设置维保单位人</b>
	*/
	public void setT_wbdwr(String t_wbdwr) {
		this.t_wbdwr = t_wbdwr;
	}
	/**
	*<b>Summary: 获取申请人时间</b>
	*/
	public Object getT_sqr_sj() {
		return t_sqr_sj;
	}
	/**
	*<b>Summary: 设置申请人时间</b>
	*/
	public void setT_sqr_sj(Object t_sqr_sj) {
		this.t_sqr_sj = t_sqr_sj;
	}
	/**
	*<b>Summary: 获取标题</b>
	*/
	public String getT_title() {
		return t_title;
	}
	/**
	*<b>Summary: 设置标题</b>
	*/
	public void setT_title(String t_title) {
		this.t_title = t_title;
	}

}
