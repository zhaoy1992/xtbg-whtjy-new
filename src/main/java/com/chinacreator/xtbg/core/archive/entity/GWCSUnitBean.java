package com.chinacreator.xtbg.core.archive.entity;

/**
 * 
 *<p>Title:GWCSUnitBean.java</p>
 *<p>Description:公文传输Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Oct 31, 2013
 */
public class GWCSUnitBean {
	private String org_id;		//机构id
	private String org_name;		//机构名称
	private String org_addr;		//机构地址码
	private String parent_id;		//父机构id
	private String isouter;		//是否为外部机构
	
	private String config_child_sql;	//配置文件中查询子节点数据sql
	private String config_copies;		//配置文件中份数
	private String config_number;		//配置文件中编号
	private String config_dom_id;		//配置文件中domid
	private String config_sqlParamValue;//配置文件中对字段赋值的值
	
	public String getConfig_dom_id() {
		return config_dom_id;
	}
	public void setConfig_dom_id(String config_dom_id) {
		this.config_dom_id = config_dom_id;
	}
	public String getConfig_sqlParamValue() {
		return config_sqlParamValue;
	}
	public void setConfig_sqlParamValue(String config_sqlParamValue) {
		this.config_sqlParamValue = config_sqlParamValue;
	}
	public String getConfig_child_sql() {
		return config_child_sql;
	}
	public void setConfig_child_sql(String config_child_sql) {
		this.config_child_sql = config_child_sql;
	}
	public String getConfig_copies() {
		return config_copies;
	}
	public void setConfig_copies(String config_copies) {
		this.config_copies = config_copies;
	}
	public String getConfig_number() {
		return config_number;
	}
	public void setConfig_number(String config_number) {
		this.config_number = config_number;
	}
	/**
	*<b>Summary: 获取机构id</b>
	*/
	public String getOrg_id() {
		return org_id;
	}
	/**
	*<b>Summary: 设置机构id</b>
	*/
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}
	/**
	*<b>Summary: 获取机构名称</b>
	*/
	public String getOrg_name() {
		return org_name;
	}
	/**
	*<b>Summary: 设置机构名称</b>
	*/
	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	/**
	*<b>Summary: 获取机构地址码</b>
	*/
	public String getOrg_addr() {
		return org_addr;
	}
	/**
	*<b>Summary: 设置机构地址码</b>
	*/
	public void setOrg_addr(String org_addr) {
		this.org_addr = org_addr;
	}
	/**
	*<b>Summary: 获取父机构id</b>
	*/
	public String getParent_id() {
		return parent_id;
	}
	/**
	*<b>Summary: 设置父机构id</b>
	*/
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	/**
	*<b>Summary: 获取是否为外部机构</b>
	*/
	public String getIsouter() {
		return isouter;
	}
	/**
	*<b>Summary: 设置是否为外部机构</b>
	*/
	public void setIsouter(String isouter) {
		this.isouter = isouter;
	}
}
