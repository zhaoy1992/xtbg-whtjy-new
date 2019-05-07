package com.chinacreator.xtbg.core.data.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:DataDataDao.java</p>
 *<p>Description:资料实体接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-21
 */
public interface DataDataDao {

	/**
	 * 
	*<b>Summary: </b>
	* selDataDataList(查询资料列表信息)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDataDataList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getDataBaseBean(根据id查询资料信息)
	* @param id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDataBaseBean(String id, Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getDataBaseBeanList(根据分类id查询资料信息)
	* @param typeid
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getDataBaseBeanList(String typeid, Connection conn)throws Exception;
}
