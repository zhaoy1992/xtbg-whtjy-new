package com.chinacreator.xtbg.core.pubconfig.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.pubconfig.dao.MdColumnsDao;
/**
 * 
 *<p>Title:MdColumnsDaoImpl.java</p>
 *<p>Description:数据元素字段实体接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-31
 */
public class MdColumnsDaoImpl extends XtDbBaseDao implements MdColumnsDao {

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getMdTable
	  * @param table_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.pubconfig.dao.MdColumnsDao#getMdTable(java.lang.String)
	 */
	public List<Map<String, String>> getMdColumns(String table_id)
			throws Exception {
		List<Map<String, String>> list= new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select distinct c.*,u.DATA_TYPE,u.DATA_LENGTH from oa_md_columns c, user_tab_columns u,oa_md_table t"+
				" where c.column_code=u.COLUMN_NAME and c.table_id=t.table_id and u.TABLE_NAME=t.table_code and c.table_id=? order by c.column_sn");
		
		list = queryToListMap(sql.toString(), table_id);
		
		return list;
	}

}
