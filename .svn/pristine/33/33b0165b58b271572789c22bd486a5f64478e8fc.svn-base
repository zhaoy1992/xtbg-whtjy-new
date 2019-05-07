package com.chinacreator.xtbg.yimingju.carmanage.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.dbbase.dao.BaseDao;
import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.pub.util.DaoUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarDriverDao;
import com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean;
import com.chinacreator.xtbg.yimingju.carmanage.service.CarDriverService;
/**
 * 
 *<p>Title:CarDrivaerServiceImpl.java</p>
 *<p>Description:发改委所用车辆管理司机信息管理业务层实现类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2013-10-24
 */
public class CarDrivaerServiceImpl implements CarDriverService {
	private static final Logger LOG = Logger.getLogger(CarDrivaerServiceImpl.class);

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 insertDriver
	  * @param driverBean
	  * @return 
	  * @see com.chinacreator.xtbg.yimingju.carmanage.service.CarDriverService#insertDriver(com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean)
	 */
	public boolean insertDriver(DriverBean driverBean) {
		try {
			BaseDao  dao = (BaseDao)DaoImplClassUtil.getDaoImplClass("carDriver");
			String driver_id = DaoUtil.findBySequencsName("SEQ_TA_OA_DRIVER");
			driverBean.setDriver_id(driver_id);
			dao.insert(driverBean);
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			e.printStackTrace();
			return false;
		}
		
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 findDriverInfoById
	  * @param driver_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.yimingju.carmanage.service.CarDriverService#findDriverInfoById(java.lang.String)
	 */
	public List<DriverBean> findDriverInfoById(String driver_id)
			throws Exception {
		List<DriverBean> list = new ArrayList<DriverBean>();
		try {
			CarDriverDao  dao = (CarDriverDao)DaoImplClassUtil.getDaoImplClass("carDriver");
			list = dao.queryDriverInfoById(driver_id);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 updateDriver
	  * @param driverBean
	  * @return 
	  * @see com.chinacreator.xtbg.yimingju.carmanage.service.CarDriverService#updateDriver(com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean)
	 */
	public boolean updateDriver(DriverBean driverBean) {
		try {
			BaseDao  dao = (BaseDao)DaoImplClassUtil.getDaoImplClass("carDriver");
			dao.update(driverBean);
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 
	  * <b>Summary: </b>
	  *     复写方法 deleteDriver
	  * @param driverBean
	  * @param driver_ids
	  * @return 
	  * @see com.chinacreator.xtbg.yimingju.carmanage.service.CarDriverService#deleteDriver(com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean, java.lang.String)
	 */
	public boolean deleteDriver(DriverBean driverBean, String driver_ids) {
		try {
			BaseDao  dao = (BaseDao)DaoImplClassUtil.getDaoImplClass("carDriver");
			driverBean.setDeleteKey("driver_id");
			dao.deleteListById(driverBean, driver_ids);
			return true;
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			e.printStackTrace();
			return false;
		}
	}
	
	
}
