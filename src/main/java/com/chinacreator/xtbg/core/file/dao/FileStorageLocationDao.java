package com.chinacreator.xtbg.core.file.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:FileStorageLocationDao.java</p>
 *<p>Description:档案存放位置管理接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-15
 */
public interface FileStorageLocationDao {

	/**
	 * 
	*<b>Summary: </b>
	* selFileStoragoLocationList(查询存放位置列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selFileStoragoLocationList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getFileStorangeLocationBean(根据f_storage_id查询存放位置信息)
	* @param f_storage_id
	* @return
	 */
	public Map<String, String> getFileStorageLocationBean(String f_storage_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getFileStorageLocationURL(根据f_storage_id查询存放位置的路径)
	* @param f_storage_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getFileStorageLocationURL(String f_storage_id) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isFileStorageLocationBean(根据f_storage_id查询是否有子类)
	* @param f_storage_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public int isFileStorageLocationBean(String f_storage_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* selChildFileStorageLocationBean(根据f_storage_id查询所有子类)
	* @param f_storage_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> selChildFileStorageLocationBean(String f_storage_id) throws Exception;
	
}
