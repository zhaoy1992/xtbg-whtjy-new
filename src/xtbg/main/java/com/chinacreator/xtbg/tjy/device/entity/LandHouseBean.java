package com.chinacreator.xtbg.tjy.device.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:LandHouseBean.java</p>
 *<p>Description:土地房屋实体类</p>
 *<p>Copyright:Copyright (c) 2014</p>
 *<p>Company:湖南科创</p>
 *@author 陈郊
 *@version 1.0
 *@CreateDate:2015-11-23
 */
public class LandHouseBean extends XtDbBaseBean{
	 /** 
	  * <b>Summary: </b>
	  *     构造一个 DevAccount  
	   * <b>Remarks: </b>
	  *     构造类 DevAccount 的构造函数 OsapPlanItem
	  * @param tableName 
	  */
		public LandHouseBean() {
			super("ta_oa_landhouseitem", "lh_id");
		}
		private String lh_id;				//主键ID
		private String lh_number;			//编号
		private String lh_name;				//名称
		private String lh_area;				//面积
		private String lh_location;			//地点
		private String lh_identify_code;	//证号
		private Object lh_date;				//日期
		private String lh_money;			//金额
		private String lh_date_start;		//开始时间
		private String lh_date_end;			//结束时间
		private String lh_remarks;			//备注
		private String unit_id;           //所属单位ID
		private String unit_name;           //所属单位名称
		
		public String getLh_remarks() {
			return lh_remarks;
		}
		public void setLh_remarks(String lh_remarks) {
			this.lh_remarks = lh_remarks;
		}
		public String getLh_date_start() {
			return lh_date_start;
		}
		public void setLh_date_start(String lh_date_start) {
			this.lh_date_start = lh_date_start;
		}
		public String getLh_date_end() {
			return lh_date_end;
		}
		public void setLh_date_end(String lh_date_end) {
			this.lh_date_end = lh_date_end;
		}
		public String getLh_id() {
			return lh_id;
		}
		public void setLh_id(String lh_id) {
			this.lh_id = lh_id;
		}
		public String getLh_number() {
			return lh_number;
		}
		public void setLh_number(String lh_number) {
			this.lh_number = lh_number;
		}
		public String getLh_name() {
			return lh_name;
		}
		public void setLh_name(String lh_name) {
			this.lh_name = lh_name;
		}
		public String getLh_area() {
			return lh_area;
		}
		public void setLh_area(String lh_area) {
			this.lh_area = lh_area;
		}
		public String getLh_location() {
			return lh_location;
		}
		public void setLh_location(String lh_location) {
			this.lh_location = lh_location;
		}
		public String getLh_identify_code() {
			return lh_identify_code;
		}
		public void setLh_identify_code(String lh_identify_code) {
			this.lh_identify_code = lh_identify_code;
		}
		public Object getLh_date() {
			return lh_date;
		}
		public void setLh_date(Object lh_date) {
			this.lh_date = lh_date;
		}
		public String getLh_money() {
			return lh_money;
		}
		public void setLh_money(String lh_money) {
			this.lh_money = lh_money;
		}
		public String getUnit_id() {
			return unit_id;
		}
		public void setUnit_id(String unit_id) {
			this.unit_id = unit_id;
		}
		public String getUnit_name() {
			return unit_name;
		}
		public void setUnit_name(String unit_name) {
			this.unit_name = unit_name;
		}
		
}
