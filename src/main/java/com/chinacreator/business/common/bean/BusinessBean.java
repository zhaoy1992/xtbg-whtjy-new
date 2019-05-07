package com.chinacreator.business.common.bean;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinacreator.sysmgrcoreext.manager.bean.UserOrgStatusBean;

/**
 * <p>
 * Title:BusinessBean.java
 * </p>
 * <p>
 * Description:请求处理后的值对对像
 * </p>
 * <p>
 * Copyright:Copyright (c) 2012
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * 
 * @author 沈联成
 * @version 1.0
 * @date 2012-11-20
 */
public class BusinessBean {
	private final Map<String, String> paramMap = new HashMap<String, String>();// 请求参数值对像
	private String userID;// 用户ID
	private String userDeptID;// 用户所在部门ID
	private String userName;// 用户名字
	private String userDeptName;// 用户所在部门名字
	private String userKey;// 登陆用户名
	private String parentDeptID;
	private List<UserOrgStatusBean> allOrgList;//所有机构的集合
	private HttpServletRequest request;
	private HttpServletResponse response;

	public void setParam(String key, String value) {
		paramMap.put(key, value);
	}

	public String getParam(String key) {
		return paramMap.get(key);
	}

	public Map<String, String> getParamMap() {
		return paramMap;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserDeptID() {
		return userDeptID;
	}

	public void setUserDeptID(String userDeptID) {
		this.userDeptID = userDeptID;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserDeptName() {
		return userDeptName;
	}

	public void setUserDeptName(String userDeptName) {
		this.userDeptName = userDeptName;
	}

	public String getUserKey() {
		return userKey;
	}

	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public String getParentDeptID() {
		return parentDeptID;
	}

	public void setParentDeptID(String parentDeptID) {
		this.parentDeptID = parentDeptID;
	}

	public List<UserOrgStatusBean> getAllOrgList() {
		return allOrgList;
	}

	public void setAllOrgList(List<UserOrgStatusBean> allOrgList) {
		this.allOrgList = allOrgList;
	}
	
	
}
