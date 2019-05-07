
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevTakcareDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:DevTakcareDao.java</p>
 *<p>Description:设备维修和保养记录数据库接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-8
 */
public interface DevTakcareDao {
	/**
	 * 
	*<b>Summary: </b>
	* selDevTakcareList(查询设备维修和保养记录列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevTakcareList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getDevTakcareBean(根据id查询设备维修和保养记录)
	* @param id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevTakcareBean(String id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteDevTakcareById(根据id删除设备维修和保养记录)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevTakcareById(Connection conn,String beanId)throws Exception;
}
