package com.chinacreator.xtbg.core.paper.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:PaperMakeNoticeDao.java</p>
 *<p>Description:约稿通知接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-9-11
 */
public interface PaperMakeNoticeDao {

	/**
	 * 
	*<b>Summary: </b>
	* selMakeNoticeList(查询约稿通知信息列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selMakeNoticeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getMakeNoticeBean(根据id查询约稿通知信息)
	* @param con
	* @param id
	* @return
	* @throws Exception
	 */
	public Map<String,String> getMakeNoticeBean(Connection con,String id)throws Exception;
	
}
