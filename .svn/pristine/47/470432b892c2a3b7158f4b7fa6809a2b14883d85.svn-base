
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     ElectDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-1   Administrator    最初版本
   */
package com.chinacreator.xtbg.suxian.electroniccheck.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean;


/**
 *<p>Title:ElectDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-1
 */
public interface ElectDao {
	/**
	*<b>Summary: </b>
	* selElecSetforList(查询考勤设置管理列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selElecSetforList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	*<b>Summary: </b>
	* getResElecSet(得到考勤设置的数据 根据ID)
	* @param elect_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getResElecSet(String elect_id, Connection conn) throws Exception;
	/**
	*<b>Summary: </b>
	* querySetRecord(查询sx_ta_oa_electcheck表是否有记录)
	* @return
	* @throws Exception
	 */
	public ElectResetBean querySetRecord(String user_id) throws Exception;
	
	/**
	*<b>Summary: </b>
	* findElecStatExist(查询该用户考勤状态 是否已经有记录)
	* @param user_id
	* @param date
	* @param state
	* @return
	* @throws Exception
	 */
	public boolean findElecStatExist(String user_id,String date,String state,Connection conn) throws Exception;
	
	
	
}
