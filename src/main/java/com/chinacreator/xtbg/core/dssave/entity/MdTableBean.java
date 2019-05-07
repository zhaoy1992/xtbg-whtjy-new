package com.chinacreator.xtbg.core.dssave.entity;

import java.util.List;
/**
 * 
 *<p>Title:MdBean.java</p>
 *<p>Description:数据元表名</p>
 *<p>Copyright:Copyright (c) 2010</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-4-8
 */
public class MdTableBean {
	private static final long serialVersionUID = 1L;
	
	private String table_id;    //表id
	private String table_code;		//表代码名称
	private String table_name;	//表中文名称
	private String table_pk;	//表主键名称
	private String parent_table_id;//父表id
	private String business_type;		//业务类型
	private String table_sn;		//排序号
	private List<MdColumnBean> mdList;//数据元列表
	private List<MdTableBean> sonlist; //子表
	
	private String pkname;
	private String havepk;
	
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
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	public String getTable_pk() {
		return table_pk;
	}
	public void setTable_pk(String table_pk) {
		this.table_pk = table_pk;
	}
	public String getParent_table_id() {
		return parent_table_id;
	}
	public void setParent_table_id(String parent_table_id) {
		this.parent_table_id = parent_table_id;
	}
	public String getBusiness_type() {
		return business_type;
	}
	public void setBusiness_type(String business_type) {
		this.business_type = business_type;
	}
	public String getTable_sn() {
		return table_sn;
	}
	public void setTable_sn(String table_sn) {
		this.table_sn = table_sn;
	}
	public List<MdColumnBean> getMdList() {
		return mdList;
	}
	public void setMdList(List<MdColumnBean> mdList) {
		this.mdList = mdList;
	}
	public List<MdTableBean> getSonlist() {
		return sonlist;
	}
	public void setSonlist(List<MdTableBean> sonlist) {
		this.sonlist = sonlist;
	}
	public String getPkname() {
		return pkname;
	}
	public void setPkname(String pkname) {
		this.pkname = pkname;
	}
	public String getHavepk() {
		return havepk;
	}
	public void setHavepk(String havepk) {
		this.havepk = havepk;
	}
	
}
