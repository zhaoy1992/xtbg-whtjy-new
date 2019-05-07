
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsPlanDataDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-6-27   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.officesupplies.data;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;

/**
 *<p>Title:OsPlanDataDaoImpl.java</p>
 *<p>Description:查询模版中需要导出的数据类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-6-27
 */
public class OsPlanDataDaoImpl  extends XtDbBaseDao {
	
	private static final Log LOG = LogFactory.getLog(OsPlanDataDaoImpl.class);
	
	/** 
	 * <b>Summary:  查询采购申请表信息</b>
	 *     复写方法 getOsApplyPlan
	 * @param it_id
	 * @param conn
	 * @return
	 * @throws Exception 
	 */
	public Map<String, String> getOsApplyPlan(String t_id) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			Map<String, String> viewMap = new HashMap<String, String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select  t_id,t_org_id,t_org_name,");
			sql.append("  to_char(t_creator_time,'yyyy-mm-dd') as t_creator_time, ");
			sql.append("  t_title,t_bmfzyj,t_user_id,t_user_name  ");
			sql.append("  from ta_oa_osapplan ");
			sql.append(" where t_id = ? ");
			viewMap = queryToSingleMap(conn, sql.toString(), t_id);
			conn.commit();
			return viewMap;
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			throw e;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/** 
	 * <b>Summary:  查询采购计划审批信息</b>
	 *     复写方法 getOsexaminaTion
	 * @param it_id
	 * @param conn
	 * @return
	 * @throws Exception 
	 */
	public Map<String, String> getOsexaminaTion(String t_id) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			Map<String, String> viewMap = new HashMap<String, String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select  t_osexa_id,");
			sql.append("  t_osexa_org_id,");
			sql.append("  t_osexa_org_name,");
			sql.append("  to_char(t_osexa_date,'yyyy-mm-dd') as t_osexa_date, ");
			sql.append("  t_osexa_title, ");
			sql.append("  t_osexa_bgsyj, ");
			sql.append("  t_osexa_zgyj,");
			sql.append("  t_osexa_yzyj, ");
			sql.append("  t_osexa_user_id,  ");
			sql.append("  t_osexa_user_name ");
			sql.append("  from ta_oa_osexamination ");
			sql.append(" where t_osexa_id = ? ");
			viewMap = queryToSingleMap(conn, sql.toString(), t_id);
			conn.commit();
			return viewMap;
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			throw e;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	/** 
	 * <b>Summary:  查询领用申请表信息</b>
	 *     复写方法 getOsHandLyobj
	 * @param it_id
	 * @param conn
	 * @return
	 * @throws Exception 
	 */
	public Map<String, String> getOsHandLyobj(String t_id) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			Map<String, String> viewMap = new HashMap<String, String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select t_appregyhp_id,");
			sql.append("       t_fj_id,");
			sql.append("       t_zw_id,");
			sql.append("       t_appregyhp_org_id,");
			sql.append("       t_appregyhp_org_name,");
			sql.append("       t_appregyhp_user_id,");
			sql.append("       t_appregyhp_user_name,");
			sql.append("       to_char(t_appregyhp_date,'yyyy-mm-dd') as t_appregyhp_date,");
			sql.append("       t_appregyhp_appids,");
			sql.append("       t_appregyhp_title,");
			sql.append("       t_appregyhp_bgsuserid,");
			sql.append("       t_appregyhp_bgsyj,");
			sql.append("       t_appregyhp_bgsusername");
			sql.append("  from TA_OA_OSAPPREGYHP");
			sql.append(" where t_appregyhp_id = ? ");
			viewMap = queryToSingleMap(conn, sql.toString(), t_id);
			conn.commit();
			return viewMap;
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			throw e;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	/** 
	 * <b>Summary:  固定资产申领登记表</b>
	 *     复写方法 getOsnoMove
	 * @param it_id
	 * @param conn
	 * @return
	 * @throws Exception 
	 */
	public Map<String, String> getOsnoMove(String t_id) throws Exception {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			Map<String, String> viewMap = new HashMap<String, String>();
			StringBuffer sql = new StringBuffer();
			sql.append("select t_osnom_id,");
			sql.append("              t_fj_id,");
			sql.append("              t_zw_id,");
			sql.append("              t_hava_ids,");
			sql.append("              t_osnom_org_id,");
			sql.append("              t_osnom_org_name,");
			sql.append("              t_osnom_user_id,");
			sql.append("              t_osnom_user_name,");
			sql.append("              t_osnom_title,");
			sql.append("              to_char(t_osnom_date,'yyyy-mm-dd') as t_osnom_date,");
			sql.append("              t_osnom_bmfzryj,");
			sql.append("              t_osnom_bgsfzryj,");
			sql.append("              t_osnom_zgldyj,");
			sql.append("              t_osnom_yzyj");
			sql.append("         from ta_oa_osnomove");
			sql.append("         where t_osnom_id=?");
			viewMap = queryToSingleMap(conn, sql.toString(), t_id);
			conn.commit();
			return viewMap;
		}catch(Exception e){
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
			throw e;
		} finally {
			DbManager.closeConnection(conn);
		}
	}
	
	
	
}
