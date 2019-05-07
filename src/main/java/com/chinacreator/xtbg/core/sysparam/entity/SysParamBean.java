package com.chinacreator.xtbg.core.sysparam.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:SysParam.java</p>
 *<p>Description:系统参数表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-18
 */
public class SysParamBean extends XtDbBaseBean {
	
	private String p_id;		//参数主键ID
	private String p_type;		//参数类型
	private String p_code;		//参数编号
	private String p_name;		//参数名称
	private String p_content;		//参数内容
	private String p_valid;		//是否有效
	private Object p_creator_time;		//创建时间
	private String p_isupdate;		//是否可修改
	private String p_remark;		//参数描述
	private String dictdata_id;		//字典数据ID
	
	public SysParamBean(){
		super("oa_sys_param","p_id");
	}
	/**
	*<b>Summary: 获取参数主键ID</b>
	*/
	public String getP_id() {
		return p_id;
	}
	/**
	*<b>Summary: 设置参数主键ID</b>
	*/
	public void setP_id(String p_id) {
		this.p_id = p_id;
	}
	/**
	*<b>Summary: 获取参数类型</b>
	*/
	public String getP_type() {
		return p_type;
	}
	/**
	*<b>Summary: 设置参数类型</b>
	*/
	public void setP_type(String p_type) {
		this.p_type = p_type;
	}
	/**
	*<b>Summary: 获取参数编号</b>
	*/
	public String getP_code() {
		return p_code;
	}
	/**
	*<b>Summary: 设置参数编号</b>
	*/
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	/**
	*<b>Summary: 获取参数名称</b>
	*/
	public String getP_name() {
		return p_name;
	}
	/**
	*<b>Summary: 设置参数名称</b>
	*/
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	/**
	*<b>Summary: 获取参数内容</b>
	*/
	public String getP_content() {
		return p_content;
	}
	/**
	*<b>Summary: 设置参数内容</b>
	*/
	public void setP_content(String p_content) {
		this.p_content = p_content;
	}
	/**
	*<b>Summary: 获取是否有效</b>
	*/
	public String getP_valid() {
		return p_valid;
	}
	/**
	*<b>Summary: 设置是否有效</b>
	*/
	public void setP_valid(String p_valid) {
		this.p_valid = p_valid;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public Object getP_creator_time() {
		return p_creator_time;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setP_creator_time(Object p_creator_time) {
		this.p_creator_time = p_creator_time;
	}
	/**
	*<b>Summary: 获取是否可修改</b>
	*/
	public String getP_isupdate() {
		return p_isupdate;
	}
	/**
	*<b>Summary: 设置是否可修改</b>
	*/
	public void setP_isupdate(String p_isupdate) {
		this.p_isupdate = p_isupdate;
	}
	/**
	*<b>Summary: 获取参数描述</b>
	*/
	public String getP_remark() {
		return p_remark;
	}
	/**
	*<b>Summary: 设置参数描述</b>
	*/
	public void setP_remark(String p_remark) {
		this.p_remark = p_remark;
	}
	/**
	*<b>Summary: 获取字典数据ID</b>
	*/
	public String getDictdata_id() {
		return dictdata_id;
	}
	/**
	*<b>Summary: 设置字典数据ID</b>
	*/
	public void setDictdata_id(String dictdata_id) {
		this.dictdata_id = dictdata_id;
	}
}
