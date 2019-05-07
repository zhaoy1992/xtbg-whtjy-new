package com.chinacreator.xtbg.tjy.detectionsupplies.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * 
 *<p>Title:OsAppObjectDao.java</p>
 *<p>Description:处理添加入计划表的物品数据DAO层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-6
 */
public interface OsAppObjectDao {
	/**
	 * 
	*<b>Summary: </b>
	* selectOsAppObject(根据计划表id查询出物品列表)
	* @param t_id
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> selectOsAppObject(String t_id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteOsAppObject(根据计划表id删除物品)
	* @param t_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean deleteOsAppObject(String t_id,Connection conn) throws Exception;

}
