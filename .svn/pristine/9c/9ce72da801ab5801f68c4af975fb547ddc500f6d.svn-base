package com.chinacreator.xtbg.core.pubconfig.dao.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.pubconfig.dao.MdTableDao;
/**
 * 
 *<p>Title:MdTableDaoImpl.java</p>
 *<p>Description:数据元素实体接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-31
 */
public class MdTableDaoImpl extends XtDbBaseDao implements MdTableDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getMdTable
	  * @param table_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.MdTableDao#getMdTable(java.lang.String)
	 */
	public List<Map<String, String>> getMdTable(String table_id)
			throws Exception {
		List<Map<String, String>> list= new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * ");
		sql.append("  from oa_md_table a");
		sql.append("  connect by prior a.table_id = a.parent_table_id  ");
		sql.append(" start with a.table_id =? ");
		
		list = queryToListMap(sql.toString(), table_id);
		
		return list;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getOneMdTable
	  * @param table_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.MdTableDao#getOneMdTable(java.lang.String)
	 */
	public Map<String, String> getOneMdTable(String table_id,Connection conn) throws Exception {
		Map<String, String> map=new  HashMap<String,String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select a.*,u.constraint_name pkname ");
		sql.append("  from oa_md_table a,user_constraints u");
		sql.append("  where a.table_code=u.table_name and u.constraint_type='P' ");
		sql.append(" and a.table_id =? ");
		
		map = queryToSingleMap(conn, sql.toString(), table_id);
		
		return map;
	}

}
