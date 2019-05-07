package com.chinacreator.xtbg.yimingju.carmanage.service;

import java.util.List;

import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean;

public interface CarManageCarServiceIfc {
	/**
	 * 
	 * @param baseinfoJson
	 * @return true or false
	 */
	public String saveCarManageCarInfo(CarManageCarBean cb);
	/**
	 * 
	 * @param baseinfoJson
	 * @return true or false
	 */
	public String updateCarManageCarInfo(CarManageCarBean cb);
	
	public String Insertimg(String imgsrc,String imgid);
	
	public List<CarManageCarBean> getAllCarList();
	
	public CarManageCarBean getCarByCarId(String car_id);
	
	public CarManageCarBean getCarId(String car_id,String tableName);
	
}
