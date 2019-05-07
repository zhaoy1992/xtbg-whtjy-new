
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCompareRecodeDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:DevCompareRecodeDao.java</p>
 *<p>Description:对比记录数据库接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-8
 */
public interface DevCompareRecodeDao {
	/**
	 * 
	*<b>Summary: </b>
	* selDevCompareRecodeList(查询对比记录)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevCompareRecodeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getDevCompareRecode(根据id查询对比记录)
	* @param comp_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevCompareRecode(String comp_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteDevCompareRecodeById(根据id删除对比记录)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevCompareRecodeById(Connection conn,String beanId)throws Exception;
}
