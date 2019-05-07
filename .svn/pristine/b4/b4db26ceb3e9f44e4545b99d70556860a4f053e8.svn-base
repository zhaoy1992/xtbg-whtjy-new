package com.chinacreator.xtbg.core.file.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.file.dao.FileFondsnoDao;
import com.chinacreator.xtbg.core.file.entity.FileFondsnoBean;
import com.chinacreator.xtbg.core.file.service.FileFondsnoServiceIfc;
/**
 * 
 *<p>Title:FileFondsnoServicImpl.java</p>
 *<p>Description:档案全宗号服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-12
 */
public class FileFondsnoServicImpl implements FileFondsnoServiceIfc {

	private static final Log LOG=LogFactory.getLog(FileFondsnoServicImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 getFileFondsnoBean
	  * @param f_fondsno_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFondsnoServiceIfc#getFileFondsnoBean(java.lang.String)
	 */
	public Map<String, String> getFileFondsnoBean(String f_fondsno_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			FileFondsnoDao fileFondsnoDao = (FileFondsnoDao)LoadSpringContext.getApplicationContext().getBean("fileFondsnoDaoImpl");
			viewMap = fileFondsnoDao.getFileFondsnoBean(f_fondsno_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 addFileFondsno
	  * @param fileFondsnoBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFondsnoServiceIfc#addFileFondsno(com.chinacreator.xtbg.core.file.entity.FileFondsnoBean)
	 */
	public boolean addFileFondsno(FileFondsnoBean fileFondsnoBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileFondsnoDao fileFondsnoDao = (FileFondsnoDao)LoadSpringContext.getApplicationContext().getBean("fileFondsnoDaoImpl");			
			fileFondsnoBean.setF_fonds_id(StringUtil.getUUID());
			((BaseDao)fileFondsnoDao).insert(fileFondsnoBean, conn);
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
	  *     复写方法 deleteFileFondsno
	  * @param f_fonds_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFondsnoServiceIfc#deleteFileFondsno(java.lang.String)
	 */
	public boolean deleteFileFondsno(String f_fonds_id) {
		Connection conn = null;
		boolean flag = false;
		String[]  f_program_idsArray = null;
		FileFondsnoBean fileFondsnoBean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileFondsnoDao fileFondsnoDao = (FileFondsnoDao)LoadSpringContext.getApplicationContext().getBean("fileFondsnoDaoImpl");
			if(!StringUtil.isBlank(f_fonds_id)) {
				f_program_idsArray = f_fonds_id.split(",");
				for (int i = 0; i < f_program_idsArray.length; i++) {
					fileFondsnoBean = new FileFondsnoBean();
					fileFondsnoBean.setF_fonds_id(f_program_idsArray[i]);
					((BaseDao)fileFondsnoDao).deleteListById(fileFondsnoBean, conn, f_program_idsArray[i]);
				}
			}
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
	  *     复写方法 updateFileFondsno
	  * @param fileFondsnoBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFondsnoServiceIfc#updateFileFondsno(com.chinacreator.xtbg.core.file.entity.FileFondsnoBean)
	 */
	public boolean updateFileFondsno(FileFondsnoBean fileFondsnoBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileFondsnoDao fileFondsnoDao = (FileFondsnoDao)LoadSpringContext.getApplicationContext().getBean("fileFondsnoDaoImpl");			
			((BaseDao)fileFondsnoDao).update(fileFondsnoBean, conn);
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
	  *     复写方法 getFileFondsnoBeanByOrgid
	  * @param f_fonds_orgid
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFondsnoServiceIfc#getFileFondsnoBeanByOrgid(java.lang.String)
	 */
	public Map<String, String> getFileFondsnoBeanByOrgid(String f_fonds_orgid) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			FileFondsnoDao fileFondsnoDao = (FileFondsnoDao)LoadSpringContext.getApplicationContext().getBean("fileFondsnoDaoImpl");
			viewMap = fileFondsnoDao.getFileFondsnoBeanByOrgid(f_fonds_orgid, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}
	/**
	 * 
	  * <b>Summary: 判断全宗号和名称是否被引用</b>
	  *     复写方法 isNameorCode
	  * @param name
	  * @param code
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileFondsnoServiceIfc#isNameorCode(java.lang.String, java.lang.String)
	 */
	public String isNameorCode(String name, String code,String id) {
		FileFondsnoDao fileFondsnoDao = (FileFondsnoDao)LoadSpringContext.getApplicationContext().getBean("fileFondsnoDaoImpl");
		String s="";
		try {
			s=fileFondsnoDao.isNameorCode(name, code,id);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return s;
	}

}
