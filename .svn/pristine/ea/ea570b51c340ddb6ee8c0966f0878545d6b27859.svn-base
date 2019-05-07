
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevScrapDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-10   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.tjy.device.entity.DevScrapBean;

/**
 *<p>Title:DevScrapDao.java</p>
 *<p>Description:申请报废数据库Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-10
 */
public interface DevScrapDao {
	
	/**
	*<b>Summary: </b>
	* getDevScrapInfo(根据id查询仪器申请报废)
	* @param t_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevScrapInfo(String t_id,Connection conn) throws Exception;
	/**
	 * 保存仪器报废信息
	 * @param bean
	 * @return
	 * @throws Exception
	 */
	public void saveDevScrapInfo(DevScrapBean bean) throws Exception;
	
}
