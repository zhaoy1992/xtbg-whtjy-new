package com.chinacreator.xtbg.core.purviewmanager.dao;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:GroupDao.java</p>
 *<p>Description:用户组接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-2
 */
public interface GroupDao {

	/**
	 * 
	*<b>Summary: </b>
	* selGroupList(查询用户组信息)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selGroupList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* selUserGroupList(查询用户组下用户列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selUserGroupList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
}
