package com.chinacreator.xtbg.core.data.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:DataTypeBean.java</p>
 *<p>Description:资料分类实体Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-19
 */
public class DataTypeBean extends XtDbBaseBean {

	private String d_type_id;		//资料分类ID
	private String d_type_name;		//分类名称
	private String d_type_unit_id;		//所属单位ID
	private String d_type_unit_name;		//所属单位名称
	private String d_type_dept_id;		//所属部门id
	private String d_type_dept_name;		//所属部门名称
	private String d_type_parent_id;		//所属上级分类
	private String d_type_level;		//分类层次
	private String d_type_order;		//排序号
	private String d_type_remark;		//备注
	private String d_type_user_id;		//登记人id
	private String d_type_user_name;		//登记人姓名
	private Object d_type_create_time;		//登记时间
	
	public DataTypeBean(){
		super("oa_data_type","d_type_id");
	}
	/**
	*<b>Summary: 获取资料分类ID</b>
	*/
	public String getD_type_id() {
		return d_type_id;
	}
	/**
	*<b>Summary: 设置资料分类ID</b>
	*/
	public void setD_type_id(String d_type_id) {
		this.d_type_id = d_type_id;
	}
	/**
	*<b>Summary: 获取分类名称</b>
	*/
	public String getD_type_name() {
		return d_type_name;
	}
	/**
	*<b>Summary: 设置分类名称</b>
	*/
	public void setD_type_name(String d_type_name) {
		this.d_type_name = d_type_name;
	}
	/**
	*<b>Summary: 获取所属单位ID</b>
	*/
	public String getD_type_unit_id() {
		return d_type_unit_id;
	}
	/**
	*<b>Summary: 设置所属单位ID</b>
	*/
	public void setD_type_unit_id(String d_type_unit_id) {
		this.d_type_unit_id = d_type_unit_id;
	}
	/**
	*<b>Summary: 获取所属单位名称</b>
	*/
	public String getD_type_unit_name() {
		return d_type_unit_name;
	}
	/**
	*<b>Summary: 设置所属单位名称</b>
	*/
	public void setD_type_unit_name(String d_type_unit_name) {
		this.d_type_unit_name = d_type_unit_name;
	}
	/**
	*<b>Summary: 获取所属部门id</b>
	*/
	public String getD_type_dept_id() {
		return d_type_dept_id;
	}
	/**
	*<b>Summary: 设置所属部门id</b>
	*/
	public void setD_type_dept_id(String d_type_dept_id) {
		this.d_type_dept_id = d_type_dept_id;
	}
	/**
	*<b>Summary: 获取所属部门名称</b>
	*/
	public String getD_type_dept_name() {
		return d_type_dept_name;
	}
	/**
	*<b>Summary: 设置所属部门名称</b>
	*/
	public void setD_type_dept_name(String d_type_dept_name) {
		this.d_type_dept_name = d_type_dept_name;
	}
	/**
	*<b>Summary: 获取所属上级分类</b>
	*/
	public String getD_type_parent_id() {
		return d_type_parent_id;
	}
	/**
	*<b>Summary: 设置所属上级分类</b>
	*/
	public void setD_type_parent_id(String d_type_parent_id) {
		this.d_type_parent_id = d_type_parent_id;
	}
	/**
	*<b>Summary: 获取分类层次</b>
	*/
	public String getD_type_level() {
		return d_type_level;
	}
	/**
	*<b>Summary: 设置分类层次</b>
	*/
	public void setD_type_level(String d_type_level) {
		this.d_type_level = d_type_level;
	}
	/**
	*<b>Summary: 获取排序号</b>
	*/
	public String getD_type_order() {
		return d_type_order;
	}
	/**
	*<b>Summary: 设置排序号</b>
	*/
	public void setD_type_order(String d_type_order) {
		this.d_type_order = d_type_order;
	}
	/**
	*<b>Summary: 获取备注</b>
	*/
	public String getD_type_remark() {
		return d_type_remark;
	}
	/**
	*<b>Summary: 设置备注</b>
	*/
	public void setD_type_remark(String d_type_remark) {
		this.d_type_remark = d_type_remark;
	}
	/**
	*<b>Summary: 获取登记人id</b>
	*/
	public String getD_type_user_id() {
		return d_type_user_id;
	}
	/**
	*<b>Summary: 设置登记人id</b>
	*/
	public void setD_type_user_id(String d_type_user_id) {
		this.d_type_user_id = d_type_user_id;
	}
	/**
	*<b>Summary: 获取登记人姓名</b>
	*/
	public String getD_type_user_name() {
		return d_type_user_name;
	}
	/**
	*<b>Summary: 设置登记人姓名</b>
	*/
	public void setD_type_user_name(String d_type_user_name) {
		this.d_type_user_name = d_type_user_name;
	}
	/**
	*<b>Summary: 获取登记时间</b>
	*/
	public Object getD_type_create_time() {
		return d_type_create_time;
	}
	/**
	*<b>Summary: 设置登记时间</b>
	*/
	public void setD_type_create_time(Object d_type_create_time) {
		this.d_type_create_time = d_type_create_time;
	}
	/**
	 * 中间层资料分类
	 */
	public static final String D_TYPE_LEVEL_ONE = "1";
	/**
	 * 最底层资料分类
	 */
	public static final String D_TYPE_LEVEL_TWO = "2";

	public static String getkTypeLevelTwo() {
		return D_TYPE_LEVEL_TWO;
	}
	public static String getkTypeLevelONE() {
		return D_TYPE_LEVEL_ONE;
	}
	
}
