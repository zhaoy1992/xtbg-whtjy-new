package com.chinacreator.xtbg.core.meeting.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

public class MeetingCheckStatusBean extends XtDbBaseBean{

	public MeetingCheckStatusBean() {
		super("oa_meeting_check_status", "m_id");
	}
	
	private String m_id;		//主键id
	private String m_notice_id;		//会议通知id
	private String m_user_id;		//审核人id
	private String m_user_name;		//审核人name
	private String m_flag;		//审核状态
	private Object m_create_time;		//创建时间
	/**
	*<b>Summary: 获取主键id</b>
	*/
	public String getM_id() {
		return m_id;
	}
	/**
	*<b>Summary: 设置主键id</b>
	*/
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	/**
	*<b>Summary: 获取会议通知id</b>
	*/
	public String getM_notice_id() {
		return m_notice_id;
	}
	/**
	*<b>Summary: 设置会议通知id</b>
	*/
	public void setM_notice_id(String m_notice_id) {
		this.m_notice_id = m_notice_id;
	}
	/**
	*<b>Summary: 获取审核人id</b>
	*/
	public String getM_user_id() {
		return m_user_id;
	}
	/**
	*<b>Summary: 设置审核人id</b>
	*/
	public void setM_user_id(String m_user_id) {
		this.m_user_id = m_user_id;
	}
	/**
	*<b>Summary: 获取审核人name</b>
	*/
	public String getM_user_name() {
		return m_user_name;
	}
	/**
	*<b>Summary: 设置审核人name</b>
	*/
	public void setM_user_name(String m_user_name) {
		this.m_user_name = m_user_name;
	}
	/**
	*<b>Summary: 获取审核状态</b>
	*/
	public String getM_flag() {
		return m_flag;
	}
	/**
	*<b>Summary: 设置审核状态</b>
	*/
	public void setM_flag(String m_flag) {
		this.m_flag = m_flag;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public Object getM_create_time() {
		return m_create_time;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setM_create_time(Object m_create_time) {
		this.m_create_time = m_create_time;
	}
	
}
