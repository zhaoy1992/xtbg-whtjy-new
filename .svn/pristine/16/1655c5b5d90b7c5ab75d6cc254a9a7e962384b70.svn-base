package com.chinacreator.xtbg.core.notice.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;


/**
 * 
 *<p>Title:NoticeBaseInfo.java</p>
 *<p>Description:公告基本信息Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-18
 */
public class NoticeBaseInfoBean extends XtDbBaseBean{

	private String n_notice_id;		//公告ID
	private String n_title;		//公告标题
	private String n_content;		//公告内容
	private String n_creator_userid;		//创建人ID
	private String n_creator_username;		//创建人名称
	private String n_creator_time;		//创建时间
	private String n_release_userid;		//发布人id
	private String n_release_username;		//发布人名称
	private Object n_release_time;		//发布时间
	private String n_state;		//公告状态(0暂存，1已发布)
	private String n_attach_id;		//附件ID
	private String n_orgid;		//部门ID
	private String n_orgname;		//部门名称
	private String n_unit_id;		//单位ID
	private String n_unit_name;		//单位名称
	private String n_unit_or_personal;		//单位或个人 (1:单位 0:个人)
	private String n_isphone;		//是否是手机端发送(1:是，0:不是)
	private String n_megtype;		//消息类型(1短信，2站内消息)
	private String n_receiver_userid;		//接收人员ID
	private String n_receiver_username;		//接收人员名称
	private String n_receiver_orgid;		//接收单位ID
	private String n_receiver_orgname;		//接收单位名称
	private String n_is_sms;		//是否是短信(1.是0.否)
	private String n_is_msg;		//是否是站内(1.是0.否)
	private String n_is_mail;		//是否是邮件(1.是0.否)
	private String n_is_rtx;		//是否是j及时(1.是0.否)
	
	private String n_user_id;//当前登录用户id，审核人id
	
	private String n_audit_id;  //审核接收人编号
	private String n_audit_name;//审核接收人名字
	private String n_view;//审核意见
	private String id;//审核意见表主键id
	private String n_audit_state_view;//意见表的审核状态
	private String n_audit_state;//审核意见（主表）
	
	private String n_select_type;//公告类型选择 1普通公告，2公文公告
	
	public String getN_select_type() {
		return n_select_type;
	}
	public void setN_select_type(String n_select_type) {
		this.n_select_type = n_select_type;
	}
	//new add
	private String n_type;   //公告类型
	
	public String getN_type() {//获取公告类型
		return n_type;
	}
	public void setN_type(String n_type) {//设置公告类型
		this.n_type = n_type;
	}
	
	
	public String getN_audit_state_view() {
		return n_audit_state_view;
	}
	public String getN_user_id() {
		return n_user_id;
	}

	public void setN_user_id(String n_user_id) {
		this.n_user_id = n_user_id;
	}
	public void setN_audit_state_view(String n_audit_state_view) {
		this.n_audit_state_view = n_audit_state_view;
	}

	public String getN_view() {
		return n_view;
	}

