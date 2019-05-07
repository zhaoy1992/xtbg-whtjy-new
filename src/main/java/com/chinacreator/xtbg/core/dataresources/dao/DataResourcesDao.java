package com.chinacreator.xtbg.core.dataresources.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * 
 *<p>Title:DataResourcesDao.java</p>
 *<p>Description:数据资源Dao接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-22
 */
public interface DataResourcesDao {

	/**
	 * 
	*<b>Summary: </b>
	* getDataResourcesBeanMap(查询单位接收的数据资源)
	* @return
	 */
	public List<Map<String, String>> getDataResourcesBeanMap() throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getUserBeanMap(查询单位下面的用户)
	* @param org_id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getUserBeanMap(String org_id) throws Exception; 
	
	/**
	 * 
	*<b>Summary: </b>
	* insertOrgResourceConfig(插入机构资源配置)
	* @param boxvalue
	* @param org_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public void insertOrgResourceConfig(String boxvalue, String org_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* delOrgResourceConfig(删除机构应该的资源)
	* @param boxvalue
	* @param org_id
	* @param conn
	* @throws Exception
	 */
	public void delOrgResourceConfig(String boxvalue, String org_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getChooseOrgUser(查询机构选择的用户)
	* @param org_id
	* @param config_type
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getChooseOrgUser(String org_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* delAllChooseOrgUser(删除所有单位资源选择的用户)
	* @param org_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public void delAllChooseOrgUser(String org_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getDataResourcesRecipient(获得数据资源的单位接收人)
	* @param unit_id
	* @param resources_logo
	* @return
	* @throws Exception
	 */
	public String getDataResourcesRecipient(String unit_id, String resources_logo) throws Exception;
	
}
