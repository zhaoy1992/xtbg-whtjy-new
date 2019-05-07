package com.chinacreator.xtbg.core.sysparam.dao.impl;

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
import com.chinacreator.xtbg.core.sysparam.dao.SysParamDao;
import com.chinacreator.xtbg.core.sysparam.entity.SysParamBean;
import com.chinacreator.xtbg.core.sysparam.entity.SysParamvalueBean;
/**
 * 
 *<p>Title:SysParamDaoImpl.java</p>
 *<p>Description:系统参数设置接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-18
 */
public class SysParamDaoImpl extends XtDbBaseDao implements SysParamDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selSysParamList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.sysparam.dao.SysParamDao#selSysParamList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selSysParamList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		
		Connection conn = null;
		SysParamBean sysParamBean= new SysParamBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				sysParamBean = (SysParamBean) JSONObject.parseObject(parmjson, SysParamBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("  select * from oa_sys_param b ");
			sql.append("  where 1=1");
			
			if(sysParamBean!=null){
				if (!StringUtil.nullOrBlank(sysParamBean.getP_name())) {
					sql.append(" and b.p_name like '%'||?||'%'");
					condition.add(sysParamBean.getP_name());
				}
				if (!StringUtil.nullOrBlank(sysParamBean.getDictdata_id())) {
					sql.append(" and b.dictdata_id = ? ");
					condition.add(sysParamBean.getDictdata_id());
				}
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getSysParamBean
	  * @param p_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.sysparam.dao.SysParamDao#getSysParamBean(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getSysParamBean(String p_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_sys_param b");
		sql.append(" where b.p_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), p_id.replaceAll("'", ""));
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getSysParamByPcode
	  * @param p_code
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.sysparam.dao.SysParamDao#getSysParamByPcode(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getSysParamByPcode(String p_code, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_sys_param b");
		sql.append(" where b.p_code = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), p_code);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 selSysParamValueList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.sysparam.dao.SysParamDao#selSysParamValueList(java.lang.String, java.lang.String, java.lang.String, long, int)
	 */
	public PagingBean selSysParamvalueList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		SysParamvalueBean sysParamvalueBean= new SysParamvalueBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				sysParamvalueBean = (SysParamvalueBean) JSONObject.parseObject(parmjson, SysParamvalueBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("  select * from oa_sys_paramvalue b ");
			sql.append("  where 1=1");
			sql.append(" and b.p_code = ? ");
			condition.add(sysParamvalueBean.getP_code());
			
			if(sysParamvalueBean!=null){
				if (!StringUtil.nullOrBlank(sysParamvalueBean.getP_value_name())) {
					sql.append(" and b.p_value_name like '%'||?||'%'");
					condition.add(sysParamvalueBean.getP_value_name());
				}
				sql.append(" order by " + sortName + " " + sortOrder);
			}
			
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn,condition);
			return pb;
		} finally {
			DbManager.closeConnection(conn);
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getSysParamvalueBean
	  * @param p_value_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.sysparam.dao.SysParamDao#getSysParamvalueBean(java.lang.String, java.sql.Connection)
	 */
	public Map<String, String> getSysParamvalueBean(String p_value_id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_sys_paramvalue b");
		sql.append(" where b.p_value_id = ? ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), p_value_id);
		
		return viewMap;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getSysParamvalueByPcode
	  * @param p_code
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.sysparam.dao.SysParamDao#getSysParamvalueByPcode(java.lang.String, java.sql.Connection)
	 */
	public List<Map<String, String>> getSysParamvalueByPcode(String p_code) throws Exception {
		List<Map<String, String>> list= new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_sys_paramvalue b");
		sql.append(" where b.p_code = ? ");
		
		list = queryToListMap(sql.toString(), p_code);
		
		return list;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getSysParamvalueByPvcode
	  * @param p_value_code
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.sysparam.dao.SysParamDao#getSysParamvalueByPvcode(java.lang.String)
	 */
	public Map<String, String> getSysParamvalueByPvcode(
			String p_value_code,String p_code) throws Exception {
		Map<String, String> map= new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from oa_sys_paramvalue b");
		sql.append(" where b.p_value_code = ? and b.p_code=? ");
		
		map = queryToSingleMap(sql.toString(), p_value_code,p_code);
		
		return map;
	}

}
