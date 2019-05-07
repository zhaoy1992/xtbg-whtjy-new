package com.chinacreator.xtbg.core.purviewmanager.service.impl;

import java.sql.Connection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.purviewmanager.dao.OrgManagerDao;
import com.chinacreator.xtbg.core.purviewmanager.entity.Organization;
import com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc;

/**
 * 
 *<p>Title:OrgManagerServiceImpl.java</p>
 *<p>Description:机构管理实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-5-17
 */
public class OrgManagerServiceImpl implements OrgManagerServiceIfc {

	private static final Log LOG = LogFactory.getLog(OrgManagerServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getOrganization
	  * @param orgId
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc#getOrganization(java.lang.String)
	 */
	public Organization getOrganization(String orgId) {
		Connection conn = null;
		Organization organization = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OrgManagerDao orgManagerDao = (OrgManagerDao)LoadSpringContext.getApplicationContext().getBean("orgManagerDaoImpl");
			organization = orgManagerDao.getOrganization(orgId, conn);
			
			
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			if(conn != null){
				DbManager.closeConnection(conn);
			}
		}
		
		return organization;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addOrUpdateOrg
	  * @param org
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc#addOrUpdateOrg(com.chinacreator.xtbg.core.purviewmanager.entity.Organization)
	 */
	public boolean addOrUpdateOrg(Organization org) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OrgManagerDao orgManagerDao = (OrgManagerDao)LoadSpringContext.getApplicationContext().getBean("orgManagerDaoImpl");
			flag = orgManagerDao.addOrUpdateOrg(org, conn);
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
	  *     复写方法 sortOrg
	  * @param orgIds
	  * @return 
	  * @see com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc#sortOrg(java.lang.String)
	 */
	public boolean sortOrg(String orgIds) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			OrgManagerDao orgManagerDao = (OrgManagerDao)LoadSpringContext.getApplicationContext().getBean("orgManagerDaoImpl");
			
			flag = orgManagerDao.sortOrg(orgIds, conn);
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
