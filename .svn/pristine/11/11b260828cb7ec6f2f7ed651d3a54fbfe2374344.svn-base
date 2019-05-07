package com.chinacreator.xtbg.core.pubconfig.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * 
 *<p>Title:MdTableDao.java</p>
 *<p>Description:数据元素实体接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-31
 */
public interface MdTableDao {

	/**
	 * 
	*<b>Summary: </b>
	* getMdTable(根据Id得到表以及)
	* @param table_id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getMdTable(String table_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getOneMdTable(根据Id得到表信息)
	* @param table_id
	* @return
	* @throws Exception
	 */
	public Map<String, String> getOneMdTable(String table_id,Connection conn) throws Exception;
}
