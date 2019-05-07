package com.chinacreator.xtbg.core.common.commonlist;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinacreator.security.AccessControl;

/**
 *<p>Title:DataInfoImpl.java</p>
 *<p>Description:公用查询方法接口类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *@date 2012-1-13
 */
public abstract class DataInfoImpl {
	
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
	 * @Description  公用分面查询方法
	 * 
	 * @param parmjson  //查询参数
	 * @param sortName  //排序字段
	 * @param sortOrder  //排序方式
	 * @param offset  //从第几页开始
	 * @param maxPagesize	//当前页数
	 * @return  PagingBean
	 * @exception 
	 */
	public abstract PagingBean getDataList(String parmjson, String sortName, String sortOrder, long offset, int maxPagesize);
	  
	/**
	 * @Description  公用不分面查询方法
	 * 
	 * @param parmjson  //查询参数
	 * @param sortName  //排序字段
	 * @param sortOrder  //排序方式
	 * @return  PagingBean
	 * @exception 
	 */
	public abstract PagingBean getDataList(String parmjson, String sortName, String sortOrder);
	
}
