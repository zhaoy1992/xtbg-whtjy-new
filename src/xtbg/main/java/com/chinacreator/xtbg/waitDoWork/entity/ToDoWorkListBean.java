package com.chinacreator.xtbg.waitDoWork.entity;

public class ToDoWorkListBean {
	private String pri_id;//主键
	private String info_type;//信息类别
	private String work_name;//工作名称
	private String input_user;//发起人/部门
	private String start_time;//发起时间
	private String info_state;//信息状态
	private String info_type_showname;//信息类别显示名称
	private String notice_state;
	private String fk_id;//外键ID
	private String m_check_flag_name;//会议模块中审核状态名称
	private String m_check_flag;//会议模块中审核状态
	private String m_reg_user_id;//会议室管理员id
	private String m_reg_user_name;//会议室管理员名称
	private String m_close_time;//报名截止日期
	private String m_is_need_signup;//是否需要报名（0否1是，默认不报名）
	
	public String getNotice_state() {
		return notice_state;
	}
	public void setNotice_state(String notice_state) {
		this.notice_state = notice_state;
	}
	public String getInfo_type_showname() {
		return info_type_showname;
	}
	public void setInfo_type_showname(String infoTypeShowname) {
		info_type_showname = infoTypeShowname;
	}
	public String getPri_id() {
		return pri_id;
	}
	public void setPri_id(String priId) {
		pri_id = priId;
	}
	public String getInfo_type() {
		return info_type;
	}
	public void setInfo_type(String infoType) {
		info_type = infoType;
	}
	public String getWork_name() {
		return work_name;
	}
	public void setWork_name(String workName) {
		work_name = workName;
	}
	public String getInput_user() {
		return input_user;
	}
	public void setInput_user(String inputUser) {
		input_user = inputUser;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String startTime) {
		start_time = startTime;
	}
	public String getInfo_state() {
		return info_state;
	}
	public void setInfo_state(String infoState) {
		info_state = infoState;
	}
	public String getFk_id() {
		return fk_id;
	}
	public void setFk_id(String fk_id) {
		this.fk_id = fk_id;
	}
	public String getM_check_flag_name() {
		return m_check_flag_name;
	}
	public void setM_check_flag_name(String m_check_flag_name) {
		this.m_check_flag_name = m_check_flag_name;
	}
	public String getM_check_flag() {
		return m_check_flag;
	}
	public void setM_check_flag(String m_check_flag) {
		this.m_check_flag = m_check_flag;
	}
	public String getM_reg_user_id() {
		return m_reg_user_id;
	}
	public void setM_reg_user_id(String m_reg_user_id) {
		this.m_reg_user_id = m_reg_user_id;
	}
	public String getM_reg_user_name() {
		return m_reg_user_name;
	}
	public void setM_reg_user_name(String m_reg_user_name) {
		this.m_reg_user_name = m_reg_user_name;
	}
	public String getM_close_time() {
		return m_close_time;
	}
	public void setM_close_time(String m_close_time) {
		this.m_close_time = m_close_time;
	}
	public String getM_is_need_signup() {
		return m_is_need_signup;
	}
	public void setM_is_need_signup(String m_is_need_signup) {
		this.m_is_need_signup = m_is_need_signup;
	}
	
}
