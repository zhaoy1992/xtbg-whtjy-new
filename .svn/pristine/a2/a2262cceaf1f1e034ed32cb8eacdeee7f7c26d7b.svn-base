
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevInfoItemDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.device.dao.DevInfoItemDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevInfoItemDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public class DevInfoItemDaoImpl extends XtDbBaseDao implements DevInfoItemDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevInfoItem
	  * @param dev_code
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevInfoItemDao#getDevInfoItem(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public List<Map<String, String>> getDevInfoItem(String dev_code,
			Connection conn) throws Exception {
		List<Map<String, String>> viewMap = new ArrayList<Map<String, String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from ta_oa_devainfoitem ");
		sql.append(" where dev_code = ? order by parts_no ");
		viewMap = queryToListMap(sql.toString(), dev_code);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevInfoItemById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevInfoItemDao#deleteDevInfoItemById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteDevInfoItemById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devainfoitem ");
		sql.append(" where dev_code in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

}
