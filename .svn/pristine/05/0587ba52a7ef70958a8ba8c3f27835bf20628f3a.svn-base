package com.chinacreator.xtbg.pub.directory.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.pub.directory.entity.UserData;

/**
 * 
 *<p>Title:UserDataDao.java</p>
 *<p>Description:人员简历信息DAO</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Jul 25, 2013
 */
public interface UserDataDao {
	/**
	 * 
	*<b>Summary:人员简历信息添加 </b>
	* insert()
	* @param bean
	* @param con
	* @throws SQLException
	 */
	public void insert(UserData bean,Connection con) throws SQLException;
	
	/**
	 * 
	*<b>Summary: 人员简历信息更新</b>
	* update()
	* @param bean
	* @param con
	* @throws SQLException
	 */
	public void update(UserData bean, Connection con) throws SQLException;
	
	/**
	 * 
	*<b>Summary:人员简历信息查询 </b>
	* list()
	* @param bean
	* @param con
	* @return
	* @throws SQLException
	 */
	public List<UserData> list(UserData bean, Connection con) throws SQLException;

	/**
	 * 
	*<b>Summary: 删除数据</b>
	* delete()
	* @param bean
	* @param con
	 */
	public void delete(UserData bean, Connection con) throws SQLException;
}
