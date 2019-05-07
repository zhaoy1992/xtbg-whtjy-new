package com.chinacreator.xtbg.core.common.msgcenter.entity;

import java.io.Serializable;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 *<p>Title:MessageRecvBean.java</p>
 *<p>Description:站内消息接收实体</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-5-29
 */
public class MessageRecvBean extends XtDbBaseBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private String recv_id; // 接收id
	private String msg_id; // 消息id
	private String recv_userid; // 接收人id
	private String recv_orgid; // 接收人单位id
	private String isread; // 是否已阅 默认为未读
	private Object read_date; // 阅读时间
	private String ishidden; // 是否隐藏  默认不隐藏

	public MessageRecvBean(){
		super("oa_msg_recv","recv_id");
	}
	
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
	 * <b>Summary: 获取接收人id</b>
	 */
	public String getRecv_userid() {
		return recv_userid;
	}

	/**
	 * <b>Summary: 设置接收人id</b>
	 */
	public void setRecv_userid(String recv_userid) {
		this.recv_userid = recv_userid;
	}

	/**
	 * <b>Summary: 获取接收人单位id</b>
	 */
	public String getRecv_orgid() {
		return recv_orgid;
	}

	/**
	 * <b>Summary: 设置接收人单位id</b>
	 */
	public void setRecv_orgid(String recv_orgid) {
		this.recv_orgid = recv_orgid;
	}

	/**
	 * <b>Summary: 获取是否已阅</b>
	 */
	public String getIsread() {
		return isread;
	}

	/**
	 * <b>Summary: 设置是否已阅</b>
	 */
	public void setIsread(String isread) {
		this.isread = isread;
	}

	/**
	 * <b>Summary: 获取阅读时间</b>
	 */
	public Object getRead_date() {
		return read_date;
	}

	/**
	 * <b>Summary: 设置阅读时间</b>
	 */
	public void setRead_date(Object read_date) {
		this.read_date = read_date;
	}

	/**
	 * <b>Summary: 获取是否隐藏</b>
	 */
	public String getIshidden() {
		return ishidden;
	}

	/**
	 * <b>Summary: 设置是否隐藏</b>
	 */
	public void setIshidden(String ishidden) {
		this.ishidden = ishidden;
	}

}
