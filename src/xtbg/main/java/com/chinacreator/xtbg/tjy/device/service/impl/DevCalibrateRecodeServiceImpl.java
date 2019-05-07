
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCalibrateRecodeServiceImpl.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-4   Administrator    最初版本
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
import com.chinacreator.xtbg.tjy.device.dao.DevCalibrateRecodeDao;
import com.chinacreator.xtbg.tjy.device.dao.Impl.DevCalibrateRecodeDaoImpl;
import com.chinacreator.xtbg.tjy.device.entity.DevCalibrateRecode;
import com.chinacreator.xtbg.tjy.device.service.DevCalibrateRecodeService;

/**
 *<p>Title:DevCalibrateRecodeServiceImpl.java</p>
 *<p>Description:设备校准记录</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-4
 */
public class DevCalibrateRecodeServiceImpl implements DevCalibrateRecodeService {
	
	private static final Log LOG=LogFactory.getLog(DevCalibrateRecodeServiceImpl.class);
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 getDevCalibrateRecode
	  * @param id
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevCalibrateRecodeService#getDevCalibrateRecode(java.lang.String) 
	  */
	@Override
	public Map<String, String> getDevCalibrateRecode(String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			DevCalibrateRecodeDao devcalibraterecodedao = new DevCalibrateRecodeDaoImpl();
			viewMap = devcalibraterecodedao.getDevCalibrateRecodeBean(id, conn);
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
	  *     复写方法 insertOrUpdateDevCalibrateRecode
	  * @param bean
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevCalibrateRecodeService#insertOrUpdateDevCalibrateRecode(com.chinacreator.xtbg.tjy.device.entity.DevCalibrateRecode) 
	  */
	@Override
	public String insertOrUpdateDevCalibrateRecode(DevCalibrateRecode bean) {
		Connection conn = null;
		String beanId = "";
		try {
			//校准日期
			bean.setCalib_time(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getCalib_time()), "yyyy-MM-dd"));
			//有效期
			bean.setCalib_valitime(StringUtil.convertStringToTimestamp(StringUtil.deNull(bean.getCalib_valitime()), "yyyy-MM-dd"));
			conn = DbManager.getInstance().getTransactionConnection();
			DevCalibrateRecodeDao dao = new DevCalibrateRecodeDaoImpl();
			if(StringUtil.nullOrBlank(bean.getCalib_id())){//insert
				bean.setCalib_id(StringUtil.getUUID());
				beanId = bean.getCalib_id();
				((BaseDao)dao).insert(bean, conn);
			}else{//update
				beanId = bean.getCalib_id();
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
	  *     复写方法 deleteDevCalibrateRecodeByIds
	  * @param ids
	  * @return 
	  * @see com.chinacreator.xtbg.tjy.device.service.DevCalibrateRecodeService#deleteDevCalibrateRecodeByIds(java.lang.String[]) 
	  */
	@Override
	public String deleteDevCalibrateRecodeByIds(String[] ids) {
		Connection conn = null;
		String flag = "false";
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			DevCalibrateRecodeDao dao = new DevCalibrateRecodeDaoImpl();
			for (String beanId : ids) {
				dao.deleteDevCalibrateRecodeById(conn, beanId);
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
