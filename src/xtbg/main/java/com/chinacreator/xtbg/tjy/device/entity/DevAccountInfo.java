
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAccount.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:DevAccountInfo.java</p>
 *<p>Description:设备详情</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public class DevAccountInfo extends XtDbBaseBean{
	 /** 
	  * <b>Summary: </b>
	  *     构造一个 DevAccount  
	   * <b>Remarks: </b>
	  *     构造类 DevAccount 的构造函数 OsapPlanItem
	  * @param tableName 
	  */
		public DevAccountInfo() {
			super("ta_oa_devaccount", "id");
		}
		private String id;				//主键ID
		private String dev_code;		//设备编号
		private String dev_name;		//设备名称
		private String type;			//设备型号
		private String make_users;		//制造厂家
		private String factory_no;		//出厂编号
		private Object creat_date;		//生产日期
		private String product_no;		//产品合格证编号
		private String quality_no;		//质量证明书编号

		private String user_orgid;			//使用部门ID
		private String user_orgname;		//使用部门名称
		private String custos_userid;		//保管人ID
		private String custos_username;		//保管人名称
		private String dev_stockflag;		//设备使用状态  1:在库 2:借出
		private String dev_state;			//设备完好状态  1:完好2:在修 3:报废 4:损耗 5:停用
		private String technical_parameters;	//设备主要技术参数
		private String dev_attach_id;			//附件ID
		private String user_unit;		     //保管部门单位ID
		private String user_unitname;		 //保管部门单位名称
		
		private String creater_userid;		//登记人ID
		private String creater_username;	//登记人名称
		private Object creat_time;		//登记时间
		private String car_photo;		//设备图纸
		private String dev_photoid;		//设备图片ID
		private String price;		//价格
		private Object arrive_time;		//设备到达时间
		private String remark;		//备注
		private String devsup_id;	//供应商ID
		
		//列表查询用
		private String devsup_mc; //供应商名称
		private String creat_StartDate;	//生产开始日期
		private String creat_EndDate;	//生产结束日期
		private String arrive_StartTime;//设备到达开始时间
		private String arrive_EndTime;//设备到达结束时间
		private String creat_StartTime;//登记开始时间
		private String creat_EndTime;//登记结束时间
		private String isseeflag;	//是否查看预警
		private String seecount;	//查看预警数量
		
		/**
		*<b>Summary: 获取主键ID</b>
		*/
		public String getId() {
			return id;
		}
		/**
		*<b>Summary: 设置主键ID</b>
		*/
		public void setId(String id) {
			this.id = id;
		}
		/**
		*<b>Summary: 获取设备编号</b>
		*/
		public String getDev_code() {
			return dev_code;
		}
		/**
		*<b>Summary: 设置设备编号</b>
		*/
		public void setDev_code(String dev_code) {
			this.dev_code = dev_code;
		}
		/**
		*<b>Summary: 获取设备名称</b>
		*/
		public String getDev_name() {
			return dev_name;
		}
		/**
		*<b>Summary: 设置设备名称</b>
		*/
		public void setDev_name(String dev_name) {
			this.dev_name = dev_name;
		}
		/**
		*<b>Summary: 获取设备型号</b>
		*/
		public String getType() {
			return type;
		}
		/**
		*<b>Summary: 设置设备型号</b>
		*/
		public void setType(String type) {
			this.type = type;
		}
		/**
		*<b>Summary: 获取制造厂家</b>
		*/
		public String getMake_users() {
			return make_users;
		}
		/**
		*<b>Summary: 设置制造厂家</b>
		*/
		public void setMake_users(String make_users) {
			this.make_users = make_users;
		}
		/**
		*<b>Summary: 获取出厂编号</b>
		*/
		public String getFactory_no() {
			return factory_no;
		}
		/**
		*<b>Summary: 设置出厂编号</b>
		*/
		public void setFactory_no(String factory_no) {
			this.factory_no = factory_no;
		}
		/**
		*<b>Summary: 获取生产日期</b>
		*/
		public Object getCreat_date() {
			return creat_date;
		}
		/**
		*<b>Summary: 设置生产日期</b>
		*/
		public void setCreat_date(Object creat_date) {
			this.creat_date = creat_date;
		}
		/**
		*<b>Summary: 获取产品合格证编号</b>
		*/
		public String getProduct_no() {
			return product_no;
		}
		/**
		*<b>Summary: 设置产品合格证编号</b>
		*/
		public void setProduct_no(String product_no) {
			this.product_no = product_no;
		}
		/**
		*<b>Summary: 获取质量证明书编号
		</b>
		*/
		public String getQuality_no() {
			return quality_no;
		}
		/**
		*<b>Summary: 设置质量证明书编号
		</b>
		*/
		public void setQuality_no(String quality_no) {
			this.quality_no = quality_no;
		}
		/**
		*<b>Summary: 获取使用部门ID</b>
		*/
		public String getUser_orgid() {
			return user_orgid;
		}
		/**
		*<b>Summary: 设置使用部门ID</b>
		*/
		public void setUser_orgid(String user_orgid) {
			this.user_orgid = user_orgid;
		}
		/**
		*<b>Summary: 获取使用部门名称</b>
		*/
		public String getUser_orgname() {
			return user_orgname;
		}
		/**
		*<b>Summary: 设置使用部门名称</b>
		*/
		public void setUser_orgname(String user_orgname) {
			this.user_orgname = user_orgname;
		}
		/**
		*<b>Summary: 获取保管人ID</b>
		*/
		public String getCustos_userid() {
			return custos_userid;
		}
		/**
		*<b>Summary: 设置保管人ID</b>
		*/
		public void setCustos_userid(String custos_userid) {
			this.custos_userid = custos_userid;
		}
		/**
		*<b>Summary: 获取保管人名称</b>
		*/
		public String getCustos_username() {
			return custos_username;
		}
		/**
		*<b>Summary: 设置保管人名称</b>
		*/
		public void setCustos_username(String custos_username) {
			this.custos_username = custos_username;
		}
		/**
		*<b>Summary: 获取设备使用状态  1:在库 2:借出</b>
		*/
		public String getDev_stockflag() {
			return dev_stockflag;
		}
		/**
		*<b>Summary: 设置设备使用状态  1:在库 2:借出</b>
		*/
		public void setDev_stockflag(String dev_stockflag) {
			this.dev_stockflag = dev_stockflag;
		}
		/**
		*<b>Summary: 获取设备完好状态  1:完好2:在修 3:报废 4:损耗</b>
		*/
		public String getDev_state() {
			return dev_state;
		}
		/**
		*<b>Summary: 设置设备完好状态  1:完好2:在修 3:报废 4:损耗</b>
		*/
		public void setDev_state(String dev_state) {
			this.dev_state = dev_state;
		}
		/**
		*<b>Summary: 获取设备主要技术参数
		</b>
		*/
		public String getTechnical_parameters() {
			return technical_parameters;
		}
		/**
		*<b>Summary: 设置设备主要技术参数
		</b>
		*/
		public void setTechnical_parameters(String technical_parameters) {
			this.technical_parameters = technical_parameters;
		}
		/**
		*<b>Summary: 获取登记人ID</b>
		*/
		public String getCreater_userid() {
			return creater_userid;
		}
		/**
		*<b>Summary: 设置登记人ID</b>
		*/
		public void setCreater_userid(String creater_userid) {
			this.creater_userid = creater_userid;
		}
		/**
		*<b>Summary: 获取登记人名称</b>
		*/
		public String getCreater_username() {
			return creater_username;
		}
		/**
		*<b>Summary: 设置登记人名称</b>
		*/
		public void setCreater_username(String creater_username) {
			this.creater_username = creater_username;
		}
		/**
		*<b>Summary: 获取登记时间</b>
		*/
		public Object getCreat_time() {
			return creat_time;
		}
		/**
		*<b>Summary: 设置登记时间</b>
		*/
		public void setCreat_time(Object creat_time) {
			this.creat_time = creat_time;
		}
		/**
		*<b>Summary: 获取设备图纸</b>
		*/
		public String getCar_photo() {
			return car_photo;
		}
		/**
		*<b>Summary: 设置设备图纸</b>
		*/
		public void setCar_photo(String car_photo) {
			this.car_photo = car_photo;
		}
		/**
		*<b>Summary: 获取价格</b>
		*/
		public String getPrice() {
			return price;
		}
		/**
		*<b>Summary: 设置价格</b>
		*/
		public void setPrice(String price) {
			this.price = price;
		}
		/**
		*<b>Summary: 获取设备图片ID</b>
		*/
		public String getDev_photoid() {
			return dev_photoid;
		}
		/**
		*<b>Summary: 设置设备图片ID</b>
		*/
		public void setDev_photoid(String dev_photoid) {
			this.dev_photoid = dev_photoid;
		}
		/**
		*<b>Summary: 获取设备到达时间</b>
		*/
		public Object getArrive_time() {
			return arrive_time;
		}
		/**
		*<b>Summary: 设置设备到达时间</b>
		*/
		public void setArrive_time(Object arrive_time) {
			this.arrive_time = arrive_time;
		}
		/**
		*<b>Summary: 获取备注</b>
		*/
		public String getRemark() {
			return remark;
		}
		/**
		*<b>Summary: 设置备注</b>
		*/
		public void setRemark(String remark) {
			this.remark = remark;
		}
		public String getDevsup_id() {
			return devsup_id;
		}
		public void setDevsup_id(String devsup_id) {
			this.devsup_id = devsup_id;
		}
		public String getDevsup_mc() {
			return devsup_mc;
		}
		public void setDevsup_mc(String devsup_mc) {
			this.devsup_mc = devsup_mc;
		}
		public String getCreat_StartDate() {
			return creat_StartDate;
		}
		public void setCreat_StartDate(String creat_StartDate) {
			this.creat_StartDate = creat_StartDate;
		}
		public String getCreat_EndDate() {
			return creat_EndDate;
		}
		public void setCreat_EndDate(String creat_EndDate) {
			this.creat_EndDate = creat_EndDate;
		}
		public String getArrive_StartTime() {
			return arrive_StartTime;
		}
		public void setArrive_StartTime(String arrive_StartTime) {
			this.arrive_StartTime = arrive_StartTime;
		}
		public String getArrive_EndTime() {
			return arrive_EndTime;
		}
		public void setArrive_EndTime(String arrive_EndTime) {
			this.arrive_EndTime = arrive_EndTime;
		}
		public String getCreat_StartTime() {
			return creat_StartTime;
		}
		public void setCreat_StartTime(String creat_StartTime) {
			this.creat_StartTime = creat_StartTime;
		}
		public String getCreat_EndTime() {
			return creat_EndTime;
		}
		public void setCreat_EndTime(String creat_EndTime) {
			this.creat_EndTime = creat_EndTime;
		}
		public String getIsseeflag() {
			return isseeflag;
		}
		public void setIsseeflag(String isseeflag) {
			this.isseeflag = isseeflag;
		}
		public String getSeecount() {
			return seecount;
		}
		public void setSeecount(String seecount) {
			this.seecount = seecount;
		}
		public String getDev_attach_id() {
			return dev_attach_id;
		}
		public void setDev_attach_id(String dev_attach_id) {
			this.dev_attach_id = dev_attach_id;
		}
		public String getUser_unit() {
			return user_unit;
		}
		public void setUser_unit(String user_unit) {
			this.user_unit = user_unit;
		}
		public String getUser_unitname() {
			return user_unitname;
		}
		public void setUser_unitname(String user_unitname) {
			this.user_unitname = user_unitname;
		}
}
