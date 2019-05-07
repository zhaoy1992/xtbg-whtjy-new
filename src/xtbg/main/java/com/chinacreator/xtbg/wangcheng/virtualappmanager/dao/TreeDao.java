package com.chinacreator.xtbg.wangcheng.virtualappmanager.dao;


import java.util.Map;


/**
 *<p>Title:TestZtreeDao.java</p>
 *<p>Description:测试Ztree的dao层接口</p> 
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2012-1-12
 */
public interface TreeDao {
	/**
	 * 获得机构树
	 * @param map
	 * @return
	 */
	public String getOrgTreeMessage(Map<String ,String> map);
	/*
	*//**
	 * 获得用户树
	 * @param map
	 * @return
	 *//*
	public String getOrgUserRoleTreeMessage(Map<String ,String> map ,String showLevel);*/
	
	
}
