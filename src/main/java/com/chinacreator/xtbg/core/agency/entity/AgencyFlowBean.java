package com.chinacreator.xtbg.core.agency.entity;

public class AgencyFlowBean {

	private String id;//主键
	
	private String agency_name;//代理人名称
	
	private String agency_id;//代理人id
	
	private String entrust_name;//委托人名称
	
	private String entrust_id;//委托人id
	
	private String flow_id;//实例id
	
	private String user_name;//下一环节执行人

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String userName) {
		user_name = userName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAgency_name() {
		return agency_name;
	}

	public void setAgency_name(String agencyName) {
		agency_name = agencyName;
	}

	public String getAgency_id() {
		return agency_id;
	}

	public void setAgency_id(String agencyId) {
		agency_id = agencyId;
	}

	public String getEntrust_name() {
		return entrust_name;
	}

	public void setEntrust_name(String entrustName) {
		entrust_name = entrustName;
	}

	public String getEntrust_id() {
		return entrust_id;
	}

	public void setEntrust_id(String entrustId) {
		entrust_id = entrustId;
	}

	public String getFlow_id() {
		return flow_id;
	}

	public void setFlow_id(String flowId) {
		flow_id = flowId;
	}
}
