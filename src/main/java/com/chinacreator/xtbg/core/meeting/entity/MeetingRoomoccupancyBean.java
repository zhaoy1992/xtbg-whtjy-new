package com.chinacreator.xtbg.core.meeting.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:MeetingRoomoccupancyBean.java</p>
 *<p>Description:会议室占用情况实体Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-28
 */
public class MeetingRoomoccupancyBean extends XtDbBaseBean{

	public MeetingRoomoccupancyBean() {
		super("oa_meeting_roomoccupancy", "m_ro_id");
	}
	
	private String m_ro_id;		//主键id
	private String m_room_id;		//会议室id
	private String m_room_name;		//会议室名称
	private String m_title;		//会议标题
	private Object m_begin_time;		//会议开始时间
	private Object m_end_time;		//会议结束时间
	private String m_link_userid;		//联系人
	private String m_link_tel;		//联系人电话
	/**
	*<b>Summary: 获取联系人</b>
	*/
	public String getM_link_username() {
		return m_link_username;
	}
	/**
	*<b>Summary: 获取联系人</b>
	*/
	public void setM_link_username(String m_link_username) {
		this.m_link_username = m_link_username;
	}

	private String m_link_username; //联系人
	/**
	*<b>Summary: 获取主键id</b>
	*/
	public String getM_ro_id() {
		return m_ro_id;
	}
	/**
	*<b>Summary: 设置主键id</b>
	*/
	public void setM_ro_id(String m_ro_id) {
		this.m_ro_id = m_ro_id;
	}
	/**
	*<b>Summary: 获取会议室id</b>
	*/
	public String getM_room_id() {
		return m_room_id;
	}
	/**
	*<b>Summary: 设置会议室id</b>
	*/
	public void setM_room_id(String m_room_id) {
		this.m_room_id = m_room_id;
	}
	/**
	*<b>Summary: 获取会议室名称</b>
	*/
	public String getM_room_name() {
		return m_room_name;
	}
	/**
	*<b>Summary: 设置会议室名称</b>
	*/
	public void setM_room_name(String m_room_name) {
		this.m_room_name = m_room_name;
	}
	/**
	*<b>Summary: 获取会议标题</b>
	*/
	public String getM_title() {
		return m_title;
	}
	/**
	*<b>Summary: 设置会议标题</b>
	*/
	public void setM_title(String m_title) {
		this.m_title = m_title;
	}
	/**
	*<b>Summary: 获取会议开始时间</b>
	*/
	public Object getM_begin_time() {
		return m_begin_time;
	}
	/**
	*<b>Summary: 设置会议开始时间</b>
	*/
	public void setM_begin_time(Object m_begin_time) {
		this.m_begin_time = m_begin_time;
	}
	/**
	*<b>Summary: 获取会议结束时间</b>
	*/
	public Object getM_end_time() {
		return m_end_time;
	}
	/**
	*<b>Summary: 设置会议结束时间</b>
	*/
	public void setM_end_time(Object m_end_time) {
		this.m_end_time = m_end_time;
	}
	/**
	*<b>Summary: 获取联系人</b>
	*/
	public String getM_link_userid() {
		return m_link_userid;
	}
	/**
	*<b>Summary: 设置联系人</b>
	*/
	public void setM_link_userid(String m_link_userid) {
		this.m_link_userid = m_link_userid;
	}
	/**
	*<b>Summary: 获取联系人电话</b>
	*/
	public String getM_link_tel() {
		return m_link_tel;
	}
	/**
	*<b>Summary: 设置联系人电话</b>
	*/
	public void setM_link_tel(String m_link_tel) {
		this.m_link_tel = m_link_tel;
	}
}
