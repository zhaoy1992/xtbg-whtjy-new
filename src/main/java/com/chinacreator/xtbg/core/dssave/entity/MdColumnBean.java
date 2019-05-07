package com.chinacreator.xtbg.core.dssave.entity;
/**
 * 
 *<p>Title:MdColumnBean.java</p>
 *<p>Description:数据元字段名</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-4-8
 */
public class MdColumnBean {
	private static final long serialVersionUID = 1L;
	
	private String column_id;    //字段id
	private String table_id; //表id
	private String column_code;//字段代码
	private String column_name;//字段名称
	private String column_sn;//排序号
	private String isview; //是否为意见字段(默认为0 不是，1为是
	
	//add by 黄海 增加	以下属性  关联至SYS.USER_TAB_COLUMNS 2013-06-06
	private String table_name;   //表名
	private String data_type;    //字段类型
	private String data_length;  //字段长度
	private String nullable;     //可为空
	private String ispk;         //是否主键
	//end
	
	
	public String getIsview() {
		return isview;
	}
	public void setIsview(String isview) {
		this.isview = isview;
	}
	public String getColumn_id() {
		return column_id;
	}
	public void setColumn_id(String column_id) {
		this.column_id = column_id;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}
	public String getColumn_code() {
		return column_code;
	}
	public void setColumn_code(String column_code) {
		this.column_code = column_code;
	}
	public String getColumn_name() {
		return column_name;
	}
	public void setColumn_name(String column_name) {
		this.column_name = column_name;
	}
	public String getColumn_sn() {
		return column_sn;
	}
	public void setColumn_sn(String column_sn) {
		this.column_sn = column_sn;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	public String getData_type() {
		return data_type;
	}
	public void setData_type(String data_type) {
		this.data_type = data_type;
	}
	public String getData_length() {
		return data_length;
	}
	public void setData_length(String data_length) {
		this.data_length = data_length;
	}
	public String getNullable() {
		return nullable;
	}
	public void setNullable(String nullable) {
		this.nullable = nullable;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getIspk() {
		return ispk;
	}
	public void setIspk(String ispk) {
		this.ispk = ispk;
	}
}
