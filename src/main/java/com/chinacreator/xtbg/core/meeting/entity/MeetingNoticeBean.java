package com.chinacreator.xtbg.core.meeting.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:MeetingNotice.java</p>
 *<p>Description:会议通知表</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-19
 */
public class MeetingNoticeBean  extends XtDbBaseBean {	
	public MeetingNoticeBean() {
		super("oa_meeting_notice", "m_notice_id");
	}
	private String m_notice_id;		//会议通知id
	private String m_type_id;		//会议类型id
	private String m_type_name;		//会议类型name
	private String m_room_id;		//会议室id
	private String m_room_name;		//会议室name
	private String m_title;		//标题
	private Object m_begin_time;		//会议开始时间
	private Object m_end_time;		//会议结束时间
	private String m_address;		//地点(默认显示会议室地点)
	private String m_link_user_id;		//联系人（默认当前申请人）
	private String m_link_user_name;		//联系人name
	private String m_link_dept_id;		//联系部门（默认当前申请人所在的部门）
	private String m_link_dept_name;		//联系部门name
	private String m_link_tel;		//联系电话
	private String m_master_user_id;		//主持人
	private String m_master_user_name;		//主持人name
	private String m_attender_count;		//与会人数
	private Object m_close_time;		//报名截止日期
	private String m_send_name;		//发送名义（默认为“单位名义发送）
	private String m_contents;		//会议正文
	private String m_is_need_signup;		//是否需要报名（0否1是，默认不报名）
	private String m_create_user_id;		//申请人id
	private String m_create_user_name;		//申请人name
	private Object m_create_time;		//申请时间
	private String m_create_dept_id;		//申请人部门id
	private String m_create_dept_name;		//申请人部门name
	
	private String m_check_flag;		//会议通知状态(见后台静态常量)
	private String m_check_flag_name;		//会议通知状态name
	
	private String m_check_user_id;		//审核人id
	private String m_check_user_name;		//审核人name
	private Object m_check_time;		//审核时间
	
	private String m_current_user_id;		//发布人id
	private String m_current_user_name;		//发布人name
	private Object m_current_time;		//发布时间
	
	private String m_is_addsend;		//是否补发(1是,0否,默认0)
	private String m_is_resend;		//是否重发(1是,0否,默认0)
	private String m_receiver_unit_ids;		//参会单位ids
	private String m_receiver_user_ids;		//参会人员ids
	private String m_receiver_other_unit_ids;		//其他参会单位ids
	private String m_receiver_other_user_ids;		//其他参会人员ids
	private String m_receiver_unit_names;		//参会单位names
	private String m_receiver_user_names;		//参会人员names
	private String m_receiver_other_unit_names;		//其他参会单位names
	private String m_receiver_other_user_names;		//其他参会人员names
	private String m_djbh;		//附件id
	private String m_remark;		//备注
	
	private String m_reg_user_id; //会议室管理员id
	private String m_reg_user_name; //会议室管理员name
	
	private String m_update_user_id;		//更新人id
	private String m_update_user_name;		//更新人name

	private String administrator_ids;     //会议室管理员ids
	private String administrator_names;     //会议室管理员names
	
	private String signup_percent;    //报名率
	private String read_percent;    //阅读率
	
	private String m_begin_time_end; //查询专用，开始时间范围
	
	private String m_other_user_input;
	
	private String m_create_unit_id;		//申请人单位id
	private String m_create_unit_name;		//申请人单位name
	
