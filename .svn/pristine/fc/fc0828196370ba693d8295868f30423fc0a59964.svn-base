package com.chinacreator.xtbg.yimingju.carmanage.service.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageRefuelmanageDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageRefuelmanageBean;
import com.chinacreator.xtbg.yimingju.carmanage.service.CarManageRefuelmanageServiceIfc;

public class CarManageRefuelmanageServiceImpl implements CarManageRefuelmanageServiceIfc {
	
	private static final Log LOG = LogFactory.getLog(CarManageRefuelmanageServiceImpl.class);
	/**
	  * 复写方法 handleCarManageRefuelmanage
	  * @param CarManageRefuelmanageBean
	  * @return 
	 */
	public boolean handleCarManageRefuelmanage(CarManageRefuelmanageBean carManageRefuelmanageBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			CarManageRefuelmanageDao carManageRefuelmanageDao = (CarManageRefuelmanageDao)DaoImplClassUtil .getDaoImplClass("carManageRefuelmanageDaoImpl");
			if(StringUtil.nullOrBlank(carManageRefuelmanageBean.getFuel_id())){
				carManageRefuelmanageBean.setFuel_id(StringUtil.getUUID());
				((BaseDao)carManageRefuelmanageDao).insert(carManageRefuelmanageBean, conn);
			}else{
				((BaseDao)carManageRefuelmanageDao).update(carManageRefuelmanageBean, conn);
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
	  * 复写方法 deleteCarManageRefuelmanage
	  * @param 
	  * @return 
	 */
	public boolean deleteCarManageRefuelmanage(String id) {
		Connection conn = null;
		boolean flag = false;
		String[]  ids = null;
		CarManageRefuelmanageBean carManageRefuelmanageBean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			CarManageRefuelmanageDao carManageRefuelmanageDao = (CarManageRefuelmanageDao)DaoImplClassUtil .getDaoImplClass("carManageRefuelmanageDaoImpl");
			if(!StringUtil.isBlank(id)) {
				ids = id.split(",");
				for (int i = 0; i < ids.length; i++) {
					carManageRefuelmanageBean = new CarManageRefuelmanageBean();
					carManageRefuelmanageBean.setFuel_id(ids[i]);
					((BaseDao)carManageRefuelmanageDao).deleteListById(carManageRefuelmanageBean, conn, ids[i]);
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
	  * 复写方法 getFileProgramPageBean
	  * @param id
	  * @return 
	 */
	public Map<String, String> getCarManageRefuelmanage(String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			CarManageRefuelmanageDao carManageRefuelmanageDao = (CarManageRefuelmanageDao)DaoImplClassUtil .getDaoImplClass("carManageRefuelmanageDaoImpl");
			viewMap = carManageRefuelmanageDao.getCarManageRefuelmanage(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}

	
}
