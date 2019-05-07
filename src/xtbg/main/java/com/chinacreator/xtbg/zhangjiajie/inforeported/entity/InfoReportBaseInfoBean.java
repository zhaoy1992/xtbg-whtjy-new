package com.chinacreator.xtbg.zhangjiajie.inforeported.entity;

import java.util.List;

public class InfoReportBaseInfoBean {

	private String submittedinfo_id;//报送id,主键
	private String infotype_id;//类型id
	private String infotype_name;//类型名称
	private String submittedinfo_typecode;//信息报送状态编号
	private String submittedinfo_typecode4getinfouser;//信息报送接者状态编号
	private String submittedinfo_typecode2delete;//信息报送需要删除的状态编号
	private String submittedinfo_typename;//信息报送状态名称
	private String submittedinfo_title;//标题
	private String input_date;//录入时间
	private String release_time;//发布时间
	private String releaseunit_name;//发布单位
	private String is_release;//发布状态
	private String is_recommend;//推荐状态
	private String is_alternate;//备用状态
	private String recommend_time;//推荐时间
	private String recommend_username;//推荐人
	private String inputuser_id;//录入者id
	private String inputuser_name;//录入者
	private String org_id;//录入机构id 也是上报机构id
	private String org_name;//录入机构名称  也是上报机构name
	private String department;//录入单位名称
	private String departmentid;//录入单位id
	private String keyword;//关键字
	private String andit_time;//审核时间(对应：退稿时间)
	private String submit_content;//信息内容
	private String andit_opinion;//操作意见（对应：退稿时间）
	private String andit_person;//操作时间（对应：退稿人）
	private String reportunits;//上报接收人
	private String reportunitsname;//上报接收人名称
	private String partunits;//发布接收人
	private String partunitsname;//发布接收人名称
	private String sendauditusers;//送审接收人
	private String sendauditusersname;//送审接收人名称
	private List<InfoReportAuditIdeaBean> andit_infos;//审核意见
	private String view_num;//保存相关接收人数量
	private String submit_content_phone;//手机预览的内容
	private String relese_time;//上报时间
	private String leadedit_state;//是否是领导报送
	
	private String sbusername; //上报接收人姓名
	private String ssusername;//送审接收人姓名
	private String fbusername;//发布接收人姓名
	
