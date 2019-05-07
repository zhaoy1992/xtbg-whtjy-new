package com.chinacreator.xtbg.core.process.processconfig.entity;

/**
 *<p>Title:ActColStatusBean.java</p>
 *<p>Description:流程活动表单元素状态表(环节字段状态表)</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-5-29
 */
public class ActColStatusBean {

	/**
	 * id:主键
	 */
	private String id;

	/**
	 * action_id:活动id
	 */
	private String action_id;

	/**
	 * table_id:库表id
	 */
	private String table_id;

	/**
	 * table_code:库表code
	 */
	private String table_code;

	/**
	 * column_id:字段id
	 */
	private String column_id;

	/**
	 * column_code:字段code
	 */
	private String column_code;

	/**
	 * readonly:是否只读
	 */
	private String readonly;

	/**
	 * hidden:是否隐藏
	 */
	private String hidden;

	/**
	 * disable:是否禁用
	 */
	private String disable;

	/**
	 * disable:字段name
	 */
	private String column_name;

	/**
	 * ckd1:readonly勾选状态
	 */
	private String ckd1;

	/**
	 * ckd2:hidden勾选状态
	 */
	private String ckd2;

	/**
	 * ckd3:disable勾选状态
	 */
	private String ckd3;

	/**
	 * required 是否可用
	 */
	private String required;
	
	/**
	 * ckd4:required勾选状态
	 */
	private String ckd4;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAction_id() {
		return action_id;
	}

	public void setAction_id(String action_id) {
		this.action_id = action_id;
	}

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

	public String getColumn_id() {
		return column_id;
	}

	public void setColumn_id(String column_id) {
		this.column_id = column_id;
	}

	public String getColumn_code() {
		return column_code;
	}

	public void setColumn_code(String column_code) {
		this.column_code = column_code;
	}

	public String getReadonly() {
		return readonly;
	}

	public void setReadonly(String readonly) {
		this.readonly = readonly;
	}

	public String getHidden() {
		return hidden;
	}

	public void setHidden(String hidden) {
		this.hidden = hidden;
	}

	public String getDisable() {
		return disable;
	}

	public void setDisable(String disable) {
		this.disable = disable;
	}

	public String getColumn_name() {
		return column_name;
	}

	public void setColumn_name(String column_name) {
		this.column_name = column_name;
	}

	public String getCkd1() {
		return ckd1;
	}

	public void setCkd1(String ckd1) {
		this.ckd1 = ckd1;
	}

	public String getCkd2() {
		return ckd2;
	}

	public void setCkd2(String ckd2) {
		this.ckd2 = ckd2;
	}

	public String getCkd3() {
		return ckd3;
	}

	public void setCkd3(String ckd3) {
		this.ckd3 = ckd3;
	}

	public String getRequired() {
		return required;
	}

	public void setRequired(String required) {
		this.required = required;
	}

	public String getCkd4() {
		return ckd4;
	}

	public void setCkd4(String ckd4) {
		this.ckd4 = ckd4;
	}

}
