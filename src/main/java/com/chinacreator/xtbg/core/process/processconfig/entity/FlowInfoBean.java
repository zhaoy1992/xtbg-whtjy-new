package com.chinacreator.xtbg.core.process.processconfig.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>
 * Title:FlowInfoBean.java
 * </p>
 *<p>
 * Description:流程信息表
 * </p>
 *<p>
 * Copyright:Copyright (c) 2013
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author 黄艺平
 *@version 1.0 2013-4-22
 */
public class FlowInfoBean extends XtDbBaseBean{
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
	private Object create_time;

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

	private String business_id; // 业务ID
	private String from_path; // 表单路径
	private String is_text; // 是否有正文
	private String insname_rule;//流程名生成规则
	private String table_id;//业务表id
	private String flow_tyle; //流程类型(1:表单 ,2: word)
	private String template_id; //word模板ID
	private String form_image_id; //发布菜单图片
	private String attach_id;  //附件ID
	private String busitype_type_code; //业务类型分类编号
	private String next_flow_id; //业务类型分类编号
	
	
	public String getNext_flow_id() {
		return next_flow_id;
	}
	public void setNext_flow_id(String next_flow_id) {
		this.next_flow_id = next_flow_id;
	}
	/**
	 * <b>Summary: </b>
	 *     获取busitype_type_code的值
	 * @return busitype_type_code 
	 */
	public String getBusitype_type_code() {
		return busitype_type_code;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 busitype_type_code 的值 
	 * @param busitype_type_code 
	 */
	public void setBusitype_type_code(String busitype_type_code) {
		this.busitype_type_code = busitype_type_code;
	}
	public String getAttach_id() {
		return attach_id;
	}
	public void setAttach_id(String attach_id) {
		this.attach_id = attach_id;
	}
	public String getForm_image_id() {
		return form_image_id;
	}
	public void setForm_image_id(String form_image_id) {
		this.form_image_id = form_image_id;
	}
	public String getFlow_tyle() {
		return flow_tyle;
	}
	public void setFlow_tyle(String flow_tyle) {
		this.flow_tyle = flow_tyle;
	}
	public String getTemplate_id() {
		return template_id;
	}
	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}
	public FlowInfoBean(){
		super("oa_flow_baseinfo","flow_id");
	}
	/**
	 * @return the busitype_name
	 */
	public String getBusitype_name() {
		return busitype_name;
	}

	/**
	 * @param busitypeName
	 *            the busitype_name to set
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
	 * @param orgName
	 *            the org_name to set
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

	public Object getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Object createTime) {
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

	public String getBusiness_id() {
		return business_id;
	}

	public void setBusiness_id(String businessId) {
		business_id = businessId;
	}

	public String getFrom_path() {
		return from_path;
	}

	public void setFrom_path(String fromPath) {
		from_path = fromPath;
	}

	public String getIs_text() {
		return is_text;
	}

	public void setIs_text(String isText) {
		is_text = isText;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String tableId) {
		table_id = tableId;
	}
	public String getInsname_rule() {
		return insname_rule;
	}
	public void setInsname_rule(String insnameRule) {
		insname_rule = insnameRule;
	}

}
