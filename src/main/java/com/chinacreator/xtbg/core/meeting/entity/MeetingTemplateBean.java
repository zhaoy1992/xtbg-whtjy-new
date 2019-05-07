package com.chinacreator.xtbg.core.meeting.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:MeetingTemplate.java</p>
 *<p>Description:会议通知模板</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-19
 */
public class MeetingTemplateBean extends XtDbBaseBean{	
		
	public MeetingTemplateBean(){
		super("oa_meeting_template","m_tmp_id");
	}
	private String m_begin_time_end ;     //查询时专用（会议召开时间）
	private String m_tmp_id;		//主键id
	private String m_type_id;		//会议类型id
	private String m_type_name;		//会议类型name
	private String m_room_id;		//会议室id
	private String m_room_name;		//会议室name
	private String m_title;		//标题
	private Object m_begin_time;		//会议开始时间
	private Object m_end_time;		//会议结束时间
	private String m_address;		//地点
	private String m_link_user_id;		//联系人（默认当前申请人）
	private String m_link_user_name;		//联系人name
	private String m_link_dept_id;		//联系部门（默认当前申请人所在的部门）
	private String m_link_dept_name;		//部门name
	private String m_link_tel;		//联系电话
	private String m_master_user_id;		//主持人id
	private String m_master_user_name;		//主持人name
	private String m_attender_count;		//与会人数
	private Object m_close_time;		//报名截止日期
	private String m_send_name;		//发送名义（默认为“单位名义发送）
	private String m_contents;		//会议正文
	private String m_is_need_signup;		//是否需要报名（0否1是，默认不报名）
	private String m_receiver_unit_ids;		//参会单位ids
	private String m_receiver_user_ids;		//参会人员ids
	private String m_receiver_other_unit_ids;		//其他参会单位ids
	private String m_receiver_other_user_ids;		//其他参会人员ids
	private String m_receiver_unit_names;		//参会单位names
	private String m_receiver_user_names;		//参会人员names
	private String m_receiver_other_unit_names;		//其他参会单位names
	private String m_receiver_other_user_names;		//其他参会人员names
	private String m_tmp_contents;		//模板说明
	private Object m_tmp_create_time;		//模板登记时间
	private String m_tmp_creator_id;		//模板创建人id
	private String m_tmp_creator_name;		//模板创建人姓名
	private String m_msg_type;		//msg类别 短信or信息
	private String m_msg_contents;		//msg内容
	private String m_tmp_unit_id;		//模板所属单位id
	private String m_tmp_unit_name;		//模板所属单位名
	private String m_tmp_org_id;		//模板所属部门id
	private String m_tmp_org_name;		//模板所属部门名
	/**
	*<b>Summary: 获取主键id</b>
	*/
	public String getM_tmp_id() {
		return m_tmp_id;
	}
	/**
	*<b>Summary: 设置主键id</b>
	*/
	public void setM_tmp_id(String m_tmp_id) {
		this.m_tmp_id = m_tmp_id;
	}
	/**
	*<b>Summary: 获取会议类型id</b>
	*/
	public String getM_type_id() {
		return m_type_id;
	}
	/**
	*<b>Summary: 设置会议类型id</b>
	*/
	public void setM_type_id(String m_type_id) {
		this.m_type_id = m_type_id;
	}
	/**
	*<b>Summary: 获取会议类型name</b>
	*/
	public String getM_type_name() {
		return m_type_name;
	}
	/**
	*<b>Summary: 设置会议类型name</b>
	*/
	public void setM_type_name(String m_type_name) {
		this.m_type_name = m_type_name;
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
	*<b>Summary: 获取会议室name</b>
	*/
	public String getM_room_name() {
		return m_room_name;
	}
	/**
	*<b>Summary: 设置会议室name</b>
	*/
	public void setM_room_name(String m_room_name) {
		this.m_room_name = m_room_name;
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
	*<b>Summary: 获取地点</b>
	*/
	public String getM_address() {
		return m_address;
	}
	/**
	*<b>Summary: 设置地点</b>
	*/
	public void setM_address(String m_address) {
		this.m_address = m_address;
	}
	/**
	*<b>Summary: 获取联系人（默认当前申请人）</b>
	*/
	public String getM_link_user_id() {
		return m_link_user_id;
	}
	/**
	*<b>Summary: 设置联系人（默认当前申请人）</b>
	*/
	public void setM_link_user_id(String m_link_user_id) {
		this.m_link_user_id = m_link_user_id;
	}
	/**
	*<b>Summary: 获取联系人name</b>
	*/
	public String getM_link_user_name() {
		return m_link_user_name;
	}
	/**
	*<b>Summary: 设置联系人name</b>
	*/
	public void setM_link_user_name(String m_link_user_name) {
		this.m_link_user_name = m_link_user_name;
	}
	/**
	*<b>Summary: 获取联系部门（默认当前申请人所在的部门）</b>
	*/
	public String getM_link_dept_id() {
		return m_link_dept_id;
	}
	/**
	*<b>Summary: 设置联系部门（默认当前申请人所在的部门）</b>
	*/
	public void setM_link_dept_id(String m_link_dept_id) {
		this.m_link_dept_id = m_link_dept_id;
	}
	/**
	*<b>Summary: 获取部门name</b>
	*/
	public String getM_link_dept_name() {
		return m_link_dept_name;
	}
	/**
	*<b>Summary: 设置部门name</b>
	*/
	public void setM_link_dept_name(String m_link_dept_name) {
		this.m_link_dept_name = m_link_dept_name;
	}
	/**
	*<b>Summary: 获取联系电话</b>
	*/
	public String getM_link_tel() {
		return m_link_tel;
	}
	/**
	*<b>Summary: 设置联系电话</b>
	*/
	public void setM_link_tel(String m_link_tel) {
		this.m_link_tel = m_link_tel;
	}
	/**
	*<b>Summary: 获取主持人id</b>
	*/
	public String getM_master_user_id() {
		return m_master_user_id;
	}
	/**
	*<b>Summary: 设置主持人id</b>
	*/
	public void setM_master_user_id(String m_master_user_id) {
		this.m_master_user_id = m_master_user_id;
	}
	/**
	*<b>Summary: 获取主持人name</b>
	*/
	public String getM_master_user_name() {
		return m_master_user_name;
	}
	/**
	*<b>Summary: 设置主持人name</b>
	*/
	public void setM_master_user_name(String m_master_user_name) {
		this.m_master_user_name = m_master_user_name;
	}
	/**
	*<b>Summary: 获取与会人数</b>
	*/
	public String getM_attender_count() {
		return m_attender_count;
	}
	/**
	*<b>Summary: 设置与会人数</b>
	*/
	public void setM_attender_count(String m_attender_count) {
		this.m_attender_count = m_attender_count;
	}
	/**
	*<b>Summary: 获取报名截止日期</b>
	*/
	public Object getM_close_time() {
		return m_close_time;
	}
	/**
	*<b>Summary: 设置报名截止日期</b>
	*/
	public void setM_close_time(Object m_close_time) {
		this.m_close_time = m_close_time;
	}
	/**
	*<b>Summary: 获取发送名义（默认为“单位名义发送）</b>
	*/
	public String getM_send_name() {
		return m_send_name;
	}
	/**
	*<b>Summary: 设置发送名义（默认为“单位名义发送）</b>
	*/
	public void setM_send_name(String m_send_name) {
		this.m_send_name = m_send_name;
	}
	/**
	*<b>Summary: 获取会议正文</b>
	*/
	public String getM_contents() {
		return m_contents;
	}
	/**
	*<b>Summary: 设置会议正文</b>
	*/
	public void setM_contents(String m_contents) {
		this.m_contents = m_contents;
	}
	/**
	*<b>Summary: 获取是否需要报名（0否1是，默认不报名）</b>
	*/
	public String getM_is_need_signup() {
		return m_is_need_signup;
	}
	/**
	*<b>Summary: 设置是否需要报名（0否1是，默认不报名）</b>
	*/
	public void setM_is_need_signup(String m_is_need_signup) {
		this.m_is_need_signup = m_is_need_signup;
	}
	/**
	*<b>Summary: 获取参会单位ids</b>
	*/
	public String getM_receiver_unit_ids() {
		return m_receiver_unit_ids;
	}
	/**
	*<b>Summary: 设置参会单位ids</b>
	*/
	public void setM_receiver_unit_ids(String m_receiver_unit_ids) {
		this.m_receiver_unit_ids = m_receiver_unit_ids;
	}
	/**
	*<b>Summary: 获取参会人员ids</b>
	*/
	public String getM_receiver_user_ids() {
		return m_receiver_user_ids;
	}
	/**
	*<b>Summary: 设置参会人员ids</b>
	*/
	public void setM_receiver_user_ids(String m_receiver_user_ids) {
		this.m_receiver_user_ids = m_receiver_user_ids;
	}
	/**
	*<b>Summary: 获取其他参会单位ids</b>
	*/
	public String getM_receiver_other_unit_ids() {
		return m_receiver_other_unit_ids;
	}
	/**
	*<b>Summary: 设置其他参会单位ids</b>
	*/
	public void setM_receiver_other_unit_ids(String m_receiver_other_unit_ids) {
		this.m_receiver_other_unit_ids = m_receiver_other_unit_ids;
	}
	/**
	*<b>Summary: 获取其他参会人员ids</b>
	*/
	public String getM_receiver_other_user_ids() {
		return m_receiver_other_user_ids;
	}
	/**
	*<b>Summary: 设置其他参会人员ids</b>
	*/
	public void setM_receiver_other_user_ids(String m_receiver_other_user_ids) {
		this.m_receiver_other_user_ids = m_receiver_other_user_ids;
	}
	/**
	*<b>Summary: 获取参会单位names</b>
	*/
	public String getM_receiver_unit_names() {
		return m_receiver_unit_names;
	}
	/**
	*<b>Summary: 设置参会单位names</b>
	*/
	public void setM_receiver_unit_names(String m_receiver_unit_names) {
		this.m_receiver_unit_names = m_receiver_unit_names;
	}
	/**
	*<b>Summary: 获取参会人员names</b>
	*/
	public String getM_receiver_user_names() {
		return m_receiver_user_names;
	}
	/**
	*<b>Summary: 设置参会人员names</b>
	*/
	public void setM_receiver_user_names(String m_receiver_user_names) {
		this.m_receiver_user_names = m_receiver_user_names;
	}
	/**
	*<b>Summary: 获取其他参会单位names</b>
	*/
	public String getM_receiver_other_unit_names() {
		return m_receiver_other_unit_names;
	}
	/**
	*<b>Summary: 设置其他参会单位names</b>
	*/
	public void setM_receiver_other_unit_names(String m_receiver_other_unit_names) {
		this.m_receiver_other_unit_names = m_receiver_other_unit_names;
	}
	/**
	*<b>Summary: 获取其他参会人员names</b>
	*/
	public String getM_receiver_other_user_names() {
		return m_receiver_other_user_names;
	}
	/**
	*<b>Summary: 设置其他参会人员names</b>
	*/
	public void setM_receiver_other_user_names(String m_receiver_other_user_names) {
		this.m_receiver_other_user_names = m_receiver_other_user_names;
	}
	/**
	*<b>Summary: 获取模板说明</b>
	*/
	public String getM_tmp_contents() {
		return m_tmp_contents;
	}
	/**
	*<b>Summary: 设置模板说明</b>
	*/
	public void setM_tmp_contents(String m_tmp_contents) {
		this.m_tmp_contents = m_tmp_contents;
	}
	/**
	*<b>Summary: 获取模板登记时间</b>
	*/
	public Object getM_tmp_create_time() {
		return m_tmp_create_time;
	}
	/**
	*<b>Summary: 设置模板登记时间</b>
	*/
	public void setM_tmp_create_time(Object m_tmp_create_time) {
		this.m_tmp_create_time = m_tmp_create_time;
	}
	/**
	*<b>Summary: 获取模板创建人id</b>
	*/
	public String getM_tmp_creator_id() {
		return m_tmp_creator_id;
	}
	/**
	*<b>Summary: 设置模板创建人id</b>
	*/
	public void setM_tmp_creator_id(String m_tmp_creator_id) {
		this.m_tmp_creator_id = m_tmp_creator_id;
	}
	/**
	*<b>Summary: 获取模板创建人姓名</b>
	*/
	public String getM_tmp_creator_name() {
		return m_tmp_creator_name;
	}
	/**
	*<b>Summary: 设置模板创建人姓名</b>
	*/
	public void setM_tmp_creator_name(String m_tmp_creator_name) {
		this.m_tmp_creator_name = m_tmp_creator_name;
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
	*<b>Summary: 获取msg内容</b>
	*/
	public String getM_msg_contents() {
		return m_msg_contents;
	}
	/**
	*<b>Summary: 设置msg内容</b>
	*/
	public void setM_msg_contents(String m_msg_contents) {
		this.m_msg_contents = m_msg_contents;
	}
	/**
	*<b>Summary: 获取模板所属单位id</b>
	*/
	public String getM_tmp_unit_id() {
		return m_tmp_unit_id;
	}
	/**
	*<b>Summary: 设置模板所属单位id</b>
	*/
	public void setM_tmp_unit_id(String m_tmp_unit_id) {
		this.m_tmp_unit_id = m_tmp_unit_id;
	}
	/**
	*<b>Summary: 获取模板所属单位名</b>
	*/
	public String getM_tmp_unit_name() {
		return m_tmp_unit_name;
	}
	/**
	*<b>Summary: 设置模板所属单位名</b>
	*/
	public void setM_tmp_unit_name(String m_tmp_unit_name) {
		this.m_tmp_unit_name = m_tmp_unit_name;
	}
	/**
	*<b>Summary: 获取模板所属部门id</b>
	*/
	public String getM_tmp_org_id() {
		return m_tmp_org_id;
	}
	/**
	*<b>Summary: 设置模板所属部门id</b>
	*/
	public void setM_tmp_org_id(String m_tmp_org_id) {
		this.m_tmp_org_id = m_tmp_org_id;
	}
	/**
	*<b>Summary: 获取模板所属部门名</b>
	*/
	public String getM_tmp_org_name() {
		return m_tmp_org_name;
	}
	/**
	*<b>Summary: 设置模板所属部门名</b>
	*/
	public void setM_tmp_org_name(String m_tmp_org_name) {
		this.m_tmp_org_name = m_tmp_org_name;
	}
	public String getM_begin_time_end() {
		return m_begin_time_end;
	}
	public void setM_begin_time_end(String mBeginTimeEnd) {
		m_begin_time_end = mBeginTimeEnd;
	}
	
}
