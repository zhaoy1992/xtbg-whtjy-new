package com.chinacreator.xtbg.core.data.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:DataTypeDao.java</p>
 *<p>Description:资料分类dao接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-20
 */
public interface DataTypeDao {

	/**
	 * 
	*<b>Summary: </b>
	* getDataTypeBean(根据id查询资料分类信息)
	* @param id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDataTypeBean(String id, Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* selDataTypeList(查询资料分类列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selDataTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* deleteDataTypeBeansById(根据id删除分类以及子分类信息)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deleteDataTypeBeansById(Connection conn,String beanId)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isSonDataType(根据id查询是否有子分类)
	* @param conn
	* @param beanId
	* @return 
	* @throws Exception
	 */
	public boolean isSonDataType(Connection conn,String beanId)throws Exception;
}
