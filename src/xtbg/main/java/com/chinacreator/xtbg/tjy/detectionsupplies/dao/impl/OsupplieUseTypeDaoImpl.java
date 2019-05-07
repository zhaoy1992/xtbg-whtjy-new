
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsupplieUseTypeDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.detectionsupplies.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.alibaba.fastjson.JSONObject;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsupplieUseTypeDao;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsupplieUseType;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:OsupplieUseTypeDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public class OsupplieUseTypeDaoImpl extends XtDbBaseDao implements OsupplieUseTypeDao{

	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selOsupplieUseTypeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsupplieUseTypeDao
	  * #selOsupplieUseTypeList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selOsupplieUseTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		
		Connection conn = null;
		OsupplieUseType osupplieusetype= new OsupplieUseType();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				osupplieusetype = (OsupplieUseType) JSONObject.parseObject(parmjson, OsupplieUseType.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select");
			sql.append("       ofustype_id,");
			sql.append("       ofustype_name,");
			sql.append("       ofustype_no ");
			sql.append("  from TA_OA_DETOSUPPLIEUSETYPE t ");
			sql.append(" where 1=1 ");
			if(osupplieusetype!=null){
				if (!StringUtil.nullOrBlank(osupplieusetype.getUnit_id())) {
					sql.append(" and t.unit_id = ? ");
					condition.add(osupplieusetype.getUnit_id());
				}
				
				if (!StringUtil.nullOrBlank(osupplieusetype.getOfustype_name())) {
					sql.append(" and ofustype_name like '%'||?||'%'");
					condition.add(osupplieusetype.getOfustype_name());
				}
			}
			//排序
			sql.append(" order by " + sortName + " " + sortOrder);
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getOsupplieUseType
	  * @param ofus_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsupplieUseTypeDao#getOsupplieUseType(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getOsupplieUseType(String ofus_id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from TA_OA_DETOSUPPLIEUSETYPE ");
		sql.append(" where ofustype_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), ofus_id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteOsupplieUseBeansById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsupplieUseTypeDao#deleteOsupplieUseBeansById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteOsupplieUseBeansById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from TA_OA_DETOSUPPLIEUSETYPE ");
		sql.append(" where ofustype_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}


	/**
	 * 
	  * <b>Summary: 查询所有物品信息</b>
	  *     复写方法 queryAllOsupplieUseType
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsupplieUseTypeDao#queryAllOsupplieUseType()
	 */
	public List<Map<String, String>> queryAllOsupplieUseType(String unit_id) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		List<Map<String, String>> allOsupplieUseList = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select OFUSTYPE_ID, OFUSTYPE_NAME ");
		sql.append("  from TA_OA_DETOSUPPLIEUSETYPE ");
		sql.append(" where 1=1 and unit_id = '"+unit_id+"'  order by  ofustype_no ");
		pdb.preparedSelect(sql.toString());
		pdb.executePrepared();
		for (int i = 0; i < pdb.size(); i++) {
			Map<String, String> allOsupplieUseMap = new HashMap<String, String>();
			allOsupplieUseMap.put("OFUSTYPE_ID", pdb.getString(i, "OFUSTYPE_ID"));
			allOsupplieUseMap.put("OFUSTYPE_NAME", pdb.getString(i, "OFUSTYPE_NAME"));
			allOsupplieUseList.add(allOsupplieUseMap);
		}
		return allOsupplieUseList;
	}
	
//	 /** 
//	  * <b>Summary: </b>
//	  *     复写方法 updateUseItem
//	  * @param conn
//	  * @param beanId
//	  * @return
//	  * @throws Exception 
//	  */
//	@Override
//	public boolean insertUseItem(String type_id,String item_id)
//			throws Exception {
//		StringBuffer sql = new StringBuffer();
//		sql.append(" delete from ta_oa_osupplieusetype ");
//		sql.append(" where ofustype_id in ");
//		sql.append("       (?)");
//		PreparedDBUtil pdb = new PreparedDBUtil();
//		pdb.preparedUpdate(sql.toString());
//		pdb.setString(1, beanId);
//		pdb.executePrepared(conn);
//		return true;
//	}
	
}
