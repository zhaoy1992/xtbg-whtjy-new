package com.chinacreator.xtbg.zhangjiajie.inforeported.entity;

import com.chinacreator.xtbg.pub.util.DataControlUtil;

public class InfoReportSearchBean {


	private String submittedinfo_title;//标题
	private String org_id;//上报单位id
	private String org_name;//上报单位名称
	private String input_starttime;//录入开始时间
	private String input_endtime;//录入结束时间
	private String infotype_id;//信息类型id
	private String inputuser_id;//录入者id
	private String releaseunit_id;//栏目id
	private String is_published;//发布状态
	private String submittedinfo_typecode;//信息状态
	private String rolename;//权限名称
	private String infostate;
	private String submittedinfo_typename;//

	public String getSubmittedinfo_typename() {
		return submittedinfo_typename;
	}
	public void setSubmittedinfo_typename(String submittedinfoTypename) {
		submittedinfo_typename = submittedinfoTypename;
	}
	public String getInfostate() {
		return infostate;
	}
	public void setInfostate(String infostate) {
		this.infostate = infostate;
	}
	public String getOrg_name() {
		return org_name;
	}
	public void setOrg_name(String orgName) {
		org_name = orgName;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	public String getSubmittedinfo_typecode() {
		return submittedinfo_typecode;
	}
	public void setSubmittedinfo_typecode(String submittedinfoTypecode) {
		submittedinfo_typecode = submittedinfoTypecode;
	}
	public String getIs_published() {
		return is_published;
	}
	public void setIs_published(String isPublished) {
		is_published = isPublished;
	}
	public String getReleaseunit_id() {
		return releaseunit_id;
	}
	public void setReleaseunit_id(String releaseunitId) {
		releaseunit_id = releaseunitId;
	}
	public String getSubmittedinfo_title() {
		return DataControlUtil.replaceStr(submittedinfo_title);
	}
	public void setSubmittedinfo_title(String submittedinfoTitle) {
		submittedinfo_title = submittedinfoTitle;
	}
	public String getOrg_id() {
		return org_id;
	}
	public void setOrg_id(String orgId) {
		org_id = orgId;
	}
	public String getInput_starttime() {
		return input_starttime;
	}
	public void setInput_starttime(String inputStarttime) {
		input_starttime = inputStarttime;
	}
	public String getInput_endtime() {
		return input_endtime;
	}
	public void setInput_endtime(String inputEndtime) {
		input_endtime = inputEndtime;
	}
	public String getInfotype_id() {
		return infotype_id;
	}
	public void setInfotype_id(String infotypeId) {
		infotype_id = infotypeId;
	}
	public String getInputuser_id() {
		return inputuser_id;
	}
	public void setInputuser_id(String inputuserId) {
		inputuser_id = inputuserId;
	}
	
	
}
