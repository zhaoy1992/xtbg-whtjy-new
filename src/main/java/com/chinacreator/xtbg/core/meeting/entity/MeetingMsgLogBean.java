package com.chinacreator.xtbg.core.meeting.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:MeetingMsgLog.java</p>
 *<p>Description:会议通知发送消息日志</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-19
 */
public class MeetingMsgLogBean extends XtDbBaseBean {
	
	public MeetingMsgLogBean() {
		super("oa_meeting_msg_log", "m_id");
	}
	
	private String m_id;		//主键
	private String m_notice_id;		//会议通知id
	private String m_contents;		//msg内容
	private String m_msg_type;		//msg类别 短信or信息
	private String m_msg_send_flag;		//发送类型重发、补发、发布、草稿
	private String m_msg_send_flag_name;		//发送类型name
	/**
	*<b>Summary: 获取主键</b>
	*/
	public String getM_id() {
		return m_id;
	}
	/**
	*<b>Summary: 设置主键</b>
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
	*<b>Summary: 获取msg内容</b>
	*/
	public String getM_contents() {
		return m_contents;
	}
	/**
	*<b>Summary: 设置msg内容</b>
	*/
	public void setM_contents(String m_contents) {
		this.m_contents = m_contents;
	}
	/**
	*<b>Summary: 获取msg类别 短信or信息</b>
	*/
	public String getM_msg_type() {
		return m_msg_type;
	}
	/**
	*<b>Summary: 设置msg类别 短信or信息</b>
	*/
	public void setM_msg_type(String m_msg_type) {
		this.m_msg_type = m_msg_type;
	}
	/**
	*<b>Summary: 获取发送类型重发、补发、发布</b>
	*/
	public String getM_msg_send_flag() {
		return m_msg_send_flag;
	}
	/**
	*<b>Summary: 设置发送类型重发、补发、发布</b>
	*/
	public void setM_msg_send_flag(String m_msg_send_flag) {
		this.m_msg_send_flag = m_msg_send_flag;
	}
	/**
	*<b>Summary: 获取发送类型name</b>
	*/
	public String getM_msg_send_flag_name() {
		return m_msg_send_flag_name;
	}
	/**
	*<b>Summary: 设置发送类型name</b>
	*/
	public void setM_msg_send_flag_name(String m_msg_send_flag_name) {
		this.m_msg_send_flag_name = m_msg_send_flag_name;
	}
	
}