	public String getRelese_time() {
		return relese_time;
	}
	public void setRelese_time(String releseTime) {
		relese_time = releseTime;
	}
	public String getSubmit_content_phone() {
		return submit_content_phone;
	}
	public void setSubmit_content_phone(String submitContentPhone) {
		submit_content_phone = submitContentPhone;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getDepartmentid() {
		return departmentid;
	}
	public void setDepartmentid(String departmentid) {
		this.departmentid = departmentid;
	}
	public String getView_num() {
		return view_num;
	}
	public void setView_num(String viewNum) {
		view_num = viewNum;
	}
	public String getSubmittedinfo_typecode2delete() {
		return submittedinfo_typecode2delete;
	}
	public void setSubmittedinfo_typecode2delete(String submittedinfoTypecode2delete) {
		submittedinfo_typecode2delete = submittedinfoTypecode2delete;
	}
	public String getSubmittedinfo_typecode4getinfouser() {
		return submittedinfo_typecode4getinfouser;
	}
	public void setSubmittedinfo_typecode4getinfouser(
			String submittedinfoTypecode4getinfouser) {
		submittedinfo_typecode4getinfouser = submittedinfoTypecode4getinfouser;
	}
	public String getReportunitsname() {
		return reportunitsname;
	}
	public void setReportunitsname(String reportunitsname) {
		this.reportunitsname = reportunitsname;
	}
	public String getPartunitsname() {
		return partunitsname;
	}
	public void setPartunitsname(String partunitsname) {
		this.partunitsname = partunitsname;
	}
	public String getSendauditusersname() {
		return sendauditusersname;
	}
	public void setSendauditusersname(String sendauditusersname) {
		this.sendauditusersname = sendauditusersname;
	}
	public String getSendauditusers() {
		return sendauditusers;
	}
	public void setSendauditusers(String sendauditusers) {
		this.sendauditusers = sendauditusers;
	}
	public String getIs_alternate() {
		return is_alternate;
	}
	public void setIs_alternate(String isAlternate) {
		is_alternate = isAlternate;
	}
	public String getReportunits() {
		return reportunits;
	}
	public void setReportunits(String reportunits) {
		this.reportunits = reportunits;
	}
	public String getPartunits() {
		return partunits;
	}
	public void setPartunits(String partunits) {
		this.partunits = partunits;
	}
	public String getAndit_opinion() {
		return andit_opinion;
	}
	public void setAndit_opinion(String anditOpinion) {
		andit_opinion = anditOpinion;
	}
	public String getAndit_person() {
		return andit_person;
	}
	public void setAndit_person(String anditPerson) {
		andit_person = anditPerson;
	}

	public List<InfoReportAuditIdeaBean> getAndit_infos() {
		return andit_infos;
	}
	public void setAndit_infos(List<InfoReportAuditIdeaBean> anditInfos) {
		andit_infos = anditInfos;
	}
	public String getIs_release() {
		return is_release;
	}
	public void setIs_release(String isRelease) {
		is_release = isRelease;
	}
	public String getIs_recommend() {
		return is_recommend;
	}
	public void setIs_recommend(String isRecommend) {
		is_recommend = isRecommend;
	}
	public String getReleaseunit_name() {
		return releaseunit_name;
	}
	public void setReleaseunit_name(String releaseunitName) {
		releaseunit_name = releaseunitName;
	}
	public String getRelease_time() {
		return release_time;
	}
	public void setRelease_time(String releaseTime) {
		release_time = releaseTime;
	}
	public String getSubmittedinfo_id() {
		return submittedinfo_id;
	}
	public void setSubmittedinfo_id(String submittedinfoId) {
		submittedinfo_id = submittedinfoId;
	}
	public String getInfotype_id() {
		return infotype_id;
	}
	public void setInfotype_id(String infotypeId) {
		infotype_id = infotypeId;
	}
	public String getInfotype_name() {
		return infotype_name;
	}
	public void setInfotype_name(String infotypeName) {
		infotype_name = infotypeName;
	}
	public String getSubmittedinfo_typecode() {
		return submittedinfo_typecode;
	}
	public void setSubmittedinfo_typecode(String submittedinfoTypecode) {
		submittedinfo_typecode = submittedinfoTypecode;
	}
	public String getSubmittedinfo_typename() {
		return submittedinfo_typename;
	}
	public void setSubmittedinfo_typename(String submittedinfoTypename) {
		submittedinfo_typename = submittedinfoTypename;
	}
	public String getSubmittedinfo_title() {
		return submittedinfo_title;
	}
	public void setSubmittedinfo_title(String submittedinfoTitle) {
		submittedinfo_title = submittedinfoTitle;
	}
	public String getInput_date() {
		return input_date;
	}
	public void setInput_date(String inputDate) {
		input_date = inputDate;
	}
	public String getInputuser_id() {
		return inputuser_id;
	}
	public void setInputuser_id(String inputuserId) {
		inputuser_id = inputuserId;
	}
	public String getInputuser_name() {
		return inputuser_name;
	}
	public void setInputuser_name(String inputuserName) {
		inputuser_name = inputuserName;
	}
	public String getOrg_id() {
		return org_id;
	}
	public void setOrg_id(String orgId) {
		org_id = orgId;
	}
	public String getOrg_name() {
		return org_name;
	}
	public void setOrg_name(String orgName) {
		org_name = orgName;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getAndit_time() {
		return andit_time;
	}
	public void setAndit_time(String anditTime) {
		andit_time = anditTime;
	}
	public String getSubmit_content() {
		return submit_content;
	}
	public void setSubmit_content(String submitContent) {
		submit_content = submitContent;
	}
	public String getRecommend_time() {
		return recommend_time;
	}
	public void setRecommend_time(String recommendTime) {
		recommend_time = recommendTime;
	}
	public String getRecommend_username() {
		return recommend_username;
	}
	public void setRecommend_username(String recommendUsername) {
		recommend_username = recommendUsername;
	}
	/**
	 * <b>Summary: </b>
	 *     获取leadedit_state的值
	 * @return leadedit_state 
	 */
	public String getLeadedit_state() {
		return leadedit_state;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 leadedit_state 的值 
	 * @param leadedit_state 
	 */
	public void setLeadedit_state(String leadedit_state) {
		this.leadedit_state = leadedit_state;
	}
	/**
	 * <b>Summary: </b>
	 *     获取sbusername的值
	 * @return sbusername 
	 */
	public String getSbusername() {
		return sbusername;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 sbusername 的值 
	 * @param sbusername 
	 */
	public void setSbusername(String sbusername) {
		this.sbusername = sbusername;
	}
	/**
	 * <b>Summary: </b>
	 *     获取ssusername的值
	 * @return ssusername 
	 */
	public String getSsusername() {
		return ssusername;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 ssusername 的值 
	 * @param ssusername 
	 */
	public void setSsusername(String ssusername) {
		this.ssusername = ssusername;
	}
	/**
	 * <b>Summary: </b>
	 *     获取fbusername的值
	 * @return fbusername 
	 */
	public String getFbusername() {
		return fbusername;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 fbusername 的值 
	 * @param fbusername 
	 */
	public void setFbusername(String fbusername) {
		this.fbusername = fbusername;
	}
	
}
