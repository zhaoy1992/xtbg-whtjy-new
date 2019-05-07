
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAppItemDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-27   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.device.dao.DevAppItemDao;
import com.chinacreator.xtbg.tjy.device.entity.DevAppItem;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevAppItemDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-27
 */
public class DevAppItemDaoImpl extends XtDbBaseDao implements  DevAppItemDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevAppItem
	  * @param plain_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevAppItemDao#getDevAppItem(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public List<Map<String, String>> getDevAppItem(String plain_id,
			Connection conn) throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from ta_oa_devappitem ");
		sql.append(" where item_plainid = ? order by item_no ");
		viewMap = queryToListMap(sql.toString(), plain_id);
		
		return viewMap;
	}
	
	/**
	*<b>Summary: </b>
	* getDevAppItemInfo(根据id查询物品明细表信息)
	* @param item_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getDevAppItemInfo(String item_id, Connection conn) throws Exception{
		
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * ");
		sql.append("  from ta_oa_devappitem ");
		sql.append(" where item_id = ?  ");
		viewMap = queryToSingleMap(sql.toString(), item_id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevAppItemById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevAppItemDao#deleteDevAppItemById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteDevAppItemById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devappitem ");
		sql.append(" where item_plainid in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}


	/**
	 * 
	  * <b>Summary: 根据仪器设备采购的id查询出物品列表</b>
	  *     复写方法 findDevAppItemList
	  * @param devAppItem
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevAppItemDao#findDevAppItemList(com.chinacreator.xtbg.tjy.device.entity.DevAppItem, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean findDevAppItemList(DevAppItem devAppItem,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		PagingBean pb = new PagingBean();
		PreparedDBUtil  db = new PreparedDBUtil ();
		List<DevAppItem> list = new ArrayList<DevAppItem>();
		StringBuffer sql = new StringBuffer();
		
		sql.append("select t.item_id,");
		sql.append("       t.item_plainid,");
		sql.append("       t.item_name,");
		sql.append("       t.item_type,");
		sql.append("       t.item_jscs,");
		sql.append("       t.item_tjzccj,");
		sql.append("       t.item_sl,");
		sql.append("       t.item_gzly,");
		sql.append("       t.item_ysfy,");
		sql.append("       t.item_no,");
		sql.append("       t.item_pzrid,");
		sql.append("       t.item_pzrmc,");
		sql.append("       t.item_sfyz");
		sql.append("       from ta_oa_devappitem t");
		sql.append("       where t.item_plainid=?");
		sql.append("         and t.item_sl>t.item_sfyz ");
		sql.append(" order by " + sortName + " " + sortOrder);
    	db.preparedSelect(sql.toString(), offset, maxPagesize);
    	db.setString(1, devAppItem.getItem_plainid());
    	db.executePrepared();
		for(int i = 0;i < db.size();i++){
			DevAppItem devAppListItem = new DevAppItem();
			devAppListItem.setItem_id(db.getString(i, "item_id"));
			devAppListItem.setItem_plainid(db.getString(i, "item_plainid"));
			devAppListItem.setItem_name(db.getString(i, "item_name"));
			devAppListItem.setItem_type(db.getString(i, "item_type"));
			devAppListItem.setItem_jscs(db.getString(i, "item_jscs"));
			devAppListItem.setItem_tjzccj(db.getString(i, "item_tjzccj"));
			devAppListItem.setItem_sl(db.getString(i, "item_sl"));
			devAppListItem.setItem_gzly(db.getString(i, "item_gzly"));
			devAppListItem.setItem_ysfy(db.getString(i, "item_ysfy"));
			devAppListItem.setItem_no(db.getString(i, "item_no"));
			
			list.add(devAppListItem);
	    }
	    pb.setList(list);
	    pb.setRecords((long)db.getTotalSize());
		return pb;
	}

}
