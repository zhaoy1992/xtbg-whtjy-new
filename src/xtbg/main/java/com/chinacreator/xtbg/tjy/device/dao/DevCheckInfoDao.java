
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCheckInfoDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-7   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:DevCheckInfoDao.java</p>
 *<p>Description:检查记录数据库Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-7
 */
public interface DevCheckInfoDao {
	/**
	 * 
	*<b>Summary: </b>
	* selDevCheckInfoList(查询检查记录)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevCheckInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getDevCheckInfo(根据id查询检查记录)
	* @param id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevCheckInfo(String id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteDevCheckInfoById(根据id删除检查记录)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevCheckInfoById(Connection conn,String beanId)throws Exception;
}
