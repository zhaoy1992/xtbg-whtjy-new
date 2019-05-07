package com.chinacreator.xtbg.yimingju.mail.entity;

import com.chinacreator.xtbg.pub.dbbase.entity.XtDbBaseBean;

public class MailBoxMemoryConfigBean extends XtDbBaseBean{
	public MailBoxMemoryConfigBean() {
		super("oa_mail_memoryconfig", new String[]{"id"});
	}
	
	private String id;		//主键
	private String user_id;		//用户id
	private String memory;		//邮箱容量
	/**
	*<b>Summary: 获取主键</b>
	*/
	public String getId() {
		return id;
	}
	/**
	*<b>Summary: 设置主键</b>
	*/
	public void setId(String id) {
		this.id = id;
	}
	/**
	*<b>Summary: 获取用户id</b>
	*/
	public String getUser_id() {
		return user_id;
	}
	/**
	*<b>Summary: 设置用户id</b>
	*/
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	/**
	*<b>Summary: 获取邮箱容量</b>
	*/
	public String getMemory() {
		return memory;
	}
	/**
	*<b>Summary: 设置邮箱容量</b>
	*/
	public void setMemory(String memory) {
		this.memory = memory;
	}
}
