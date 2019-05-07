package com.chinacreator.xtbg.core.guestreception.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:GuestReceiveBean.java</p>
 *<p>Description:接待人员名单实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-4
 */
public class GuestReceiveBean extends XtDbBaseBean {

	public GuestReceiveBean(){
		super("OA_GUESTRECEIVE","pid");
	}
	private String pid;		//本表主键
	private String grinfo_id;		//主键id
	private String ptusername;		//接待人员姓名
	private String ptuserid;		//接待人员姓名id
	private String ptsex;		//接待人员性别
	private String ptpost;		//接待人员单位和职位
	private String remark1;		//备用1
	private String remark2;		//备用2
	private Object creattime;		//创建时间按
	/**
	*<b>Summary: 获取本表主键</b>
	*/
	public String getPid() {
		return pid;
	}
	/**
	*<b>Summary: 设置本表主键</b>
	*/
	public void setPid(String pid) {
		this.pid = pid;
	}
	/**
	*<b>Summary: 获取主键id</b>
	*/
	public String getGrinfo_id() {
		return grinfo_id;
	}
	/**
	*<b>Summary: 设置主键id</b>
	*/
	public void setGrinfo_id(String grinfo_id) {
		this.grinfo_id = grinfo_id;
	}
	/**
	*<b>Summary: 获取接待人员姓名</b>
	*/
	public String getPtusername() {
		return ptusername;
	}
	/**
	*<b>Summary: 设置接待人员姓名</b>
	*/
	public void setPtusername(String ptusername) {
		this.ptusername = ptusername;
	}
	/**
	*<b>Summary: 获取接待人员姓名id</b>
	*/
	public String getPtuserid() {
		return ptuserid;
	}
	/**
	*<b>Summary: 设置接待人员姓名id</b>
	*/
	public void setPtuserid(String ptuserid) {
		this.ptuserid = ptuserid;
	}
	/**
	*<b>Summary: 获取接待人员性别</b>
	*/
	public String getPtsex() {
		return ptsex;
	}
	/**
	*<b>Summary: 设置接待人员性别</b>
	*/
	public void setPtsex(String ptsex) {
		this.ptsex = ptsex;
	}
	/**
	*<b>Summary: 获取接待人员单位和职位</b>
	*/
	public String getPtpost() {
		return ptpost;
	}
	/**
	*<b>Summary: 设置接待人员单位和职位</b>
	*/
	public void setPtpost(String ptpost) {
		this.ptpost = ptpost;
	}
	/**
	*<b>Summary: 获取备用1</b>
	*/
	public String getRemark1() {
		return remark1;
	}
	/**
	*<b>Summary: 设置备用1</b>
	*/
	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}
	/**
	*<b>Summary: 获取备用2</b>
	*/
	public String getRemark2() {
		return remark2;
	}
	/**
	*<b>Summary: 设置备用2</b>
	*/
	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}
	/**
	*<b>Summary: 获取创建时间按</b>
	*/
	public Object getCreattime() {
		return creattime;
	}
	/**
	*<b>Summary: 设置创建时间按</b>
	*/
	public void setCreattime(Object creattime) {
		this.creattime = creattime;
	}
}
