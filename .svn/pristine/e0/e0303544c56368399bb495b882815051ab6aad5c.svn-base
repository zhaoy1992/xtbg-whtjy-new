
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ReviewInfoDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-19   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.review.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:ReviewInfoDao.java</p>
 *<p>Description:评审记录管理dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-19
 */
public interface ReviewInfoDao {
	/**
	 * 
	*<b>Summary: </b>
	* selReviewInfoList(查询评审记录管理列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selReviewInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getReviewInfo(根据id查询评审记录管理)
	* @param oftype_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getReviewInfo(String oftype_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteReviewInfoById(根据id删除评审记录管理)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteReviewInfoById(Connection conn,String beanId)throws Exception;
}
