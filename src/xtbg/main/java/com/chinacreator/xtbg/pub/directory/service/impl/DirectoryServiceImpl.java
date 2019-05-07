package com.chinacreator.xtbg.pub.directory.service.impl;

import java.sql.Connection;
import java.sql.SQLException;

import javax.transaction.RollbackException;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.chinacreator.eform.util.Escape;
import com.chinacreator.sysmgrcore.entity.User;
import com.chinacreator.xtbg.pub.directory.dao.DirectoryDao;
import com.chinacreator.xtbg.pub.directory.dao.UserDataDao;
import com.chinacreator.xtbg.pub.directory.dao.imploracle.UserDataDaoImpl;
import com.chinacreator.xtbg.pub.directory.entity.DirectoryBean;
import com.chinacreator.xtbg.pub.directory.entity.UserData;
import com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.pub.util.DataControlUtil;
import com.chinacreator.xtbg.pub.util.DbconnManager;
import com.chinacreator.xtbg.pub.util.StringUtil;
import com.frameworkset.orm.transaction.TransactionManager;

/**
 *<p>Title:DirectoryServiceImpl.java</p>
 *<p>Description:名录管理服务实现类</p> 
 *<p>Company:湖南科创</p>
 *@author 刘春元
 *@version 1.0
 *2012-1-6
 */
public class DirectoryServiceImpl implements DirectoryServiceIfc {
	public static final Logger logger = Logger.getLogger(DirectoryServiceImpl.class.getName());
	

	
	/**
	 * @Description  保存名录管理
	 * 
	 * @param paramjosn  要保存的数据对象
	 * @return  boolean
	 * @exception 
	 */
	public String saveType(String paramjosn) {
		DirectoryBean TypeBean  = new DirectoryBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			TypeBean = (DirectoryBean) JSONObject.parseObject(paramjosn, DirectoryBean.class);
		} 
		String directoryid = "";
		
		try {
			DirectoryDao dao = (DirectoryDao) DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
			directoryid = dao.addType(TypeBean);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(e.getMessage());
			return "false";
		}
		return directoryid;
	}

	/**
	 * @Description  根据名录管理ID获得名录管理
	 * 
	 * @param id 名录管理ID
	 * @return  TypeBean 名录管理对象
	 * @exception 
	 */
	public DirectoryBean getTypeBeanById(String id,String listtype) {
		DirectoryBean TypeBean = null;
		try {
			DirectoryDao dao = (DirectoryDao)DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
			TypeBean = dao.getTypeBeanById(id,listtype);
		} catch (Exception e) {
			logger.info(e.getMessage());
		}
		return TypeBean;
	}

	/**
	 * @Description  修改名录管理
	 * 
	 * @param paramjosn  要修改的名录管理
	 * @return  boolean
	 * @exception 
	 */
	public boolean updateType(String paramjosn) {
		DirectoryBean TypeBean  = new DirectoryBean();
		if (!StringUtil.isBlank(paramjosn)) {
			paramjosn = DataControlUtil.replaceStr(paramjosn);
			paramjosn = Escape.unescape(paramjosn);
			TypeBean = (DirectoryBean) JSONObject.parseObject(paramjosn, DirectoryBean.class);
		} 
		try {
			DirectoryDao dao = (DirectoryDao)DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
			dao.updateType(TypeBean);
		} catch (Exception e) {
			logger.info(e.getMessage()); 
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * @Description  删除名录管理信息
	 * 
	 * @param ids  //要删除的名录管理ID
	 * @return  boolean
	 * @exception 
	 */
	public boolean delType(String ids) {
		try {
			DirectoryDao dao = (DirectoryDao)DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
			dao.delType(ids);
		} catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
		return true;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getTypeBeanById
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc#getTypeBeanById(java.lang.String)
	 */
	public User getuserinfo(String id) {
		User user=new User();
		try {
			DirectoryDao dao = (DirectoryDao)DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
			user=dao.getuserinfo(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public String createSelectHtml(String viewName, String selected,
			String selectName) {
		String selectHtml = "";
		try {
			DirectoryDao dao = (DirectoryDao)DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
			selectHtml = dao.createSelectHtml(viewName, selected, selectName);
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		return selectHtml;
	}

	@Override
	public String getSystemParameter(String paramId) throws SQLException {
		String value = "";
		try {
			DirectoryDao dao = (DirectoryDao)DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
			value = dao.getSystemParameter(paramId);
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		return value;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateUserinfowc
	  * @param user
	  * @return 
	  * @see com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc#updateUserinfowc(com.chinacreator.sysmgrcore.entity.User)
	 */
	@Override
	public boolean updateUserinfowc(User user,String listStr) {
		boolean flag = false;
		TransactionManager tm = new TransactionManager();
		Connection con = null;
		try {
			tm.begin();
			con = DbconnManager.getInstance().getConnection();
			UserDataDao userDataDao = new UserDataDaoImpl();
			DirectoryDao dao = (DirectoryDao)DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
			dao.updateUserinfowc(user);
			String[] list = listStr.split("##@##");
			for(int i=0;i<list.length;i++){
				String strBean = list[i];
				if(strBean != null && strBean.length() > 0){
					String[] listBean = strBean.split("@#@");
					UserData bean = new UserData();
					bean.setId(listBean[0]);
					bean.setUser_id(listBean[1]);
					bean.setType(listBean[2]);
					bean.setArg1(listBean[3]);
					bean.setArg2(listBean[4]);
					bean.setArg3(listBean[5]);
					bean.setArg4(listBean[6]);
					bean.setArg5(listBean[7]);
					
					if(StringUtil.isBlank(bean.getId())){
						bean.setId(DaoUtil.getUUID());
						userDataDao.insert(bean, con);
					} else {
						userDataDao.update(bean, con);
					}
				}
			}
			tm.commit();
		} catch (Exception e) {
			try {
				tm.rollback();
			} catch (RollbackException e1) {
				logger.error(e.getMessage(),e);
			}
			logger.error(e.getMessage(),e);
		} finally {
			DbconnManager.closeConnection(con);
		}
		return flag;
	}
}
