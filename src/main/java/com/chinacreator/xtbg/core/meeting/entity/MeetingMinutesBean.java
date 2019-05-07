package com.chinacreator.xtbg.core.meeting.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:MeetingMinutes.java</p>
 *<p>Description:会议纪要表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-19
 */
public class MeetingMinutesBean extends XtDbBaseBean{
	private static final long serialVersionUID = 1L;
	private String m_minutes_id;		//主键id
	private String m_current_flag;		//状态(0 草稿（暂存）、1发布)
	private String m_title;		        //标题
	private String m_contents;		    //内容
	private String m_reg_user_id;		//登记人id
	private String m_reg_user_name;		//登记人name
	private Object m_reg_time;		    //登记时间
	private String m_attach_id;		    //附件id
	private String m_notice_id;         //会议id
	private Object m_begin_time;        //会议开始时间
	private String m_read_person_ids;   //会议纪要阅读人员id
	private String m_read_person_names; //会议纪要阅读人员姓名
	
	private String m_begin_time_end ;     //查询时专用（会议召开时间）
	
	public MeetingMinutesBean(){
		super("oa_meeting_minutes","m_minutes_id");
	}
	/**
	*<b>Summary: 获取主键id</b>
	*/
	public String getM_minutes_id() {
		return m_minutes_id;
	}
	/**
	*<b>Summary: 设置主键id</b>
	*/
	public void setM_minutes_id(String m_minutes_id) {
		this.m_minutes_id = m_minutes_id;
	}
	/**
	*<b>Summary: 获取状态(3草稿（暂存）、1发布)</b>
	*/
	public String getM_current_flag() {
		return m_current_flag;
	}
	/**
	*<b>Summary: 设置状态(3草稿（暂存）、1发布)</b>
	*/
	public void setM_current_flag(String m_current_flag) {
		this.m_current_flag = m_current_flag;
	}
	/**
	*<b>Summary: 获取标题</b>
	*/
	public String getM_title() {
		return m_title;
	}
	/**
	*<b>Summary: 设置标题</b>
	*/
	public void setM_title(String m_title) {
		this.m_title = m_title;
	}
	/**
	*<b>Summary: 获取内容</b>
	*/
	public String getM_contents() {
		return m_contents;
	}
	/**
	*<b>Summary: 设置内容</b>
	*/
	public void setM_contents(String m_contents) {
		this.m_contents = m_contents;
	}
	/**
	*<b>Summary: 获取登记人id</b>
	*/
	public String getM_reg_user_id() {
		return m_reg_user_id;
	}
	/**
	*<b>Summary: 设置登记人id</b>
	*/
	public void setM_reg_user_id(String m_reg_user_id) {
		this.m_reg_user_id = m_reg_user_id;
	}
	/**
	*<b>Summary: 获取登记人name</b>
	*/
	public String getM_reg_user_name() {
		return m_reg_user_name;
	}
	/**
	*<b>Summary: 设置登记人name</b>
	*/
	public void setM_reg_user_name(String m_reg_user_name) {
		this.m_reg_user_name = m_reg_user_name;
	}
	/**
	*<b>Summary: 获取登记时间</b>
	*/
	public Object getM_reg_time() {
		return m_reg_time;
	}
	/**
	*<b>Summary: 设置登记时间</b>
	*/
	public void setM_reg_time(Object m_reg_time) {
		this.m_reg_time = m_reg_time;
	}
	/**
	*<b>Summary: 获取附件id</b>
	*/
	public String getM_attach_id() {
		return m_attach_id;
	}
	/**
	*<b>Summary: 设置附件id</b>
	*/
	public void setM_attach_id(String m_attach_id) {
		this.m_attach_id = m_attach_id;
	}
	public String getM_notice_id() {
		return m_notice_id;
	}
	public void setM_notice_id(String mNoticeId) {
		m_notice_id = mNoticeId;
	}
	public Object getM_begin_time() {
		return m_begin_time;
	}
	public void setM_begin_time(Object mBeginTime) {
		m_begin_time = mBeginTime;
	}
	public String getM_read_person_ids() {
		return m_read_person_ids;
	}
	public void setM_read_person_ids(String mReadPersonIds) {
		m_read_person_ids = mReadPersonIds;
	}
	public String getM_read_person_names() {
		return m_read_person_names;
	}
	public void setM_read_person_names(String mReadPersonNames) {
		m_read_person_names = mReadPersonNames;
	}
	public String getM_begin_time_end() {
		return m_begin_time_end;
	}
	public void setM_begin_time_end(String mRegTimeEnd) {
		m_begin_time_end = mRegTimeEnd;
	}	

}
