package com.chinacreator.xtbg.core.notice.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;

/**
 * 
 *<p>Title:NoticMsg.java</p>
 *<p>Description:公告消息实体Bean</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-18
 */
public class NoticeMsgBean extends XtDbBaseBean{

	private String n_msgid;		//主键ID
	private String n_notice_id;		//公告ID
	private String n_megtype;		//消息类型(1短信，2站内消息)
	private String n_msgcontent;		//消息内容
	public NoticeMsgBean() {
		//在构造器里面设置好表名和主键，具体进行更新，删除等操作时可以重新设置updateKey，deleteKey，及主键
		super("OA_NOTICE_MSG", "N_MSGID");
	}
	/**
	*<b>Summary: 获取主键ID</b>
	*/
	public String getN_msgid() {
		return n_msgid;
	}
	/**
	*<b>Summary: 设置主键ID</b>
	*/
	public void setN_msgid(String n_msgid) {
		this.n_msgid = n_msgid;
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
	*<b>Summary: 获取消息内容</b>
	*/
	public String getN_msgcontent() {
		return n_msgcontent;
	}
	/**
	*<b>Summary: 设置消息内容</b>
	*/
	public void setN_msgcontent(String n_msgcontent) {
		this.n_msgcontent = n_msgcontent;
	}
}
