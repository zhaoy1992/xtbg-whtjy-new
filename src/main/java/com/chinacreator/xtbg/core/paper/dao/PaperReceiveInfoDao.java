package com.chinacreator.xtbg.core.paper.dao;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:PaperReceiveNoticeDao.java</p>
 *<p>Description:信息发布后的接收方明细情况接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-28
 */
public interface PaperReceiveInfoDao {

	/**
	 * 
	*<b>Summary: </b>
	* selReceiveInfoList(查询信息发布后的接收方明细情况列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selReceiveInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
}
