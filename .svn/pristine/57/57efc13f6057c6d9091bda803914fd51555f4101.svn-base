
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsapPlanItemDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-20   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.detectionsupplies.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 *<p>Title:OsapPlanItemDao.java</p>
 *<p>Description:物品列表dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-20
 */
public interface OsapPlanItemDao {
	/**
	 * 
	*<b>Summary: </b>
	* getOsapPlanItem(根据id查询物品列表)
	* @param oftype_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getOsapPlanItem(String it_planid, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteOsapPlanItemById(根据id删除物品列表)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteOsapPlanItemById(Connection conn,String beanId)throws Exception;
	
}
