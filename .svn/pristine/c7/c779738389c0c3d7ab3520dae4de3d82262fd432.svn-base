package com.chinacreator.xtbg.core.common.msgcenter.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:MessageSendBean.java</p>
 *<p>Description:站内消息发送实体</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-29
 */
public class MessageSendBean extends XtDbBaseBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private String msg_id; // 消息id
	private String msg_content; // 消息内容
	private String msg_type; //消息类型
	private String msg_url; // 链接地址
	private String send_userid; // 发送人
	private String send_orgid; // 发送人机构id
	private Timestamp send_date; // 发送时间	
	private String recv_userIds;//消息接收人id  多位接收人之间用“,”分割
	
	public MessageSendBean(){
		super("oa_msg_send","msg_id");
	}

	/**
	 * <b>Summary: 获取消息id</b>
	 */
	public String getMsg_id() {
		return msg_id;
	}

	/**
	 * <b>Summary: 设置消息id</b>
	 */
	public void setMsg_id(String msg_id) {
		this.msg_id = msg_id;
	}

	/**
	 * <b>Summary: 获取消息内容</b>
	 */
	public String getMsg_content() {
		return msg_content;
	}

	/**
	 * <b>Summary: 设置消息内容</b>
	 */
	public void setMsg_content(String msg_content) {
		this.msg_content = msg_content;
	}

	/**
	 * <b>Summary: 获取消息类型</b>
	 */
	public String getMsg_type() {
		return msg_type;
	}

	/**
	 * <b>Summary: 设置消息类型</b>
	 */
	public void setMsg_type(String msg_type) {
		this.msg_type = msg_type;
	}

	/**
	 * <b>Summary: 获取链接地址</b>
	 */
	public String getMsg_url() {
		return msg_url;
	}

	/**
	 * <b>Summary: 设置链接地址</b>
	 */
	public void setMsg_url(String msg_url) {
		this.msg_url = msg_url;
	}

	/**
	 * <b>Summary: 获取发送人</b>
	 */
	public String getSend_userid() {
		return send_userid;
	}

	/**
	 * <b>Summary: 设置发送人</b>
	 */
	public void setSend_userid(String send_userid) {
		this.send_userid = send_userid;
	}

	/**
	 * <b>Summary: 获取发送人机构id</b>
	 */
	public String getSend_orgid() {
		return send_orgid;
	}

	/**
	 * <b>Summary: 设置发送人机构id</b>
	 */
	public void setSend_orgid(String send_orgid) {
		this.send_orgid = send_orgid;
	}

	/**
	 * <b>Summary: 获取发送时间</b>
	 */
	public Timestamp getSend_date() {
		return send_date;
	}

	/**
	 * <b>Summary: 设置发送时间</b>
	 */
	public void setSend_date(Timestamp send_date) {
		this.send_date = send_date;
	}

	public String getRecv_userIds() {
		return recv_userIds;
	}

	public void setRecv_userIds(String recv_userIds) {
		this.recv_userIds = recv_userIds;
	}
}
