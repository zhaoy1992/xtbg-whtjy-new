package com.chinacreator.xtbg.core.common.iweboffice.bean;

/**
 * 
 *<p>Title:WordTemplateBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-5-31
 */

public class WordTemplateBean {
	
	private String template_id;//模板主键
	private String moduletype_logo;//模块标识
	private String template_name;//模板名称
	private String template_userid;//创建者主键
	private String template_username;//创建者
	private String org_id;//机构id
	private String org_name;//机构名称
	private String template_remark;//模版说明
	private String is_common;//是否通用模板
	private String template_sn;//模版序号
	private String singn_config; //模板会签内容配置
	private String table_code;		//表名
	private String table_id;		//表名
	
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}
	public String getTable_code() {
		return table_code;
	}
	public void setTable_code(String table_code) {
		this.table_code = table_code;
	}
	
	/**
	 * <b>Summary: </b>
	 *     获取singn_config的值
	 * @return singn_config 
	 */
	public String getSingn_config() {
		return singn_config;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 singn_config 的值 
	 * @param singn_config 
	 */
	public void setSingn_config(String singn_config) {
		this.singn_config = singn_config;
	}
	public String getTemplate_sn() {
		return template_sn;
	}
	public void setTemplate_sn(String templateSn) {
		template_sn = templateSn;
	}
	public String getTemplate_id() {
		return template_id;
	}
	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}
	public String getModuletype_logo() {
		return moduletype_logo;
	}
	public void setModuletype_logo(String moduletype_logo) {
		this.moduletype_logo = moduletype_logo;
	}
	public String getTemplate_name() {
		return template_name;
	}
	public void setTemplate_name(String template_name) {
		this.template_name = template_name;
	}
	public String getTemplate_userid() {
		return template_userid;
	}
	public void setTemplate_userid(String template_userid) {
		this.template_userid = template_userid;
	}
	public String getTemplate_username() {
		return template_username;
	}
	public void setTemplate_username(String template_username) {
		this.template_username = template_username;
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
	public String getTemplate_remark() {
		return template_remark;
	}
	public void setTemplate_remark(String template_remark) {
		this.template_remark = template_remark;
	}
	public String getIs_common() {
		return is_common;
	}
	public void setIs_common(String is_common) {
		this.is_common = is_common;
	}
	
	
	
}
