package com.chinacreator.xtbg.core.common.iweboffice.bean;

/**
 *<p>Title:</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2011</p>
 *<p>Company:湖南科创</p>
 *@author yi.yang
 *@version 1.0
 *@date 2011-9-16
 */

public class RuleItemBean {
	private String ruleitem_id;
	private String template_id;
	private String ruleitem_name;
	private String ruleitem_value_typename;
	private String ruleitem_value_type;
	private String ruleitem_value;
	private String ruleitem_var_name;
	private String ruleitem_help;
	private String ruleitem_flag;
	private String ruleitem_remark;
	private String control_type;//控件类型
	private String control_type_value;//控件类型value
	private String table_id;
	private String column_id;
	private String column_name;
	private String table_cell; //表格位置
	private String data_come_from_table_id; //来文表名(支持:页面在初始化时,自动填入其他业务数据)
	private String data_come_from_column_id; //来文列名(支持:页面在初始化时,自动填入其他业务数据)
	
	public String getColumn_name() {
		return column_name;
	}
	public void setColumn_name(String column_name) {
		this.column_name = column_name;
	}
	public String getData_come_from_table_id() {
		return data_come_from_table_id;
	}
	public void setData_come_from_table_id(String data_come_from_table_id) {
		this.data_come_from_table_id = data_come_from_table_id;
	}
	public String getData_come_from_column_id() {
		return data_come_from_column_id;
	}
	public void setData_come_from_column_id(String data_come_from_column_id) {
		this.data_come_from_column_id = data_come_from_column_id;
	}
	/**
	 * <b>Summary: </b>
	 *     获取table_cell的值
	 * @return table_cell 
	 */
	public String getTable_cell() {
		return table_cell;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 table_cell 的值 
	 * @param table_cell 
	 */
	public void setTable_cell(String table_cell) {
		this.table_cell = table_cell;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}
	public String getColumn_id() {
		return column_id;
	}
	public void setColumn_id(String column_id) {
		this.column_id = column_id;
	}

	public String getControl_type_value() {
		return control_type_value;
	}
	public void setControl_type_value(String controlTypeValue) {
		control_type_value = controlTypeValue;
	}
	public String getRuleitem_var_name() {
		return ruleitem_var_name;
	}
	public void setRuleitem_var_name(String ruleitemVarName) {
		ruleitem_var_name = ruleitemVarName;
	}
	public String getRuleitem_value_typename() {
		return ruleitem_value_typename;
	}
	public void setRuleitem_value_typename(String ruleitemValueTypename) {
		ruleitem_value_typename = ruleitemValueTypename;
	}
	public String getRuleitem_id() {
		return ruleitem_id;
	}
	public void setRuleitem_id(String ruleitemId) {
		ruleitem_id = ruleitemId;
	}
	public String getTemplate_id() {
		return template_id;
	}
	public void setTemplate_id(String templateId) {
		template_id = templateId;
	}
	public String getRuleitem_name() {
		return ruleitem_name;
	}
	public void setRuleitem_name(String ruleitemName) {
		ruleitem_name = ruleitemName;
	}
	public String getRuleitem_value_type() {
		return ruleitem_value_type;
	}
	public void setRuleitem_value_type(String ruleitemValueType) {
		ruleitem_value_type = ruleitemValueType;
	}
	public String getRuleitem_value() {
		return ruleitem_value;
	}
	public void setRuleitem_value(String ruleitemValue) {
		ruleitem_value = ruleitemValue;
	}
	public String getRuleitem_help() {
		return ruleitem_help;
	}
	public void setRuleitem_help(String ruleitemHelp) {
		ruleitem_help = ruleitemHelp;
	}
	public String getRuleitem_flag() {
		return ruleitem_flag;
	}
	public void setRuleitem_flag(String ruleitemFlag) {
		ruleitem_flag = ruleitemFlag;
	}
	public String getRuleitem_remark() {
		return ruleitem_remark;
	}
	public void setRuleitem_remark(String ruleitemRemark) {
		ruleitem_remark = ruleitemRemark;
	}
	public String getControl_type() {
		return control_type;
	}
	public void setControl_type(String controlType) {
		control_type = controlType;
	}
	
	
	
	
}
