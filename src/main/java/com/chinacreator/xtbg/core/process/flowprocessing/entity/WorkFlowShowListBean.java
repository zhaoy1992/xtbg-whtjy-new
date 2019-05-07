package com.chinacreator.xtbg.core.process.flowprocessing.entity;

public class WorkFlowShowListBean {
	private String ins_id;//实例id
	private String busi_id;//业务id
	private String actInsId ;//环节实例id
	private String cc_form_instanceid;//ccformid
	private String ins_code;//办件编号
	private String busitype_code;//业务类型
	private String busitype_name;
	private String ins_name;//实例名称
	private String accepter;//发起人
	private String accept_time;//发起时间
	private String act_name;//当前环节
	private String def_id;//流程定义ID
	private String action_defid;//活动定义ID
	private String actiontype_code;//活动类型编号 
	private String procId;//流程实例ID
	private String action_form;//表单
	private String status_name;//状态名称
	private String entrust_name;//代理人名称
	private String flow_form;//表单
	private String act_index;//环节排序
	private String act_insid;//环节实例ID
	private String flow_id;//流程ID
	private String template_id; //模板ID
	private String user_name;
	private String user_realname;
	private String org_id;
	private String org_name;
	private String chief_endtime;
	private String is_agency; //是否代理
	private String entrust_user_name; //代理人
	
	private String number_title;//文号
	
	private String planStatus;//审批状态
	
	//特检院OA 事务处理模块 追加 【业务类别】 start
	private String busitype_type_name;
	//特检院OA 事务处理模块 追加 【业务类别】 end
	
	private String curexecutor;//当前流程执行人
	
	public String getEntrust_user_name() {
		return entrust_user_name;
	}
	public void setEntrust_user_name(String entrust_user_name) {
		this.entrust_user_name = entrust_user_name;
	}
	public String getIs_agency() {
		return is_agency;
	}
	public void setIs_agency(String is_agency) {
		this.is_agency = is_agency;
	}
	public String getUser_realname() {
		return user_realname;
	}
	public void setUser_realname(String user_realname) {
		this.user_realname = user_realname;
	}
	public String getChief_endtime() {
		return chief_endtime;
	}
	public void setChief_endtime(String chief_endtime) {
		this.chief_endtime = chief_endtime;
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
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	/**
	 * <b>Summary: </b>
	 *     获取template_id的值
	 * @return template_id 
	 */
	public String getTemplate_id() {
		return template_id;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 template_id 的值 
	 * @param template_id 
	 */
	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}
	public String getFlow_id() {
		return flow_id;
	}
	public void setFlow_id(String flow_id) {
		this.flow_id = flow_id;
	}
	public String getAct_insid() {
		return act_insid;
	}
	public void setAct_insid(String act_insid) {
		this.act_insid = act_insid;
	}
	public String getAct_index() {
		return act_index;
	}
	public void setAct_index(String act_index) {
		this.act_index = act_index;
	}
	public String getFlow_form() {
		return flow_form;
	}
	public void setFlow_form(String flow_form) {
		this.flow_form = flow_form;
	}
	public String getEntrust_name() {
		return entrust_name;
	}
	public void setEntrust_name(String entrustName) {
		entrust_name = entrustName;
	}
	public String getAction_form() {
		return action_form;
	}
	public void setAction_form(String action_form) {
		this.action_form = action_form;
	}
	public String getStatus_name() {
		return status_name;
	}
	public void setStatus_name(String status_name) {
		this.status_name = status_name;
	}
	public String getAction_defid() {
		return action_defid;
	}
	public void setAction_defid(String action_defid) {
		this.action_defid = action_defid;
	}
	public String getActiontype_code() {
		return actiontype_code;
	}
	public void setActiontype_code(String actiontype_code) {
		this.actiontype_code = actiontype_code;
	}
	public String getBusi_id() {
		return busi_id;
	}
	public void setBusi_id(String busiId) {
		busi_id = busiId;
	}
	
	public String getActInsId() {
		return actInsId;
	}
	public void setActInsId(String actInsId) {
		this.actInsId = actInsId;
	}
	public String getCc_form_instanceid() {
		return cc_form_instanceid;
	}
	public void setCc_form_instanceid(String ccFormInstanceid) {
		cc_form_instanceid = ccFormInstanceid;
	}
	public String getIns_id() {
		return ins_id;
	}
	public void setIns_id(String insId) {
		ins_id = insId;
	}
	public String getIns_code() {
		return ins_code;
	}
	public void setIns_code(String insCode) {
		ins_code = insCode;
	}
	public String getBusitype_code() {
		return busitype_code;
	}
	public void setBusitype_code(String busitypeCode) {
		busitype_code = busitypeCode;
	}
	public String getIns_name() {
		return ins_name;
	}
	public void setIns_name(String insName) {
		ins_name = insName;
	}
	public String getAccepter() {
		return accepter;
	}
	public void setAccepter(String accepter) {
		this.accepter = accepter;
	}
	public String getAccept_time() {
		return accept_time;
	}
	public void setAccept_time(String acceptTime) {
		accept_time = acceptTime;
	}
	public String getAct_name() {
		return act_name;
	}
	public void setAct_name(String actName) {
		act_name = actName;
	}
	public String getDef_id() {
		return def_id;
	}
	public void setDef_id(String def_id) {
		this.def_id = def_id;
	}
	public String getProcId() {
		return procId;
	}
	public void setProcId(String procId) {
		this.procId = procId;
	}
	public String getBusitype_name() {
		return busitype_name;
	}
	public void setBusitype_name(String busitype_name) {
		this.busitype_name = busitype_name;
	}
	public String getBusitype_type_name() {
		return busitype_type_name;
	}
	public void setBusitype_type_name(String busitype_type_name) {
		this.busitype_type_name = busitype_type_name;
	}
	public String getNumber_title() {
		return number_title;
	}
	public void setNumber_title(String number_title) {
		this.number_title = number_title;
	}
	/**
	 * <b>Summary: </b>
	 *     获取planStatus的值
	 * @return planStatus 
	 */
	public String getPlanStatus() {
		return planStatus;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 planStatus 的值 
	 * @param planStatus 
	 */
	public void setPlanStatus(String planStatus) {
		this.planStatus = planStatus;
	}
	
	public String getCurexecutor() {
		return curexecutor;
	}
	
	public void setCurexecutor(String curexecutor) {
		this.curexecutor = curexecutor;
	}
}
