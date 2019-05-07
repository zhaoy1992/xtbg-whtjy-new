
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevRepairDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-6   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevRepairDao;
import com.chinacreator.xtbg.tjy.device.entity.DevRepairBean;

/**
 *<p>Title:DevRepairDaoImpl.java</p>
 *<p>Description:仪器设备维修数据库接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-6
 */
public class DevRepairDaoImpl extends XtDbBaseDao implements DevRepairDao{

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevRepairInfo
	  * @param t_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevRepairDao#getDevRepairInfo(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevRepairInfo(String t_id, Connection conn)
			throws Exception {
		
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t_id,");
		sql.append("       t_fj_id,");
		sql.append("       t_zw_id,");
		sql.append("       t_sb_id,");
		sql.append("       t_wxfys,");
		sql.append("       t_wxnr,");
		sql.append("       t_sbsyr_id,");
		sql.append("       t_sbsyr_mc,");
		sql.append("       t_fgldsh,");
		sql.append("       t_ycsh,");
		sql.append("       t_wxysqk,");
		sql.append("       t_wbdwr,");
		sql.append("       t_sqr_sj,");
		sql.append("       t_title");
		sql.append("       from ta_oa_devrepair ");
		sql.append(" where t_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), t_id);
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selDevRepairInfoList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevRepairDao#selDevRepairInfoList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selDevRepairInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		DevRepairBean devrepairbean= new DevRepairBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				devrepairbean = (DevRepairBean) JSONObject.parseObject(parmjson, DevRepairBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("select t_id,");
			sql.append("       t_fj_id,");
			sql.append("       t_zw_id,");
			sql.append("       t_sb_id,");
			sql.append("       t_wxfys,");
			sql.append("       t_wxnr,");
			sql.append("       t_sbsyr_id,");
			sql.append("       t_sbsyr_mc,");
			sql.append("       t_fgldsh,");
			sql.append("       t_ycsh,");
			sql.append("       t_wxysqk,");
			sql.append("       t_wbdwr,");
			sql.append("       to_char(t_sqr_sj,'yyyy-mm-dd') as t_sqr_sj,");
			sql.append("       t_title");
			sql.append("       from ta_oa_devrepair ");
			sql.append("  where 1=1" );
			if(devrepairbean!=null){
				//设备ID
				if (!StringUtil.nullOrBlank(devrepairbean.getT_sb_id())) {
					sql.append(" and t_sb_id =?");
					condition.add(devrepairbean.getT_sb_id());
				}
				//标题
				if (!StringUtil.nullOrBlank(devrepairbean.getT_title())) {
					sql.append(" and t_title like '%'||?||'%'");
					condition.add(devrepairbean.getT_title());
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

}
