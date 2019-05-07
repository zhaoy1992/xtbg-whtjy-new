package com.chinacreator.xtbg.tjy.canteenitemssupplies.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:OsExaminationBean.java</p>
 *<p>Description:审批物品数据bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-7
 */
public class OsExaminationBean extends XtDbBaseBean {
	public OsExaminationBean() {
		super("TA_OA_CANOSEXA_OBJECT", "t_osexa_ob_id");
	}
	private String t_osexa_ob_id;		//主键ID
	private String t_osexa_id;		//申购审批ID
	private String t_osexa_ob_org_ids;		//申购部门IDS
	private String t_osexa_ob_org_names;		//申购部门名称
	private String ofustype_id;		//物品ID
	private String ofustype_name;		//物品名称
	private String it_id;		//物品规格ID
	private String it_name;		//物品规格
	private String t_osexa_ob_no;		//物品数量
	private String t_osexa_ob_dj;		//单价
	private String t_osexa_ob_bz;		//备注
	private String t_os_ob_ids;     //计划物品表IDS
	private String unit_id;           //所属单位ID
	private String unit_name;           //所属单位名称
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getT_osexa_ob_id() {
		return t_osexa_ob_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setT_osexa_ob_id(String t_osexa_ob_id) {
		this.t_osexa_ob_id = t_osexa_ob_id;
	}
	/**
	*<b>Summary: 获取申购审批ID</b>
	*/
	public String getT_osexa_id() {
		return t_osexa_id;
	}
	/**
	*<b>Summary: 设置申购审批ID</b>
	*/
	public void setT_osexa_id(String t_osexa_id) {
		this.t_osexa_id = t_osexa_id;
	}
	/**
	*<b>Summary: 获取申购部门IDS</b>
	*/
	public String getT_osexa_ob_org_ids() {
		return t_osexa_ob_org_ids;
	}
	/**
	*<b>Summary: 设置申购部门IDS</b>
	*/
	public void setT_osexa_ob_org_ids(String t_osexa_ob_org_ids) {
		this.t_osexa_ob_org_ids = t_osexa_ob_org_ids;
	}
	/**
	*<b>Summary: 获取申购部门名称</b>
	*/
	public String getT_osexa_ob_org_names() {
		return t_osexa_ob_org_names;
	}
	/**
	*<b>Summary: 设置申购部门名称</b>
	*/
	public void setT_osexa_ob_org_names(String t_osexa_ob_org_names) {
		this.t_osexa_ob_org_names = t_osexa_ob_org_names;
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
	public String getT_osexa_ob_no() {
		return t_osexa_ob_no;
	}
	/**
	*<b>Summary: 设置物品数量</b>
	*/
	public void setT_osexa_ob_no(String t_osexa_ob_no) {
		this.t_osexa_ob_no = t_osexa_ob_no;
	}
	/**
	*<b>Summary: 获取单价</b>
	*/
	public String getT_osexa_ob_dj() {
		return t_osexa_ob_dj;
	}
	/**
	*<b>Summary: 设置单价</b>
	*/
	public void setT_osexa_ob_dj(String t_osexa_ob_dj) {
		this.t_osexa_ob_dj = t_osexa_ob_dj;
	}
	/**
	*<b>Summary: 获取备注</b>
	*/
	public String getT_osexa_ob_bz() {
		return t_osexa_ob_bz;
	}
	/**
	*<b>Summary: 设置备注</b>
	*/
	public void setT_osexa_ob_bz(String t_osexa_ob_bz) {
		this.t_osexa_ob_bz = t_osexa_ob_bz;
	}
	public String getT_os_ob_ids() {
		return t_os_ob_ids;
	}
	public void setT_os_ob_ids(String t_os_ob_ids) {
		this.t_os_ob_ids = t_os_ob_ids;
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
