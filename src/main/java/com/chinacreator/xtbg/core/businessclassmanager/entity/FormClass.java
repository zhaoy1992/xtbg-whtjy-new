package com.chinacreator.xtbg.core.businessclassmanager.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:FormClass.java</p>
 *<p>Description:业务类别实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-30
 */
public class FormClass extends XtDbBaseBean {

	private String app_id;		//应用ID
	private String ec_id;		//业务类别编号
	private String ec_name;		//业务类别名称
	private String ec_upid;		//上级表单编号
	private String remark;		//业务类别描述
	private String owner_id;		//创建人
	private String ec_sn;		//业务类别排序号
	
	public FormClass(){
		super("TB_FORM_CLASS","ec_id");
	}
	
	/**
	*<b>Summary: 获取应用ID</b>
	*/
	public String getApp_id() {
		return app_id;
	}
	/**
	*<b>Summary: 设置应用ID</b>
	*/
	public void setApp_id(String app_id) {
		this.app_id = app_id;
	}
	/**
	*<b>Summary: 获取业务类别编号</b>
	*/
	public String getEc_id() {
		return ec_id;
	}
	/**
	*<b>Summary: 设置业务类别编号</b>
	*/
	public void setEc_id(String ec_id) {
		this.ec_id = ec_id;
	}
	/**
	*<b>Summary: 获取业务类别名称</b>
	*/
	public String getEc_name() {
		return ec_name;
	}
	/**
	*<b>Summary: 设置业务类别名称</b>
	*/
	public void setEc_name(String ec_name) {
		this.ec_name = ec_name;
	}
	/**
	*<b>Summary: 获取上级表单编号</b>
	*/
	public String getEc_upid() {
		return ec_upid;
	}
	/**
	*<b>Summary: 设置上级表单编号</b>
	*/
	public void setEc_upid(String ec_upid) {
		this.ec_upid = ec_upid;
	}
	/**
	*<b>Summary: 获取业务类别描述</b>
	*/
	public String getRemark() {
		return remark;
	}
	/**
	*<b>Summary: 设置业务类别描述</b>
	*/
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/**
	*<b>Summary: 获取创建人</b>
	*/
	public String getOwner_id() {
		return owner_id;
	}
	/**
	*<b>Summary: 设置创建人</b>
	*/
	public void setOwner_id(String owner_id) {
		this.owner_id = owner_id;
	}
	/**
	*<b>Summary: 获取业务类别排序号</b>
	*/
	public String getEc_sn() {
		return ec_sn;
	}
	/**
	*<b>Summary: 设置业务类别排序号</b>
	*/
	public void setEc_sn(String ec_sn) {
		this.ec_sn = ec_sn;
	}
}
