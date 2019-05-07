package com.chinacreator.xtbg.tjy.officesupplies.entity;
/**
 * 固定资产历史使用记录bean
 * @author 王淑滨
 *
 */
public class OsAccountHistoryBean {
	   private String id;//主键
	   private String gdzc_id;//固定资产id
	   private String gdzc_name;//固定资产名称
	   private String user_id;//使用人id
	   private String user_name;//使用人名
	   private String org_id;//使用部门id
	   private String org_name;//使用部门
	   private String use_type;//使用类型：借用/领用/借用归还/领用归还等
	   private String user_date;//使用时间
	   private String ghdj_id;//归还登记表id
	   
	
	public String getGhdj_id() {
		return ghdj_id;
	}
	public void setGhdj_id(String ghdjId) {
		ghdj_id = ghdjId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdzc_id() {
		return gdzc_id;
	}
	public void setGdzc_id(String gdzcId) {
		gdzc_id = gdzcId;
	}
	public String getGdzc_name() {
		return gdzc_name;
	}
	public void setGdzc_name(String gdzcName) {
		gdzc_name = gdzcName;
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
	public String getUse_type() {
		return use_type;
	}
	public void setUse_type(String useType) {
		use_type = useType;
	}
	public String getUser_date() {
		return user_date;
	}
	public void setUser_date(String userDate) {
		user_date = userDate;
	}
	   
	   
}
