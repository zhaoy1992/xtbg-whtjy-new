package com.chinacreator.xtbg.suxian.electroniccheck.entity;

import java.util.List;

import com.chinacreator.xtbg.pub.dbbase.entity.XtDbBaseBean;



/**
 *<p>Title:ElectResetBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 付程
 *@version 1.0
 *@date 2012-2-24
 */
public class ElectResetBeanXt extends XtDbBaseBean{


	public ElectResetBeanXt(String tableName, String[] allKey) {
		super(tableName, allKey);
		// TODO Auto-generated constructor stub
	}
	private String elect_id;//主键id
	private String start_time;//上班时间
	private String end_time;//下班时间
	private String auto_check;//是否支持自动考勤
	private String rest_time;//作息时间
	private String username;//当期用户
	private String userid;//当期用户id
	private String dept_id;//部门id
	private String dept_name;//部门
	private String orgid;//单位id
	private String orgname;//单位名称
	private String isuse;//是否使用当前作息时间
	
	//add by tieshan
	private String am_end_time;  //上午下班时间
	private String pm_start_time; //下午上班时间
	
	
	
	
	public String getAm_end_time() {
		return am_end_time;
	}
	public void setAm_end_time(String am_end_time) {
		this.am_end_time = am_end_time;
	}
	public String getPm_start_time() {
		return pm_start_time;
	}
	public void setPm_start_time(String pm_start_time) {
		this.pm_start_time = pm_start_time;
	}
	public String getElect_id() {
		return elect_id;
	}
	public void setElect_id(String elect_id) {
		this.elect_id = elect_id;
	}
	public String getIsuse() {
		return isuse;
	}
	public void setIsuse(String isuse) {
		this.isuse = isuse;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getAuto_check() {
		return auto_check;
	}
	public void setAuto_check(String auto_check) {
		this.auto_check = auto_check;
	}
	public String getRest_time() {
		return rest_time;
	}
	public void setRest_time(String rest_time) {
		this.rest_time = rest_time;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	
	}


