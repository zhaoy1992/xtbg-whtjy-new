package com.chinacreator.xtbg.core.common.note.entity;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *<p>Title:NoteDetailHisBean.java</p>
 *<p>Description:短信历史接收实体</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-17
 */
public class NoteDetailHisBean implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String recv_id; // 接收id
	private String buffer_id; // 短信id
	private String phone_num; // 接收号码
	private String user_id; // 接收人id
	private String user_name; // 接收人姓名
	private String org_id; // 接收人单位id
	private String org_name; // 接收人单位名称
	private String response_id; // 短信发送的响应id
	private String response_status; // 短信回执状态(已发送，发送成功，发送失败)
	private Timestamp status_date; // 回执时间
	private String response_content; // 回复短信内容
	private Timestamp content_date; // 回复短信时间

	/**
	 * <b>Summary: 获取接收id</b>
	 */
	public String getRecv_id() {
		return recv_id;
	}

	/**
	 * <b>Summary: 设置接收id</b>
	 */
	public void setRecv_id(String recv_id) {
		this.recv_id = recv_id;
	}

	/**
	 * <b>Summary: 获取短信id</b>
	 */
	public String getBuffer_id() {
		return buffer_id;
	}

	/**
	 * <b>Summary: 设置短信id</b>
	 */
	public void setBuffer_id(String buffer_id) {
		this.buffer_id = buffer_id;
	}

	/**
	 * <b>Summary: 获取接收号码</b>
	 */
	public String getPhone_num() {
		return phone_num;
	}

	/**
	 * <b>Summary: 设置接收号码</b>
	 */
	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}

	/**
	 * <b>Summary: 获取接收人id</b>
	 */
	public String getUser_id() {
		return user_id;
	}

	/**
	 * <b>Summary: 设置接收人id</b>
	 */
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	/**
	 * <b>Summary: 获取接收人姓名</b>
	 */
	public String getUser_name() {
		return user_name;
	}

	/**
	 * <b>Summary: 设置接收人姓名</b>
	 */
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	/**
	 * <b>Summary: 获取接收人单位id</b>
	 */
	public String getOrg_id() {
		return org_id;
	}

	/**
	 * <b>Summary: 设置接收人单位id</b>
	 */
	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}

	/**
	 * <b>Summary: 获取接收人单位名称</b>
	 */
	public String getOrg_name() {
		return org_name;
	}

	/**
	 * <b>Summary: 设置接收人单位名称</b>
	 */
	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}

	/**
	 * <b>Summary: 获取短信发送的响应id</b>
	 */
	public String getResponse_id() {
		return response_id;
	}

	/**
	 * <b>Summary: 设置短信发送的响应id</b>
	 */
	public void setResponse_id(String response_id) {
		this.response_id = response_id;
	}

	/**
	 * <b>Summary: 获取短信回执状态(已发送，发送成功，发送失败)</b>
	 */
	public String getResponse_status() {
		return response_status;
	}

	/**
	 * <b>Summary: 设置短信回执状态(已发送，发送成功，发送失败)</b>
	 */
	public void setResponse_status(String response_status) {
		this.response_status = response_status;
	}

	/**
	 * <b>Summary: 获取回执时间</b>
	 */
	public Timestamp getStatus_date() {
		return status_date;
	}

	/**
	 * <b>Summary: 设置回执时间</b>
	 */
	public void setStatus_date(Timestamp status_date) {
		this.status_date = status_date;
	}

	/**
	 * <b>Summary: 获取回复短信内容</b>
	 */
	public String getResponse_content() {
		return response_content;
	}

	/**
	 * <b>Summary: 设置回复短信内容</b>
	 */
	public void setResponse_content(String response_content) {
		this.response_content = response_content;
	}

	/**
	 * <b>Summary: 获取回复短信时间</b>
	 */
	public Timestamp getContent_date() {
		return content_date;
	}

	/**
	 * <b>Summary: 设置回复短信时间</b>
	 */
	public void setContent_date(Timestamp content_date) {
		this.content_date = content_date;
	}

}