	public void setN_view(String n_view) {
		this.n_view = n_view;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getN_audit_state() {
		return n_audit_state;
	}
	
	public void setN_audit_state(String n_audit_state) {
		this.n_audit_state = n_audit_state;
	}

	public String getN_audit_id() {
		return n_audit_id;
	}

	public void setN_audit_id(String n_audit_id) {
		this.n_audit_id = n_audit_id;
	}

	public String getN_audit_name() {
		return n_audit_name;
	}

	public void setN_audit_name(String n_audit_name) {
		this.n_audit_name = n_audit_name;
	}
	private String ismeeting;// 0公告   or  1会议
	
	public NoticeBaseInfoBean() {
		//在构造器里面设置好表名和主键，具体进行更新，删除等操作时可以重新设置updateKey，deleteKey，及主键
		super("oa_notice_baseinfo", "n_notice_id");
	}
	
	/**
	*<b>Summary: 获取公告ID</b>
	*/
	public String getN_notice_id() {
		return n_notice_id;
	}
	/**
	*<b>Summary: 设置公告ID</b>
	*/
	public void setN_notice_id(String n_notice_id) {
		this.n_notice_id = n_notice_id;
	}
	/**
	*<b>Summary: 获取公告标题</b>
	*/
	public String getN_title() {
		return n_title;
	}
	/**
	*<b>Summary: 设置公告标题</b>
	*/
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	/**
	*<b>Summary: 获取公告内容</b>
	*/
	public String getN_content() {
		return n_content;
	}
	/**
	*<b>Summary: 设置公告内容</b>
	*/
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	/**
	*<b>Summary: 获取创建人ID</b>
	*/
	public String getN_creator_userid() {
		return n_creator_userid;
	}
	/**
	*<b>Summary: 设置创建人ID</b>
	*/
	public void setN_creator_userid(String n_creator_userid) {
		this.n_creator_userid = n_creator_userid;
	}
	/**
	*<b>Summary: 获取创建人名称</b>
	*/
	public String getN_creator_username() {
		return n_creator_username;
	}
	/**
	*<b>Summary: 设置创建人名称</b>
	*/
	public void setN_creator_username(String n_creator_username) {
		this.n_creator_username = n_creator_username;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public String getN_creator_time() {
		return n_creator_time;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setN_creator_time(String n_creator_time) {
		this.n_creator_time = n_creator_time;
	}
	/**
	*<b>Summary: 获取发布人id</b>
	*/
	public String getN_release_userid() {
		return n_release_userid;
	}
	/**
	*<b>Summary: 设置发布人id</b>
	*/
	public void setN_release_userid(String n_release_userid) {
		this.n_release_userid = n_release_userid;
	}
	/**
	*<b>Summary: 获取发布人名称</b>
	*/
	public String getN_release_username() {
		return n_release_username;
	}
	/**
	*<b>Summary: 设置发布人名称</b>
	*/
	public void setN_release_username(String n_release_username) {
		this.n_release_username = n_release_username;
	}
	/**
	*<b>Summary: 获取发布时间</b>
	*/
	public Object getN_release_time() {
		return n_release_time;
	}
	/**
	*<b>Summary: 设置发布时间</b>
	*/
	public void setN_release_time(Object n_release_time) {
		this.n_release_time = n_release_time;
	}
	/**
	*<b>Summary: 获取公告状态(0暂存，1已发布)</b>
	*/
	public String getN_state() {
		return n_state;
	}
	/**
	*<b>Summary: 设置公告状态(0暂存，1已发布)</b>
	*/
	public void setN_state(String n_state) {
		this.n_state = n_state;
	}
	/**
	*<b>Summary: 获取附件ID</b>
	*/
	public String getN_attach_id() {
		return n_attach_id;
	}
	/**
	*<b>Summary: 设置附件ID</b>
	*/
	public void setN_attach_id(String n_attach_id) {
		this.n_attach_id = n_attach_id;
	}
	/**
	*<b>Summary: 获取部门ID</b>
	*/
	public String getN_orgid() {
		return n_orgid;
	}
	/**
	*<b>Summary: 设置部门ID</b>
	*/
	public void setN_orgid(String n_orgid) {
		this.n_orgid = n_orgid;
	}
	/**
	*<b>Summary: 获取部门名称</b>
	*/
	public String getN_orgname() {
		return n_orgname;
	}
	/**
	*<b>Summary: 设置部门名称</b>
	*/
	public void setN_orgname(String n_orgname) {
		this.n_orgname = n_orgname;
	}
	/**
	*<b>Summary: 获取单位ID</b>
	*/
	public String getN_unit_id() {
		return n_unit_id;
	}
	/**
	*<b>Summary: 设置单位ID</b>
	*/
	public void setN_unit_id(String n_unit_id) {
		this.n_unit_id = n_unit_id;
	}
	/**
	*<b>Summary: 获取单位名称</b>
	*/
	public String getN_unit_name() {
		return n_unit_name;
	}
	/**
	*<b>Summary: 设置单位名称</b>
	*/
	public void setN_unit_name(String n_unit_name) {
		this.n_unit_name = n_unit_name;
	}
	/**
	*<b>Summary: 获取单位或个人 (1:单位 0:个人)</b>
	*/
	public String getN_unit_or_personal() {
		return n_unit_or_personal;
	}
	/**
	*<b>Summary: 设置单位或个人 (1:单位 0:个人)</b>
	*/
	public void setN_unit_or_personal(String n_unit_or_personal) {
		this.n_unit_or_personal = n_unit_or_personal;
	}
	/**
	*<b>Summary: 获取是否是手机端发送(1:是，0:不是)</b>
	*/
	public String getN_isphone() {
		return n_isphone;
	}
	/**
	*<b>Summary: 设置是否是手机端发送(1:是，0:不是)</b>
	*/
	public void setN_isphone(String n_isphone) {
		this.n_isphone = n_isphone;
	}
	/**
	*<b>Summary: 获取消息类型(1短信，2站内消息)</b>
	*/
	public String getN_megtype() {
		return n_megtype;
	}
	/**
	*<b>Summary: 设置消息类型(1短信，2站内消息)</b>
	*/
	public void setN_megtype(String n_megtype) {
		this.n_megtype = n_megtype;
	}
	/**
	*<b>Summary: 获取接收人员ID</b>
	*/
	public String getN_receiver_userid() {
		return n_receiver_userid;
	}
	/**
	*<b>Summary: 设置接收人员ID</b>
	*/
	public void setN_receiver_userid(String n_receiver_userid) {
		this.n_receiver_userid = n_receiver_userid;
	}
	/**
	*<b>Summary: 获取接收人员名称</b>
	*/
	public String getN_receiver_username() {
		return n_receiver_username;
	}
	/**
	*<b>Summary: 设置接收人员名称</b>
	*/
	public void setN_receiver_username(String n_receiver_username) {
		this.n_receiver_username = n_receiver_username;
	}
	/**
	*<b>Summary: 获取接收单位ID</b>
	*/
	public String getN_receiver_orgid() {
		return n_receiver_orgid;
	}
	/**
	*<b>Summary: 设置接收单位ID</b>
	*/
	public void setN_receiver_orgid(String n_receiver_orgid) {
		this.n_receiver_orgid = n_receiver_orgid;
	}
	/**
	*<b>Summary: 获取接收单位名称</b>
	*/
	public String getN_receiver_orgname() {
		return n_receiver_orgname;
	}
	/**
	*<b>Summary: 设置接收单位名称</b>
	*/
	public void setN_receiver_orgname(String n_receiver_orgname) {
		this.n_receiver_orgname = n_receiver_orgname;
	}

	
	/**
	*<b>Summary: </b>
	* getIsmeeting(获取查看类型)
	* @return 
	*/
	public String getIsmeeting() {
		return ismeeting;
	}

	
	/**
	*<b>Summary: </b>
	* setIsmeeting(设置查看类型)
	* @param ismeeting 
	*/
	public void setIsmeeting(String ismeeting) {
		this.ismeeting = ismeeting;
	}
	/**
	*<b>Summary: 获取是否是短信(1.是0.否)</b>
	*/
	public String getN_is_sms() {
		return n_is_sms;
	}
	/**
	*<b>Summary: 设置是否是短信(1.是0.否)</b>
	*/
	public void setN_is_sms(String n_is_sms) {
		this.n_is_sms = n_is_sms;
	}
	/**
	*<b>Summary: 获取是否是站内(1.是0.否)</b>
	*/
	public String getN_is_msg() {
		return n_is_msg;
	}
	/**
	*<b>Summary: 设置是否是站内(1.是0.否)</b>
	*/
	public void setN_is_msg(String n_is_msg) {
		this.n_is_msg = n_is_msg;
	}
	/**
	*<b>Summary: 获取是否是邮件(1.是0.否)</b>
	*/
	public String getN_is_mail() {
		return n_is_mail;
	}
	/**
	*<b>Summary: 设置是否是邮件(1.是0.否)</b>
	*/
	public void setN_is_mail(String n_is_mail) {
		this.n_is_mail = n_is_mail;
	}
	/**
	*<b>Summary: 获取是否是j及时(1.是0.否)</b>
	*/
	public String getN_is_rtx() {
		return n_is_rtx;
	}
	/**
	*<b>Summary: 设置是否是j及时(1.是0.否)</b>
	*/
	public void setN_is_rtx(String n_is_rtx) {
		this.n_is_rtx = n_is_rtx;
	}
	
}
