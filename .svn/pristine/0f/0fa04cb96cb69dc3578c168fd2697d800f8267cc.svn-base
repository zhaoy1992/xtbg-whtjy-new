
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevInfoItemDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 *<p>Title:DevInfoItemDao.java</p>
 *<p>Description:配件数据库dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public interface DevInfoItemDao {
	
	/**
	 * 
	*<b>Summary: </b>
	* getDevInfoItem(根据id查询 配件列表)
	* @param dev_code
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getDevInfoItem(String dev_code, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteDevInfoItemById(根据id删除配件列表)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevInfoItemById(Connection conn,String beanId)throws Exception;
}
