package com.chinacreator.xtbg.caizhengting.ibrary.entity;

/**
 * 
 *<p>Title:IBraryRegBookInfoBean.java</p>
 *<p>Description:图书借阅申请表信息bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-20
 */
public class IBraryRegBookInfoBean {
	
	private String t_regb_id;		//主键ID
	private String t_regb_user_id;		//申请人ID
	private String t_regb_user_name;		//申请人名称
	private String t_regb_date;		//申请时间
	private String t_regb_bookids;		//申请图书IDS
	private String t_regb_org_id;		//申请所属部门ID
	private String t_regb_org_name;		//申请所属部门名称
	private String t_regb_dept_id;		//申请所属单位ID
	private String t_regb_dept_name;		//申请所属单位名称
	private String t_regb_state;		//申请状态
	private String t_regb_gh_date;		//应归还时间
	private String t_regb_booknames;		//申请图书NAMES
	private String t_regb_iskonw;		//是否知悉
	private String t_regb_jy_date;		//借阅时间
	private String t_regb_truegh_date;		//实际归还时间
	private String t_regb_isxj;		//是否续借
	private String t_regb_auditopinion;//审核意见
	
	private String whatTabs;       //哪个tab页的数据列表(用于列表查询)  1待借阅      2  已借阅              3 已超期
	
