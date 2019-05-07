package com.chinacreator.xtbg.core.inspect.dao;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:InspectTypeDao.java</p>
 *<p>Description:督查督办任务类别接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-4
 */
public interface InspectTypeDao {
	
	/**
	 * 
	*<b>Summary: </b>
	* selDataDataList(督查督办的类别查询)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean selInspectTypeList(String parmjson, String sortName,String sortOrder, long offset, int maxPagesize)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* selInspectReportList(上报查询列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selInspectReportList(String parmjson, String sortName,String sortOrder, long offset, int maxPagesize)throws Exception;
}
