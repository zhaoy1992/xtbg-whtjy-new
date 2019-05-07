package com.chinacreator.xtbg.core.dssave.entity;
/**
 * 
 *<p>Title:ViewListBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-4-20
 */
public class ViewListBean {
	private static final long serialVersionUID = 1L;
	
	public static final String FIRST_ACTION_INS_ID = "first_action_ins_id";
	
	private String hander_time;		//填入意见时间
	private String is_valid;		//是否有效
	private String remark1;		//备注1
	private String remark2;		//备注2
	private String org_id;		//机构ID
	private String org_name;		//机构名称
	private String user_id;		//用户ID
	private String user_name;		//用户名称
	private String viewlist_id;		//意见ID
	private String ins_id;		//实例ID
	private String action_id;		//活动定义ID
	private String action_name;		//活动名称
	private String action_handeridea;		//活动处理意见
	private String table_name;				//表名
	private String column_name;				//字段名
	private String action_ins_id;	//活动实例ID
	
	public String getAction_ins_id() {
		return action_ins_id;
	}
	public void setAction_ins_id(String action_ins_id) {
		this.action_ins_id = action_ins_id;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	public String getColumn_name() {
		return column_name;
	}
	public void setColumn_name(String column_name) {
		this.column_name = column_name;
	}
	/**
	*<b>Summary: 获取填入意见时间</b>
	*/
	public String getHander_time() {
		return hander_time;
	}
	/**
	*<b>Summary: 设置填入意见时间</b>
	*/
	public void setHander_time(String hander_time) {
		this.hander_time = hander_time;
	}
	/**
	*<b>Summary: 获取是否有效</b>
	*/
	public String getIs_valid() {
		return is_valid;
	}
	/**
	*<b>Summary: 设置是否有效</b>
	*/
	public void setIs_valid(String is_valid) {
		this.is_valid = is_valid;
	}
	/**
	*<b>Summary: 获取备注1</b>
	*/
	public String getRemark1() {
		return remark1;
	}
	/**
	*<b>Summary: 设置备注1</b>
	*/
	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}
	/**
	*<b>Summary: 获取备注2</b>
	*/
	public String getRemark2() {
		return remark2;
	}
	/**
	*<b>Summary: 设置备注2</b>
	*/
	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}
	/**
	*<b>Summary: 获取机构ID</b>
	*/
	public String getOrg_id() {
		return org_id;
	}
	/**
	*<b>Summary: 设置机构ID</b>
	*/
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}
	/**
	*<b>Summary: 获取机构名称</b>
	*/
	public String getOrg_name() {
		return org_name;
	}
	/**
	*<b>Summary: 设置机构名称</b>
	*/
	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	/**
	*<b>Summary: 获取用户ID</b>
	*/
	public String getUser_id() {
		return user_id;
	}
	/**
	*<b>Summary: 设置用户ID</b>
	*/
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	/**
	*<b>Summary: 获取用户名称</b>
	*/
	public String getUser_name() {
		return user_name;
	}
	/**
	*<b>Summary: 设置用户名称</b>
	*/
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	/**
	*<b>Summary: 获取意见ID</b>
	*/
	public String getViewlist_id() {
		return viewlist_id;
	}
	/**
	*<b>Summary: 设置意见ID</b>
	*/
	public void setViewlist_id(String viewlist_id) {
		this.viewlist_id = viewlist_id;
	}
	/**
	*<b>Summary: 获取实例ID</b>
	*/
	public String getIns_id() {
		return ins_id;
	}
	/**
	*<b>Summary: 设置实例ID</b>
	*/
	public void setIns_id(String ins_id) {
		this.ins_id = ins_id;
	}
	/**
	*<b>Summary: 获取活动ID</b>
	*/
	public String getAction_id() {
		return action_id;
	}
	/**
	*<b>Summary: 设置活动ID</b>
	*/
	public void setAction_id(String action_id) {
		this.action_id = action_id;
	}
	/**
	*<b>Summary: 获取活动名称</b>
	*/
	public String getAction_name() {
		return action_name;
	}
	/**
	*<b>Summary: 设置活动名称</b>
	*/
	public void setAction_name(String action_name) {
		this.action_name = action_name;
	}
	/**
	*<b>Summary: 获取活动处理意见</b>
	*/
	public String getAction_handeridea() {
		return action_handeridea;
	}
	/**
	*<b>Summary: 设置活动处理意见</b>
	*/
	public void setAction_handeridea(String action_handeridea) {
		this.action_handeridea = action_handeridea;
	}
}
