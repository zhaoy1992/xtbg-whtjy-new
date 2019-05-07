
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevEquipmentaccBean.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-20   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:DevEquipmentaccBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-20
 */
public class DevEquipmentaccBean extends XtDbBaseBean{

	
	  /** 
	  * <b>Summary: </b>
	  *     构造一个 DevEquipmentaccBean  
	   * <b>Remarks: </b>
	  *     构造类 DevEquipmentaccBean 的构造函数 DevEquipmentaccBean
	  * @param tableName 
	  */
	public DevEquipmentaccBean() {
		super("ta_oa_devequipmentacc", "t_id");
	}
	
	private String t_id;		//主键
	private String t_title;		//标题
	private String t_sbname;		//设备名称
	private String t_ggno;		//规格型号
	private String t_factory;		//生产厂
	private String t_ccno;		//出厂编号
	private Object t_dhdate;		//到货日期
	private String t_wg;		//外观
	private String t_hgzorzzs;		//合格证或质证书
	private String t_sbqd;		//设备清单或项目明细
	private String t_sbsysms;		//设备使用说明书
	private String t_sbazsms;		//设备安装说明书
	private String t_cphgz;		//产品合格证
	private String t_zlsms;		//质量证明书
	private String t_jdcsba;		//检定、测试报告
	private String t_pzorfj;		//配件或辅件
	private String t_yhtyq;		//与合同要求
	private String t_other;		//其他
	private String t_aztsqk;		//安装调试或试用情况
	private String t_ysjl;		//验收结论
	private String t_gfysr;		//供方验收人
	private Object t_gfysr_date;		//供方验收人签字时间
	private String t_byysr_yj;		//本院验收人员意见
	private String t_sbzrgcs_yj;		//设备责任工程师意见
	private String t_fyjsfzr_yj;		//分院技术负责人意见
	private String t_sb_id;		//设备id
	private String item_id;		//申请明细表ID
	private String t_sl;		//数量
	/**
	*<b>Summary: 获取主键</b>
	*/
	public String getT_id() {
		return t_id;
	}
	/**
	*<b>Summary: 设置主键</b>
	*/
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	/**
	*<b>Summary: 获取标题</b>
	*/
	public String getT_title() {
		return t_title;
	}
	/**
	*<b>Summary: 设置标题</b>
	*/
	public void setT_title(String t_title) {
		this.t_title = t_title;
	}
	/**
	*<b>Summary: 获取设备名称</b>
	*/
	public String getT_sbname() {
		return t_sbname;
	}
	/**
	*<b>Summary: 设置设备名称</b>
	*/
	public void setT_sbname(String t_sbname) {
		this.t_sbname = t_sbname;
	}
	/**
	*<b>Summary: 获取规格型号</b>
	*/
	public String getT_ggno() {
		return t_ggno;
	}
	/**
	*<b>Summary: 设置规格型号</b>
	*/
	public void setT_ggno(String t_ggno) {
		this.t_ggno = t_ggno;
	}
	/**
	*<b>Summary: 获取生产厂</b>
	*/
	public String getT_factory() {
		return t_factory;
	}
	/**
	*<b>Summary: 设置生产厂</b>
	*/
	public void setT_factory(String t_factory) {
		this.t_factory = t_factory;
	}
	/**
	*<b>Summary: 获取出厂编号</b>
	*/
	public String getT_ccno() {
		return t_ccno;
	}
	/**
	*<b>Summary: 设置出厂编号</b>
	*/
	public void setT_ccno(String t_ccno) {
		this.t_ccno = t_ccno;
	}
	/**
	*<b>Summary: 获取到货日期</b>
	*/
	public Object getT_dhdate() {
		return t_dhdate;
	}
	/**
	*<b>Summary: 设置到货日期</b>
	*/
	public void setT_dhdate(Object t_dhdate) {
		this.t_dhdate = t_dhdate;
	}
	/**
	*<b>Summary: 获取外观</b>
	*/
	public String getT_wg() {
		return t_wg;
	}
	/**
	*<b>Summary: 设置外观</b>
	*/
	public void setT_wg(String t_wg) {
		this.t_wg = t_wg;
	}
	/**
	*<b>Summary: 获取合格证或质证书</b>
	*/
	public String getT_hgzorzzs() {
		return t_hgzorzzs;
	}
	/**
	*<b>Summary: 设置合格证或质证书</b>
	*/
	public void setT_hgzorzzs(String t_hgzorzzs) {
		this.t_hgzorzzs = t_hgzorzzs;
	}
	/**
	*<b>Summary: 获取设备清单或项目明细</b>
	*/
	public String getT_sbqd() {
		return t_sbqd;
	}
	/**
	*<b>Summary: 设置设备清单或项目明细</b>
	*/
	public void setT_sbqd(String t_sbqd) {
		this.t_sbqd = t_sbqd;
	}
	/**
	*<b>Summary: 获取设备使用说明书</b>
	*/
	public String getT_sbsysms() {
		return t_sbsysms;
	}
	/**
	*<b>Summary: 设置设备使用说明书</b>
	*/
	public void setT_sbsysms(String t_sbsysms) {
		this.t_sbsysms = t_sbsysms;
	}
	/**
	*<b>Summary: 获取设备安装说明书</b>
	*/
	public String getT_sbazsms() {
		return t_sbazsms;
	}
	/**
	*<b>Summary: 设置设备安装说明书</b>
	*/
	public void setT_sbazsms(String t_sbazsms) {
		this.t_sbazsms = t_sbazsms;
	}
	/**
	*<b>Summary: 获取产品合格证</b>
	*/
	public String getT_cphgz() {
		return t_cphgz;
	}
	/**
	*<b>Summary: 设置产品合格证</b>
	*/
	public void setT_cphgz(String t_cphgz) {
		this.t_cphgz = t_cphgz;
	}
	/**
	*<b>Summary: 获取质量证明书</b>
	*/
	public String getT_zlsms() {
		return t_zlsms;
	}
	/**
	*<b>Summary: 设置质量证明书</b>
	*/
	public void setT_zlsms(String t_zlsms) {
		this.t_zlsms = t_zlsms;
	}
	/**
	*<b>Summary: 获取检定、测试报告</b>
	*/
	public String getT_jdcsba() {
		return t_jdcsba;
	}
	/**
	*<b>Summary: 设置检定、测试报告</b>
	*/
	public void setT_jdcsba(String t_jdcsba) {
		this.t_jdcsba = t_jdcsba;
	}
	/**
	*<b>Summary: 获取配件或辅件</b>
	*/
	public String getT_pzorfj() {
		return t_pzorfj;
	}
	/**
	*<b>Summary: 设置配件或辅件</b>
	*/
	public void setT_pzorfj(String t_pzorfj) {
		this.t_pzorfj = t_pzorfj;
	}
	/**
	*<b>Summary: 获取与合同要求</b>
	*/
	public String getT_yhtyq() {
		return t_yhtyq;
	}
	/**
	*<b>Summary: 设置与合同要求</b>
	*/
	public void setT_yhtyq(String t_yhtyq) {
		this.t_yhtyq = t_yhtyq;
	}
	/**
	*<b>Summary: 获取其他</b>
	*/
	public String getT_other() {
		return t_other;
	}
	/**
	*<b>Summary: 设置其他</b>
	*/
	public void setT_other(String t_other) {
		this.t_other = t_other;
	}
	/**
	*<b>Summary: 获取安装调试或试用情况</b>
	*/
	public String getT_aztsqk() {
		return t_aztsqk;
	}
	/**
	*<b>Summary: 设置安装调试或试用情况</b>
	*/
	public void setT_aztsqk(String t_aztsqk) {
		this.t_aztsqk = t_aztsqk;
	}
	/**
	*<b>Summary: 获取验收结论</b>
	*/
	public String getT_ysjl() {
		return t_ysjl;
	}
	/**
	*<b>Summary: 设置验收结论</b>
	*/
	public void setT_ysjl(String t_ysjl) {
		this.t_ysjl = t_ysjl;
	}
	/**
	*<b>Summary: 获取供方验收人</b>
	*/
	public String getT_gfysr() {
		return t_gfysr;
	}
	/**
	*<b>Summary: 设置供方验收人</b>
	*/
	public void setT_gfysr(String t_gfysr) {
		this.t_gfysr = t_gfysr;
	}
	/**
	*<b>Summary: 获取供方验收人签字时间</b>
	*/
	public Object getT_gfysr_date() {
		return t_gfysr_date;
	}
	/**
	*<b>Summary: 设置供方验收人签字时间</b>
	*/
	public void setT_gfysr_date(Object t_gfysr_date) {
		this.t_gfysr_date = t_gfysr_date;
	}
	/**
	*<b>Summary: 获取本院验收人员意见</b>
	*/
	public String getT_byysr_yj() {
		return t_byysr_yj;
	}
	/**
	*<b>Summary: 设置本院验收人员意见</b>
	*/
	public void setT_byysr_yj(String t_byysr_yj) {
		this.t_byysr_yj = t_byysr_yj;
	}
	/**
	*<b>Summary: 获取设备责任工程师意见</b>
	*/
	public String getT_sbzrgcs_yj() {
		return t_sbzrgcs_yj;
	}
	/**
	*<b>Summary: 设置设备责任工程师意见</b>
	*/
	public void setT_sbzrgcs_yj(String t_sbzrgcs_yj) {
		this.t_sbzrgcs_yj = t_sbzrgcs_yj;
	}
	/**
	*<b>Summary: 获取分院技术负责人意见</b>
	*/
	public String getT_fyjsfzr_yj() {
		return t_fyjsfzr_yj;
	}
	/**
	*<b>Summary: 设置分院技术负责人意见</b>
	*/
	public void setT_fyjsfzr_yj(String t_fyjsfzr_yj) {
		this.t_fyjsfzr_yj = t_fyjsfzr_yj;
	}
	/**
	*<b>Summary: 获取设备id</b>
	*/
	public String getT_sb_id() {
		return t_sb_id;
	}
	/**
	*<b>Summary: 设置设备id</b>
	*/
	public void setT_sb_id(String t_sb_id) {
		this.t_sb_id = t_sb_id;
	}
	/**
	*<b>Summary: 获取申请明细表ID</b>
	*/
	public String getItem_id() {
		return item_id;
	}
	/**
	*<b>Summary: 设置申请明细表ID</b>
	*/
	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}
	/**
	*<b>Summary: 获取数量</b>
	*/
	public String getT_sl() {
		return t_sl;
	}
	/**
	*<b>Summary: 设置数量</b>
	*/
	public void setT_sl(String t_sl) {
		this.t_sl = t_sl;
	}

}
