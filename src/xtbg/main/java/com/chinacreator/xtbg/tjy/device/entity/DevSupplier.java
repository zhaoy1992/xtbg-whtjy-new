
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevSupplier.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-27   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:DevSupplier.java</p>
 *<p>Description:供应商名录实体bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-27
 */
public class DevSupplier extends XtDbBaseBean{

	  /** 
	  * <b>Summary: </b>
	  *     构造一个 DevSupplier  
	   * <b>Remarks: </b>
	  *     构造类 DevSupplier 的构造函数 DevSupplier
	  * @param tableName 
	  */
	public DevSupplier() {
		super("ta_oa_devsupplier", "devsup_id");
	}
	
	private String devsup_id;		//主键ID
	private String devsup_mc;		//供应商名称
	private Object devsup_slsj;		//收录时间
	private String devsup_gfxz;		//供方性质
	private String devsup_gflb;		//供方类别
	private String devsup_gfdz;		//供方地址
	private String devsup_fddbr;	//法定代表人
	private String devsup_lxdb;		//联系代表
	private String devsup_lxdh;		//联系电话
	private String devsup_xyd;		//信誉度
	private String devsup_sfyx;		//是否有效
	private String devsup_tgcp;		//提供产品
	
	private String devsup_Sslsj;	//收录开始时间
	private String devsup_Eslsj;	//收录结束时间
	
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getDevsup_id() {
		return devsup_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setDevsup_id(String devsup_id) {
		this.devsup_id = devsup_id;
	}
	/**
	*<b>Summary: 获取供应商名称</b>
	*/
	public String getDevsup_mc() {
		return devsup_mc;
	}
	/**
	*<b>Summary: 设置供应商名称</b>
	*/
	public void setDevsup_mc(String devsup_mc) {
		this.devsup_mc = devsup_mc;
	}
	/**
	*<b>Summary: 获取收录时间</b>
	*/
	public Object getDevsup_slsj() {
		return devsup_slsj;
	}
	/**
	*<b>Summary: 设置收录时间</b>
	*/
	public void setDevsup_slsj(Object devsup_slsj) {
		this.devsup_slsj = devsup_slsj;
	}
	/**
	*<b>Summary: 获取供方性质</b>
	*/
	public String getDevsup_gfxz() {
		return devsup_gfxz;
	}
	/**
	*<b>Summary: 设置供方性质</b>
	*/
	public void setDevsup_gfxz(String devsup_gfxz) {
		this.devsup_gfxz = devsup_gfxz;
	}
	/**
	*<b>Summary: 获取供方类别</b>
	*/
	public String getDevsup_gflb() {
		return devsup_gflb;
	}
	/**
	*<b>Summary: 设置供方类别</b>
	*/
	public void setDevsup_gflb(String devsup_gflb) {
		this.devsup_gflb = devsup_gflb;
	}
	/**
	*<b>Summary: 获取供方地址</b>
	*/
	public String getDevsup_gfdz() {
		return devsup_gfdz;
	}
	/**
	*<b>Summary: 设置供方地址</b>
	*/
	public void setDevsup_gfdz(String devsup_gfdz) {
		this.devsup_gfdz = devsup_gfdz;
	}
	/**
	*<b>Summary: 获取法定代表人</b>
	*/
	public String getDevsup_fddbr() {
		return devsup_fddbr;
	}
	/**
	*<b>Summary: 设置法定代表人</b>
	*/
	public void setDevsup_fddbr(String devsup_fddbr) {
		this.devsup_fddbr = devsup_fddbr;
	}
	/**
	*<b>Summary: 获取联系代表</b>
	*/
	public String getDevsup_lxdb() {
		return devsup_lxdb;
	}
	/**
	*<b>Summary: 设置联系代表</b>
	*/
	public void setDevsup_lxdb(String devsup_lxdb) {
		this.devsup_lxdb = devsup_lxdb;
	}
	/**
	*<b>Summary: 获取联系电话</b>
	*/
	public String getDevsup_lxdh() {
		return devsup_lxdh;
	}
	/**
	*<b>Summary: 设置联系电话</b>
	*/
	public void setDevsup_lxdh(String devsup_lxdh) {
		this.devsup_lxdh = devsup_lxdh;
	}
	/**
	*<b>Summary: 获取信誉度</b>
	*/
	public String getDevsup_xyd() {
		return devsup_xyd;
	}
	/**
	*<b>Summary: 设置信誉度</b>
	*/
	public void setDevsup_xyd(String devsup_xyd) {
		this.devsup_xyd = devsup_xyd;
	}
	/**
	*<b>Summary: 获取是否有效</b>
	*/
	public String getDevsup_sfyx() {
		return devsup_sfyx;
	}
	/**
	*<b>Summary: 设置是否有效</b>
	*/
	public void setDevsup_sfyx(String devsup_sfyx) {
		this.devsup_sfyx = devsup_sfyx;
	}
	/**
	*<b>Summary: 获取提供产品</b>
	*/
	public String getDevsup_tgcp() {
		return devsup_tgcp;
	}
	/**
	*<b>Summary: 设置提供产品</b>
	*/
	public void setDevsup_tgcp(String devsup_tgcp) {
		this.devsup_tgcp = devsup_tgcp;
	}
	public String getDevsup_Sslsj() {
		return devsup_Sslsj;
	}
	public void setDevsup_Sslsj(String devsup_Sslsj) {
		this.devsup_Sslsj = devsup_Sslsj;
	}
	public String getDevsup_Eslsj() {
		return devsup_Eslsj;
	}
	public void setDevsup_Eslsj(String devsup_Eslsj) {
		this.devsup_Eslsj = devsup_Eslsj;
	}
	
}
