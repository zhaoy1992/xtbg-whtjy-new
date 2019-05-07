package com.chinacreator.xtbg.pub.flowinfoconif.entity;

public class FlowInfoBean {
	/**
	 * 流程ID
	 */
	private String flow_id;
	
	/**
	 * 流程名称
	 */
	private String flow_name;
	
	/**
	 * 类型编号
	 */
	private String busitype_code;

	/**
	 * 机构ID
	 */
	private String org_id;
	
	/**
	 * 机构名称
	 */
	private String org_name;
	
	/**
	 * 是否个性化流程
	 */
	private String is_indivi;
	
	/**
	 * 是否有效
	 */
	private String is_valid;
	
	/**
	 * 创建时间
	 */
	private String create_time;
	
	/**
	 * 流程时限
	 */
	private String flow_limit;
	
	/**
	 * 时限单位
	 */
	private String limit_unit;
	/**
	 * 类型名称
	 */
	public String busitype_name;
	
	
	public String is_public;//是否为公共流程
	public String getIs_public() {
		return is_public;
	}
	public void setIs_public(String isPublic) {
		is_public = isPublic;
	}
	/**
	 * @return the busitype_name
	 */
	public String getBusitype_name() {
		return busitype_name;
	}
	/**
	 * @param busitypeName the busitype_name to set
	 */
	public void setBusitype_name(String busitypeName) {
		busitype_name = busitypeName;
	}
	/**
	 * @return the org_name
	 */
	public String getOrg_name() {
		return org_name;
	}
	/**
	 * @param orgName the org_name to set
	 */
	public void setOrg_name(String orgName) {
		org_name = orgName;
	}

	public String getFlow_id() {
		return flow_id;
	}

	public void setFlow_id(String flowId) {
		flow_id = flowId;
	}

	public String getFlow_name() {
		return flow_name;
	}

	public void setFlow_name(String flowName) {
		flow_name = flowName;
	}

	public String getOrg_id() {
		return org_id;
	}

	public void setOrg_id(String orgId) {
		org_id = orgId;
	}

	public String getIs_indivi() {
		return is_indivi;
	}

	public void setIs_indivi(String isIndivi) {
		is_indivi = isIndivi;
	}

	public String getIs_valid() {
		return is_valid;
	}

	public void setIs_valid(String isValid) {
		is_valid = isValid;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String createTime) {
		create_time = createTime;
	}

	public String getFlow_limit() {
		return flow_limit;
	}

	public void setFlow_limit(String flowLimit) {
		flow_limit = flowLimit;
	}

	public String getLimit_unit() {
		return limit_unit;
	}

	public void setLimit_unit(String limitUnit) {
		limit_unit = limitUnit;
	}
	
	public String getBusitype_code() {
		return busitype_code;
	}

	public void setBusitype_code(String busitypeCode) {
		busitype_code = busitypeCode;
	}

	
}
