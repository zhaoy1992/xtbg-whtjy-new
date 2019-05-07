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
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageViolationrecordDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageViolationrecordBean;
import com.chinacreator.xtbg.yimingju.carmanage.service.CarManageViolationrecordServiceIfc;

public class CarManageViolationrecordServiceImpl implements CarManageViolationrecordServiceIfc {
	
	private static final Log LOG = LogFactory.getLog(CarManageViolationrecordServiceImpl.class);
	/**
	  * 复写方法 handleCarManageViolationrecord
	  * @param CarManageViolationrecordBean
	  * @return 
	 */
	public boolean handleCarManageViolationrecord(CarManageViolationrecordBean carManageViolationrecordBean) {
		Connection conn = null;
		boolean flag = false;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			CarManageViolationrecordDao carManageViolationrecordDao = (CarManageViolationrecordDao)DaoImplClassUtil .getDaoImplClass("carManageViolationrecordDaoImpl");
			if(StringUtil.nullOrBlank(carManageViolationrecordBean.getEndorsement_id())){
				carManageViolationrecordBean.setEndorsement_id(StringUtil.getUUID());
				((BaseDao)carManageViolationrecordDao).insert(carManageViolationrecordBean, conn);
			}else{
				((BaseDao)carManageViolationrecordDao).update(carManageViolationrecordBean, conn);
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
	  * 复写方法 deleteCarManageViolationrecord
	  * @param 
	  * @return 
	 */
	public boolean deleteCarManageViolationrecord(String id) {
		Connection conn = null;
		boolean flag = false;
		String[]  ids = null;
		CarManageViolationrecordBean carManageViolationrecordBean = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			CarManageViolationrecordDao carManageViolationrecordDao = (CarManageViolationrecordDao)DaoImplClassUtil .getDaoImplClass("carManageViolationrecordDaoImpl");
			if(!StringUtil.isBlank(id)) {
				ids = id.split(",");
				for (int i = 0; i < ids.length; i++) {
					carManageViolationrecordBean = new CarManageViolationrecordBean();
					carManageViolationrecordBean.setEndorsement_id(ids[i]);
					((BaseDao)carManageViolationrecordDao).deleteListById(carManageViolationrecordBean, conn, ids[i]);
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
	public Map<String, String> getCarManageViolationrecord(String id) {
		Connection conn = null;
		Map<String, String> viewMap = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			viewMap = new HashMap<String, String>();
			CarManageViolationrecordDao carManageViolationrecordDao = (CarManageViolationrecordDao)DaoImplClassUtil .getDaoImplClass("carManageViolationrecordDaoImpl");
			viewMap = carManageViolationrecordDao.getCarManageViolationrecord(id, conn);
		} catch (Exception e) {
			DbManager.rollBackNoThrow(conn);
			LOG.error(e.getMessage(), e);
		} finally{
			DbManager.closeConnection(conn);
			
		}
		return viewMap;
	}

	
}
