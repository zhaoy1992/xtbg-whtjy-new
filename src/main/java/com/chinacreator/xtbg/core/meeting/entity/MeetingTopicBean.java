package com.chinacreator.xtbg.core.meeting.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:MeetingTopic.java</p>
 *<p>Description:会议议题表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-19
 */
public class MeetingTopicBean extends XtDbBaseBean{
	private static final long serialVersionUID = 1L;
	
	public MeetingTopicBean() {
		super("oa_meeting_topic", "m_topic_id");
	}
	
	private String m_topic_id;		//议题id
	private String m_notice_id;		//会议通知id
	private String m_topic_name;		//议题名称
	private Object m_begin_time;		//开始时间
	private String m_user_id;		//汇报人id
	private String m_user_name;		//汇报人name
	private String m_remark;		//备注
	private String m_topic_unit_ids;		//议题参与单位ids
	private String m_topic_user_ids;		//议题参与人员ids
	private String m_topic_unit_names;		//议题参与单位names
	private String m_topic_user_names;		//议题参与单位names
	/**
	*<b>Summary: 获取议题id</b>
	*/
	public String getM_topic_id() {
		return m_topic_id;
	}
	/**
	*<b>Summary: 设置议题id</b>
	*/
	public void setM_topic_id(String m_topic_id) {
		this.m_topic_id = m_topic_id;
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
	*<b>Summary: 获取议题名称</b>
	*/
	public String getM_topic_name() {
		return m_topic_name;
	}
	/**
	*<b>Summary: 设置议题名称</b>
	*/
	public void setM_topic_name(String m_topic_name) {
		this.m_topic_name = m_topic_name;
	}
	/**
	*<b>Summary: 获取开始时间</b>
	*/
	public Object getM_begin_time() {
		return m_begin_time;
	}
	/**
	*<b>Summary: 设置开始时间</b>
	*/
	public void setM_begin_time(Object m_begin_time) {
		this.m_begin_time = m_begin_time;
	}
	/**
	*<b>Summary: 获取汇报人id</b>
	*/
	public String getM_user_id() {
		return m_user_id;
	}
	/**
	*<b>Summary: 设置汇报人id</b>
	*/
	public void setM_user_id(String m_user_id) {
		this.m_user_id = m_user_id;
	}
	/**
	*<b>Summary: 获取汇报人name</b>
	*/
	public String getM_user_name() {
		return m_user_name;
	}
	/**
	*<b>Summary: 设置汇报人name</b>
	*/
	public void setM_user_name(String m_user_name) {
		this.m_user_name = m_user_name;
	}
	/**
	*<b>Summary: 获取备注</b>
	*/
	public String getM_remark() {
		return m_remark;
	}
	/**
	*<b>Summary: 设置备注</b>
	*/
	public void setM_remark(String m_remark) {
		this.m_remark = m_remark;
	}
	/**
	*<b>Summary: 获取议题参与单位ids</b>
	*/
	public String getM_topic_unit_ids() {
		return m_topic_unit_ids;
	}
	/**
	*<b>Summary: 设置议题参与单位ids</b>
	*/
	public void setM_topic_unit_ids(String m_topic_unit_ids) {
		this.m_topic_unit_ids = m_topic_unit_ids;
	}
	/**
	*<b>Summary: 获取议题参与人员ids</b>
	*/
	public String getM_topic_user_ids() {
		return m_topic_user_ids;
	}
	/**
	*<b>Summary: 设置议题参与人员ids</b>
	*/
	public void setM_topic_user_ids(String m_topic_user_ids) {
		this.m_topic_user_ids = m_topic_user_ids;
	}
	/**
	*<b>Summary: 获取议题参与单位names</b>
	*/
	public String getM_topic_unit_names() {
		return m_topic_unit_names;
	}
	/**
	*<b>Summary: 设置议题参与单位names</b>
	*/
	public void setM_topic_unit_names(String m_topic_unit_names) {
		this.m_topic_unit_names = m_topic_unit_names;
	}
	/**
	*<b>Summary: 获取议题参与单位names</b>
	*/
	public String getM_topic_user_names() {
		return m_topic_user_names;
	}
	/**
	*<b>Summary: 设置议题参与单位names</b>
	*/
	public void setM_topic_user_names(String m_topic_user_names) {
		this.m_topic_user_names = m_topic_user_names;
	}
}
