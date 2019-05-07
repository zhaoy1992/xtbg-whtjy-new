package com.chinacreator.xtbg.core.workbench.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *<p>Title:WorkbenchDao.java</p>
 *<p>Description:工作台dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
 */
public interface WorkbenchDao {
	
	/**
	*<b>Summary: </b>
	* queryUserData(查询用户首页显示数据)
	* @param sql 查询sql语句
	* @param params	查询的参数集合
	* @param dbColumns	要查询的字段集合
	* @param maxRownum	查询的条数
	* @param conn
	* @return 
	* @throws SQLException
	*/
	public List<Map<String, String>> queryUserData(String sql,List<String> params,List<String> dbColumns,int maxRownum,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* queryPendingNum(查询用户待办数据)
	* @param functionSql 查询的sql语句
	* @param params	函数参数
	* @param conn
	* @return 返回待办的数据字符串，以‘,’分割，顺序与first_config.xml中配置的顺序一直
	* @throws SQLException
	*/
	public String queryPendingNum(String functionSql,List<String> params,Connection conn) throws SQLException;

}
