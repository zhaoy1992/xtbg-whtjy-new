
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevSettleItemDaoImp.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-15   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.device.dao.DevSettleItemDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevSettleItemDaoImp.java</p>
 *<p>Description:采购验收结算物品列表dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-15
 */
public class DevSettleItemDaoImpl  extends XtDbBaseDao implements DevSettleItemDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevSettleItemList
	  * @param devsettle_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevSettleItemDao#getDevSettleItemList(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public List<Map<String, String>> getDevSettleItemList(String devsettle_id,
			Connection conn) throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from ta_oa_devsettleitem ");
		sql.append(" where devsettle_id = ? order by item_no ");
		viewMap = queryToListMap(sql.toString(), devsettle_id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevSettleItemInfo
	  * @param t_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevSettleItemDao#getDevSettleItemInfo(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevSettleItemInfo(String t_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * ");
		sql.append("  from ta_oa_devsettleitem ");
		sql.append(" where t_id = ?  ");
		viewMap = queryToSingleMap(sql.toString(), t_id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevSettleItemById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevSettleItemDao#deleteDevSettleItemById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteDevSettleItemById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devsettleitem ");
		sql.append(" where devsettle_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

}