	private String is_sms;		//是否短信(1是,0否)
	private String is_msg;		//是否站内消息(1是,0否)
	private String is_rtx;		//是否及时消息(1是,0否)
	private String is_mail;		//是否邮件(1是,0否)
	
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
	*<b>Summary: 获取地点(默认显示会议室地点)</b>
	*/
	public String getM_address() {
		return m_address;
	}
	/**
	*<b>Summary: 设置地点(默认显示会议室地点)</b>
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
	*<b>Summary: 获取联系部门name</b>
	*/
	public String getM_link_dept_name() {
		return m_link_dept_name;
	}
	/**
	*<b>Summary: 设置联系部门name</b>
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
	*<b>Summary: 获取主持人</b>
	*/
	public String getM_master_user_id() {
		return m_master_user_id;
	}
	/**
	*<b>Summary: 设置主持人</b>
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
	*<b>Summary: 获取申请人id</b>
	*/
	public String getM_create_user_id() {
		return m_create_user_id;
	}
	/**
	*<b>Summary: 设置申请人id</b>
	*/
	public void setM_create_user_id(String m_create_user_id) {
		this.m_create_user_id = m_create_user_id;
	}
	/**
	*<b>Summary: 获取申请人name</b>
	*/
	public String getM_create_user_name() {
		return m_create_user_name;
	}
	/**
	*<b>Summary: 设置申请人name</b>
	*/
	public void setM_create_user_name(String m_create_user_name) {
		this.m_create_user_name = m_create_user_name;
	}
	/**
	*<b>Summary: 获取申请时间</b>
	*/
	public Object getM_create_time() {
		return m_create_time;
	}
	/**
	*<b>Summary: 设置申请时间</b>
	*/
	public void setM_create_time(Object m_create_time) {
		this.m_create_time = m_create_time;
	}
	/**
	*<b>Summary: 获取申请人部门id</b>
	*/
	public String getM_create_dept_id() {
		return m_create_dept_id;
	}
	/**
	*<b>Summary: 设置申请人部门id</b>
	*/
	public void setM_create_dept_id(String m_create_dept_id) {
		this.m_create_dept_id = m_create_dept_id;
	}
	/**
	*<b>Summary: 获取申请人部门name</b>
	*/
	public String getM_create_dept_name() {
		return m_create_dept_name;
	}
	/**
	*<b>Summary: 设置申请人部门name</b>
	*/
	public void setM_create_dept_name(String m_create_dept_name) {
		this.m_create_dept_name = m_create_dept_name;
	}
	/**
	*<b>Summary: 获取会议通知状态(见后台静态常量)</b>
	*/
	public String getM_check_flag() {
		return m_check_flag;
	}
	/**
	*<b>Summary: 设置会议通知状态(见后台静态常量)</b>
	*/
	public void setM_check_flag(String m_check_flag) {
		this.m_check_flag = m_check_flag;
	}
	/**
	*<b>Summary: 获取会议通知状态name</b>
	*/
	public String getM_check_flag_name() {
		return m_check_flag_name;
	}
	/**
	*<b>Summary: 设置会议通知状态name</b>
	*/
	public void setM_check_flag_name(String m_check_flag_name) {
		this.m_check_flag_name = m_check_flag_name;
	}
	/**
	*<b>Summary: 获取审核人id</b>
	*/
	public String getM_check_user_id() {
		return m_check_user_id;
	}
	/**
	*<b>Summary: 设置审核人id</b>
	*/
	public void setM_check_user_id(String m_check_user_id) {
		this.m_check_user_id = m_check_user_id;
	}
	/**
	*<b>Summary: 获取审核人name</b>
	*/
	public String getM_check_user_name() {
		return m_check_user_name;
	}
	/**
	*<b>Summary: 设置审核人name</b>
	*/
	public void setM_check_user_name(String m_check_user_name) {
		this.m_check_user_name = m_check_user_name;
	}
	/**
	*<b>Summary: 获取审核时间</b>
	*/
	public Object getM_check_time() {
		return m_check_time;
	}
	/**
	*<b>Summary: 设置审核时间</b>
	*/
	public void setM_check_time(Object m_check_time) {
		this.m_check_time = m_check_time;
	}
	/**
	*<b>Summary: 获取发布人id</b>
	*/
	public String getM_current_user_id() {
		return m_current_user_id;
	}
	/**
	*<b>Summary: 设置发布人id</b>
	*/
	public void setM_current_user_id(String m_current_user_id) {
		this.m_current_user_id = m_current_user_id;
	}
	/**
	*<b>Summary: 获取发布人name</b>
	*/
	public String getM_current_user_name() {
		return m_current_user_name;
	}
	/**
	*<b>Summary: 设置发布人name</b>
	*/
	public void setM_current_user_name(String m_current_user_name) {
		this.m_current_user_name = m_current_user_name;
	}
	/**
	*<b>Summary: 获取发布时间</b>
	*/
	public Object getM_current_time() {
		return m_current_time;
	}
	/**
	*<b>Summary: 设置发布时间</b>
	*/
	public void setM_current_time(Object m_current_time) {
		this.m_current_time = m_current_time;
	}
	/**
	*<b>Summary: 获取是否补发(1是,0否,默认0)</b>
	*/
	public String getM_is_addsend() {
		return m_is_addsend;
	}
	/**
	*<b>Summary: 设置是否补发(1是,0否,默认0)</b>
	*/
	public void setM_is_addsend(String m_is_addsend) {
		this.m_is_addsend = m_is_addsend;
	}
	/**
	*<b>Summary: 获取是否重发(1是,0否,默认0)</b>
	*/
	public String getM_is_resend() {
		return m_is_resend;
	}
	/**
	*<b>Summary: 设置是否重发(1是,0否,默认0)</b>
	*/
	public void setM_is_resend(String m_is_resend) {
		this.m_is_resend = m_is_resend;
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
	*<b>Summary: 获取附件id</b>
	*/
	public String getM_djbh() {
		return m_djbh;
	}
	/**
	*<b>Summary: 设置附件id</b>
	*/
	public void setM_djbh(String m_djbh) {
		this.m_djbh = m_djbh;
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
	*<b>Summary: 获取会议室管理员id</b>
	*/
	public String getM_reg_user_id() {
		return m_reg_user_id;
	}
	/**
	*<b>Summary: 设置会议室管理员id</b>
	*/
	public void setM_reg_user_id(String m_reg_user_id) {
		this.m_reg_user_id = m_reg_user_id;
	}
	/**
	*<b>Summary: 获取会议室管理员name</b>
	*/
	public String getM_reg_user_name() {
		return m_reg_user_name;
	}
	/**
	*<b>Summary: 设置会议室管理员name</b>
	*/
	public void setM_reg_user_name(String m_reg_user_name) {
		this.m_reg_user_name = m_reg_user_name;
	}
	/**
	*<b>Summary: 获取更新人id</b>
	*/
	public String getM_update_user_id() {
		return m_update_user_id;
	}
	/**
	*<b>Summary: 设置更新人id</b>
	*/
	public void setM_update_user_id(String m_update_user_id) {
		this.m_update_user_id = m_update_user_id;
	}
	/**
	*<b>Summary: 获取更新人name</b>
	*/
	public String getM_update_user_name() {
		return m_update_user_name;
	}
	/**
	*<b>Summary: 设置更新人name</b>
	*/
	public void setM_update_user_name(String m_update_user_name) {
		this.m_update_user_name = m_update_user_name;
	}
	/**
	*<b>Summary: 获取会议室管理员ids</b>
	*/
	public String getAdministrator_ids() {
		return administrator_ids;
	}
	/**
	*<b>Summary: 设置会议室管理员ids</b>
	*/
	public void setAdministrator_ids(String administrator_ids) {
		this.administrator_ids = administrator_ids;
	}
	/**
	*<b>Summary: 获取会议室管理员names</b>
	*/
	public String getAdministrator_names() {
		return administrator_names;
	}
	/**
	*<b>Summary: 设置会议室管理员names</b>
	*/
	public void setAdministrator_names(String administrator_names) {
		this.administrator_names = administrator_names;
	}
	/**
	*<b>Summary: 获取报名率</b>
	*/
	public String getSignup_percent() {
		return signup_percent;
	}
	/**
	*<b>Summary: 设置报名率</b>
	*/
	public void setSignup_percent(String signup_percent) {
		this.signup_percent = signup_percent;
	}
	/**
	*<b>Summary: 获取阅读率</b>
	*/
	public String getRead_percent() {
		return read_percent;
	}
	/**
	*<b>Summary: 设置阅读率</b>
	*/
	public void setRead_percent(String read_percent) {
		this.read_percent = read_percent;
	}
	public String getM_begin_time_end() {
		return m_begin_time_end;
	}
	public void setM_begin_time_end(String mBeginTimeEnd) {
		m_begin_time_end = mBeginTimeEnd;
	}
	/**
	*<b>Summary: 获取其他用户</b>
	*/
	public String getM_other_user_input() {
		return m_other_user_input;
	}
	/**
	*<b>Summary: 设置其他用户</b>
	*/
	public void setM_other_user_input(String m_other_user_input) {
		this.m_other_user_input = m_other_user_input;
	}
	/**
	*<b>Summary: 获取单位id</b>
	*/
	public String getM_create_unit_id() {
		return m_create_unit_id;
	}
	/**
	*<b>Summary: 设置单位id</b>
	*/
	public void setM_create_unit_id(String m_create_unit_id) {
		this.m_create_unit_id = m_create_unit_id;
	}
	/**
	*<b>Summary: 获取单位name</b>
	*/
	public String getM_create_unit_name() {
		return m_create_unit_name;
	}
	/**
	*<b>Summary: 设置单位name</b>
	*/
	public void setM_create_unit_name(String m_create_unit_name) {
		this.m_create_unit_name = m_create_unit_name;
	}
	
	/**
	*<b>Summary: 获取是否短信(1是,0否)</b>
	*/
	public String getIs_sms() {
		return is_sms;
	}
	/**
	*<b>Summary: 设置是否短信(1是,0否)</b>
	*/
	public void setIs_sms(String is_sms) {
		this.is_sms = is_sms;
	}
	/**
	*<b>Summary: 获取是否站内消息(1是,0否)</b>
	*/
	public String getIs_msg() {
		return is_msg;
	}
	/**
	*<b>Summary: 设置是否站内消息(1是,0否)</b>
	*/
	public void setIs_msg(String is_msg) {
		this.is_msg = is_msg;
	}
	/**
	*<b>Summary: 获取是否及时消息(1是,0否)</b>
	*/
	public String getIs_rtx() {
		return is_rtx;
	}
	/**
	*<b>Summary: 设置是否及时消息(1是,0否)</b>
	*/
	public void setIs_rtx(String is_rtx) {
		this.is_rtx = is_rtx;
	}
	/**
	*<b>Summary: 获取是否邮件(1是,0否)</b>
	*/
	public String getIs_mail() {
		return is_mail;
	}
	/**
	*<b>Summary: 设置是否邮件(1是,0否)</b>
	*/
	public void setIs_mail(String is_mail) {
		this.is_mail = is_mail;
	}
	
}
