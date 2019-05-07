
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevSettleItemDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-15   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 *<p>Title:DevSettleItemDao.java</p>
 *<p>Description:采购验收结算物品列表dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-15
 */
public interface DevSettleItemDao {
	/**
	 * 
	*<b>Summary: </b>
	* getDevSettleItem(根据结算流程表单中主键id查询结算物品列表)
	* @param devsettle_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getDevSettleItemList(String devsettle_id, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getDevSettleItemInfo(根据id查询结算物品明细表信息)
	* @param t_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevSettleItemInfo(String t_id, Connection conn) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* deleteDevSettleItemById(根据id删除结算货品列表)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevSettleItemById(Connection conn,String beanId)throws Exception;
	
}
