package com.chinacreator.xtbg.core.file.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:FilelendingBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 任涛
 *@version 1.0
 *2013-8-13
 */
public class FilelendingBean extends XtDbBaseBean{
	
	public FilelendingBean(){
		//在构造器里面设置好表名和主键，具体进行更新，删除等操作时可以重新设置updateKey，deleteKey，及主键
		super("oa_file_lending", "f_lending_id");  
	}
	private String f_lending_id; //借阅ID
	private String f_lending_reason; //借阅理由
	private String f_lending_userid; //借阅人ID
	private String f_lending_username; //借阅人姓名
	private String f_org_id; //所属的单位ID
	private String f_org_name; //所属单位名称
	private String f_dept_id; //所属部门ID
	private String f_dept_name; //所属部门名
	private String f_tel; //联系电话
	private Object f_creator_time; //申请日期
	private String f_checkmsg; //审批意见
	public String getF_lending_id() {
		return f_lending_id;
	}
	public void setF_lending_id(String f_lending_id) {
		this.f_lending_id = f_lending_id;
	}
	public String getF_lending_reason() {
		return f_lending_reason;
	}
	public void setF_lending_reason(String f_lending_reason) {
		this.f_lending_reason = f_lending_reason;
	}
	public String getF_lending_userid() {
		return f_lending_userid;
	}
	public void setF_lending_userid(String f_lending_userid) {
		this.f_lending_userid = f_lending_userid;
	}
	public String getF_lending_username() {
		return f_lending_username;
	}
	public void setF_lending_username(String f_lending_username) {
		this.f_lending_username = f_lending_username;
	}
	public String getF_org_id() {
		return f_org_id;
	}
	public void setF_org_id(String f_org_id) {
		this.f_org_id = f_org_id;
	}
	public String getF_org_name() {
		return f_org_name;
	}
	public void setF_org_name(String f_org_name) {
		this.f_org_name = f_org_name;
	}
	public String getF_dept_id() {
		return f_dept_id;
	}
	public void setF_dept_id(String f_dept_id) {
		this.f_dept_id = f_dept_id;
	}
	public String getF_dept_name() {
		return f_dept_name;
	}
	public void setF_dept_name(String f_dept_name) {
		this.f_dept_name = f_dept_name;
	}
	public String getF_tel() {
		return f_tel;
	}
	public void setF_tel(String f_tel) {
		this.f_tel = f_tel;
	}
	public Object getF_creator_time() {
		return f_creator_time;
	}
	public void setF_creator_time(Object f_creator_time) {
		this.f_creator_time = f_creator_time;
	}
	public String getF_checkmsg() {
		return f_checkmsg;
	}
	public void setF_checkmsg(String f_checkmsg) {
		this.f_checkmsg = f_checkmsg;
	}
	/**
	 * 活动环节:借阅申请
	 */
	public static final String ACT_JY_SQ = "danganjieyue_wp1_act1";
	/**
	 * 活动环节:部门审核
	 */
	public static final String ACT_BM_SH = "danganjieyue_wp1_act2";
	/**
	 * 活动环节:档案管理员审核
	 */
	public static final String ACT_DAGLY_SH = "danganjieyue_wp1_act3";
	/**
	 * 活动环节:各级部门会签
	 */
	public static final String ACT_BMS_SH = "danganjieyue_wp1_act4";
	/**
	 * 活动环节:借阅通知
	 */
	public static final String ACT_JY_TZ = "danganjieyue_wp1_act5";
}
