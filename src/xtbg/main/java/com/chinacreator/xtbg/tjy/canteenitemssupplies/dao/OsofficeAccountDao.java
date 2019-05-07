
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsofficeAccountDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-9   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.canteenitemssupplies.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:OsofficeAccountDao.java</p>
 *<p>Description:固定资产台帐台帐管理数据库接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-9
 */
public interface OsofficeAccountDao {

	/**
	*<b>Summary: </b>
	* OsofficeAccountByOrgList(查询台帐管理)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean OsofficeAccountByOrgList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	*<b>Summary: </b>
	* OsofficeDetailList(查询台帐详情管理)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean OsofficeDetailList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getOfficeDetailBean(根据类型Id查询固定资产台帐详细信息)
	* @param id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getOfficeDetailBean(String id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteOfficeDetailByIds(根据id删除固定资产台帐详细信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteOfficeDetailByIds(Connection conn,String beanId)throws Exception;
	
	/**
	*<b>Summary: </b>
	* OsofficeDetailToExcel(查询台帐详情管理用于导出Excel)
	* @param parmjson
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> OsofficeDetailToExcel(String parmjson) throws Exception;
	
}
