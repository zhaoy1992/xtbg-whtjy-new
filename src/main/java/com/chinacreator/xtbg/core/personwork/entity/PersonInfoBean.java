package com.chinacreator.xtbg.core.personwork.entity;
/**
 * 
 *<p>Title:PersonInfoBean.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-6-13
 */
public class PersonInfoBean {
	private String person_id;//人员id
	private String name;//姓名
	private String commonlymobile;//常用手机号码
	private String qqNum;//qq号码
	private String email;//电子邮箱
	private String group_id;//所在分组
	private String group;
	private String officphone;//办公电话
	private String homephone;//家用电话
	private String org_id;//所在单位
	private String org_name;//所在单位名称
	private String user_id;//用户id
	private String info_type;//信息类型
	private String nick_name;//昵称
	private String eng_name;//姓名的拼音
	private String info_source;//信息来源
	private String info_source_name;//信息来源名称
	private String createtime;//创建时间
	private String is_public;//是否公共通讯录（即外部通讯录）
	private String remark;//备注
	
	

	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getInfo_source() {
		return info_source;
	}
	public void setInfo_source(String infoSource) {
		info_source = infoSource;
	}
	public String getInfo_source_name() {
		return info_source_name;
	}
	public void setInfo_source_name(String infoSourceName) {
		info_source_name = infoSourceName;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public String getEng_name() {
		return eng_name;
	}
	public void setEng_name(String engName) {
		eng_name = engName;
	}
	public String getNick_name() {
		return nick_name;
	}
	public void setNick_name(String nickName) {
		nick_name = nickName;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String userId) {
		user_id = userId;
	}
	public String getInfo_type() {
		return info_type;
	}
	public void setInfo_type(String infoType) {
		info_type = infoType;
	}
	public String getOrg_name() {
		return org_name;
	}
	public void setOrg_name(String orgName) {
		org_name = orgName;
	}
	public String getOfficphone() {
		return officphone;
	}
	public void setOfficphone(String officphone) {
		this.officphone = officphone;
	}
	public String getHomephone() {
		return homephone;
	}
	public void setHomephone(String homephone) {
		this.homephone = homephone;
	}
	public String getOrg_id() {
		return org_id;
	}
	public void setOrg_id(String orgId) {
		org_id = orgId;
	}
	public String getPerson_id() {
		return person_id;
	}
	public void setPerson_id(String personId) {
		person_id = personId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCommonlymobile() {
		return commonlymobile;
	}
	public void setCommonlymobile(String commonlymobile) {
		this.commonlymobile = commonlymobile;
	}
	public String getQqNum() {
		return qqNum;
	}
	public void setQqNum(String qqNum) {
		this.qqNum = qqNum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String groupId) {
		group_id = groupId;
	}
	/**
	 * <b>Summary: </b>
	 *     获取is_public的值
	 * @return is_public 
	 */
	public String getIs_public() {
		return is_public;
	}
	/** 
	 * <b>Summary: </b>
	 *     设置 is_public 的值 
	 * @param is_public 
	 */
	public void setIs_public(String is_public) {
		this.is_public = is_public;
	}
	
	
	
}
