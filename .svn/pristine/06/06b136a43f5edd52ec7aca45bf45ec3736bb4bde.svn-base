
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsapPlanItemDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-20   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.canteenitemssupplies.dao.OsapPlanItemDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:OsapPlanItemDaoImpl.java</p>
 *<p>Description:物品列表dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-20
 */
public class OsapPlanItemDaoImpl extends XtDbBaseDao implements OsapPlanItemDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getOsapPlanItem
	  * @param it_planid
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsapPlanItemDao#getOsapPlanItem(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public List<Map<String, String>> getOsapPlanItem(String it_planid,
			Connection conn) throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * ");
		sql.append(" from TA_OA_CANOSAPPLANITEM ");
		sql.append(" where it_planid = ? ");
		viewMap = queryToListMap(sql.toString(), it_planid);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteOsapPlanItemById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsapPlanItemDao#deleteOsapPlanItemById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteOsapPlanItemById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from TA_OA_CANOSAPPLANITEM ");
		sql.append(" where it_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	
}