	private String sq_start_time;   //申请开始时间  （用于查询）
	private String sq_end_time;     //申请结束时间  （用于查询）
	private String jy_start_time;   //借阅开始时间  （用于查询）
	private String jy_end_time;     //借阅结束时间  （用于查询）
	private String t_regb_sqtype; //申请类型
	
	
	public String getT_regb_sqtype() {
		return t_regb_sqtype;
	}
	public void setT_regb_sqtype(String t_regb_sqtype) {
		this.t_regb_sqtype = t_regb_sqtype;
	}
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getT_regb_id() {
		return t_regb_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setT_regb_id(String t_regb_id) {
		this.t_regb_id = t_regb_id;
	}
	/**
	*<b>Summary: 获取申请人ID</b>
	*/
	public String getT_regb_user_id() {
		return t_regb_user_id;
	}
	/**
	*<b>Summary: 设置申请人ID</b>
	*/
	public void setT_regb_user_id(String t_regb_user_id) {
		this.t_regb_user_id = t_regb_user_id;
	}
	/**
	*<b>Summary: 获取申请人名称</b>
	*/
	public String getT_regb_user_name() {
		return t_regb_user_name;
	}
	/**
	*<b>Summary: 设置申请人名称</b>
	*/
	public void setT_regb_user_name(String t_regb_user_name) {
		this.t_regb_user_name = t_regb_user_name;
	}
	/**
	*<b>Summary: 获取申请时间</b>
	*/
	public String getT_regb_date() {
		return t_regb_date;
	}
	/**
	*<b>Summary: 设置申请时间</b>
	*/
	public void setT_regb_date(String t_regb_date) {
		this.t_regb_date = t_regb_date;
	}
	/**
	*<b>Summary: 获取申请图书IDS</b>
	*/
	public String getT_regb_bookids() {
		return t_regb_bookids;
	}
	/**
	*<b>Summary: 设置申请图书IDS</b>
	*/
	public void setT_regb_bookids(String t_regb_bookids) {
		this.t_regb_bookids = t_regb_bookids;
	}
	/**
	*<b>Summary: 获取申请所属部门ID</b>
	*/
	public String getT_regb_org_id() {
		return t_regb_org_id;
	}
	/**
	*<b>Summary: 设置申请所属部门ID</b>
	*/
	public void setT_regb_org_id(String t_regb_org_id) {
		this.t_regb_org_id = t_regb_org_id;
	}
	/**
	*<b>Summary: 获取申请所属部门名称</b>
	*/
	public String getT_regb_org_name() {
		return t_regb_org_name;
	}
	/**
	*<b>Summary: 设置申请所属部门名称</b>
	*/
	public void setT_regb_org_name(String t_regb_org_name) {
		this.t_regb_org_name = t_regb_org_name;
	}
	/**
	*<b>Summary: 获取申请所属单位ID</b>
	*/
	public String getT_regb_dept_id() {
		return t_regb_dept_id;
	}
	/**
	*<b>Summary: 设置申请所属单位ID</b>
	*/
	public void setT_regb_dept_id(String t_regb_dept_id) {
		this.t_regb_dept_id = t_regb_dept_id;
	}
	/**
	*<b>Summary: 获取申请所属单位名称</b>
	*/
	public String getT_regb_dept_name() {
		return t_regb_dept_name;
	}
	/**
	*<b>Summary: 设置申请所属单位名称</b>
	*/
	public void setT_regb_dept_name(String t_regb_dept_name) {
		this.t_regb_dept_name = t_regb_dept_name;
	}
	/**
	*<b>Summary: 获取申请状态</b>
	*/
	public String getT_regb_state() {
		return t_regb_state;
	}
	/**
	*<b>Summary: 设置申请状态</b>
	*/
	public void setT_regb_state(String t_regb_state) {
		this.t_regb_state = t_regb_state;
	}
	/**
	*<b>Summary: 获取应归还时间</b>
	*/
	public String getT_regb_gh_date() {
		return t_regb_gh_date;
	}
	/**
	*<b>Summary: 设置应归还时间</b>
	*/
	public void setT_regb_gh_date(String t_regb_gh_date) {
		this.t_regb_gh_date = t_regb_gh_date;
	}
	/**
	*<b>Summary: 获取申请图书NAMES</b>
	*/
	public String getT_regb_booknames() {
		return t_regb_booknames;
	}
	/**
	*<b>Summary: 设置申请图书NAMES</b>
	*/
	public void setT_regb_booknames(String t_regb_booknames) {
		this.t_regb_booknames = t_regb_booknames;
	}
	/**
	*<b>Summary: 获取是否知悉</b>
	*/
	public String getT_regb_iskonw() {
		return t_regb_iskonw;
	}
	/**
	*<b>Summary: 设置是否知悉</b>
	*/
	public void setT_regb_iskonw(String t_regb_iskonw) {
		this.t_regb_iskonw = t_regb_iskonw;
	}
	/**
	*<b>Summary: 获取借阅时间</b>
	*/
	public String getT_regb_jy_date() {
		return t_regb_jy_date;
	}
	/**
	*<b>Summary: 设置借阅时间</b>
	*/
	public void setT_regb_jy_date(String t_regb_jy_date) {
		this.t_regb_jy_date = t_regb_jy_date;
	}
	/**
	*<b>Summary: 获取实际归还时间</b>
	*/
	public String getT_regb_truegh_date() {
		return t_regb_truegh_date;
	}
	/**
	*<b>Summary: 设置实际归还时间</b>
	*/
	public void setT_regb_truegh_date(String t_regb_truegh_date) {
		this.t_regb_truegh_date = t_regb_truegh_date;
	}
	/**
	*<b>Summary: 获取是否续借</b>
	*/
	public String getT_regb_isxj() {
		return t_regb_isxj;
	}
	/**
	*<b>Summary: 设置是否续借</b>
	*/
	public void setT_regb_isxj(String t_regb_isxj) {
		this.t_regb_isxj = t_regb_isxj;
	}
	public String getWhatTabs() {
		return whatTabs;
	}
	public void setWhatTabs(String whatTabs) {
		this.whatTabs = whatTabs;
	}
	public String getSq_start_time() {
		return sq_start_time;
	}
	public void setSq_start_time(String sq_start_time) {
		this.sq_start_time = sq_start_time;
	}
	public String getSq_end_time() {
		return sq_end_time;
	}
	public void setSq_end_time(String sq_end_time) {
		this.sq_end_time = sq_end_time;
	}
	public String getJy_start_time() {
		return jy_start_time;
	}
	public void setJy_start_time(String jy_start_time) {
		this.jy_start_time = jy_start_time;
	}
	public String getJy_end_time() {
		return jy_end_time;
	}
	public void setJy_end_time(String jy_end_time) {
		this.jy_end_time = jy_end_time;
	}
	/**
	 * <b>Summary: </b>
	 *     获取t_regb_auditopinion的值
	 * @return t_regb_auditopinion 
	 */
	public String getT_regb_auditopinion() {
		return t_regb_auditopinion;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 t_regb_auditopinion 的值 
	 * @param t_regb_auditopinion 
	 */
	public void setT_regb_auditopinion(String t_regb_auditopinion) {
		this.t_regb_auditopinion = t_regb_auditopinion;
	}

}
