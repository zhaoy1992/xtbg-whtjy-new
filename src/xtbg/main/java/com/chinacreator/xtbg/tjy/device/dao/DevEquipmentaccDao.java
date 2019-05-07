
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevEquipmentaccDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-20   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;

/**
 *<p>Title:DevEquipmentaccDao.java</p>
 *<p>Description:政府采购验收表单数据库接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-20
 */
public interface DevEquipmentaccDao {

	/**
	*<b>Summary: </b>
	* getDevEquipmentacc(根据id查询政府采购验收表单)
	* @param devsup_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevEquipmentacc(String t_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteDevEquipmentacById(根据id删除政府采购验收表单)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevEquipmentacById(Connection conn,String beanId)throws Exception;
}
