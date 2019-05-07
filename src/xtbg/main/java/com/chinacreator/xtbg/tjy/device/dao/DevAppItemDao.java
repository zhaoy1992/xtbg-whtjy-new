
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAppItemDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-27   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.device.entity.DevAppItem;

/**
 *<p>Title:DevAppItemDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-27
 */
public interface DevAppItemDao {
	/**
	 * 
	*<b>Summary: </b>
	* getDevAppItem(根据id查询物品列表)
	* @param plain_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getDevAppItem(String plain_id, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getDevAppItemInfo(根据id查询物品明细表信息)
	* @param item_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevAppItemInfo(String item_id, Connection conn) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* deleteDevAppItemById(根据id删除物品列表)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevAppItemById(Connection conn,String beanId)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findDevAppItemList(根据仪器设备采购的id查询出物品列表)
	* @param devAppItem
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean findDevAppItemList(DevAppItem devAppItem, String sortName, String sortOrder, long offset, int maxPagesize)throws Exception;
}
