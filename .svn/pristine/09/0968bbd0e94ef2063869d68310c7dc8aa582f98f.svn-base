
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevRepairDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-6   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:DevRepairDao.java</p>
 *<p>Description:仪器设备维修数据库接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-6
 */
public interface DevRepairDao {
	/**
	*<b>Summary: </b>
	* getDevRepairInfo(根据id查询仪器设备维修)
	* @param t_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevRepairInfo(String t_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* selDevRepairInfoList(查询仪器设备维修列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevRepairInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
}
