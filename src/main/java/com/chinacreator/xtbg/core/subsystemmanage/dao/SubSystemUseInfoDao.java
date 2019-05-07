package com.chinacreator.xtbg.core.subsystemmanage.dao;

import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:SubSystemUseInfoDao.java</p>
 *<p>Description:子系统使用情况Dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-28
 */
public interface SubSystemUseInfoDao {
	/**
	 * @Description 根据条件查询子系统使用信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	
	public PagingBean findSubSystemUseInfoList(Map<String,String> SearchConditionMap, String sortName, String sortOrder, long offset, int maxPagesize);

	/**
	 * 
	*<b>Summary: 获取用户对子系统的使用情况</b>
	* @param info_id
	* @return
	 */
	public Map<String,String> findSubSystemUseInfo(String info_id);
	
	/**
	 * 
	*<b>Summary: 在当前系统id中是否已经存在了此用户</b>
	* isExsitUserInSysid(请用一句话描述这个方法的作用)
	* @param user_id
	* @param sys_id
	* @return
	 */
	public boolean isExsitUserInSysid(String info_id,String user_id,String sys_id) throws Exception;
	
	/**
	*<b>Summary: 导入用户 在当前系统id中是否已经存在了此用户</b>
	* isExsitUserInSysid(请用一句话描述这个方法的作用)
	* @param user_name
	* @param sys_id
	* @return
	 */
	public boolean isFindUserInSysid(String user_name,String sys_id) throws Exception;
	
	/**
	*<b>Summary: 导入用户  在当前系统id中是否已经存在了此用户</b>
	* isExsitUserInSysid(请用一句话描述这个方法的作用)
	* @param user_id
	* @param sys_id
	* @return
	 */
	public Map<String,String> FindUserInSysid(String user_id,String sys_id) throws Exception;
}
