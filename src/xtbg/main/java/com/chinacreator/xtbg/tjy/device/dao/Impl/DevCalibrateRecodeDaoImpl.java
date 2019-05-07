
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCalibrateRecodeDaoImpl.java
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
import com.chinacreator.xtbg.tjy.device.dao.DevCalibrateRecodeDao;
import com.chinacreator.xtbg.tjy.device.entity.DevCalibrateRecode;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevCalibrateRecodeDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-8
 */
public class DevCalibrateRecodeDaoImpl extends XtDbBaseDao implements DevCalibrateRecodeDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selDevCalibrateRecodeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevCalibrateRecodeDao#selDevCalibrateRecodeList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selDevCalibrateRecodeList(String parmjson,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception {
		Connection conn = null;
		DevCalibrateRecode devcalibraterecode= new DevCalibrateRecode();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				devcalibraterecode = (DevCalibrateRecode) JSONObject.parseObject(parmjson, DevCalibrateRecode.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select calib_id,");
			sql.append("       t_sb_id,");
			sql.append("       calib_no,");
			sql.append("       calib_org_id,");
			sql.append("       calib_org_name,");
			sql.append("       to_char(calib_time,'yyyy-mm-dd') as calib_time,");
			sql.append("       to_char(calib_valitime,'yyyy-mm-dd') as calib_valitime,");
			sql.append("       calib_parrange,");
			sql.append("       calib_type,");
			sql.append("       info.dev_code as dev_code,");
			sql.append("       info.dev_name as dev_name");
			sql.append("  from ta_oa_devaccount info, ta_oa_devcalibraterecode calib");
			sql.append("  where info.id = calib.t_sb_id");
			if(devcalibraterecode!=null){
				//设备设备ID
				if (!StringUtil.nullOrBlank(devcalibraterecode.getT_sb_id())) {
					sql.append(" and t_sb_id = ? ");
					condition.add(devcalibraterecode.getT_sb_id());
				}
				//设备编号
				if (!StringUtil.nullOrBlank(devcalibraterecode.getDev_code())) {
					sql.append(" and info.dev_code like '%'||?||'%'");
					condition.add(devcalibraterecode.getDev_code());
				}
				//设备名称
				if (!StringUtil.nullOrBlank(devcalibraterecode.getDev_name())) { 
					sql.append(" and info.dev_name like '%'||?||'%'");
					condition.add(devcalibraterecode.getDev_name());
				}
				//校对类型
				if (!StringUtil.nullOrBlank(devcalibraterecode.getCalib_type())) { 
					sql.append(" and calib_type like '%'||?||'%'");
					condition.add(devcalibraterecode.getCalib_type());
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
	  *     复写方法 getDevCalibrateRecodeBean
	  * @param calib_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevCalibrateRecodeDao#getDevCalibrateRecodeBean(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevCalibrateRecodeBean(String calib_id,
			Connection conn) throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select calib_id,");
		sql.append("       t_sb_id,");
		sql.append("       calib_no,");
		sql.append("       calib_org_id,");
		sql.append("       calib_org_name,");
		sql.append("       to_char(calib_time,'yyyy-mm-dd') as calib_time,");
		sql.append("       to_char(calib_valitime,'yyyy-mm-dd') as calib_valitime,");
		sql.append("       calib_parrange,");
		sql.append("       calib_type,");
		sql.append("       info.dev_code as dev_code,");
		sql.append("       info.dev_name as dev_name");
		sql.append("  from ta_oa_devaccount info, ta_oa_devcalibraterecode calib");
		sql.append("  where info.id = calib.t_sb_id");
		sql.append("       and calib_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), calib_id);
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevCalibrateRecodeById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevCalibrateRecodeDao#deleteDevCalibrateRecodeById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteDevCalibrateRecodeById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devcalibraterecode ");
		sql.append(" where calib_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	
}
