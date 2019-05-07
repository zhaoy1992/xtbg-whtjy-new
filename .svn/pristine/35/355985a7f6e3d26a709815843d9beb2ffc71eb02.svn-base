package com.chinacreator.xtbg.core.businessclassmanager.service.impl;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.epp.util.UniqueIdManager;
import com.chinacreator.xtbg.core.businessclassmanager.dao.FormClassDao;
import com.chinacreator.xtbg.core.businessclassmanager.entity.FormClass;
import com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.common.util.DbManager;
/**
 * 
 *<p>Title:FormClassServiceImpl.java</p>
 *<p>Description:业务类型服务接口实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-30
 */
public class FormClassServiceImpl implements FormClassService {

	private static final Log LOG=LogFactory.getLog(FormClassServiceImpl.class);
	/**
	 * 
	  * <b>Summary: 根据应用id和上级id查询业务类型信息</b>
	  *     复写方法 getEformClassList
	  * @param appID
	  * @param upid
	  * @return 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService#getEformClassList(java.lang.String, java.lang.String)
	 */
	public List<Map<String, String>> getEformClassList(String appID, String upid) {
		Connection conn=null;
		List<Map<String, String>> list=new ArrayList<Map<String,String>>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormClassDao dao=(FormClassDao)LoadSpringContext.getApplicationContext().getBean("formClassDaoImpl");
			list=dao.getEformClassList(appID, upid, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return list;
	}

	/**
	 * 
	  * <b>Summary:根据ID查询业务类型信息 </b>
	  *     复写方法 getFormClassByClassId
	  * @param classId
	  * @return 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService#getFormClassByClassId(java.lang.String)
	 */
	public Map<String, String> getFormClassByClassId(String classId) {
		Connection conn=null;
		Map<String, String> map=new HashMap<String, String>();
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormClassDao dao=(FormClassDao)LoadSpringContext.getApplicationContext().getBean("formClassDaoImpl");
			map=dao.getFormClassByClassId(classId, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return map;
	}

	/**
	 * 
	  * <b>Summary: 根据应用id查询排序号</b>
	  *     复写方法 getMaxEc_SnByAppId
	  * @param appId
	  * @return 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService#getMaxEc_SnByAppId(java.lang.String)
	 */
	public int getMaxEc_SnByAppId(String appId) {
		Connection conn=null;
		int flag=0;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormClassDao dao=(FormClassDao)LoadSpringContext.getApplicationContext().getBean("formClassDaoImpl");
			flag=dao. getMaxEc_SnByAppId(appId, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

	/**
	  * <b>Summary: 判断该业务类型是否存在</b>
	  *     复写方法 isExistByUpId
	  * @param ec_name
	  * @param app_id
	  * @param ec_upid
	  * @return 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService#isExistByUpId(java.lang.String, java.lang.String, java.lang.String)
	 */
	public boolean isExistByUpId(String ec_name, String app_id, String ec_upid) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormClassDao dao=(FormClassDao)LoadSpringContext.getApplicationContext().getBean("formClassDaoImpl");
			flag=dao.isExistByUpId(ec_name, app_id, ec_upid, conn);
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
	  * <b>Summary:判断该业务类型是否存在 </b>
	  *     复写方法 isExistByEc_name
	  * @param ec_name
	  * @param app_id
	  * @param ec_id
	  * @param up_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService#isExistByEc_name(java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	public boolean isExistByEc_name(String ec_name, String app_id,
			String ec_id, String up_id) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormClassDao dao=(FormClassDao)LoadSpringContext.getApplicationContext().getBean("formClassDaoImpl");
			flag=dao.isExistByEc_name(ec_name, app_id, ec_id, up_id, conn);
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
	  * <b>Summary: 添加业务类型</b>
	  *     复写方法 insertFormClass
	  * @param formClass
	  * @return 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService#insertFormClass(com.chinacreator.xtbg.core.businessclassmanager.entity.FormClass)
	 */
	public boolean insertFormClass(FormClass formClass) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormClassDao dao=(FormClassDao)LoadSpringContext.getApplicationContext().getBean("formClassDaoImpl");
			String new_ecid = UniqueIdManager.getUniqueId();
			formClass.setEc_id(new_ecid);
			((BaseDao)dao).insert(formClass, conn);
			flag=true;
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
	  * <b>Summary: 更新业务类型</b>
	  *     复写方法 updateFormClass
	  * @param formClass
	  * @return 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService#updateFormClass(com.chinacreator.xtbg.core.businessclassmanager.entity.FormClass)
	 */
	public boolean updateFormClass(FormClass formClass) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormClassDao dao=(FormClassDao)LoadSpringContext.getApplicationContext().getBean("formClassDaoImpl");
			((BaseDao)dao).update(formClass, conn);
			flag=true;
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
	  * <b>Summary: 删除业务类型</b>
	  *     复写方法 delFormClass
	  * @param ec_id
	  * @return 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService#delFormClass(java.lang.String)
	 */
	public boolean delFormClass(String ec_id) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormClassDao dao=(FormClassDao)LoadSpringContext.getApplicationContext().getBean("formClassDaoImpl");
			FormClass formclass=new FormClass();
			formclass.setDeleteKey("ec_id");
			((BaseDao)dao).deleteListById(formclass, conn, ec_id);
			flag=true;
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
	  * <b>Summary: 查询是否有子类</b>
	  *     复写方法 isExistSonByUpId
	  * @param ec_upid
	  * @return 
	  * @see com.chinacreator.xtbg.core.businessclassmanager.service.FormClassService#isExistSonByUpId(java.lang.String)
	 */
	public boolean isExistSonByUpId(String ec_upid) {
		Connection conn=null;
		boolean flag=false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			FormClassDao dao=(FormClassDao)LoadSpringContext.getApplicationContext().getBean("formClassDaoImpl");
			flag=dao.isExistSonByUpId(ec_upid, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}
