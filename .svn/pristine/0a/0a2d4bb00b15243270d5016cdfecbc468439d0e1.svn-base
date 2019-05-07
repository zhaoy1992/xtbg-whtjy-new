
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PsdataBaseDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-14   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.persondata.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:PsdataBaseDao.java</p>
 *<p>Description:个人资料Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-14
 */
public interface PsdataBaseDao {
	/**
	*<b>Summary: </b>
	* selPsdataBaseList(查询个人资料列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selPsdataBaseList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getPsdataBaseById(根据id查询个人资料信息)
	* @param p_data_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getPsdataBaseById(String p_data_id, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deletePsdataBaseBeansById(根据id删除资料基本信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deletePsdataBaseBeansById(Connection conn,String beanId)throws Exception;
	
	/**
	*<b>Summary: </b>
	* selupLoadPsdataBase(查询 导出资料列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selupLoadPsdataBase(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
}
