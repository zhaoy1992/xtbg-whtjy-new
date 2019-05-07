package com.chinacreator.xtbg.core.archive.entity;

import com.chinacreator.xtbg.core.common.dbbase.entity.XtDbBaseBean;
/**
 * 
 *<p>Title:DocumentComideaBean.java</p>
 *<p>Description:常用意见实体类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-20
 */
public class DocumentComideaBean extends XtDbBaseBean {
	public DocumentComideaBean(){
		super("OA_DOCUMENT_COMIDEA","IDEA_ID");
	}
	private String idea_id;		//null
	private String idea_content;		//null
	private String user_id;		//null
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getIdea_id() {
		return idea_id;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setIdea_id(String idea_id) {
		this.idea_id = idea_id;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getIdea_content() {
		return idea_content;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setIdea_content(String idea_content) {
		this.idea_content = idea_content;
	}
	/**
	*<b>Summary: 获取null</b>
	*/
	public String getUser_id() {
		return user_id;
	}
	/**
	*<b>Summary: 设置null</b>
	*/
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
}
