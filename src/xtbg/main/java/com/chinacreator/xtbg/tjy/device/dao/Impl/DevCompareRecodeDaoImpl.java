
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCompareRecodeDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-8   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevCompareRecodeDao;
import com.chinacreator.xtbg.tjy.device.entity.DevCompareRecode;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevCompareRecodeDaoImpl.java</p>
 *<p>Description:对比记录数据库接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-8
 */
public class DevCompareRecodeDaoImpl extends XtDbBaseDao implements DevCompareRecodeDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selDevCompareRecodeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevCompareRecodeDao#selDevCompareRecodeList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selDevCompareRecodeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		DevCompareRecode devcomparerecode= new DevCompareRecode();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				devcomparerecode = (DevCompareRecode) JSONObject.parseObject(parmjson, DevCompareRecode.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select comp_id,");
			sql.append("       t_sb_id,");
			sql.append("       comp_sb_id,");
			sql.append("       comp_result,");
			sql.append("       comp.remark,");
			sql.append("       to_char(comp.creator_time,'yyyy-mm-dd') as creator_time,");
			sql.append("       info.dev_code as dev_code,");
			sql.append("       info.dev_name as dev_name,");
			sql.append("       info1.dev_code as com_devcode,");
			sql.append("       info1.dev_name as com_devname");
			sql.append("  from ta_oa_devcomparerecode comp, ta_oa_devaccount info, ta_oa_devaccount info1 ");
			sql.append(" where comp.t_sb_id = info.id");
			sql.append("   and comp.comp_sb_id = info1.id");
			if(devcomparerecode!=null){
				//设备设备ID
				if (!StringUtil.nullOrBlank(devcomparerecode.getT_sb_id())) {
					sql.append(" and t_sb_id = ? ");
					condition.add(devcomparerecode.getT_sb_id());
				}
				//设备编号
				if (!StringUtil.nullOrBlank(devcomparerecode.getDev_code())) {
					sql.append(" and info.dev_code like '%'||?||'%'");
					condition.add(devcomparerecode.getDev_code());
				}
				//设备名称
				if (!StringUtil.nullOrBlank(devcomparerecode.getDev_name())) { 
					sql.append(" and info.dev_name like '%'||?||'%'");
					condition.add(devcomparerecode.getDev_name());
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
	  *     复写方法 getDevCompareRecode
	  * @param comp_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevCompareRecodeDao#getDevCompareRecode(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevCompareRecode(String comp_id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select comp_id,");
		sql.append("       t_sb_id,");
		sql.append("       comp_sb_id,");
		sql.append("       comp_result,");
		sql.append("       comp.remark,");
		sql.append("       info.dev_code as dev_code,");
		sql.append("       info.dev_name as dev_name,");
		sql.append("       info1.dev_code as com_devcode,");
		sql.append("       info1.dev_name as com_devname");
		sql.append("  from ta_oa_devcomparerecode comp, ta_oa_devaccount info, ta_oa_devaccount info1 ");
		sql.append(" where comp.t_sb_id = info.id");
		sql.append("   and comp.comp_sb_id = info1.id");
		sql.append("       and comp_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), comp_id);
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevCompareRecodeById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevCompareRecodeDao#deleteDevCompareRecodeById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteDevCompareRecodeById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devcomparerecode ");
		sql.append(" where comp_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

}
