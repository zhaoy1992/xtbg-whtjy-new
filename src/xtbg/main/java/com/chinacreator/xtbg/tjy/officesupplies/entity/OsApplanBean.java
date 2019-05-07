package com.chinacreator.xtbg.tjy.officesupplies.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:OsApplanBean.java</p>
 *<p>Description:计划表数据bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-7
 */
public class OsApplanBean  extends XtDbBaseBean{
	
	private String t_id;		//主键
	private String t_fj_id;		//附件id
	private String t_zw_id;		//正文id
	private String t_org_id;		//机构ID
	private String t_org_name;		//机构名称
	private String t_creator_time;		//填报时间
	private String t_title;		//申请标题
	private String t_bmfzyj;		//部门负责人意见
	private String t_user_id;		//申请人ID
	private String t_user_name;		//申请人名称
	private String t_state;		//'1'表示已入库
	private String t_rkuser_id;//入库人id
	private String t_rkuser_name;//入库人名
	private String t_rkdate;//入库时间
	private String unit_id;           //所属单位ID
	private String unit_name;           //所属单位名称
	

	private String start_time;//查询开始时间
	private String end_time;//查询结束时间
	
	
	
	public String getT_rkuser_id() {
		return t_rkuser_id;
	}

	public void setT_rkuser_id(String tRkuserId) {
		t_rkuser_id = tRkuserId;
	}

	public String getT_rkuser_name() {
		return t_rkuser_name;
	}

	public void setT_rkuser_name(String tRkuserName) {
		t_rkuser_name = tRkuserName;
	}

	public String getT_rkdate() {
		return t_rkdate;
	}

	public void setT_rkdate(String tRkdate) {
		t_rkdate = tRkdate;
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

	public OsApplanBean() {
		super("TA_OA_OSAPPLAN", "t_id");
	}
	
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
	*<b>Summary: 获取机构ID</b>
	*/
	public String getT_org_id() {
		return t_org_id;
	}
	/**
	*<b>Summary: 设置机构ID</b>
	*/
	public void setT_org_id(String t_org_id) {
		this.t_org_id = t_org_id;
	}
	/**
	*<b>Summary: 获取机构名称</b>
	*/
	public String getT_org_name() {
		return t_org_name;
	}
	/**
	*<b>Summary: 设置机构名称</b>
	*/
	public void setT_org_name(String t_org_name) {
		this.t_org_name = t_org_name;
	}
	/**
	*<b>Summary: 获取填报时间</b>
	*/
	public String getT_creator_time() {
		return t_creator_time;
	}
	/**
	*<b>Summary: 设置填报时间</b>
	*/
	public void setT_creator_time(String t_creator_time) {
		this.t_creator_time = t_creator_time;
	}
	/**
	*<b>Summary: 获取申请标题</b>
	*/
	public String getT_title() {
		return t_title;
	}
	/**
	*<b>Summary: 设置申请标题</b>
	*/
	public void setT_title(String t_title) {
		this.t_title = t_title;
	}
	/**
	*<b>Summary: 获取部门负责人意见</b>
	*/
	public String getT_bmfzyj() {
		return t_bmfzyj;
	}
	/**
	*<b>Summary: 设置部门负责人意见</b>
	*/
	public void setT_bmfzyj(String t_bmfzyj) {
		this.t_bmfzyj = t_bmfzyj;
	}
	/**
	*<b>Summary: 获取申请人ID</b>
	*/
	public String getT_user_id() {
		return t_user_id;
	}
	/**
	*<b>Summary: 设置申请人ID</b>
	*/
	public void setT_user_id(String t_user_id) {
		this.t_user_id = t_user_id;
	}
	/**
	*<b>Summary: 获取申请人名称</b>
	*/
	public String getT_user_name() {
		return t_user_name;
	}
	/**
	*<b>Summary: 设置申请人名称</b>
	*/
	public void setT_user_name(String t_user_name) {
		this.t_user_name = t_user_name;
	}
	/**
	*<b>Summary: 获取'1'表示已经审批过了的计划表</b>
	*/
	public String getT_state() {
		return t_state;
	}
	/**
	*<b>Summary: 设置'1'表示已经审批过了的计划表</b>
	*/
	public void setT_state(String t_state) {
		this.t_state = t_state;
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
