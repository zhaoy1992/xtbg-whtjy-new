package com.chinacreator.xtbg.yimingju.carmanage.service;

import java.util.Map;

import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageMileagerecordBean;

public interface CarManageMileagerecordServiceIfc {

	/**
	  * 复写方法 handleCarManageMileagerecord
	  * @param CarManageMileagerecordBean
	  * @return 
	 */
	public boolean handleCarManageMileagerecord(CarManageMileagerecordBean carManageMileagerecordBean)  ;
	/**
	  * 复写方法 deleteCarManageMileagerecord
	  * @param 
	  * @return 
	 */
	public boolean deleteCarManageMileagerecord(String id);
	/**
	  * 复写方法 getCarManageMileagerecord
	  * @param id
	  * @return 
	 */
	public Map<String, String> getCarManageMileagerecord(String id);
}
