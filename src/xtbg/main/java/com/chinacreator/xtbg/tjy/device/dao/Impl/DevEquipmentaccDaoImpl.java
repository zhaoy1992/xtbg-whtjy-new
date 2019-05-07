
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevEquipmentaccDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-20   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.dao.Impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.tjy.device.dao.DevEquipmentaccDao;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:DevEquipmentaccDao.java</p>
 *<p>Description:政府采购验收表单数据库接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-20
 */
public class DevEquipmentaccDaoImpl extends XtDbBaseDao implements DevEquipmentaccDao {

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevEquipmentacc
	  * @param t_id
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevEquipmentaccDao#getDevEquipmentacc(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getDevEquipmentacc(String t_id, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t_id,");
		sql.append("       t_title,");
		sql.append("       t_sbname,");
		sql.append("       t_ggno,");
		sql.append("       t_factory,");
		sql.append("       t_ccno,");
		sql.append("       to_char(t_dhdate,'yyyy-mm-dd') as t_dhdate,");
		sql.append("       t_wg,");
		sql.append("       t_hgzorzzs,");
		sql.append("       t_sbqd,");
		sql.append("       t_sbsysms,");
		sql.append("       t_sbazsms,");
		sql.append("       t_cphgz,");
		sql.append("       t_zlsms,");
		sql.append("       t_jdcsba,");
		sql.append("       t_pzorfj,");
		sql.append("       t_yhtyq,");
		sql.append("       t_other,");
		sql.append("       t_aztsqk,");
		sql.append("       t_ysjl,");
		sql.append("       t_gfysr,");
		sql.append("       to_char(t_gfysr_date,'yyyy-mm-dd') as t_gfysr_date,");
		sql.append("       t_byysr_yj,");
		sql.append("       t_sbzrgcs_yj,");
		sql.append("       t_fyjsfzr_yj,");
		sql.append("       t_sb_id,");
		sql.append("       item_id,");
		sql.append("       t_sl");
		sql.append("  from ta_oa_devequipmentacc");
		sql.append(" where t_id = ? ");
		viewMap = queryToSingleMap(conn, sql.toString(), t_id);
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevEquipmentacById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.device.dao.DevEquipmentaccDao#deleteDevEquipmentacById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteDevEquipmentacById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("delete ");
		sql.append("  from ta_oa_devequipmentacc t");
		sql.append(" where t.t_id in (select t1.item_reportid");
		sql.append("                    from ta_oa_devsettleitem t1");
		sql.append("                   where t1.devsettle_id in (?))");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}

}
