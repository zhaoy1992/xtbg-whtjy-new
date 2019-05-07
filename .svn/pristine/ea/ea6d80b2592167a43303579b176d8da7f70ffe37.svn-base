
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ReviewUserDao.java
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
 *<p>Title:ReviewUserDao.java</p>
 *<p>Description:专家库管理Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-19
 */
public interface ReviewUserDao {
	/**
	 * 
	*<b>Summary: </b>
	* selReviewUserList(查询专家库管理列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selReviewUserList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getReviewUser(根据id查询专家库信息)
	* @param oftype_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getReviewUser(String oftype_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteReviewUserById(根据id删除专家库信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteReviewUserById(Connection conn,String beanId)throws Exception;
	
}
