package com.chinacreator.xtbg.core.process.processconfig.entity;

import java.sql.Timestamp;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:FlowWfactionExtBean.java</p>
 *<p>Description:流程活动扩展表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-4-22
 */
public class FlowWfactionExtBean extends XtDbBaseBean{
	
	public FlowWfactionExtBean() {
		super("TA_OA_FLOW_WFACTION_EXT","actionext_id");
	}
	private String actionext_id;
	private String action_id;
	private String isshowuser;//是否动态选择执行人
	private String isshowreject;//是否退窗
	private String isshowback;//是否回退
	private Timestamp create_time;
	private String autoassignment;//是否使用前置活动执行人
	private String issignjoinbyorder;//是否按顺序会签
	private String isdispense; //是否分发
	private String is_auto_complete;
	
	public String getIs_auto_complete() {
		return is_auto_complete;
	}
	public void setIs_auto_complete(String is_auto_complete) {
		this.is_auto_complete = is_auto_complete;
	}
	/**
	 * <b>Summary: </b>
	 *     获取isdispense的值
	 * @return isdispense 
	 */
	public String getIsdispense() {
		return isdispense;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 isdispense 的值 
	 * @param isdispense 
	 */
	public void setIsdispense(String isdispense) {
		this.isdispense = isdispense;
	}
	public String getIssignjoinbyorder() {
		return issignjoinbyorder;
	}
	public void setIssignjoinbyorder(String issignjoinbyorder) {
		this.issignjoinbyorder = issignjoinbyorder;
	}
	public String getAutoassignment() {
		return autoassignment;
	}
	public void setAutoassignment(String autoassignment) {
		this.autoassignment = autoassignment;
	}
	public String getActionext_id() {
		return actionext_id;
	}
	public void setActionext_id(String actionextId) {
		actionext_id = actionextId;
	}
	public String getAction_id() {
		return action_id;
	}
	public void setAction_id(String actionId) {
		action_id = actionId;
	}
	public String getIsshowuser() {
		return isshowuser;
	}
	public void setIsshowuser(String isshowuser) {
		this.isshowuser = isshowuser;
	}
	public String getIsshowreject() {
		return isshowreject;
	}
	public void setIsshowreject(String isshowreject) {
		this.isshowreject = isshowreject;
	}
	public String getIsshowback() {
		return isshowback;
	}
	public void setIsshowback(String isshowback) {
		this.isshowback = isshowback;
	}
	public Timestamp getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Timestamp createTime) {
		create_time = createTime;
	}
	
	
}
