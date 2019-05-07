package com.chinacreator.xtbg.core.common.cache.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;

/**
 * 
 *<p>Title:SystemCacheDao.java</p>
 *<p>Description:系统缓存Dao接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-16
 */
public interface UserCacheDao {

	/**
	 * 
	*<b>Summary: </b>
	* getUserCacheList(查询用户缓存)
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<UserCacheBean> getUserCacheList(Connection conn) throws Exception;
	
	
	
	
}
