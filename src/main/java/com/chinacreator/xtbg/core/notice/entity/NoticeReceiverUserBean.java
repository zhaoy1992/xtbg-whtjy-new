package com.chinacreator.xtbg.core.notice.entity;

import java.sql.Timestamp;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:NoticReceiverUserBean.java</p>
 *<p>Description:公告接收人实例Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-18
 */
public class NoticeReceiverUserBean extends XtDbBaseBean{

	
	private String n_receiverid;		//主键ID
	private String n_notice_id;		//公告ID
	private String n_receiver_userid;		//接收人ID
	private String n_receiver_username;		//接收人名称
	private String n_receiveruser_orgid;		//接收人单位ID
	private String n_receiveruser_orgname;		//接收人单位名称
	private String n_isview;		//是否已查看(1:是，0:不是)
	private Timestamp n_creator_time;		//创建时间
	private String n_isdel;		//是否已删除(1:是，0:不是)
	
	private String org_name;//查询是的用的部门条件
	
	public NoticeReceiverUserBean() {
		//在构造器里面设置好表名和主键，具体进行更新，删除等操作时可以重新设置updateKey，deleteKey，及主键
		super("oa_notice_receiver_user", "n_receiverid");
	}
	
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getN_receiverid() {
		return n_receiverid;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setN_receiverid(String n_receiverid) {
		this.n_receiverid = n_receiverid;
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
	*<b>Summary: 获取接收人ID</b>
	*/
	public String getN_receiver_userid() {
		return n_receiver_userid;
	}
	/**
	*<b>Summary: 设置接收人ID</b>
	*/
	public void setN_receiver_userid(String n_receiver_userid) {
		this.n_receiver_userid = n_receiver_userid;
	}
	/**
	*<b>Summary: 获取接收人名称</b>
	*/
	public String getN_receiver_username() {
		return n_receiver_username;
	}
	/**
	*<b>Summary: 设置接收人名称</b>
	*/
	public void setN_receiver_username(String n_receiver_username) {
		this.n_receiver_username = n_receiver_username;
	}
	/**
	*<b>Summary: 获取接收人单位ID</b>
	*/
	public String getN_receiveruser_orgid() {
		return n_receiveruser_orgid;
	}
	/**
	*<b>Summary: 设置接收人单位ID</b>
	*/
	public void setN_receiveruser_orgid(String n_receiveruser_orgid) {
		this.n_receiveruser_orgid = n_receiveruser_orgid;
	}
	/**
	*<b>Summary: 获取接收人单位名称</b>
	*/
	public String getN_receiveruser_orgname() {
		return n_receiveruser_orgname;
	}
	/**
	*<b>Summary: 设置接收人单位名称</b>
	*/
	public void setN_receiveruser_orgname(String n_receiveruser_orgname) {
		this.n_receiveruser_orgname = n_receiveruser_orgname;
	}
	/**
	*<b>Summary: 获取是否已查看(1:是，0:不是)</b>
	*/
	public String getN_isview() {
		return n_isview;
	}
	/**
	*<b>Summary: 设置是否已查看(1:是，0:不是)</b>
	*/
	public void setN_isview(String n_isview) {
		this.n_isview = n_isview;
	}
	/**
	*<b>Summary: 获取创建时间</b>
	*/
	public Timestamp getN_creator_time() {
		return n_creator_time;
	}
	/**
	*<b>Summary: 设置创建时间</b>
	*/
	public void setN_creator_time(Timestamp n_creator_time) {
		this.n_creator_time = n_creator_time;
	}
	/**
	*<b>Summary: 获取是否已删除(1:是，0:不是)</b>
	*/
	public String getN_isdel() {
		return n_isdel;
	}
	/**
	*<b>Summary: 设置是否已删除(1:是，0:不是)</b>
	*/
	public void setN_isdel(String n_isdel) {
		this.n_isdel = n_isdel;
	}

	public String getOrg_name() {
		return org_name;
	}

	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}
	
}
