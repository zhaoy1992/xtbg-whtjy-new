
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsupplieUseTypeDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.canteenitemssupplies.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:OsupplieUseTypeDao.java</p>
 *<p>Description:常用类型Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public interface OsupplieUseTypeDao {
	/**
	 * 
	*<b>Summary: </b>
	* selOsupplieUseTypeList(查询常用类型列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selOsupplieUseTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getOsupplieUseType(根据id查询物品信息)
	* @param ofus_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getOsupplieUseType(String ofus_id ,Connection conn) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* deleteOsupplieBeansById(根据id删除类型)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteOsupplieUseBeansById(Connection conn,String beanId)throws Exception;
	
	/**
	*<b>Summary: </b>
	* isOsupplieTypeBean(判断类型是否被引用)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 *//*
	public int isOsupplieTypeBean(Connection conn,String beanId)throws Exception;*/
	
	/**
	 * 
	*<b>Summary: </b>
	* queryAllOsupplieUseType(查询所有物品信息)
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryAllOsupplieUseType(String unit_id) throws Exception;
}
