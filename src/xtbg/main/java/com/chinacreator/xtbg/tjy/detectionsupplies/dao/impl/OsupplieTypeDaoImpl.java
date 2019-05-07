
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsupplieTypeDaoImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-17   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.detectionsupplies.dao.impl;

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
import com.chinacreator.xtbg.tjy.detectionsupplies.dao.OsupplieTypeDao;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsupplieTypeBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:OsupplieTypeDaoImpl.java</p>
 *<p>Description:设备和易耗品Dao实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-17
 */
public class OsupplieTypeDaoImpl extends XtDbBaseDao implements OsupplieTypeDao{
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 selOsupplieTypeList
	  * @param parmjson
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsupplieTypeDao
	  * #selOsupplieTypeList(java.lang.String, java.lang.String, java.lang.String, long, int) 
	  */
	@Override
	public PagingBean selOsupplieTypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		OsupplieTypeBean osupplietypebean= new OsupplieTypeBean();
		PagingBean pb = new PagingBean();
		List<String> condition = new ArrayList<String>();
		try {
			if (!StringUtil.isBlank(parmjson)) {
				osupplietypebean = (OsupplieTypeBean) JSONObject.parseObject(parmjson, OsupplieTypeBean.class);
			}
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("select  oftype_id,");
			sql.append("        oftype_name, ");
			sql.append("        oftype_remark, ");
			sql.append("        oftype_no, ");
			sql.append("        oftype_flag");
			sql.append("  from TA_OA_DETOSUPPLIETYPE");
			sql.append("  where 1=1");
			if(osupplietypebean!=null){
				if (!StringUtil.nullOrBlank(osupplietypebean.getUnit_id())) {
					sql.append(" and unit_id = ? ");
					condition.add(osupplietypebean.getUnit_id());
				}
				if (!StringUtil.nullOrBlank(osupplietypebean.getOftype_name())) {
					sql.append(" and oftype_name like '%'||?||'%'");
					condition.add(osupplietypebean.getOftype_name());
				}
				if (!StringUtil.nullOrBlank(osupplietypebean.getOftype_flag())) {
					sql.append(" and oftype_flag = ?");
					condition.add(osupplietypebean.getOftype_flag());
				}	
				if (!StringUtil.nullOrBlank(osupplietypebean.getUnit_id())) {
					sql.append(" and unit_id = ?");
					condition.add(osupplietypebean.getUnit_id());
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
	  *     复写方法 getOsupplieType
	  * @param oftype_id
	  * @param oftype_flag
	  * @param conn
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsupplieTypeDao#getOsupplieType(java.lang.String, java.sql.Connection) 
	  */
	@Override
	public Map<String, String> getOsupplieType(String oftype_id,String oftype_flag, Connection conn)
			throws Exception {
		Map<String, String> viewMap = new HashMap<String, String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select *");
		sql.append("  from TA_OA_DETOSUPPLIETYPE ");
		sql.append(" where oftype_id = ? ");
		sql.append(" and oftype_flag = "+oftype_flag+" ");
		
		viewMap = queryToSingleMap(conn, sql.toString(), oftype_id);
		
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteOsupplieBeansById
	  * @param conn
	  * @param beanId
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.tjy.officesupplies.dao.OsupplieTypeDao#deleteOsupplieBeansById(java.sql.Connection, java.lang.String) 
	  */
	@Override
	public boolean deleteOsupplieBeansById(Connection conn, String beanId)
			throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from TA_OA_DETOSUPPLIETYPE ");
		sql.append(" where oftype_id in ");
		sql.append("       (?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedUpdate(sql.toString());
		pdb.setString(1, beanId);
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	*<b>Summary: </b>
	* isOsupplieTypeBean(判断类型是否被引用)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public int isOsupplieTypeBean(Connection conn,String beanId)throws Exception{
		
		PreparedDBUtil pdb = new PreparedDBUtil();// 初始化数据库连接
		StringBuffer sql = null;
		sql = new StringBuffer();
		sql.append("  select count(*) numb from oa_persondata_base ");
		sql.append(" where p_type_id=?  ");
		pdb.preparedSelect(sql.toString());
		int i = 1;
		pdb.setString(i++, beanId);
		pdb.executePrepared(conn);
		int count=0;
		if(pdb.size()>0){
			count=pdb.getInt(0, "numb");
		}
		return  count;
	}

}
