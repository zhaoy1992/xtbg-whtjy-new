
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAccountDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:DevAccountDao.java</p>
 *<p>Description:设备详情数据库dao层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public interface DevAccountInfoDao {
	
	/**
	*<b>Summary: </b>
	* selDevAccountList(查询设备台帐列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevAccountList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getDevAccount(根据id查询设备台帐)
	* @param id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevAccount(String id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getDevAccountByDevCode(根据设备编号查询设备台帐)
	* @param dev_code
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevAccountByDevCode(String dev_code,Connection conn) throws Exception;
	/**
	*<b>Summary: </b>
	* deleteDevAccount(根据id删除设备台帐)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevAccount(Connection conn,String beanId)throws Exception;
	
	/**
	*<b>Summary: </b>
	* getDevEquipmentacc(根据id查询政府采购设备验证信息)
	* @param t_sb_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevEquipmentacc(String t_sb_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getDevEqAppInfo(根据id查询政府采购单信息)
	* @param id  采购明细表ID
	* @return Map
	 */
	public Map<String, String> getDevEqAppInfo(String id,Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getgetDevAccountByDevCode(根据设备编号查询设备id)
	* @param dev_code
	* @return
	* @throws Exception
	 */
	public String getgetDevAccountByDevCode(String dev_code) throws Exception;
	
}
