
 /**
 * [Product]
  *     xtbg-base
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     FirstPageDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-7-8   邱炼    最初版本
   */
package com.chinacreator.xtbg.waitDoWork.dao.imploracle;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.workbench.dao.impl.WorkbenchDaoImpl;

/**
 *<p>Title:FirstPageDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-7-8
 */
public class FirstPageDaoImpl {
	
	private static final Logger LOG = Logger.getLogger(FirstPageDaoImpl.class);
	/**
	*<b>Summary: </b>
	* queryIfm_NoticUserData(查询 用户id查询相应的 院内简报显示数据)
	* @param 	userID	用户id
	* @return   List<Map<字段名, 字段值>>  
	*/
	public List<Map<String, String>> queryIfm_NoticUserData(String userID,int showMaxRowNum) {
		List<Map<String, String>> list = null;
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getConnection();
			list = new ArrayList<Map<String, String>>();
			StringBuffer sql = new StringBuffer();
			sql.append("select b.n_notice_id as n_notice_id,");
			sql.append("       b.n_title as n_title,");
			sql.append("       b.n_type,");
			sql.append("       b.n_release_userid,");
			sql.append("       b.n_release_username,");
			sql.append("       b.n_release_time");
			sql.append("  from oa_notice_baseinfo b");
			sql.append(" where b.n_state = '1'");
			sql.append("   and b.n_type = '3' ");
			sql.append(" order by n_release_time desc");
			
			List<String> params = new ArrayList<String>();
			//params.add(userID);
			
			String columnString = "n_title";// 显示字段

			if (!"".equals(columnString)) {// 加样式的显示字段
				columnString += "," + "n_title ";
			}

			if (!"".equals(columnString)) {// url参数字段
				columnString += "," + "n_notice_id";
			}

			List<String> dbColumns = Arrays.asList(columnString.split(","));

			WorkbenchDaoImpl  dao = new WorkbenchDaoImpl();
			list = dao.queryUserData(sql.toString(), params, dbColumns, showMaxRowNum , conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally {
			DbManager.closeConnection(conn);
		}
		return list;
	}
}
