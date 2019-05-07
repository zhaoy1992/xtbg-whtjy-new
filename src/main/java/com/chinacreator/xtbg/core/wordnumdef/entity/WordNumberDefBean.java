package com.chinacreator.xtbg.core.wordnumdef.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:WordNumberDefBean.java</p>
 *<p>Description:文号维护实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-17
 */
public class WordNumberDefBean extends XtDbBaseBean {

	public WordNumberDefBean(){
		super("oa_word_number_def","");
	}
	
	private String number_type;		//编号类型
	private String number_year;		//编号年份
	private String number_order;		//排序号
	private String number_org_id;		//机构号
	private String remark1;		//扩展字段
	
	private String number_code;//当前编号
	private String number_org_name;//机构名称
	
	/**
	*<b>Summary: 获取编号类型</b>
	*/
	public String getNumber_type() {
		return number_type;
	}
	/**
	*<b>Summary: 设置编号类型</b>
	*/
	public void setNumber_type(String number_type) {
		this.number_type = number_type;
	}
	/**
	*<b>Summary: 获取编号年份</b>
	*/
	public String getNumber_year() {
		return number_year;
	}
	/**
	*<b>Summary: 设置编号年份</b>
	*/
	public void setNumber_year(String number_year) {
		this.number_year = number_year;
	}
	/**
	*<b>Summary: 获取排序号</b>
	*/
	public String getNumber_order() {
		return number_order;
	}
	/**
	*<b>Summary: 设置排序号</b>
	*/
	public void setNumber_order(String number_order) {
		this.number_order = number_order;
	}
	/**
	*<b>Summary: 获取机构号</b>
	*/
	public String getNumber_org_id() {
		return number_org_id;
	}
	/**
	*<b>Summary: 设置机构号</b>
	*/
	public void setNumber_org_id(String number_org_id) {
		this.number_org_id = number_org_id;
	}
	/**
	*<b>Summary: 获取扩展字段</b>
	*/
	public String getRemark1() {
		return remark1;
	}
	/**
	*<b>Summary: 设置扩展字段</b>
	*/
	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}
	public String getNumber_code() {
		return number_code;
	}
	public void setNumber_code(String number_code) {
		this.number_code = number_code;
	}
	public String getNumber_org_name() {
		return number_org_name;
	}
	public void setNumber_org_name(String number_org_name) {
		this.number_org_name = number_org_name;
	}
	
	
}
