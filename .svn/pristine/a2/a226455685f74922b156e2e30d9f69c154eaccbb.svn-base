package com.chinacreator.xtbg.core.common.cache;

import java.sql.Connection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.dao.UserCacheDao;
import com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
/**
 * 
 *<p>Title:UserCache.java</p>
 *<p>Description:用户缓存数据加载</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-17
 */
public class UserCache {

	private static final Log LOG = LogFactory.getLog(UserCache.class);
	
	private static List<UserCacheBean> userCacheBeanList = null;//所有用户ListMap
	
	private static Map<String, UserCacheBean> userCacheBeanMap = null;//用户缓存数据
	
	private UserCacheDao userCacheDao = null;
	
	public static List<UserCacheBean> getUserCacheBeanList() {
		return userCacheBeanList;
	}

	public static void setUserCacheBeanList(List<UserCacheBean> userCacheBeanList) {
		UserCache.userCacheBeanList = userCacheBeanList;
	}
	/**
	 * 
	*<b>Summary: </b>
	* getUserCacheBean(根据用户id获取用户缓存数据)
	* @param userId
	* @return
	 */
	public static UserCacheBean getUserCacheBean(String userId) {
		if(userCacheBeanMap != null){
			return userCacheBeanMap.get(userId);
		}else{
			return null;
		}
	}
	
	public static void addUserCacheBean(String userId, UserCacheBean userCacheBean) {
		userCacheBeanMap.put(userId, userCacheBean);
	}
	
	/**
	*<b>Summary: </b>
	* init(用户缓存数据初始化)
	* @throws Exception
	*/
	public void init() {
		Connection conn = null;
		try{
			conn = DbManager.getInstance().getConnection();
			userCacheBeanMap = new ConcurrentHashMap<String, UserCacheBean>();
			userCacheDao = (UserCacheDao)LoadSpringContext.getApplicationContext().getBean("userCacheDaoImpl");
			userCacheBeanList = userCacheDao.getUserCacheList(conn);
			for(UserCacheBean userCacheBean : userCacheBeanList){
				addUserCacheBean(userCacheBean.getUser_id(), userCacheBean);
			}
			
			LOG.info("加载用户缓存信息成功");
		}catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	
	
}
