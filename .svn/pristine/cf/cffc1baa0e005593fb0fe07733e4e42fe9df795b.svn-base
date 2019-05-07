
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevTakcareDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

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
import com.chinacreator.xtbg.tjy.device.dao.DevTakcareDao;
import com.chinacreator.xtbg.tjy.device.entity.DevTakcareBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevTakcareDaoImpl.java</p>
 *<p>Description:设备维修和保养记录数据库接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-8
 */
public class DevTakcareDaoImpl extends XtDbBaseDao implements DevTakcareDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selDevTakcareList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevTakcareDao#selDevTakcareList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selDevTakcareList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		DevTakcareBean devtakcarebean= new DevTakcareBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				devtakcarebean = (DevTakcareBean) JSONObject.parseObject(parmjson, DevTakcareBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select tac_id,");
			sql.append("       t_sb_id,");
			sql.append("       info.num as dev_code,");
			sql.append("       info.name as dev_name,");
			sql.append("       info.type_name as  dev_type,");
			sql.append("       to_char(tac_usertime,'yyyy-mm-dd') as tac_usertime,");
			sql.append("       tac_content,");
			sql.append("       tac_checkcontent,");
			sql.append("       tac_maintenance,");
			sql.append("       t.devmanageid as devmanageid,");
			sql.append("       t.devmanagename as devmanagename,");
			sql.append("	   info.state as state,");
			sql.append("       to_char(tac_time,'yyyy-mm-dd') as tac_time");
			sql.append("  from ta_oa_whtjy_gdzc info, ta_oa_devtakcare t");
			sql.append(" where info.id = t.t_sb_id");
			if(devtakcarebean!=null){
				//设备编号
				if (!StringUtil.nullOrBlank(devtakcarebean.getDev_code())) {
					sql.append(" and info.num like '%'||?||'%'");
					condition.add(devtakcarebean.getDev_code());
				}
				//设备名称
				if (!StringUtil.nullOrBlank(devtakcarebean.getDev_name())) { 
					sql.append(" and info.name like '%'||?||'%'");
					condition.add(devtakcarebean.getDev_name());
				}
				//设备类型
				if (!StringUtil.nullOrBlank(devtakcarebean.getDev_type())) { 
					sql.append(" and info.type_name like '%'||?||'%'");
					condition.add(devtakcarebean.getDev_type());
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
	  *     复写方法 getDevTakcareBean
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevTakcareDao#getDevTakcareBean(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevTakcareBean(String id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select tac_id,");
		sql.append("       t_sb_id,");
		sql.append("       info.num as dev_code,");
		sql.append("       info.name as dev_name,");
		sql.append("       info.type_name as  dev_type,");
		sql.append("       to_char(tac_usertime,'yyyy-mm-dd') as tac_usertime,");
		sql.append("       tac_content,");
		sql.append("       tac_checkcontent,");
		sql.append("       tac_maintenance,");
		sql.append("       devmanageid,");
		sql.append("       devmanagename,");
		sql.append("       to_char(tac_time,'yyyy-mm-dd') as tac_time");
		sql.append("  from ta_oa_whtjy_gdzc info, ta_oa_devtakcare t");
		sql.append(" where info.id = t.t_sb_id");
		sql.append("       and t.tac_id=? ");
		viewMap = queryToSingleMap(conn, sql.toString(), id);
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevTakcareById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevTakcareDao#deleteDevTakcareById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteDevTakcareById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devtakcare ");
		sql.append(" where tac_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

}
