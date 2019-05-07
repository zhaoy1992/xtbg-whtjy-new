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
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageMileagerecordDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageMileagerecordBean;
import com.chinacreator.xtbg.yimingju.carmanage.service.CarManageMileagerecordServiceIfc;

public class CarManageMileagerecordServiceImpl implements CarManageMileagerecordServiceIfc {
	
	private static final Log LOG = LogFactory.getLog(CarManageMileagerecordServiceImpl.class);
	/**
	  * 复写方法 handleCarManageMileagerecord
	  * @param CarManageMileagerecordBean
	  * @return 
	 */
	public boolean handleCarManageMileagerecord(CarManageMileagerecordBean carManageMileagerecordBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			CarManageMileagerecordDao carManageMileagerecordDao = (CarManageMileagerecordDao)DaoImplClassUtil .getDaoImplClass("carManageMileagerecordDaoImpl");
			if(StringUtil.nullOrBlank(carManageMileagerecordBean.getMileagerecord_id())){
				carManageMileagerecordBean.setMileagerecord_id(StringUtil.getUUID());
				((BaseDao)carManageMileagerecordDao).insert(carManageMileagerecordBean, conn);
			}else{
				((BaseDao)carManageMileagerecordDao).update(carManageMileagerecordBean, conn);
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
	  * 复写方法 deleteCarManageMileagerecord
	  * @param 
	  * @return 
	 */
	public boolean deleteCarManageMileagerecord(String id) {
		Connection conn = null;
		boolean flag = false;
		String[]  ids = null;
		CarManageMileagerecordBean carManageMileagerecordBean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			CarManageMileagerecordDao carManageMileagerecordDao = (CarManageMileagerecordDao)DaoImplClassUtil .getDaoImplClass("carManageMileagerecordDaoImpl");
			if(!StringUtil.isBlank(id)) {
				ids = id.split(",");
				for (int i = 0; i < ids.length; i++) {
					carManageMileagerecordBean = new CarManageMileagerecordBean();
					carManageMileagerecordBean.setMileagerecord_id(ids[i]);
					((BaseDao)carManageMileagerecordDao).deleteListById(carManageMileagerecordBean, conn, ids[i]);
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
	  * 复写方法 getCarManageMileagerecord
	  * @param id
	  * @return 
	 */
	public Map<String, String> getCarManageMileagerecord(String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			CarManageMileagerecordDao carManageMileagerecordDao = (CarManageMileagerecordDao)DaoImplClassUtil .getDaoImplClass("carManageMileagerecordDaoImpl");
			viewMap = carManageMileagerecordDao.getCarManageMileagerecord(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}

	
}
