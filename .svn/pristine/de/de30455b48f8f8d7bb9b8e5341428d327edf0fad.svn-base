package com.chinacreator.xtbg.core.directory.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.core.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.core.directory.entity.HeTongBean;
import com.chinacreator.xtbg.core.directory.entity.ListShowUtilBean;
import com.chinacreator.xtbg.core.directory.entity.UserinfoBean;
import com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc;

/**
 *<p>Title:DirectoryServiceImpl.java</p>
 *<p>Description:名录管理服务实现类</p> 
// *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2012-1-6
 */
public class DirectoryServiceImpl implements DirectoryServiceIfc {
	public static final Logger LOG = Logger
			.getLogger(DirectoryServiceImpl.class.getName());

	/**
	 * 
	 * <b>Summary: </b> 复写方法 getTypeBeanById
	 * 
	 * @param id
	 * @param listtype
	 * @return
	 * @see com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc#getTypeBeanById(java.lang.String,
	 *      java.lang.String)
	 */
	public DirectoryBean getTypeBeanById(String id, String listtype) {
		DirectoryBean TypeBean = null;
		try {
			DirectoryDao dao = (DirectoryDao) LoadSpringContext
					.getApplicationContext().getBean("directoryDaoImpl");
			TypeBean = dao.getTypeBeanById(id, listtype);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return TypeBean;
	}
		
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFirstCodeShowInfo
	  * @param orgoruserid
	  * @return 
	  * @see com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc#getFirstCodeShowInfo(java.lang.String)
	 */
	@Override
	public List<ListShowUtilBean> getFirstCodeShowInfo(String orgoruserid) {
		try {
			DirectoryDao dao = (DirectoryDao) LoadSpringContext
					.getApplicationContext().getBean("directoryDaoImpl");

			return dao.getFirstCodeShowInfo(orgoruserid);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ArrayList<ListShowUtilBean>();
		}
	}
	/**
	 * 
	 *<b>Summary: 管理员修改用户信息</b> updateUserinfo(请用一句话描述这个方法的作用)
	 * 
	 * @param userinfoBean
	 * @throws Exception
	 */
	public boolean updateUserinfo(UserinfoBean userinfoBean, HeTongBean heTongBean){
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DirectoryDao dao = (DirectoryDao) LoadSpringContext
					.getApplicationContext().getBean("directoryDaoImpl");

			dao.updateUserinfo(userinfoBean,heTongBean,conn);
			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.closeTransactionConnection(conn, false);
			return false;
		}
	}

	/**
	 * 
	  * <b>Summary: 根据用户ID获得合同信息</b>
	  *     复写方法 getHeTongBeanById
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc#getHeTongBeanById(java.lang.String)
	 */
	public HeTongBean getHeTongBeanById(String id) {
		HeTongBean heTongBean = null;
		try {
			DirectoryDao dao = (DirectoryDao) LoadSpringContext
					.getApplicationContext().getBean("directoryDaoImpl");
			heTongBean = dao.getHeTongBeanById(id);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return heTongBean;
	}

	/**
	 * 
	  * <b>Summary: 根据人员id查询其配置的可查看的薪酬人员id</b>
	  *     复写方法 getPeizhiUserId
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc#getPeizhiUserId(java.lang.String)
	 */
	public String getPeizhiUserId(String id) {
		String peizhiUserIds = "";
		try {
			DirectoryDao dao = (DirectoryDao) LoadSpringContext
					.getApplicationContext().getBean("directoryDaoImpl");
			peizhiUserIds = dao.queryPeizhiUserId(id);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
		}
		return peizhiUserIds;
	}

	/**
	 * 
	  * <b>Summary: 管理员修改用户薪酬信息</b>
	  *     复写方法 updateUserXCinfo
	  * @param userinfoBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc#updateUserXCinfo(com.chinacreator.xtbg.core.directory.entity.UserinfoBean)
	 */
	public boolean updateUserXCinfo(UserinfoBean userinfoBean) {
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DirectoryDao dao = (DirectoryDao) LoadSpringContext
					.getApplicationContext().getBean("directoryDaoImpl");

			dao.updateUserXCinfo(userinfoBean,conn);
			DbManager.closeTransactionConnection(conn, true);
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			DbManager.closeTransactionConnection(conn, false);
			return false;
		}
	}

}
