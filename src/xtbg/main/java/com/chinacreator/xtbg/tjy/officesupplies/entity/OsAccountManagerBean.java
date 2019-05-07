package com.chinacreator.xtbg.tjy.officesupplies.entity;
/**
 * 固定资产使用管理bean
 * @author 王淑滨
 *
 */
public class OsAccountManagerBean {
	   private String m_id;//主键id
	   private String m_type;//管理类型（借用/借用归还等）
	   private String use_date;//使用时间
	   private String user_id;//用户id
	   private String user_name;//用户名
	   private String org_id;//部门id
	   private String org_name;//部门名
	   private String register_user_id;//登记人id
	   private String register_user_name;//登记人名
	   private String register_date;//登记时间
	   private String gdzc_classify;//资产类别
	   
	public String getGdzc_classify() {
		return gdzc_classify;
	}
	public void setGdzc_classify(String gdzcClassify) {
		gdzc_classify = gdzcClassify;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String mId) {
		m_id = mId;
	}
	public String getM_type() {
		return m_type;
	}
	public void setM_type(String mType) {
		m_type = mType;
	}
	public String getUse_date() {
		return use_date;
	}
	public void setUse_date(String useDate) {
		use_date = useDate;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String userId) {
		user_id = userId;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String userName) {
		user_name = userName;
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
	public String getRegister_user_id() {
		return register_user_id;
	}
	public void setRegister_user_id(String registerUserId) {
		register_user_id = registerUserId;
	}
	public String getRegister_user_name() {
		return register_user_name;
	}
	public void setRegister_user_name(String registerUserName) {
		register_user_name = registerUserName;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String registerDate) {
		register_date = registerDate;
	}
	   
	   
}
