package com.chinacreator.xtbg.core.common.tree.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.tree.entity.ResourceRoleUserBean;
/**
 * 
 *<p>Title:ResourceConfigDao.java</p>
 *<p>Description:查询资源配置信息</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-5-30
 */
public interface ResourceConfigDao {

	/**
	 * 
	*<b>Summary: </b>
	* queryOrginUserList(查询机构对应的人)
	* @param orgid
	* @param resourceType
	* @param userid
	* @return
	* @throws Exception
	 */
	public List<ResourceRoleUserBean> queryOrginUserList (String orgid, String resourceType ,String userid)throws Exception;


	/**
	 * 
	*<b>Summary: </b>
	* queryUserMatchOrg(查询人对应的机构)
	* @param userId
	* @return
	* @throws SQLException
	 */
	public ResourceRoleUserBean queryUserMatchOrg(String userId)  throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getUnitReceiverUser(获得单位接收人)
	* @param org_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public String getUnitReceiverUser(String org_id, Connection conn) throws Exception;
	
	
	
	
	
}
