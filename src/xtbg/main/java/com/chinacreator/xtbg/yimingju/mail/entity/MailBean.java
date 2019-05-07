package com.chinacreator.xtbg.yimingju.mail.entity;

/**
 *<p>
 * Title:邮件Bean
 * </p>
 *<p>
 * Description:
 * </p>
 *<p>
 * Copyright:Copyright (c) 2012
 * </p>
 *<p>
 * Company:湖南科创
 * </p>
 * 
 * @author dijun.sheng
 *@version 1.0 2012-11-15
 */
public class MailBean {
	private String mid; // 邮件ID
	private String title; // 邮件标题
	private String createtime; // 发送时间
	private String attachment_id; // 附件ID
	private String state; // 状态：0 草稿 1发送 -1删除（报销；主要用于删除已发送邮件）
	private String deptid; // 发件人部门ID
	private String deptname; // 发件人部门名称
	private String sendpid; // 发件人ID
	private String sendpname; // 发件人名称
	private String dxtzjsr; // 是否短信通知收件人
	private String content; // 内容
	private String receivepid; // 收件人
	private String receivepname; // 收件人名称
	private String readstate; // 状态(是否阅读)
	private String use_starttime; // 开始日期
	private String use_endtime; // 结束日期
	private Integer number; // 结束日期

	private String isType;// 短信提醒
	private String message_info;// 短信内容 
	public String getMessage_info() {
		return message_info;
	}
	
	public void setMessage_info(String message_info) {
		this.message_info = message_info;
	}

	public String getIsType() {
		return isType;
	}

	public void setIsType(String isType) {
		this.isType = isType;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getReadstate() {
		return readstate;
	}

	public void setReadstate(String readstate) {
		this.readstate = readstate;
	}

	public String getReceivepid() {
		return receivepid;
	}

	public String getUse_starttime() {
		return use_starttime;
	}

	public void setUse_starttime(String use_starttime) {
		this.use_starttime = use_starttime;
	}

	public String getUse_endtime() {
		return use_endtime;
	}

	public void setUse_endtime(String use_endtime) {
		this.use_endtime = use_endtime;
	}

	public void setReceivepid(String receivepid) {
		this.receivepid = receivepid;
	}

	public String getReceivepname() {
		return receivepname;
	}

	public void setReceivepname(String receivepname) {
		this.receivepname = receivepname;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getAttachment_id() {
		return attachment_id;
	}

	public void setAttachment_id(String attachment_id) {
		this.attachment_id = attachment_id;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getDeptid() {
		return deptid;
	}

	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}

	public String getDeptname() {
		return deptname;
	}

	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}

	public String getSendpid() {
		return sendpid;
	}

	public void setSendpid(String sendpid) {
		this.sendpid = sendpid;
	}

	public String getSendpname() {
		return sendpname;
	}

	public void setSendpname(String sendpname) {
		this.sendpname = sendpname;
	}

	public String getDxtzjsr() {
		return dxtzjsr;
	}

	public void setDxtzjsr(String dxtzjsr) {
		this.dxtzjsr = dxtzjsr;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
