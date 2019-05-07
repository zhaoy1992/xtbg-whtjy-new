
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCalibrateRecodeDao.java
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
 *<p>Title:DevCalibrateRecodeDao.java</p>
 *<p>Description:校准记录数据库Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-8
 */
public interface DevCalibrateRecodeDao {
	/**
	 * 
	*<b>Summary: </b>
	* selDevCalibrateRecodeList(查询校准记录)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevCalibrateRecodeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getDevCalibrateRecodeBean(根据id查询校准记录)
	* @param appr_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevCalibrateRecodeBean(String calib_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteDevCalibrateRecodeById(根据id删除校准记录)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevCalibrateRecodeById(Connection conn,String beanId)throws Exception;
}
