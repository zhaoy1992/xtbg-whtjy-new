package com.chinacreator.xtbg.core.common.im.entity;

import java.sql.Timestamp;

/**
 *<p>Title:IMBean.java</p>
 *<p>Description:即使消息</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-8
 */
public class IMBean {
	
	private String msg_id;//消息id
	
	private String send_user;//发送人
	
	private String recv_user;//接收人
	
	private String msg;//消息
	
	private Timestamp send_date;//发送时间

	public String getMsg_id() {
		return msg_id;
	}

	public void setMsg_id(String msg_id) {
		this.msg_id = msg_id;
	}

	public String getSend_user() {
		return send_user;
	}

	public void setSend_user(String send_user) {
		this.send_user = send_user;
	}

	public String getRecv_user() {
		return recv_user;
	}

	public void setRecv_user(String recv_user) {
		this.recv_user = recv_user;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Timestamp getSend_date() {
		return send_date;
	}

	public void setSend_date(Timestamp send_date) {
		this.send_date = send_date;
	}

}
