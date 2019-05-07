package com.chinacreator.xtbg.tjy.device.entity;
/**
 * 
 *<p>Title:DevChuzuBean.java</p>
 *<p>Description:仪器设备出租</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shaoun.wu
 *@version 1.0
 *2015-11-13
 */
public class DevChuzuBean {
	private String t_id;		//主键
	private String t_sb_id;		//设备ID
	private String t_jbr_id;		//经办人ID
	private String t_jre_mc;		//经办人名称
	private String t_czorg_id;		//领用部门ID
	private String t_czorg_mc;		//领用部门名称
	private String t_czdate;		//领用日期
	private String t_ghdate;		//归还日期
	private String t_sbgly_id;		//设备管理员ID
	private String t_sbgly_mc;		//设备管理员名称
	private String t_title;		//标题
	private String t_money; //出租金额
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public String getT_sb_id() {
		return t_sb_id;
	}
	public void setT_sb_id(String t_sb_id) {
		this.t_sb_id = t_sb_id;
	}
	public String getT_jbr_id() {
		return t_jbr_id;
	}
	public void setT_jbr_id(String t_jbr_id) {
		this.t_jbr_id = t_jbr_id;
	}
	public String getT_jre_mc() {
		return t_jre_mc;
	}
	public void setT_jre_mc(String t_jre_mc) {
		this.t_jre_mc = t_jre_mc;
	}
	public String getT_czorg_id() {
		return t_czorg_id;
	}
	public void setT_czorg_id(String t_czorg_id) {
		this.t_czorg_id = t_czorg_id;
	}
	public String getT_czorg_mc() {
		return t_czorg_mc;
	}
	public void setT_czorg_mc(String t_czorg_mc) {
		this.t_czorg_mc = t_czorg_mc;
	}
	
	public String getT_czdate() {
		return t_czdate;
	}
	public void setT_czdate(String t_czdate) {
		this.t_czdate = t_czdate;
	}
	public String getT_ghdate() {
		return t_ghdate;
	}
	public void setT_ghdate(String t_ghdate) {
		this.t_ghdate = t_ghdate;
	}
	public String getT_sbgly_id() {
		return t_sbgly_id;
	}
	public void setT_sbgly_id(String t_sbgly_id) {
		this.t_sbgly_id = t_sbgly_id;
	}
	public String getT_sbgly_mc() {
		return t_sbgly_mc;
	}
	public void setT_sbgly_mc(String t_sbgly_mc) {
		this.t_sbgly_mc = t_sbgly_mc;
	}
	public String getT_title() {
		return t_title;
	}
	public void setT_title(String t_title) {
		this.t_title = t_title;
	}
	public String getT_money() {
		return t_money;
	}
	public void setT_money(String t_money) {
		this.t_money = t_money;
	}
	
	
}
