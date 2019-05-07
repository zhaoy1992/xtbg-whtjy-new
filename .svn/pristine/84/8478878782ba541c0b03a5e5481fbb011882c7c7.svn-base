
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevSupplierDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-27   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevSupplierDao;
import com.chinacreator.xtbg.tjy.device.entity.DevSupplier;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevSupplierDaoImpl.java</p>
 *<p>Description:供应商名录数据库接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-27
 */
public class DevSupplierDaoImpl extends XtDbBaseDao implements DevSupplierDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selDevSupplierList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevSupplierDao#selDevSupplierList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selDevSupplierList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		DevSupplier devsupplier= new DevSupplier();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				devsupplier = (DevSupplier) JSONObject.parseObject(parmjson, DevSupplier.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select devsup_id,");
			sql.append("       devsup_mc,");
			sql.append("       to_char(devsup_slsj,'yyyy-mm-dd') as devsup_slsj,");
			sql.append("       devsup_gfxz,");
			sql.append("       devsup_gflb,");
			sql.append("       devsup_gfdz,");
			sql.append("       devsup_fddbr,");
			sql.append("       devsup_lxdb,");
			sql.append("       devsup_lxdh,");
			sql.append("       devsup_xyd,");
			sql.append("       devsup_sfyx,");
			sql.append("       devsup_tgcp,");
			sql.append("       devsup_gflb as devsup_gflbbh, ");
			sql.append("       devsup_gfxz as devsup_gflxzbh, ");
			sql.append("       devsup_xyd as devsup_xydbh	");
			sql.append("  from ta_oa_devsupplier");
			sql.append("  where 1=1" );
			if(devsupplier!=null){
				//供应商名称
				if (!StringUtil.nullOrBlank(devsupplier.getDevsup_mc())) {
					sql.append(" and devsup_mc like '%'||?||'%'");
					condition.add(devsupplier.getDevsup_mc());
				}
				//收录开始时间
				if (!StringUtil.nullOrBlank(devsupplier.getDevsup_Sslsj())) { 
					sql.append(" and devsup_slsj >= ").append(" to_date('").append(devsupplier.getDevsup_Sslsj()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
				}
				//收录结束时间
				if (!StringUtil.nullOrBlank(devsupplier.getDevsup_Eslsj())) { 
					sql.append(" and devsup_slsj <= ").append(" to_date('").append(devsupplier.getDevsup_Eslsj()).append(" 23:59:59','yyyy-MM-dd HH24:mi:ss') ");
				}
				//供方类别
				if (!StringUtil.nullOrBlank(devsupplier.getDevsup_gflb())) {
					sql.append(" and devsup_gflb =? ");
					condition.add(devsupplier.getDevsup_gflb());
				}
				//信誉度
				if (!StringUtil.nullOrBlank(devsupplier.getDevsup_xyd())) { 
					sql.append(" and devsup_xyd =?");
					condition.add(devsupplier.getDevsup_xyd());
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
	  *     复写方法 getDevSupplier
	  * @param devsup_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevSupplierDao#getDevSupplier(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevSupplier(String devsup_id, Connection conn)
			throws Exception {
		
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select devsup_id,");
		sql.append("       devsup_mc,");
		sql.append("       to_char(devsup_slsj,'yyyy-mm-dd' ) as devsup_slsj,");
		sql.append("       devsup_gfxz,");
		sql.append("       devsup_gflb,");
		sql.append("       devsup_gfdz,");
		sql.append("       devsup_fddbr,");
		sql.append("       devsup_lxdb,");
		sql.append("       devsup_lxdh,");
		sql.append("       devsup_xyd,");
		sql.append("       devsup_sfyx,");
		sql.append("       devsup_tgcp");
		sql.append("  from ta_oa_devsupplier ");
		sql.append(" where devsup_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), devsup_id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevSupplierById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevSupplierDao#deleteDevSupplierById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteDevSupplierById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from ta_oa_devsupplier ");
		sql.append(" where devsup_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

}
