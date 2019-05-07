package com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.OsAppObjectDao;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 * 
 *<p>Title:OsAppObjectDaoImpl.java</p>
 *<p>Description: 处理添加入计划表的物品数据DAO层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2014-3-6
 */
public class OsAppObjectDaoImpl extends XtDbBaseDao implements OsAppObjectDao {

	/**
	 * 
	  * <b>Summary: 根据计划表id查询出物品列表</b>
	  *     复写方法 selectOsAppObject
	  * @param t_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppObjectDao#selectOsAppObject(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> selectOsAppObject(String t_id) throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from TA_OA_CANOSAPP_OBJECT ");
		sql.append(" where T_ID = ? ");
		viewMap = queryToListMap(sql.toString(), t_id);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: 根据计划表id删除物品</b>
	  *     复写方法 deleteOsAppObject
	  * @param t_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsAppObjectDao#deleteOsAppObject(java.lang.String, java.sql.Connection)
	 */
	public boolean deleteOsAppObject(String t_id, Connection conn)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from TA_OA_CANOSAPP_OBJECT ");
		sql.append(" where T_ID in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, t_id);
		pdb.executePrepared(conn);
		return true;
	}

}
