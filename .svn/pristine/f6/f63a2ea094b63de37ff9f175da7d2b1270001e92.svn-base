
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PsdataTypeDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-12   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.persondata.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:PsdataTypeDao.java</p>
 *<p>Description:资料类型Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-12
 */
public interface PsdataTypeDao {
	/**
	 * 
	*<b>Summary: </b>
	* selPsdataTypeList(查询个人资料分类列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selPsdataTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getPsdataType(根据id查询个人资料分类信息)
	* @param p_type_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getPsdataType(String p_type_id, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deletePsdataTypeBeansById(根据id删除分类以及子类)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deletePsdataTypeBeansById(Connection conn,String beanId)throws Exception;
	
	/**
	*<b>Summary: </b>
	* isPsdataBaseBean(判断分类是否被引用)
	* @param beanId
	* @return
	* @throws Exception
	 */
	public int isPsdataBaseBean(Connection conn,String beanId)throws Exception;
	
	/**
	*<b>Summary: </b>
	* findTopTypeById(根据id查询个人资料分类信息)
	* @param user_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> findTopType(String user_id,Connection conn) throws Exception;
	
}
