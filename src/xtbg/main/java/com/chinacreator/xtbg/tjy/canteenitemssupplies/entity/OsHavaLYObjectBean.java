package com.chinacreator.xtbg.tjy.canteenitemssupplies.entity;


import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:OsHavaLYObjectBean.java</p>
 *<p>Description:物品领用信息数据bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-12
 */
public class OsHavaLYObjectBean extends XtDbBaseBean {
	
	public OsHavaLYObjectBean(){
		super("TA_OA_CANLINGYONG_OBJECT", "t_nomove_ob_id");
	}
	
	private String t_ly_id;		//主键ID
	private String oftype_id;		//物品类型ID
	private String oftype_name;		//物品类型NAME
	private String ofustype_id;		//物品ID
	private String ofustype_name;		//物品NAME
	private String it_id;		//物品规格ID
	private String it_name;		//物品规格NAME
	private String t_ha_sbno;		//设备编号
	private String t_ly_date;		//领用日期
	private String t_ly_no;		//数量
	private String t_ly_org_id;		//领用部门ID
	private String t_ly_org_name;		//领用部门NAME
	private String t_ly_user_id;		//领用人ID
	private String t_ly_user_name;		//领用人NAME
	private String t_lydj_id;		//相关领用表ID
	private String t_ha_id;		//物品库存ID
	
	private String t_ha_iswhat;  //固定资产还是易耗品
	
	private String sumNo;	//易耗品数量查询总和
	private String start_time;//物品发放查询用  开始时间
	private String end_time;//物品发放查询用  结束时间
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getT_ly_id() {
		return t_ly_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setT_ly_id(String t_ly_id) {
		this.t_ly_id = t_ly_id;
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
	*<b>Summary: 获取领用日期</b>
	*/
	public String getT_ly_date() {
		return t_ly_date;
	}
	/**
	*<b>Summary: 设置领用日期</b>
	*/
	public void setT_ly_date(String t_ly_date) {
		this.t_ly_date = t_ly_date;
	}
	/**
	*<b>Summary: 获取数量</b>
	*/
	public String getT_ly_no() {
		return t_ly_no;
	}
	/**
	*<b>Summary: 设置数量</b>
	*/
	public void setT_ly_no(String t_ly_no) {
		this.t_ly_no = t_ly_no;
	}
	/**
	*<b>Summary: 获取领用部门ID</b>
	*/
	public String getT_ly_org_id() {
		return t_ly_org_id;
	}
	/**
	*<b>Summary: 设置领用部门ID</b>
	*/
	public void setT_ly_org_id(String t_ly_org_id) {
		this.t_ly_org_id = t_ly_org_id;
	}
	/**
	*<b>Summary: 获取领用部门NAME</b>
	*/
	public String getT_ly_org_name() {
		return t_ly_org_name;
	}
	/**
	*<b>Summary: 设置领用部门NAME</b>
	*/
	public void setT_ly_org_name(String t_ly_org_name) {
		this.t_ly_org_name = t_ly_org_name;
	}
	/**
	*<b>Summary: 获取领用人ID</b>
	*/
	public String getT_ly_user_id() {
		return t_ly_user_id;
	}
	/**
	*<b>Summary: 设置领用人ID</b>
	*/
	public void setT_ly_user_id(String t_ly_user_id) {
		this.t_ly_user_id = t_ly_user_id;
	}
	/**
	*<b>Summary: 获取领用人NAME</b>
	*/
	public String getT_ly_user_name() {
		return t_ly_user_name;
	}
	/**
	*<b>Summary: 设置领用人NAME</b>
	*/
	public void setT_ly_user_name(String t_ly_user_name) {
		this.t_ly_user_name = t_ly_user_name;
	}
	/**
	*<b>Summary: 获取相关领用表ID</b>
	*/
	public String getT_lydj_id() {
		return t_lydj_id;
	}
	/**
	*<b>Summary: 设置相关领用表ID</b>
	*/
	public void setT_lydj_id(String t_lydj_id) {
		this.t_lydj_id = t_lydj_id;
	}
	/**
	*<b>Summary: 获取物品库存ID</b>
	*/
	public String getT_ha_id() {
		return t_ha_id;
	}
	/**
	*<b>Summary: 设置物品库存ID</b>
	*/
	public void setT_ha_id(String t_ha_id) {
		this.t_ha_id = t_ha_id;
	}
	public String getT_ha_iswhat() {
		return t_ha_iswhat;
	}
	public void setT_ha_iswhat(String t_ha_iswhat) {
		this.t_ha_iswhat = t_ha_iswhat;
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
	 *     获取sumNo的值
	 * @return sumNo 
	 */
	public String getSumNo() {
		return sumNo;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 sumNo 的值 
	 * @param sumNo 
	 */
	public void setSumNo(String sumNo) {
		this.sumNo = sumNo;
	}
}
