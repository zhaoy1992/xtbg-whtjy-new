
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCheckInfoDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-7   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevCheckInfoDao;
import com.chinacreator.xtbg.tjy.device.entity.DevCheckInfoBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevCheckInfoDaoImpl.java</p>
 *<p>Description:检查记录数据库Dao接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-7
 */
public class DevCheckInfoDaoImpl  extends XtDbBaseDao implements DevCheckInfoDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selDevCheckInfoList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevCheckInfoDao#selDevCheckInfoList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selDevCheckInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		DevCheckInfoBean devcheckinfobean= new DevCheckInfoBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				devcheckinfobean = (DevCheckInfoBean) JSONObject.parseObject(parmjson, DevCheckInfoBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select t.id,");
			sql.append("       t_sb_id,");
			sql.append("       info.dev_code as dev_code,");
			sql.append("       info.dev_name as dev_name,");
			sql.append("       info.type as dev_type,");
			sql.append("       to_char(chinfo_date,'yyyy-mm-dd') as chinfo_date,");
			sql.append("       user_id,");
			sql.append("       user_name,");
			sql.append("       attachid,");
			sql.append("       t.remark");
			sql.append("  from ta_oa_devaccount info, ta_oa_devcheckinfo t");
			sql.append(" where info.id = t.t_sb_id");
			if(devcheckinfobean!=null){
				//设备ID
				if (!StringUtil.nullOrBlank(devcheckinfobean.getT_sb_id())) {
					sql.append(" and t_sb_id =? ");
					condition.add(devcheckinfobean.getT_sb_id());
				}
				//设备编号
				if (!StringUtil.nullOrBlank(devcheckinfobean.getDev_code())) {
					sql.append(" and info.dev_code like '%'||?||'%'");
					condition.add(devcheckinfobean.getDev_code());
				}
				//设备名称
				if (!StringUtil.nullOrBlank(devcheckinfobean.getDev_name())) { 
					sql.append(" and info.dev_name like '%'||?||'%'");
					condition.add(devcheckinfobean.getDev_name());
				}
				//设备类型
				if (!StringUtil.nullOrBlank(devcheckinfobean.getDev_type())) { 
					sql.append(" and info.type like '%'||?||'%'");
					condition.add(devcheckinfobean.getDev_type());
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
	  *     复写方法 getDevCheckInfo
	  * @param id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevCheckInfoDao#getDevCheckInfo(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevCheckInfo(String id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.id,");
		sql.append("       t_sb_id,");
		sql.append("       info.dev_code as dev_code,");
		sql.append("       info.dev_name as dev_name,");
		sql.append("       info.type as dev_type,");
		sql.append("       to_char(chinfo_date,'yyyy-mm-dd') as chinfo_date,");
		sql.append("       user_id,");
		sql.append("       user_name,");
		sql.append("       attachid,");
		sql.append("       t.remark");
		sql.append("  from ta_oa_devaccount info, ta_oa_devcheckinfo t");
		sql.append(" where info.id = t.t_sb_id");
		sql.append("       and t.id=? ");
		viewMap = queryToSingleMap(conn, sql.toString(), id);
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevCheckInfoById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevCheckInfoDao#deleteDevCheckInfoById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteDevCheckInfoById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devcheckinfo ");
		sql.append(" where id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

}
