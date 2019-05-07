package com.chinacreator.business.common.bean;

/**
 *<p>Title:ReadServletClass.java</p>
 *<p>Description:请求处理的类配置</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 沈联成
 *@version 1.0
 *@date 2012-11-20
 */
public class ActionBean {
   
	private String classID;
	private String className;
	private String openRule;
	
	public String getClassID() {
		return classID;
	}
	public void setClassID(String classID) {
		this.classID = classID;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getOpenRule() {
		return openRule;
	}
	public void setOpenRule(String openRule) {
		this.openRule = openRule;
	}
	
}
