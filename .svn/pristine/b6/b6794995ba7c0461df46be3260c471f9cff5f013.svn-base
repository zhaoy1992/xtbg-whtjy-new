package com.chinacreator.xtbg.core.kbm.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *<p>Title:WorkbenchDao.java</p>
 *<p>Description:知识库dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-8-16
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
	
	

}
