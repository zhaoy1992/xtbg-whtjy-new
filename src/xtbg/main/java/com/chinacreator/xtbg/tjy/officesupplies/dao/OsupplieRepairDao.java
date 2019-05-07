package com.chinacreator.xtbg.tjy.officesupplies.dao;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:OsupplieRepairDao.java</p>
 *<p>Description:办公用品管理-维修登记dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2014-3-6
 */
public interface OsupplieRepairDao {
	/**
	 * 
	*<b>Summary: </b>
	* repairInfoList(维修登记列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean repairInfoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
}
