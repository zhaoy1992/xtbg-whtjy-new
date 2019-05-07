
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsupplieTypeDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-17   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.canteenitemssupplies.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:OsupplieTypeDao.java</p>
 *<p>Description:设备和易耗品类型DAO接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-17
 */
public interface OsupplieTypeDao {
	/**
	 * 
	*<b>Summary: </b>
	* selOsupplieTypeList(查询易耗品和设备列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selOsupplieTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getOsupplieType(根据id查询类型信息)
	* @param oftype_id
	* @param oftype_flag
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getOsupplieType(String oftype_id,String oftype_flag, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteOsupplieBeansById(根据id删除类型)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteOsupplieBeansById(Connection conn,String beanId)throws Exception;
	
	/**
	*<b>Summary: </b>
	* isOsupplieTypeBean(判断类型是否被引用)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public int isOsupplieTypeBean(Connection conn,String beanId)throws Exception;
	
}
