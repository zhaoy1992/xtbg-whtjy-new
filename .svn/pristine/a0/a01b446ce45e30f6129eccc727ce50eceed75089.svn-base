
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsuserTypeItemDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.officesupplies.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsuserTypeItemBean;

/**
 *<p>Title:OsuserTypeItemDao.java</p>
 *<p>Description:物品规格Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public interface OsuserTypeItemDao {
	/**
	 * 
	*<b>Summary: </b>
	* selOsuserTypeItemList(查询物品规格列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selOsuserTypeItemList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getOsuserTypeItem(根据id查询物品规格信息)
	* @param it_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getOsuserTypeItem(String it_id, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteOsuserTypeItemsById(根据id删除物品规格)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteOsuserTypeItemsById(Connection conn,String beanId)throws Exception;
	
	/**
	*<b>Summary: </b>
	* isOsuserTypeItem(判断物品规格是否被引用)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public int isOsuserTypeItem(Connection conn,String beanId)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryOsuserTyptItemList(根据物品ID查询出规格列表)
	* @param ofustypeId
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryOsuserTyptItemList(String ofustypeId) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryOsoFtypeItemList(根据物品ID查询出物品类别)
	* @param ofustypeId
	* @return
	* @throws Exception
	 */
	public Map<String, String> queryOsoFtypeItemList(String ofustypeId) throws Exception;
	
	public boolean insert(OsuserTypeItemBean bean,Connection conn)throws Exception;
	/**
	 * 根据物品id得物品信息
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getOfustypeById(String id,Connection conn)throws Exception;
}
