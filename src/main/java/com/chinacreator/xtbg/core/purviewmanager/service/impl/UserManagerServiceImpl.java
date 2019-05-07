package com.chinacreator.xtbg.core.purviewmanager.service.impl;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.cache.UserCache;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DaoUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.purviewmanager.dao.UserManagerDao;
import com.chinacreator.xtbg.core.purviewmanager.entity.OrgUserBean;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserBean;
import com.chinacreator.xtbg.core.purviewmanager.entity.UserJobOrgBean;
import com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc;

/**
 * 
 *<p>Title:UserManagerServiceImpl.java</p>
 *<p>Description:用户管理服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-27
 */
public class UserManagerServiceImpl implements UserManagerServiceIfc {

	private static final Log LOG = LogFactory.getLog(UserManagerServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getUserBean
	  * @param user_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc#getUserBean(java.lang.String)
	 */
	public Map<String, String> getUserBean(String user_id) {
		Connection conn = null;
		Map<String, String> viewMap = new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			UserManagerDao userManagerDao = (UserManagerDao)LoadSpringContext.getApplicationContext().getBean("userManagerDaoImpl");
			viewMap = userManagerDao.getUserBean(user_id, conn);
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return viewMap;
	}
	
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addorUpdateUser
	  * @param userbean
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc#addorUpdateUser(com.chinacreator.xtbg.core.purviewmanager.entity.UserBean)
	 */
	public boolean addorUpdateUser(UserBean userbean) {
		Connection conn = null;
		boolean flag = false;
		try {
			String user_id = userbean.getUser_id();
			conn = DbManager.getInstance().getTransactionConnection();
			UserManagerDao userManagerDao = (UserManagerDao)LoadSpringContext.getApplicationContext().getBean("userManagerDaoImpl");
			if(StringUtil.isBlank(user_id)) { 
				user_id = DaoUtil.findBySequencsName("seq_td_sm_user", conn);
				userbean.setUser_id(user_id);
				((BaseDao)userManagerDao).insert(userbean, conn);
				
				//保存用户岗位信息
				UserJobOrgBean userJobOrgBean = new UserJobOrgBean();
				userJobOrgBean.setUser_id(user_id);
				userJobOrgBean.setJob_id("1");
				userJobOrgBean.setOrg_id(userbean.getOrg_id());
				userJobOrgBean.setJob_sn("999");
				userJobOrgBean.setSame_job_user_sn(userManagerDao.getJobUserSn(userbean.getOrg_id(), conn));
				userJobOrgBean.setJob_starttime(new Timestamp(new Date().getTime()));
				((BaseDao)userManagerDao).insert(userJobOrgBean, conn);
				
				//保存机构用户关系
				OrgUserBean orgUserBean = new OrgUserBean();
				orgUserBean.setOrg_id(userbean.getOrg_id());
				orgUserBean.setUser_id(user_id);
				((BaseDao)userManagerDao).insert(orgUserBean, conn);
				
			} else {
				((BaseDao)userManagerDao).update(userbean, conn);
			}
			
			//刷新机构缓冲
			UserCache userCache = new UserCache();
			userCache.init();
			flag = true;
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}

	

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isUserExist
	  * @param user_name
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc#isUserExist(java.lang.String)
	 */
	public boolean isUserExist(String user_name) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			UserManagerDao userManagerDao = (UserManagerDao)LoadSpringContext.getApplicationContext().getBean("userManagerDaoImpl");
			flag = userManagerDao.isUserExist(user_name, conn);
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 isUserRealnameExist
	  * @param user_realname
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc#isUserRealnameExist(java.lang.String)
	 */
	public boolean isUserRealnameExist(String user_realname) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			UserManagerDao userManagerDao = (UserManagerDao)LoadSpringContext.getApplicationContext().getBean("userManagerDaoImpl");
			flag = userManagerDao.isUserRealnameExist(user_realname, conn);
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getRightMenu
	  * @param mapparm
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc#getRightMenu(java.util.Map)
	 */
	public String getRightMenu(Map<String, String> mapparm) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 
	  * <b>Summary:用户排序的更新 </b>
	  *     复写方法 setUserOrder
	  * @param userids
	  * @param orgid
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc#setUserOrder(java.lang.String, java.lang.String)
	 */
	public boolean setUserOrder(String userids, String orgid) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			UserManagerDao userManagerDao = (UserManagerDao)LoadSpringContext.getApplicationContext().getBean("userManagerDaoImpl");
			flag = userManagerDao.setUserOrder(userids, orgid, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		return flag;
	}

}
