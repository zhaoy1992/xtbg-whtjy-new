package com.chinacreator.xtbg.core.workbench.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.workbench.entity.UserCacheBean;

/**
 *<p>Title:UserLoginInfoDao.java</p>
 *<p>Description:用户登陆信息记录dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
 */
public interface UserLoginInfoDao {
	
	/**
	*<b>Summary: </b>
	* queryAllUserLoginInfo(查询所有用户的登录信息)
	* @param conn
	* @return
	* @throws SQLException
	*/
	public List<UserCacheBean> queryAllUserLoginInfo(Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* operLoginInfo(用户登录信息入库)
	* @param list
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean operLoginInfo(List<UserCacheBean> list,Connection conn) throws SQLException;

}
