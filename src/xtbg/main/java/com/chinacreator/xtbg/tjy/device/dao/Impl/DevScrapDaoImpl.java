
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevScrapDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-10   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.device.dao.DevScrapDao;
import com.chinacreator.xtbg.tjy.device.entity.DevScrapBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevScrapDaoImpl.java</p>
 *<p>Description:申请报废数据库Dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-10
 */
public class DevScrapDaoImpl extends XtDbBaseDao implements DevScrapDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevScrapInfo
	  * @param t_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevScrapDao#getDevScrapInfo(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevScrapInfo(String t_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t_id,");
		sql.append("       t_fj_id,");
		sql.append("       t_zw_id,");
		sql.append("       t_title,");
		sql.append("       t_sb_id,");
		sql.append("       t_trsynx,");
		sql.append("       t_bfly,");
		sql.append("       t_sbgcsyj,");
		sql.append("       t_yzlfzryj,");
		sql.append("       t_ycyj,");
		sql.append("       t_sbfzrid,");
		sql.append("       t_sbfzrmc,");
		sql.append("       t_sqrq");
		sql.append("  from ta_oa_devscrap");
		sql.append(" where t_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), t_id);
		return viewMap;
	}
	@Override
	public void saveDevScrapInfo(DevScrapBean bean) throws Exception {
		StringBuffer sql = new StringBuffer();
		PreparedDBUtil pb = new PreparedDBUtil();
		sql.append("insert into TA_OA_DEVSCRAP ");
		sql.append("(T_ID,T_SB_ID,T_TRSYNX,T_BFLY,T_SQRQ,T_TITLE) ");
		sql.append("  values(?,?,?,?,to_date(?,'yyyy-MM-dd'),?)");
		pb.preparedInsert(sql.toString());
		pb.setString(1, bean.getT_id());
		pb.setString(2, bean.getT_sb_id());
		pb.setString(3, bean.getT_trsynx());
		pb.setString(4, bean.getT_bfly());
		pb.setString(5, bean.getT_sqrq());
		pb.setString(6, bean.getT_title());
		pb.executePrepared();
	}
}
