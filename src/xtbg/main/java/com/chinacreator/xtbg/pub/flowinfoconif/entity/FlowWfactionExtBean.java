package com.chinacreator.xtbg.pub.flowinfoconif.entity;

import java.sql.Timestamp;

import com.chinacreator.xtbg.pub.dbbase.entity.XtDbBaseBean;

/**
 * 流程活动扩展表
 * @author Administrator
 *
 */
public class FlowWfactionExtBean extends XtDbBaseBean{
	
	public FlowWfactionExtBean() {
		super("TA_OA_FLOW_WFACTION_EXT","actionext_id");
		// TODO Auto-generated constructor stub
	}
	private String actionext_id;
	private String action_id;
	private String isshowuser;//是否动态选择执行人
	private String isshowreject;//是否退窗
	private String isshowback;//是否回退
	private Timestamp create_time;
	private String autoassignment;//是否使用前置活动执行人
	private String issignjoinbyorder;//是否按顺序会签

	
	
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
