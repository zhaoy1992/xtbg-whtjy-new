package com.chinacreator.xtbg.tjy.officesupplies.entity;
/**
 * 申领登记表实体
 * @author 王淑滨
 *
 */
public class OsAppRegYhpBean {
	private String t_appregyhp_id;//主键id
	private String t_fj_id;//附件id
	private String t_zw_id;//正文id
	private String t_appregyhp_org_id;//申领部门id
	private String t_appregyhp_org_name;//申领部门名
	private String t_appregyhp_user_id;//申领人id
	private String t_appregyhp_user_name;//申领人名
	private String t_appregyhp_date;//申领日期
	private String t_appregyhp_appids;//申领相关计划表id
	private String t_appregyhp_title;//申领标题
	private String t_appregyhp_bgsuserid;//
	private String t_appregyhp_bgsusername;
	private String t_appregyhp_bgsyj;
	private String t_appregyhp_bmfzryj;//部门负责人意见
	private String t_appregyhp_syzxzryj;//事业中心主任意见
	private String t_appregyhp_hqbfzryj;//后勤部负责人意见
	private String t_appregyhp_ckgly;//仓库管理员0不同意出库1同意出库
	private String t_appregyhp_ischuku;//是否出库0未出库1已出库
	private String t_appregyhp_chuku_userid;//出库人id
	private String t_appregyhp_chuku_username;//出库人名
	private String t_appregyhp_chuku_date;//出库时间
	
	private String start_time;//搜索开始时间
	private String end_time;//搜索结束时间
	
	private String type;//做出库/发放列表区别
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String startTime) {
		start_time = startTime;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String endTime) {
		end_time = endTime;
	}
	public String getT_appregyhp_id() {
		return t_appregyhp_id;
	}
	public void setT_appregyhp_id(String tAppregyhpId) {
		t_appregyhp_id = tAppregyhpId;
	}
	public String getT_fj_id() {
		return t_fj_id;
	}
	public void setT_fj_id(String tFjId) {
		t_fj_id = tFjId;
	}
	public String getT_zw_id() {
		return t_zw_id;
	}
	public void setT_zw_id(String tZwId) {
		t_zw_id = tZwId;
	}
	public String getT_appregyhp_org_id() {
		return t_appregyhp_org_id;
	}
	public void setT_appregyhp_org_id(String tAppregyhpOrgId) {
		t_appregyhp_org_id = tAppregyhpOrgId;
	}
	public String getT_appregyhp_org_name() {
		return t_appregyhp_org_name;
	}
	public void setT_appregyhp_org_name(String tAppregyhpOrgName) {
		t_appregyhp_org_name = tAppregyhpOrgName;
	}
	public String getT_appregyhp_user_id() {
		return t_appregyhp_user_id;
	}
	public void setT_appregyhp_user_id(String tAppregyhpUserId) {
		t_appregyhp_user_id = tAppregyhpUserId;
	}
	public String getT_appregyhp_user_name() {
		return t_appregyhp_user_name;
	}
	public void setT_appregyhp_user_name(String tAppregyhpUserName) {
		t_appregyhp_user_name = tAppregyhpUserName;
	}
	public String getT_appregyhp_date() {
		return t_appregyhp_date;
	}
	public void setT_appregyhp_date(String tAppregyhpDate) {
		t_appregyhp_date = tAppregyhpDate;
	}
	public String getT_appregyhp_appids() {
		return t_appregyhp_appids;
	}
	public void setT_appregyhp_appids(String tAppregyhpAppids) {
		t_appregyhp_appids = tAppregyhpAppids;
	}
	public String getT_appregyhp_title() {
		return t_appregyhp_title;
	}
	public void setT_appregyhp_title(String tAppregyhpTitle) {
		t_appregyhp_title = tAppregyhpTitle;
	}
	public String getT_appregyhp_bgsuserid() {
		return t_appregyhp_bgsuserid;
	}
	public void setT_appregyhp_bgsuserid(String tAppregyhpBgsuserid) {
		t_appregyhp_bgsuserid = tAppregyhpBgsuserid;
	}
	public String getT_appregyhp_bgsusername() {
		return t_appregyhp_bgsusername;
	}
	public void setT_appregyhp_bgsusername(String tAppregyhpBgsusername) {
		t_appregyhp_bgsusername = tAppregyhpBgsusername;
	}
	public String getT_appregyhp_bgsyj() {
		return t_appregyhp_bgsyj;
	}
	public void setT_appregyhp_bgsyj(String tAppregyhpBgsyj) {
		t_appregyhp_bgsyj = tAppregyhpBgsyj;
	}
	public String getT_appregyhp_bmfzryj() {
		return t_appregyhp_bmfzryj;
	}
	public void setT_appregyhp_bmfzryj(String tAppregyhpBmfzryj) {
		t_appregyhp_bmfzryj = tAppregyhpBmfzryj;
	}
	public String getT_appregyhp_syzxzryj() {
		return t_appregyhp_syzxzryj;
	}
	public void setT_appregyhp_syzxzryj(String tAppregyhpSyzxzryj) {
		t_appregyhp_syzxzryj = tAppregyhpSyzxzryj;
	}
	public String getT_appregyhp_hqbfzryj() {
		return t_appregyhp_hqbfzryj;
	}
	public void setT_appregyhp_hqbfzryj(String tAppregyhpHqbfzryj) {
		t_appregyhp_hqbfzryj = tAppregyhpHqbfzryj;
	}
	public String getT_appregyhp_ckgly() {
		return t_appregyhp_ckgly;
	}
	public void setT_appregyhp_ckgly(String tAppregyhpCkgly) {
		t_appregyhp_ckgly = tAppregyhpCkgly;
	}
	public String getT_appregyhp_ischuku() {
		return t_appregyhp_ischuku;
	}
	public void setT_appregyhp_ischuku(String tAppregyhpIschuku) {
		t_appregyhp_ischuku = tAppregyhpIschuku;
	}
	public String getT_appregyhp_chuku_userid() {
		return t_appregyhp_chuku_userid;
	}
	public void setT_appregyhp_chuku_userid(String tAppregyhpChukuUserid) {
		t_appregyhp_chuku_userid = tAppregyhpChukuUserid;
	}
	public String getT_appregyhp_chuku_username() {
		return t_appregyhp_chuku_username;
	}
	public void setT_appregyhp_chuku_username(String tAppregyhpChukuUsername) {
		t_appregyhp_chuku_username = tAppregyhpChukuUsername;
	}
	public String getT_appregyhp_chuku_date() {
		return t_appregyhp_chuku_date;
	}
	public void setT_appregyhp_chuku_date(String tAppregyhpChukuDate) {
		t_appregyhp_chuku_date = tAppregyhpChukuDate;
	}
	
	
	

}
