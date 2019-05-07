package com.chinacreator.xtbg.tjy.canteenitemssupplies.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:OsAppObjectBean.java</p>
 *<p>Description:计划表物品数据Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-9
 */
public class OsAppObjectBean extends XtDbBaseBean{
	
	public OsAppObjectBean() {
		super("TA_OA_CANOSAPP_OBJECT", "t_os_ob_id");
	}
	
	private String t_os_ob_id;		//主键ID
	private String t_id;		//申购计划ID
	private String t_org_id;		//申购部门ID
	private String t_org_name;		//申购部门名称
	private String ofustype_id;		//物品ID
	private String ofustype_name;		//物品名称
	private String it_id;		//物品规格ID
	private String it_name;		//物品规格
	private String t_os_ob_no;		//物品数量
	private String t_os_ob_bz;		//物品备注
	private String unit_id;           //所属单位ID
	private String unit_name;           //所属单位名称
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getT_os_ob_id() {
		return t_os_ob_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setT_os_ob_id(String t_os_ob_id) {
		this.t_os_ob_id = t_os_ob_id;
	}
	/**
	*<b>Summary: 获取申购计划ID</b>
	*/
	public String getT_id() {
		return t_id;
	}
	/**
	*<b>Summary: 设置申购计划ID</b>
	*/
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	/**
	*<b>Summary: 获取申购部门ID</b>
	*/
	public String getT_org_id() {
		return t_org_id;
	}
	/**
	*<b>Summary: 设置申购部门ID</b>
	*/
	public void setT_org_id(String t_org_id) {
		this.t_org_id = t_org_id;
	}
	/**
	*<b>Summary: 获取申购部门名称</b>
	*/
	public String getT_org_name() {
		return t_org_name;
	}
	/**
	*<b>Summary: 设置申购部门名称</b>
	*/
	public void setT_org_name(String t_org_name) {
		this.t_org_name = t_org_name;
	}
	/**
	*<b>Summary: 获取物品ID</b>
	*/
	public String getOfustype_id() {
		return ofustype_id;
	}
	/**
	*<b>Summary: 设置物品ID</b>
	*/
	public void setOfustype_id(String ofustype_id) {
		this.ofustype_id = ofustype_id;
	}
	/**
	*<b>Summary: 获取物品名称</b>
	*/
	public String getOfustype_name() {
		return ofustype_name;
	}
	/**
	*<b>Summary: 设置物品名称</b>
	*/
	public void setOfustype_name(String ofustype_name) {
		this.ofustype_name = ofustype_name;
	}
	/**
	*<b>Summary: 获取物品规格ID</b>
	*/
	public String getIt_id() {
		return it_id;
	}
	/**
	*<b>Summary: 设置物品规格ID</b>
	*/
	public void setIt_id(String it_id) {
		this.it_id = it_id;
	}
	/**
	*<b>Summary: 获取物品规格</b>
	*/
	public String getIt_name() {
		return it_name;
	}
	/**
	*<b>Summary: 设置物品规格</b>
	*/
	public void setIt_name(String it_name) {
		this.it_name = it_name;
	}
	/**
	*<b>Summary: 获取物品数量</b>
	*/
	public String getT_os_ob_no() {
		return t_os_ob_no;
	}
	/**
	*<b>Summary: 设置物品数量</b>
	*/
	public void setT_os_ob_no(String t_os_ob_no) {
		this.t_os_ob_no = t_os_ob_no;
	}
	/**
	*<b>Summary: 获取物品备注</b>
	*/
	public String getT_os_ob_bz() {
		return t_os_ob_bz;
	}
	/**
	*<b>Summary: 设置物品备注</b>
	*/
	public void setT_os_ob_bz(String t_os_ob_bz) {
		this.t_os_ob_bz = t_os_ob_bz;
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
