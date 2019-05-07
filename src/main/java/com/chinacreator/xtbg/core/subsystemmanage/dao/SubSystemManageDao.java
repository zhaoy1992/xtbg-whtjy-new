package com.chinacreator.xtbg.core.subsystemmanage.dao;

import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:SubSystemManageDao.java</p>
 *<p>Description:子系统管理Dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-28
 */
public interface SubSystemManageDao {
	/**
	 * @Description 根据条件查询子系统管理信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	
	public PagingBean findSubSystemInfoList(Map<String,String> SearchConditionMap, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * 
	*<b>Summary: 获取子系统信息</b>
	* @param sys_id
	* @return
	* @throws Exception
	 */
	public Map<String,String> findSubSystemInfo(String sys_id) throws Exception;

}
