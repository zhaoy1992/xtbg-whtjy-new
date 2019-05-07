package com.chinacreator.xtbg.core.file.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileFavoritesDao;
import com.chinacreator.xtbg.core.file.dao.FilePurviewDao;
import com.chinacreator.xtbg.core.file.entity.FileFavoritesBean;
import com.chinacreator.xtbg.core.file.service.FileFavoritesServiceIfc;
/**
 * 
 *<p>Title:FileFavoritesServiceImpl.java</p>
 *<p>Description:收藏</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 24, 2013
 */
public class FileFavoritesServiceImpl implements FileFavoritesServiceIfc {
	
	private static final Log LOG = LogFactory.getLog(FileFavoritesServiceImpl.class);
	
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 add
	 * @param FileDocBeanIds
	 * @param userId
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFavoritesServiceIfc#add(java.lang.String[], java.lang.String)
	 */
	@Override
	public boolean add(String[] FileDocBeanIds, String userId) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileFavoritesDao dao = (FileFavoritesDao)LoadSpringContext.getApplicationContext().getBean("FileFavoritesDaoImpl");
			Set<String> set = dao.getDocIdByUserId(userId,conn,true);
			for (String fileDocBeanIds : FileDocBeanIds) {
				if(!set.contains(fileDocBeanIds)){
					FileFavoritesBean bean = new FileFavoritesBean();
					bean.setF_favorites_id(StringUtil.getUUID());
					bean.setF_favorites_time(new Timestamp(new Date().getTime()));
					bean.setF_user_id(userId);
					bean.setF_doc_id(fileDocBeanIds);
					((BaseDao)dao).insert(bean, conn);
				}
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
	/**
	 * 
	 * <b>Summary: </b>
	 *     复写方法 delete
	 * @param beanId
	 * @return 
	 * @see com.chinacreator.xtbg.core.file.service.FileFavoritesServiceIfc#delete(java.lang.String[])
	 */
	@Override
	public boolean delete(String[] beanId) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FilePurviewDao dao = (FilePurviewDao)LoadSpringContext.getApplicationContext().getBean("FilePurviewDaoImpl");
			for(String id : beanId){
				((BaseDao)dao).deleteListById(new FileFavoritesBean(), conn, id);
			}
			conn.commit();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}
}
