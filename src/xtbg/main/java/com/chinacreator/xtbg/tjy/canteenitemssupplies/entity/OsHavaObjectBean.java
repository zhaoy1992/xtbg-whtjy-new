package com.chinacreator.xtbg.tjy.canteenitemssupplies.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:OsHavaObjectBean.java</p>
 *<p>Description:物品库存表数据Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-9
 */
public class OsHavaObjectBean extends XtDbBaseBean {

	
	public OsHavaObjectBean(){
		super("TA_OA_CANHAVA_OBJECT", "t_ha_id");
	}
	
	private String t_ha_id;		//主键ID
	private String oftype_id;		//物品类型ID
	private String oftype_name;		//物品类型NAME
	private String ofustype_id;		//物品ID
	private String ofustype_name;		//物品NAME
	private String it_id;		//物品规格ID
	private String it_name;		//物品规格NAME
	private String t_ha_sbno;		//设备编号
	private String t_ha_buydate;		//购买日期
	private String t_ha_ghman;		//供货厂商
	private String t_ha_overtel;		//售后电话
	private String t_ha_dj;		//单价
	private String t_ha_no;		//数量
	private String t_ha_sbstate;		//状态
	private String t_ha_ghuser;		//供货人
	private String t_ha_bz;		//备注
	private String t_ha_rkuser_id;		//入库人ID
	private String t_ha_rkuser_name;		//入库人NAME
	private String t_ha_org_id;             //物品所属部门ID 
	private String t_ha_org_name;           //物品所属部门名称
	private String t_ha_iswhat;        //哪个入口  固定资产还是易耗品
	private String startSlTime;        //入库起始时间   （用于搜索）
	private String endSlTime;          //入库截止时间  （用于搜索）
	private String zs;    //固定资产总数
	private String zk;    //固定资产在库个数
	private String bf;    //固定资产报废个数
	private String ly;    //固定资产领用个数
	private String zx;    //固定资产在修个数
	private String amidAct;//在库的且没有关联任何在办流程的物品
	private String unit_id;           //所属单位ID
	private String unit_name;           //所属单位名称
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getT_ha_id() {
		return t_ha_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setT_ha_id(String t_ha_id) {
		this.t_ha_id = t_ha_id;
	}
	/**
	*<b>Summary: 获取物品类型ID</b>
	*/
	public String getOftype_id() {
		return oftype_id;
	}
	/**
	*<b>Summary: 设置物品类型ID</b>
	*/
	public void setOftype_id(String oftype_id) {
		this.oftype_id = oftype_id;
	}
	/**
	*<b>Summary: 获取物品类型NAME</b>
	*/
	public String getOftype_name() {
		return oftype_name;
	}
	/**
	*<b>Summary: 设置物品类型NAME</b>
	*/
	public void setOftype_name(String oftype_name) {
		this.oftype_name = oftype_name;
	}
	/**
	*<b>Summary: 获取物品ID</b>
	*/
	public String getOfustype_id() {
		return ofustype_id;
	}
	/**
	*<b>Summary: 设置物品ID</b>
	*/
	public void setOfustype_id(String ofustype_id) {
		this.ofustype_id = ofustype_id;
	}
	/**
	*<b>Summary: 获取物品NAME</b>
	*/
	public String getOfustype_name() {
		return ofustype_name;
	}
	/**
	*<b>Summary: 设置物品NAME</b>
	*/
	public void setOfustype_name(String ofustype_name) {
		this.ofustype_name = ofustype_name;
	}
	/**
	*<b>Summary: 获取物品规格ID</b>
	*/
	public String getIt_id() {
		return it_id;
	}
	/**
	*<b>Summary: 设置物品规格ID</b>
	*/
	public void setIt_id(String it_id) {
		this.it_id = it_id;
	}
	/**
	*<b>Summary: 获取物品规格NAME</b>
	*/
	public String getIt_name() {
		return it_name;
	}
	/**
	*<b>Summary: 设置物品规格NAME</b>
	*/
	public void setIt_name(String it_name) {
		this.it_name = it_name;
	}
	/**
	*<b>Summary: 获取设备编号</b>
	*/
	public String getT_ha_sbno() {
		return t_ha_sbno;
	}
	/**
	*<b>Summary: 设置设备编号</b>
	*/
	public void setT_ha_sbno(String t_ha_sbno) {
		this.t_ha_sbno = t_ha_sbno;
	}
	/**
	*<b>Summary: 获取购买日期</b>
	*/
	public String getT_ha_buydate() {
		return t_ha_buydate;
	}
	/**
	*<b>Summary: 设置购买日期</b>
	*/
	public void setT_ha_buydate(String t_ha_buydate) {
		this.t_ha_buydate = t_ha_buydate;
	}
	/**
	*<b>Summary: 获取供货厂商</b>
	*/
	public String getT_ha_ghman() {
		return t_ha_ghman;
	}
	/**
	*<b>Summary: 设置供货厂商</b>
	*/
	public void setT_ha_ghman(String t_ha_ghman) {
		this.t_ha_ghman = t_ha_ghman;
	}
	/**
	*<b>Summary: 获取售后电话</b>
	*/
	public String getT_ha_overtel() {
		return t_ha_overtel;
	}
	/**
	*<b>Summary: 设置售后电话</b>
	*/
	public void setT_ha_overtel(String t_ha_overtel) {
		this.t_ha_overtel = t_ha_overtel;
	}
	/**
	*<b>Summary: 获取单价</b>
	*/
	public String getT_ha_dj() {
		return t_ha_dj;
	}
	/**
	*<b>Summary: 设置单价</b>
	*/
	public void setT_ha_dj(String t_ha_dj) {
		this.t_ha_dj = t_ha_dj;
	}
	/**
	*<b>Summary: 获取数量</b>
	*/
	public String getT_ha_no() {
		return t_ha_no;
	}
	/**
	*<b>Summary: 设置数量</b>
	*/
	public void setT_ha_no(String t_ha_no) {
		this.t_ha_no = t_ha_no;
	}
	/**
	*<b>Summary: 获取状态</b>
	*/
	public String getT_ha_sbstate() {
		return t_ha_sbstate;
	}
	/**
	*<b>Summary: 设置状态</b>
	*/
	public void setT_ha_sbstate(String t_ha_sbstate) {
		this.t_ha_sbstate = t_ha_sbstate;
	}
	/**
	*<b>Summary: 获取供货人</b>
	*/
	public String getT_ha_ghuser() {
		return t_ha_ghuser;
	}
	/**
	*<b>Summary: 设置供货人</b>
	*/
	public void setT_ha_ghuser(String t_ha_ghuser) {
		this.t_ha_ghuser = t_ha_ghuser;
	}
	/**
	*<b>Summary: 获取备注</b>
	*/
	public String getT_ha_bz() {
		return t_ha_bz;
	}
	/**
	*<b>Summary: 设置备注</b>
	*/
	public void setT_ha_bz(String t_ha_bz) {
		this.t_ha_bz = t_ha_bz;
	}
	/**
	*<b>Summary: 获取入库人ID</b>
	*/
	public String getT_ha_rkuser_id() {
		return t_ha_rkuser_id;
	}
	/**
	*<b>Summary: 设置入库人ID</b>
	*/
	public void setT_ha_rkuser_id(String t_ha_rkuser_id) {
		this.t_ha_rkuser_id = t_ha_rkuser_id;
	}
	/**
	*<b>Summary: 获取入库人NAME</b>
	*/
	public String getT_ha_rkuser_name() {
		return t_ha_rkuser_name;
	}
	/**
	*<b>Summary: 设置入库人NAME</b>
	*/
	public void setT_ha_rkuser_name(String t_ha_rkuser_name) {
		this.t_ha_rkuser_name = t_ha_rkuser_name;
	}
	public String getT_ha_iswhat() {
		return t_ha_iswhat;
	}
	public void setT_ha_iswhat(String t_ha_iswhat) {
		this.t_ha_iswhat = t_ha_iswhat;
	}
	public String getStartSlTime() {
		return startSlTime;
	}
	public void setStartSlTime(String startSlTime) {
		this.startSlTime = startSlTime;
	}
	public String getEndSlTime() {
		return endSlTime;
	}
	public void setEndSlTime(String endSlTime) {
		this.endSlTime = endSlTime;
	}
	public String getZs() {
		return zs;
	}
	public void setZs(String zs) {
		this.zs = zs;
	}
	public String getZk() {
		return zk;
	}
	public void setZk(String zk) {
		this.zk = zk;
	}
	public String getBf() {
		return bf;
	}
	public void setBf(String bf) {
		this.bf = bf;
	}
	public String getLy() {
		return ly;
	}
	public void setLy(String ly) {
		this.ly = ly;
	}
	public String getZx() {
		return zx;
	}
	public void setZx(String zx) {
		this.zx = zx;
	}
	public String getT_ha_org_id() {
		return t_ha_org_id;
	}
	public void setT_ha_org_id(String t_ha_org_id) {
		this.t_ha_org_id = t_ha_org_id;
	}
	public String getT_ha_org_name() {
		return t_ha_org_name;
	}
	public void setT_ha_org_name(String t_ha_org_name) {
		this.t_ha_org_name = t_ha_org_name;
	}
	public String getAmidAct() {
		return amidAct;
	}
	public void setAmidAct(String amidAct) {
		this.amidAct = amidAct;
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
