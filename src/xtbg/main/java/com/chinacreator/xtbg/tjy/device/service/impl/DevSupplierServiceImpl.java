
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevSupplierServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-27   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.tjy.device.dao.DevSupplierDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevSupplierDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevSupplier;
import com.chinacreator.xtbg.tjy.device.service.DevSupplierService;

/**
 *<p>Title:DevSupplierServiceImpl.java</p>
 *<p>Description:供应商名录业务接口 实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-27
 */
public class DevSupplierServiceImpl implements DevSupplierService{
	
	private static final Log LOG=LogFactory.getLog(DevSupplierServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevSupplierBean
	  * @param ofus_id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevSupplierService#getDevSupplierBean(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevSupplierBean(String ofus_id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevSupplierDao devsupplierdao = new DevSupplierDaoImpl();
			viewMap = devsupplierdao.getDevSupplier(ofus_id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return viewMap;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 insertOrUpdateDevSupplier
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevSupplierService#insertOrUpdateDevSupplier(com.chinacreator.xtbg.tjy.device.entity.DevSupplier) 
	  */
	@Override
	public String insertOrUpdateDevSupplier(DevSupplier bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//收录时间
			bean.setDevsup_slsj(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getDevsup_slsj()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			DevSupplierDao dao = new DevSupplierDaoImpl();
			if(StringUtil.nullOrBlank(bean.getDevsup_id())){//insert
				bean.setDevsup_id(StringUtil.getUUID());
				beanId = bean.getDevsup_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getDevsup_id();
				((BaseDao)dao).update(bean, conn);
			}
			conn.commit();
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return beanId;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteDevSupplierByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevSupplierService#deleteDevSupplierByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevSupplierByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevSupplierDao dao = new DevSupplierDaoImpl();
			for (String beanId : ids) {
				dao.deleteDevSupplierById(conn, beanId);
			}
			conn.commit();
			flag = "true";
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
		}
		return flag;
	}

}
