
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevIssuedPlanDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao;

import java.sql.Connection;
import java.util.Map;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:DevIssuedPlanDao.java</p>
 *<p>Description:下达核检计划数据库dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-3
 */
public interface DevIssuedPlanDao {

	/**
	 * 
	*<b>Summary: </b>
	* selDevIssuedPlanList(查询下达核检计划列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDevIssuedPlanList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getDevIssuedPlan(根据id查询下达核检计划)
	* @param plan_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevIssuedPlan(String plan_id,Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deleteDevIssuedPlanById(根据id删除下达核检计划)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDevIssuedPlanById(Connection conn,String beanId)throws Exception;
}
