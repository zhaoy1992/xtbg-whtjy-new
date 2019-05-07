package com.chinacreator.xtbg.core.common.cache;

import java.sql.Connection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.dao.OrgCacheDao;
import com.chinacreator.xtbg.core.common.cache.entity.OrgCacheBean;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;

/**
 * 
 *<p>Title:OrgCache.java</p>
 *<p>Description:机构缓存数据加载</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-17
 */
public class OrgCache {

	private static final Log LOG = LogFactory.getLog(OrgCache.class);
	
	private static List<OrgCacheBean> orgCacheBeanList = null;//所有机构缓存
	
	private static Map<String, OrgCacheBean> orgCacheBeanMap = null;//机构缓存数据
	
	private OrgCacheDao orgCacheDao = null;
	
	
	public static List<OrgCacheBean> getOrgCacheBeanList() {
		return orgCacheBeanList;
	}

	public static void setOrgCacheBeanList(List<OrgCacheBean> orgCacheBeanList) {
		OrgCache.orgCacheBeanList = orgCacheBeanList;
	}

	/**
	 * 
	*<b>Summary: </b>
	* getOrgCacheBean(根据机构id获取机构缓存数据)
	* @param orgId
	* @return
	 */
	public static OrgCacheBean getOrgCacheBean(String orgId) {
		if(orgCacheBeanMap != null){
			return orgCacheBeanMap.get(orgId);
		}else{
			return null;
		}
	}
	
	/**
	 * 
	*<b>Summary: </b>
	* addOrgCache(添加机构缓存)
	* @param orgid
	* @param bean
	 */
	public static void addOrgCache(String orgid,OrgCacheBean bean){
		orgCacheBeanMap.put(orgid, bean);
	}

	/**
	*<b>Summary: </b>
	* init(缓存数据初始化)
	* @throws Exception
	*/
	public void init() {
		Connection conn = null;
		try{
			conn = DbManager.getInstance().getConnection();
			orgCacheBeanMap = new ConcurrentHashMap<String, OrgCacheBean>();
			orgCacheDao = (OrgCacheDao)LoadSpringContext.getApplicationContext().getBean("orgCacheDaoImpl");
			orgCacheBeanList = orgCacheDao.getOrgChacheList(conn);
			for(OrgCacheBean orgCacheBean : orgCacheBeanList){
				addOrgCache(orgCacheBean.getOrg_id(),orgCacheBean);
			}
			
			LOG.info("加载单位缓存信息成功");
		}catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(),e);
		}finally{
			DbManager.closeConnection(conn);
		}
	}
	
}
