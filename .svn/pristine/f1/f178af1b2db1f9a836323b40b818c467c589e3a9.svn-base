package com.chinacreator.xtbg.core.workbench.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.workbench.entity.OnlineTopBean;

/**
 *<p>Title:OnlineTopDao.java</p>
 *<p>Description:系统最高在线用户数记录dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-26
 */
public interface OnlineTopDao {
	
	/**
	*<b>Summary: </b>
	* queryOnlineTop(查询系统最高在线用户数)
	* @param conn
	* @return
	* @throws SQLException
	*/
	public OnlineTopBean queryOnlineTop(Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* insertOnlineTop(记录最高在线用户数)
	* @param bean
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean insertOnlineTop(OnlineTopBean bean,Connection conn) throws SQLException;
	
	/**
	 * 
	*<b>Summary: </b>
	* getOnlineTree(查询在线人数树)
	* @param user_id
	* @param conn
	* @return
	 */
	public List<Map<String, String>> getOnlineTree(String user_id, Connection conn) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getOnlineUser(查询在线用户)
	* @param con
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getOnlineUser(Connection con) throws Exception;
	
	

}
