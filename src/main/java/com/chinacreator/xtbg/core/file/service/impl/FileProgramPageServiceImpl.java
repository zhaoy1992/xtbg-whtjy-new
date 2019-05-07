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
import com.chinacreator.xtbg.core.file.dao.FileProgramPageDao;
import com.chinacreator.xtbg.core.file.entity.FileProgramPageBean;
import com.chinacreator.xtbg.core.file.service.FileProgramPageServiceIfc;
/**
 * 
 *<p>Title:FileProgramPageServiceImpl.java</p>
 *<p>Description:档案程序界面处理服务实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-11
 */
public class FileProgramPageServiceImpl implements FileProgramPageServiceIfc {

	private static final Log LOG = LogFactory.getLog(FileProgramPageServiceImpl.class);
	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 handleFileProgramPage
	  * @param fileProgramPageBean
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileProgramPageServiceIfc#handleFileProgramPage(com.chinacreator.xtbg.core.file.entity.FileProgramPageBean)
	 */
	public boolean handleFileProgramPage(FileProgramPageBean fileProgramPageBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileProgramPageDao fileProgramPageDao = (FileProgramPageDao)LoadSpringContext.getApplicationContext().getBean("fileProgramPageDaoImpl");			
			if(StringUtil.nullOrBlank(fileProgramPageBean.getF_program_id())){
				fileProgramPageBean.setF_program_id(StringUtil.getUUID());
				((BaseDao)fileProgramPageDao).insert(fileProgramPageBean, conn);
			}else{
				((BaseDao)fileProgramPageDao).update(fileProgramPageBean, conn);
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
	  *     复写方法 deleteFileProgramPage
	  * @param f_program_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileProgramPageServiceIfc#deleteFileProgramPage(java.lang.String)
	 */
	public boolean deleteFileProgramPage(String f_program_id) {
		Connection conn = null;
		boolean flag = false;
		String[]  f_program_idsArray = null;
		FileProgramPageBean fileProgramPageBean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FileProgramPageDao fileProgramPageDao = (FileProgramPageDao)LoadSpringContext.getApplicationContext().getBean("fileProgramPageDaoImpl");
			if(!StringUtil.isBlank(f_program_id)) {
				f_program_idsArray = f_program_id.split(",");
				for (int i = 0; i < f_program_idsArray.length; i++) {
					fileProgramPageBean = new FileProgramPageBean();
					fileProgramPageBean.setF_program_id(f_program_idsArray[i]);
					((BaseDao)fileProgramPageDao).deleteListById(fileProgramPageBean, conn, f_program_idsArray[i]);
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
	  *     复写方法 getFileProgramPageBean
	  * @param f_program_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.file.service.FileProgramPageServiceIfc#getFileProgramPageBean(java.lang.String)
	 */
	public Map<String, String> getFileProgramPageBean(String f_program_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			FileProgramPageDao fileProgramPageDao = (FileProgramPageDao)LoadSpringContext.getApplicationContext().getBean("fileProgramPageDaoImpl");
			viewMap = fileProgramPageDao.getFileProgramPageBean(f_program_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}

	
}
