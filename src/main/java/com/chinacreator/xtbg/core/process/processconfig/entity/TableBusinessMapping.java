package com.chinacreator.xtbg.core.process.processconfig.entity;

/**
 *<p>Title:TableBusinessMapping.java</p>
 *<p>Description:业务数据元关系表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-3
 */
public class TableBusinessMapping {
	
	 /** 
	  * map_id:主键 
	  */
	private String map_id;
	
	 /** 
	  * table_id:表id 
	  */
	private String table_id;
	
	 /** 
	  * busitype_code:业务类型 
	  */
	private String busitype_code;
	
	public String getMap_id() {
		return map_id;
	}
	public void setMap_id(String map_id) {
		this.map_id = map_id;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}
	public String getBusitype_code() {
		return busitype_code;
	}
	public void setBusitype_code(String busitype_code) {
		this.busitype_code = busitype_code;
	}
}
