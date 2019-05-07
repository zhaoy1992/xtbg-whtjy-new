package com.chinacreator.xtbg.core.pubconfig.service;

import java.util.List;
import java.util.Map;

/**
 * 
 *<p>Title:MdTableAndColumnsService.java</p>
 *<p>Description:数据元素表和表元素的服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-27
 */
public interface MdTableAndColumnsService {

	/**
	 * 
	*<b>Summary: </b>
	* getOneMdTable(根据id查询表信息)
	* @param table_id
	* @return
	* @throws Exception
	 */
	public Map<String, String> getOneMdTable(String table_id);
	/**
	 * 
	*<b>Summary: </b>
	* getMdColumns(根据id查询表的元素信息)
	* @param table_id
	* @return
	 */
	public List<Map<String, String>> getMdColumns(String table_id);
	/**
	 * 
	*<b>Summary: </b>
	* updateMdColumnsAndTable(更新相应表和表元素信息)
	* @param mdtablejson
	* @param mdcolumnlistjson
	* @return
	 */
	public boolean updateMdColumnsAndTable(String mdtablejson,String mdcolumnlistjson);
}
