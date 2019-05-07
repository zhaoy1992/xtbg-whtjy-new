
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevSupplierDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-27   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:DevSupplierDao.java</p>
 *<p>Description:供应商名录数据库接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-27
 */
public interface DevSupplierDao {
	
	/**
	 * 
	*<b>Summary: </b>
	* selDevSupplierList(查询供应商名录列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevSupplierList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getDevSupplier(根据id查询供应商名录)
	* @param devsup_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevSupplier(String devsup_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteDevSupplierById(根据id删除供应商名录)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevSupplierById(Connection conn,String beanId)throws Exception;
	
}
