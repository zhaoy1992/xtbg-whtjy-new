package com.chinacreator.xtbg.yimingju.carmanage.service.impl;

import java.util.List;

import org.apache.log4j.Logger;

import com.chinacreator.xtbg.pub.util.DaoImplClassUtil;
import com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao;
import com.chinacreator.xtbg.yimingju.carmanage.dao.impl.CarManageCarDaoImpl;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean;
import com.chinacreator.xtbg.yimingju.carmanage.service.CarManageCarServiceIfc;

public class CarManageCarServiceImpl implements CarManageCarServiceIfc {
	
	private static final Logger LOG = Logger.getLogger(CarManageCarServiceImpl.class);
	private CarManageCarDao carDao = new CarManageCarDaoImpl();
	@Override
	public String saveCarManageCarInfo(CarManageCarBean cb) {
		String result="";
		try {
			CarManageCarDao carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
			result = carManageCarDao.saveCarManageCarInfo(cb);
		} catch (Exception e) {
			LOG.error(e.getMessage());
			return result="保存失败";
		}
		return result;
	}

	@Override
	public String updateCarManageCarInfo(CarManageCarBean cb) {
		String str = "修改成功" ;
		try {
			CarManageCarDao carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
			str = carManageCarDao.updateCarManageCarInfo(cb);
		} catch (Exception e) {
			LOG.error(e.getMessage());
			str ="修改失败";
		}
		return str;
	}
	@Override
	public String Insertimg(String imgsrc,String imgid){
		String str ="上传成功";
		try {
			CarManageCarDao carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
			str = carManageCarDao.Insertimg(imgsrc, imgid);
		} catch (Exception e) {
			LOG.error(e.getMessage());
			str ="上传失败";
		}
		return str;
	}
	
	
	public List<CarManageCarBean> getAllCarList(){
		return carDao.getAllCarList();
	}
	
	public CarManageCarBean getCarByCarId(String car_id){
		return carDao.getCarByCarId(car_id);
	}
	
	public CarManageCarBean getCarId(String car_id,String tableName){
		return carDao.getCarId(car_id,tableName);
	}
}
