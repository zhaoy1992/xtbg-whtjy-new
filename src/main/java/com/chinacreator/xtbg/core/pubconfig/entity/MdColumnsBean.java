package com.chinacreator.xtbg.core.pubconfig.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:MdColumnsBean.java</p>
 *<p>Description:数据元字段实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-29
 */
public class MdColumnsBean extends XtDbBaseBean {

	private String column_id;		//字段id
	private String table_id;		//表id
	private String column_code;		//字段代码
	private String column_name;		//字段名称
	private String column_sn;		//排序号
	private String isview;		//是否为意见字段(默认为0 不是，1为是)
	
	public MdColumnsBean(){
		super("oa_md_columns","column_id");
	}
	/**
	*<b>Summary: 获取字段id</b>
	*/
	public String getColumn_id() {
		return column_id;
	}
	/**
	*<b>Summary: 设置字段id</b>
	*/
	public void setColumn_id(String column_id) {
		this.column_id = column_id;
	}
	/**
	*<b>Summary: 获取表id</b>
	*/
	public String getTable_id() {
		return table_id;
	}
	/**
	*<b>Summary: 设置表id</b>
	*/
	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}
	/**
	*<b>Summary: 获取字段代码</b>
	*/
	public String getColumn_code() {
		return column_code;
	}
	/**
	*<b>Summary: 设置字段代码</b>
	*/
	public void setColumn_code(String column_code) {
		this.column_code = column_code;
	}
	/**
	*<b>Summary: 获取字段名称</b>
	*/
	public String getColumn_name() {
		return column_name;
	}
	/**
	*<b>Summary: 设置字段名称</b>
	*/
	public void setColumn_name(String column_name) {
		this.column_name = column_name;
	}
	/**
	*<b>Summary: 获取排序号</b>
	*/
	public String getColumn_sn() {
		return column_sn;
	}
	/**
	*<b>Summary: 设置排序号</b>
	*/
	public void setColumn_sn(String column_sn) {
		this.column_sn = column_sn;
	}
	/**
	*<b>Summary: 获取是否为意见字段(默认为0 不是，1为是)</b>
	*/
	public String getIsview() {
		return isview;
	}
	/**
	*<b>Summary: 设置是否为意见字段(默认为0 不是，1为是)</b>
	*/
	public void setIsview(String isview) {
		this.isview = isview;
	}
}
