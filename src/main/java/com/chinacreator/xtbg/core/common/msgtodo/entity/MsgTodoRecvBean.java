package com.chinacreator.xtbg.core.common.msgtodo.entity;

import java.io.Serializable;

/**
 *<p>Title:MsgTodoRecvBean.java</p>
 *<p>Description:统一待办接收实体</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author yin.liu
 *@version 1.0
 *2013-12-10
 */
public class MsgTodoRecvBean implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 接收ID
	 */
	private String recv_id;
	
	/**
	 * 待办ID
	 */
	private String msg_id;
	
	/**
	 * 接收人ID
	 */
	private String recv_userid;
	
	/**
	 * 接收人名称
	 */
	private String recv_username;
	
	/**
	 * 接收人单位ID
	 */
	private String recv_orgid;
	
	/**
	 * 接收人单位名称
	 */
	private String recv_orgname;
	
	/**
	 * 类型(1个人/2单位)
	 */
	private String type;
	
	/**
	 * 状态（备用）
	 */
	private String status;
	
	/**
	 * 备注（备用字段）
	 */
	private String remark;

	public String getRecv_id() {
		return recv_id;
	}

	public void setRecv_id(String recvId) {
		recv_id = recvId;
	}

	public String getMsg_id() {
		return msg_id;
	}

	public void setMsg_id(String msgId) {
		msg_id = msgId;
	}

	public String getRecv_userid() {
		return recv_userid;
	}

	public void setRecv_userid(String recvUserid) {
		recv_userid = recvUserid;
	}

	public String getRecv_username() {
		return recv_username;
	}

	public void setRecv_username(String recvUsername) {
		recv_username = recvUsername;
	}

	public String getRecv_orgid() {
		return recv_orgid;
	}

	public void setRecv_orgid(String recvOrgid) {
		recv_orgid = recvOrgid;
	}

	public String getRecv_orgname() {
		return recv_orgname;
	}

	public void setRecv_orgname(String recvOrgname) {
		recv_orgname = recvOrgname;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
