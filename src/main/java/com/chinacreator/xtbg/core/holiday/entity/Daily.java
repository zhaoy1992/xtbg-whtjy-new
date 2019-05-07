package com.chinacreator.xtbg.core.holiday.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:Daily.java</p>
 *<p>Description:作息时间管理实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-22
 */
public class Daily extends XtDbBaseBean {

	private String begin_date;		//起始日期
	private String end_date;		//结束日期
	private String am_end_time;		//上午班结束时间
	private String work_id;		//主键ID
	private String pm_end_time;		//下午班结束时间
	private String am_begin_time;		//上午班开始时间
	private String pm_begin_time;		//下午班开始时间
	private String remark;		//备注说明
	private Object last_modify_time;		//最后修改时间
	
	public Daily(){
		super("tb_workdate","work_id");
	}
	
	
	/**
	*<b>Summary: 获取起始日期</b>
	*/
	public String getBegin_date() {
		return begin_date;
	}
	/**
	*<b>Summary: 设置起始日期</b>
	*/
	public void setBegin_date(String begin_date) {
		this.begin_date = begin_date;
	}
	/**
	*<b>Summary: 获取结束日期</b>
	*/
	public String getEnd_date() {
		return end_date;
	}
	/**
	*<b>Summary: 设置结束日期</b>
	*/
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	/**
	*<b>Summary: 获取上午班结束时间</b>
	*/
	public String getAm_end_time() {
		return am_end_time;
	}
	/**
	*<b>Summary: 设置上午班结束时间</b>
	*/
	public void setAm_end_time(String am_end_time) {
		this.am_end_time = am_end_time;
	}
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getWork_id() {
		return work_id;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setWork_id(String work_id) {
		this.work_id = work_id;
	}
	/**
	*<b>Summary: 获取下午班结束时间</b>
	*/
	public String getPm_end_time() {
		return pm_end_time;
	}
	/**
	*<b>Summary: 设置下午班结束时间</b>
	*/
	public void setPm_end_time(String pm_end_time) {
		this.pm_end_time = pm_end_time;
	}
	/**
	*<b>Summary: 获取上午班开始时间</b>
	*/
	public String getAm_begin_time() {
		return am_begin_time;
	}
	/**
	*<b>Summary: 设置上午班开始时间</b>
	*/
	public void setAm_begin_time(String am_begin_time) {
		this.am_begin_time = am_begin_time;
	}
	/**
	*<b>Summary: 获取下午班开始时间</b>
	*/
	public String getPm_begin_time() {
		return pm_begin_time;
	}
	/**
	*<b>Summary: 设置下午班开始时间</b>
	*/
	public void setPm_begin_time(String pm_begin_time) {
		this.pm_begin_time = pm_begin_time;
	}
	/**
	*<b>Summary: 获取备注说明</b>
	*/
	public String getRemark() {
		return remark;
	}
	/**
	*<b>Summary: 设置备注说明</b>
	*/
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/**
	*<b>Summary: 获取最后修改时间</b>
	*/
	public Object getLast_modify_time() {
		return last_modify_time;
	}
	/**
	*<b>Summary: 设置最后修改时间</b>
	*/
	public void setLast_modify_time(Object last_modify_time) {
		this.last_modify_time = last_modify_time;
	}
}
