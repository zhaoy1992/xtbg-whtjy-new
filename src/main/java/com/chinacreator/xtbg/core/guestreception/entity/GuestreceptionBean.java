package com.chinacreator.xtbg.core.guestreception.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:GuestreceptionBean.java</p>
 *<p>Description:接待管理基本信息实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-5
 */
public class GuestreceptionBean extends XtDbBaseBean {

	public GuestreceptionBean(){
		super("oa_guestreception_info","grinfo_id");
	}
	private String grinfo_id;		//主键id
	private String grinfo_titile;		//主题
	private String grinfo_org;		//接待单位
	private String grinfo_personnum;		//人数
	private String grinfo_receptionorg;		//宾客单位
	private String grinfo_dutyofficer;		//负责人
	private Object grinfo_startime;		//开始时间
	private Object grinfo_endtime;		//结束时间
	private String grinfo_tel;		//负责人电话
	private String grinfo_content;		//内容
	private String grstatus_id;		//状态
	private String grstatus_name;		//状态
	private String grinfo_orgid;		//接待单位id
	private String grinfo_receptionorgid;		//宾客单位id
	private String grinfo_dutyofficerid;		//负责人id
	private String grinfo_sendpersonid;		//发送人id
	private String grinfo_sendpersonname;		//发送人名称
	private Object grinfo_createtime;		//创建时间
	private String grinfo_guestcontact;		//来宾联系人
	private String grinfo_guestphone;		//来宾联系人手机号码
	private String grinfo_mpersonid;		//发送多人的id
	private String grinfo_mpersonname;		//发送多人的name
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
	*<b>Summary: 获取主题</b>
	*/
	public String getGrinfo_titile() {
		return grinfo_titile;
	}
	/**
	*<b>Summary: 设置主题</b>
	*/
	public void setGrinfo_titile(String grinfo_titile) {
		this.grinfo_titile = grinfo_titile;
	}
	/**
	*<b>Summary: 获取接待单位</b>
	*/
	public String getGrinfo_org() {
		return grinfo_org;
	}
	/**
	*<b>Summary: 设置接待单位</b>
	*/
	public void setGrinfo_org(String grinfo_org) {
		this.grinfo_org = grinfo_org;
	}
	/**
	*<b>Summary: 获取人数</b>
	*/
	public String getGrinfo_personnum() {
		return grinfo_personnum;
	}
	/**
	*<b>Summary: 设置人数</b>
	*/
	public void setGrinfo_personnum(String grinfo_personnum) {
		this.grinfo_personnum = grinfo_personnum;
	}
	/**
	*<b>Summary: 获取宾客单位</b>
	*/
	public String getGrinfo_receptionorg() {
		return grinfo_receptionorg;
	}
	/**
	*<b>Summary: 设置宾客单位</b>
	*/
	public void setGrinfo_receptionorg(String grinfo_receptionorg) {
		this.grinfo_receptionorg = grinfo_receptionorg;
	}
	/**
	*<b>Summary: 获取负责人</b>
	*/
	public String getGrinfo_dutyofficer() {
		return grinfo_dutyofficer;
	}
	/**
	*<b>Summary: 设置负责人</b>
	*/
	public void setGrinfo_dutyofficer(String grinfo_dutyofficer) {
		this.grinfo_dutyofficer = grinfo_dutyofficer;
	}
	/**
	*<b>Summary: 获取开始时间</b>
	*/
	public Object getGrinfo_startime() {
		return grinfo_startime;
	}
	/**
	*<b>Summary: 设置开始时间</b>
	*/
	public void setGrinfo_startime(Object grinfo_startime) {
		this.grinfo_startime = grinfo_startime;
	}
	/**
	*<b>Summary: 获取结束时间</b>
	*/
	public Object getGrinfo_endtime() {
		return grinfo_endtime;
	}
	/**
	*<b>Summary: 设置结束时间</b>
	*/
	public void setGrinfo_endtime(Object grinfo_endtime) {
		this.grinfo_endtime = grinfo_endtime;
	}
	/**
	*<b>Summary: 获取负责人电话</b>
	*/
	public String getGrinfo_tel() {
		return grinfo_tel;
	}
	/**
	*<b>Summary: 设置负责人电话</b>
	*/
	public void setGrinfo_tel(String grinfo_tel) {
		this.grinfo_tel = grinfo_tel;
	}
	/**
	*<b>Summary: 获取内容</b>
	*/
	public String getGrinfo_content() {
		return grinfo_content;
	}
	/**
	*<b>Summary: 设置内容</b>
	*/
	public void setGrinfo_content(String grinfo_content) {
		this.grinfo_content = grinfo_content;
	}
	/**
	*<b>Summary: 获取状态</b>
	*/
	public String getGrstatus_id() {
		return grstatus_id;
	}
	/**
	*<b>Summary: 设置状态</b>
	*/
	public void setGrstatus_id(String grstatus_id) {
		this.grstatus_id = grstatus_id;
	}
	/**
	*<b>Summary: 获取接待单位id</b>
	*/
	public String getGrinfo_orgid() {
		return grinfo_orgid;
	}
	/**
	*<b>Summary: 设置接待单位id</b>
	*/
	public void setGrinfo_orgid(String grinfo_orgid) {
		this.grinfo_orgid = grinfo_orgid;
	}
	/**
	*<b>Summary: 获取宾客单位id</b>
	*/
	public String getGrinfo_receptionorgid() {
		return grinfo_receptionorgid;
	}
	/**
	*<b>Summary: 设置宾客单位id</b>
	*/
	public void setGrinfo_receptionorgid(String grinfo_receptionorgid) {
		this.grinfo_receptionorgid = grinfo_receptionorgid;
	}
	/**
	*<b>Summary: 获取负责人id</b>
	*/
	public String getGrinfo_dutyofficerid() {
		return grinfo_dutyofficerid;
	}
	/**
	*<b>Summary: 设置负责人id</b>
	*/
	public void setGrinfo_dutyofficerid(String grinfo_dutyofficerid) {
		this.grinfo_dutyofficerid = grinfo_dutyofficerid;
	}
	/**
	*<b>Summary: 获取发送人id</b>
	*/
	public String getGrinfo_sendpersonid() {
		return grinfo_sendpersonid;
	}
	/**
	*<b>Summary: 设置发送人id</b>
	*/
	public void setGrinfo_sendpersonid(String grinfo_sendpersonid) {
		this.grinfo_sendpersonid = grinfo_sendpersonid;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public Object getGrinfo_createtime() {
		return grinfo_createtime;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setGrinfo_createtime(Object grinfo_createtime) {
		this.grinfo_createtime = grinfo_createtime;
	}
	/**
	*<b>Summary: 获取来宾联系人</b>
	*/
	public String getGrinfo_guestcontact() {
		return grinfo_guestcontact;
	}
	/**
	*<b>Summary: 设置来宾联系人</b>
	*/
	public void setGrinfo_guestcontact(String grinfo_guestcontact) {
		this.grinfo_guestcontact = grinfo_guestcontact;
	}
	/**
	*<b>Summary: 获取来宾联系人手机号码</b>
	*/
	public String getGrinfo_guestphone() {
		return grinfo_guestphone;
	}
	/**
	*<b>Summary: 设置来宾联系人手机号码</b>
	*/
	public void setGrinfo_guestphone(String grinfo_guestphone) {
		this.grinfo_guestphone = grinfo_guestphone;
	}
	/**
	*<b>Summary: 获取发送多人的id</b>
	*/
	public String getGrinfo_mpersonid() {
		return grinfo_mpersonid;
	}
	/**
	*<b>Summary: 设置发送多人的id</b>
	*/
	public void setGrinfo_mpersonid(String grinfo_mpersonid) {
		this.grinfo_mpersonid = grinfo_mpersonid;
	}
	/**
	*<b>Summary: 获取发送多人的name</b>
	*/
	public String getGrinfo_mpersonname() {
		return grinfo_mpersonname;
	}
	/**
	*<b>Summary: 设置发送多人的name</b>
	*/
	public void setGrinfo_mpersonname(String grinfo_mpersonname) {
		this.grinfo_mpersonname = grinfo_mpersonname;
	}
	public String getGrstatus_name() {
		return grstatus_name;
	}
	public void setGrstatus_name(String grstatus_name) {
		this.grstatus_name = grstatus_name;
	}
	public String getGrinfo_sendpersonname() {
		return grinfo_sendpersonname;
	}
	public void setGrinfo_sendpersonname(String grinfo_sendpersonname) {
		this.grinfo_sendpersonname = grinfo_sendpersonname;
	}

}
