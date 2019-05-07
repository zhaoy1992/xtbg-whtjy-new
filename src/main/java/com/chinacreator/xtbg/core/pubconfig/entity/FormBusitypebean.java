package com.chinacreator.xtbg.core.pubconfig.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:FormBusitypebean.java</p>
 *<p>Description:表单业务类型实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-29
 */
public class FormBusitypebean extends XtDbBaseBean {

	private String busitype_code;		//类型编码
	private String busitype_name;		//类型名称
	private String type_desc;		//类型描述
	private String is_valid;		//是否有效
	private String table_id;		//表ID
	private String table_name;
	private String busitype_type_code; //业务类型分类
	
	public FormBusitypebean(){
		super("OA_FORM_BUSITYPE","busitype_code");
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


	/**
	*<b>Summary: 获取类型编码</b>
	*/
	public String getBusitype_code() {
		return busitype_code;
	}
	/**
	*<b>Summary: 设置类型编码</b>
	*/
	public void setBusitype_code(String busitype_code) {
		this.busitype_code = busitype_code;
	}
	/**
	*<b>Summary: 获取类型名称</b>
	*/
	public String getBusitype_name() {
		return busitype_name;
	}
	/**
	*<b>Summary: 设置类型名称</b>
	*/
	public void setBusitype_name(String busitype_name) {
		this.busitype_name = busitype_name;
	}
	/**
	*<b>Summary: 获取类型描述</b>
	*/
	public String getType_desc() {
		return type_desc;
	}
	/**
	*<b>Summary: 设置类型描述</b>
	*/
	public void setType_desc(String type_desc) {
		this.type_desc = type_desc;
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
	*<b>Summary: 获取表ID</b>
	*/
	public String getTable_id() {
		return table_id;
	}
	/**
	*<b>Summary: 设置表ID</b>
	*/
	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	
}
