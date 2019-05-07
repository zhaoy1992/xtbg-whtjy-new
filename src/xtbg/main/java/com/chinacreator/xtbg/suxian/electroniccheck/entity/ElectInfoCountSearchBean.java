
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ElectInfoCountSearchBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-7-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.suxian.electroniccheck.entity;

/**
 *<p>Title:ElectInfoCountSearchBean.java</p>
 *<p>Description:电子考勤统计bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-7-8
 */
public class ElectInfoCountSearchBean {
	
	private String start_time;//开始时间
	private String end_time;//解决时间
	private String username;//用户名称
	private String userid;//用户id
	private String orgid;//单位id
	private String orgname;//单位名称
    private String cdcount;//迟到 统计数
    private String ztcount;//早退 统计数
    private String kgcount;//矿工 统计数
    private String cdztcount;//迟到并早退 统计数
    private String wqcount;//外勤统计数
    private String qjcount;//请假统计数
    private String zccount;//正常统计数
    private String sjcount;//事假
    private String nxjcount;//年休假
    private String xxpxjcount;//学习培训假
    private String gcjcount;//公差假
    private String bsjcount;//病（伤）假
    private String cjcount;//产假
    private String gsjcount;//工伤假
    private String hjcount;//婚假
    private String jhsyjcount;//计划生育假
    private String sajcount;//丧假
    private String pcjcount;//陪产假
    private String state;//请假类型
    private String unit_id;//所属单位
    private String breakoff;//调休假
    
    
    
	public String getBreakoff() {
		return breakoff;
	}
	public void setBreakoff(String breakoff) {
		this.breakoff = breakoff;
	}
	public String getPcjcount() {
		return pcjcount;
	}
	public void setPcjcount(String pcjcount) {
		this.pcjcount = pcjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取start_time的值
	 * @return start_time 
	 */
	public String getStart_time() {
		return start_time;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 start_time 的值 
	 * @param start_time 
	 */
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	/**
	 * <b>Summary: </b>
	 *     获取end_time的值
	 * @return end_time 
	 */
	public String getEnd_time() {
		return end_time;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 end_time 的值 
	 * @param end_time 
	 */
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	/**
	 * <b>Summary: </b>
	 *     获取username的值
	 * @return username 
	 */
	public String getUsername() {
		return username;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 username 的值 
	 * @param username 
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * <b>Summary: </b>
	 *     获取userid的值
	 * @return userid 
	 */
	public String getUserid() {
		return userid;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 userid 的值 
	 * @param userid 
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}
	/**
	 * <b>Summary: </b>
	 *     获取orgid的值
	 * @return orgid 
	 */
	public String getOrgid() {
		return orgid;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 orgid 的值 
	 * @param orgid 
	 */
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	/**
	 * <b>Summary: </b>
	 *     获取orgname的值
	 * @return orgname 
	 */
	public String getOrgname() {
		return orgname;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 orgname 的值 
	 * @param orgname 
	 */
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	/**
	 * <b>Summary: </b>
	 *     获取cdcount的值
	 * @return cdcount 
	 */
	public String getCdcount() {
		return cdcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 cdcount 的值 
	 * @param cdcount 
	 */
	public void setCdcount(String cdcount) {
		this.cdcount = cdcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取ztcount的值
	 * @return ztcount 
	 */
	public String getZtcount() {
		return ztcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 ztcount 的值 
	 * @param ztcount 
	 */
	public void setZtcount(String ztcount) {
		this.ztcount = ztcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取kgcount的值
	 * @return kgcount 
	 */
	public String getKgcount() {
		return kgcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 kgcount 的值 
	 * @param kgcount 
	 */
	public void setKgcount(String kgcount) {
		this.kgcount = kgcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取cdztcount的值
	 * @return cdztcount 
	 */
	public String getCdztcount() {
		return cdztcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 cdztcount 的值 
	 * @param cdztcount 
	 */
	public void setCdztcount(String cdztcount) {
		this.cdztcount = cdztcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取wqcount的值
	 * @return wqcount 
	 */
	public String getWqcount() {
		return wqcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 wqcount 的值 
	 * @param wqcount 
	 */
	public void setWqcount(String wqcount) {
		this.wqcount = wqcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取qjcount的值
	 * @return qjcount 
	 */
	public String getQjcount() {
		return qjcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 qjcount 的值 
	 * @param qjcount 
	 */
	public void setQjcount(String qjcount) {
		this.qjcount = qjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取zccount的值
	 * @return zccount 
	 */
	public String getZccount() {
		return zccount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 zccount 的值 
	 * @param zccount 
	 */
	public void setZccount(String zccount) {
		this.zccount = zccount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取sjcount的值
	 * @return sjcount 
	 */
	public String getSjcount() {
		return sjcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 sjcount 的值 
	 * @param sjcount 
	 */
	public void setSjcount(String sjcount) {
		this.sjcount = sjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取nxjcount的值
	 * @return nxjcount 
	 */
	public String getNxjcount() {
		return nxjcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 nxjcount 的值 
	 * @param nxjcount 
	 */
	public void setNxjcount(String nxjcount) {
		this.nxjcount = nxjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取xxpxjcount的值
	 * @return xxpxjcount 
	 */
	public String getXxpxjcount() {
		return xxpxjcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 xxpxjcount 的值 
	 * @param xxpxjcount 
	 */
	public void setXxpxjcount(String xxpxjcount) {
		this.xxpxjcount = xxpxjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取gcjcount的值
	 * @return gcjcount 
	 */
	public String getGcjcount() {
		return gcjcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 gcjcount 的值 
	 * @param gcjcount 
	 */
	public void setGcjcount(String gcjcount) {
		this.gcjcount = gcjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取bsjcount的值
	 * @return bsjcount 
	 */
	public String getBsjcount() {
		return bsjcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 bsjcount 的值 
	 * @param bsjcount 
	 */
	public void setBsjcount(String bsjcount) {
		this.bsjcount = bsjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取cjcount的值
	 * @return cjcount 
	 */
	public String getCjcount() {
		return cjcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 cjcount 的值 
	 * @param cjcount 
	 */
	public void setCjcount(String cjcount) {
		this.cjcount = cjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取gsjcount的值
	 * @return gsjcount 
	 */
	public String getGsjcount() {
		return gsjcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 gsjcount 的值 
	 * @param gsjcount 
	 */
	public void setGsjcount(String gsjcount) {
		this.gsjcount = gsjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取hjcount的值
	 * @return hjcount 
	 */
	public String getHjcount() {
		return hjcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 hjcount 的值 
	 * @param hjcount 
	 */
	public void setHjcount(String hjcount) {
		this.hjcount = hjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取jhsyjcount的值
	 * @return jhsyjcount 
	 */
	public String getJhsyjcount() {
		return jhsyjcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 jhsyjcount 的值 
	 * @param jhsyjcount 
	 */
	public void setJhsyjcount(String jhsyjcount) {
		this.jhsyjcount = jhsyjcount;
	}
	/**
	 * <b>Summary: </b>
	 *     获取sajcount的值
	 * @return sajcount 
	 */
	public String getSajcount() {
		return sajcount;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 sajcount 的值 
	 * @param sajcount 
	 */
	public void setSajcount(String sajcount) {
		this.sajcount = sajcount;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getUnit_id() {
		return unit_id;
	}
	public void setUnit_id(String unit_id) {
		this.unit_id = unit_id;
	}
	
}
