package com.chinacreator.xtbg.core.common.tree.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinacreator.security.AccessControl;

/**
 * 
 *<p>Title:TreeDataInfo.java</p>
 *<p>Description:公共的树的抽象类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-16
 */
public abstract class TreeDataInfo {
	
	public AccessControl accesscontroler;
	
	public HttpServletRequest request;
	
	public HttpServletResponse response;
	
	public void init(HttpServletRequest req,HttpServletResponse res){
		accesscontroler = AccessControl.getAccessControl();
		accesscontroler.checkAccess(req, res);
		request = req;
		response = res;
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* getTreeDateInfo(获得类的数据信息)
	* @return
	 */
	public abstract Object getTreeDateInfo() throws Exception;
	
}
