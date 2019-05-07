package com.chinacreator.xtbg.core.common.mail.entity;

import java.sql.Timestamp;

/**
 *<p>Title:MailTopicBean.java</p>
 *<p>Description:邮件主题</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-6
 */
public class MailTopicBean {
	
	private String mail_id; // 邮件id
	private String topic; // 邮件主题
	private String content; // 邮件内容
	private String send_user; // 发件人
	private Timestamp send_date; // 发件时间
	private Timestamp create_date;// 创建时间
	private String mail_origin; // 邮件来源：1起草，2转发，3业务发送，4收件
	private String status; // 邮件状态：1草稿，2正在发送，3已发送，4已撤销，5已删除

	/**
	 * <b>Summary: 获取邮件id</b>
	 */
	public String getMail_id() {
		return mail_id;
	}

	/**
	 * <b>Summary: 设置邮件id</b>
	 */
	public void setMail_id(String mail_id) {
		this.mail_id = mail_id;
	}

	/**
	 * <b>Summary: 获取邮件主题</b>
	 */
	public String getTopic() {
		return topic;
	}

	/**
	 * <b>Summary: 设置邮件主题</b>
	 */
	public void setTopic(String topic) {
		this.topic = topic;
	}

	/**
	 * <b>Summary: 获取邮件内容</b>
	 */
	public String getContent() {
		return content;
	}

	/**
	 * <b>Summary: 设置邮件内容</b>
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * <b>Summary: 获取发件人</b>
	 */
	public String getSend_user() {
		return send_user;
	}

	/**
	 * <b>Summary: 设置发件人</b>
	 */
	public void setSend_user(String send_user) {
		this.send_user = send_user;
	}

	/**
	 * <b>Summary: 获取发件时间</b>
	 */
	public Timestamp getSend_date() {
		return send_date;
	}

	/**
	 * <b>Summary: 设置发件时间</b>
	 */
	public void setSend_date(Timestamp send_date) {
		this.send_date = send_date;
	}

	public Timestamp getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}

	/**
	 * <b>Summary: 获取邮件来源：1起草，2转发，3业务发送，4收件</b>
	 */
	public String getMail_origin() {
		return mail_origin;
	}

	/**
	 * <b>Summary: 设置邮件来源：1起草，2转发，3业务发送，4收件</b>
	 */
	public void setMail_origin(String mail_origin) {
		this.mail_origin = mail_origin;
	}

	/**
	 * <b>Summary: 获取邮件状态：1草稿，2正在发送，3已发送，4已撤销，5已删除</b>
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * <b>Summary: 设置邮件状态：1草稿，2正在发送，3已发送，4已撤销，5已删除</b>
	 */
	public void setStatus(String status) {
		this.status = status;
	}
}
