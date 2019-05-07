package com.chinacreator.xtbg.core.process.flowprocessing.entity;

/**
 *<p>Title:InsViewListBean.java</p>
 *<p>Description:活动意见Bean</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author yiping.huang
 *@version 1.0
 *@date 2012-6-13
 */
public class InsViewListBean {

	private String viewlist_id;//意见ID
	
	private String ins_id;//实例ID
	
	private String action_id;//活动ID
	
	private String action_name;//活动名称
	
	private String action_handeridea;//活动处理意见
	
	private String hander_time;//填入意见时间
	
	private String is_valid;//是否有效
	
	private String remark1;//备注1
	
	private String remark2;//备注2
	
	private String org_id;//机构ID
	
	private String org_name;//机构名称
	
	private String action_defid;//活动定义ID
	
	private String user_id;//用户ID
	
	private String user_name;//用户名称
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getAction_defid() {
		return action_defid;
	}
	public void setAction_defid(String action_defid) {
		this.action_defid = action_defid;
	}
	public String getOrg_id() {
		return org_id;
	}
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}
	public String getOrg_name() {
		return org_name;
	}
	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	public String getViewlist_id() {
		return viewlist_id;
	}
	public void setViewlist_id(String viewlist_id) {
		this.viewlist_id = viewlist_id;
	}
	public String getIns_id() {
		return ins_id;
	}
	public void setIns_id(String ins_id) {
		this.ins_id = ins_id;
	}
	public String getAction_id() {
		return action_id;
	}
	public void setAction_id(String action_id) {
		this.action_id = action_id;
	}
	public String getAction_name() {
		return action_name;
	}
	public void setAction_name(String action_name) {
		this.action_name = action_name;
	}
	public String getAction_handeridea() {
		return action_handeridea;
	}
	public void setAction_handeridea(String action_handeridea) {
		this.action_handeridea = action_handeridea;
	}
	public String getHander_time() {
		return hander_time;
	}
	public void setHander_time(String hander_time) {
		this.hander_time = hander_time;
	}
	public String getIs_valid() {
		return is_valid;
	}
	public void setIs_valid(String is_valid) {
		this.is_valid = is_valid;
	}
	public String getRemark1() {
		return remark1;
	}
	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}
	public String getRemark2() {
		return remark2;
	}
	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}
	
	
}
