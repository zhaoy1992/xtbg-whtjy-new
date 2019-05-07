package com.chinacreator.xtbg.suxian.electroniccheck.entity;



/**
 *<p>Title:BriefsEditorBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 付程
 *@version 1.0
 *@date 2012-2-24
 */
public class BriefsEditorBean {
	private String submittedinfo_typecode;//信息报送状态编号
	private String submittedinfo_typecode4getinfouser;//信息报送接者状态编号
	private String submittedinfo_typecode2delete;//信息报送需要删除的状态编号
	private String presentation_title;//简报标题
	private String create_time;//创建时间
	private String start_time;//开始时间
	
	private String end_time;//结束时间
	private String period_number;//期数id
	private String briefs_type;//简报类型
	private String release_status;//发布状态
	private String briefs_id;//简报编号

	private String bfdw;//编发单位/默认是当前用户机构
	private String mjcd;//密级程度
	private String bh;//编号
	private String ztc;//主题词
	private String zw;//正文
	private String fsdw;//发送单位
	private String csdw;//抄送单位
    private String psyj;//批示意见
    private String userid;//当前用户id
    private String fs_id;//发送单位id
    private String cs_id;//抄送单位id
    private String username;//当前用户信息
    private String orgid;//当前机构id
    private String fs_userid;//发送机构用户id
    private String cs_userid;//抄送机构用户id
	private String period_time1;//期数
    private String orgname;
	private String theme;
    private String psTime;
	private String fs_username;
	private String cs_username;
	private String dept_id;
	private String types;
	private String parent_id;
	private String nr_phone;//手机预览内容
	private String briefs_typename;
	//是否引用
	private String ischoosed;
	
	public String getBriefs_typename() {
		return briefs_typename;
	}
	public void setBriefs_typename(String briefs_typename) {
		this.briefs_typename = briefs_typename;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getTypes() {
		return types;
	}
	public void setTypes(String types) {
		this.types = types;
	}
	public String getNr_phone() {
		return nr_phone;
	}
	public void setNr_phone(String nrPhone) {
		nr_phone = nrPhone;
	}
	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public String getFs_username() {
		return fs_username;
	}
	public void setFs_username(String fs_username) {
		this.fs_username = fs_username;
	}
	public String getCs_username() {
		return cs_username;
	}
	public void setCs_username(String cs_username) {
		this.cs_username = cs_username;
	}
	public String getPsTime() {
		return psTime;
	}
	public void setPsTime(String psTime) {
		this.psTime = psTime;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public String getPeriod_time1() {
		return period_time1;
	}
	public void setPeriod_time1(String period_time1) {
		this.period_time1 = period_time1;
	}
	public String getFs_userid() {
		return fs_userid;
	}
	public void setFs_userid(String fs_userid) {
		this.fs_userid = fs_userid;
	}
	public String getCs_userid() {
		return cs_userid;
	}
	public void setCs_userid(String cs_userid) {
		this.cs_userid = cs_userid;
	}
	public String getSubmittedinfo_typecode() {
		return submittedinfo_typecode;
	}
	public void setSubmittedinfo_typecode(String submittedinfo_typecode) {
		this.submittedinfo_typecode = submittedinfo_typecode;
	}
	public String getSubmittedinfo_typecode4getinfouser() {
		return submittedinfo_typecode4getinfouser;
	}
	public void setSubmittedinfo_typecode4getinfouser(
			String submittedinfo_typecode4getinfouser) {
		this.submittedinfo_typecode4getinfouser = submittedinfo_typecode4getinfouser;
	}
	public String getSubmittedinfo_typecode2delete() {
		return submittedinfo_typecode2delete;
	}
	public void setSubmittedinfo_typecode2delete(
			String submittedinfo_typecode2delete) {
		this.submittedinfo_typecode2delete = submittedinfo_typecode2delete;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	public String getFs_id() {
		return fs_id;
	}
	public void setFs_id(String fs_id) {
		this.fs_id = fs_id;
	}
	public String getCs_id() {
		return cs_id;
	}
	public void setCs_id(String cs_id) {
		this.cs_id = cs_id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUser_id(String userid) {
		this.userid = userid;
	}
	public String getPsyj() {
		return psyj;
	}
	public void setPsyj(String psyj) {
		this.psyj = psyj;
	}
	public String getBriefs_id() {
		return briefs_id;
	}
	public void setBriefs_id(String briefs_id) {
		this.briefs_id = briefs_id;
	}
	public String getPresentation_title() {
		return presentation_title;
	}
	public void setPresentation_title(String presentation_title) {
		this.presentation_title = presentation_title;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	public String getPeriod_number() {
		return period_number;
	}
	public void setPeriod_number(String period_number) {
		this.period_number = period_number;
	}
	public String getBriefs_type() {
		return briefs_type;
	}
	public void setBriefs_type(String briefs_type) {
		this.briefs_type = briefs_type;
	}
	public String getRelease_status() {
		return release_status;
	}
	public void setRelease_status(String release_status) {
		this.release_status = release_status;
	}

	public String getBfdw() {
		return bfdw;
	}
	public void setBfdw(String bfdw) {
		this.bfdw = bfdw;
	}
	public String getMjcd() {
		return mjcd;
	}
	public void setMjcd(String mjcd) {
		this.mjcd = mjcd;
	}
	public String getBh() {
		return bh;
	}
	public void setBh(String bh) {
		this.bh = bh;
	}
	public String getZtc() {
		return ztc;
	}
	public void setZtc(String ztc) {
		this.ztc = ztc;
	}
	public String getZw() {
		return zw;
	}
	public void setZw(String zw) {
		this.zw = zw;
	}
	public String getFsdw() {
		return fsdw;
	}
	public void setFsdw(String fsdw) {
		this.fsdw = fsdw;
	}
	public String getCsdw() {
		return csdw;
	}
	public void setCsdw(String csdw) {
		this.csdw = csdw;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getIschoosed() {
		return ischoosed;
	}
	public void setIschoosed(String ischoosed) {
		this.ischoosed = ischoosed;
	}
	
}


