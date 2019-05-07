package com.chinacreator.xtbg.yimingju.carmanage.service;

import java.util.Map;

import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageViolationrecordBean;
/**
 * 
 *<p>Title:FileProgramPageServiceIfc.java</p>
 *<p>Description:档案程序界面处理服务类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-11
 */
public interface CarManageViolationrecordServiceIfc {

	/**
	  * 复写方法 handleCarManageViolationrecord
	  * @param CarManageViolationrecordBean
	  * @return 
	 */
	public boolean handleCarManageViolationrecord(CarManageViolationrecordBean carManageViolationrecordBean) ;
	/**
	  * 复写方法 deleteCarManageViolationrecord
	  * @param 
	  * @return 
	 */
	public boolean deleteCarManageViolationrecord(String id);
	/**
	  * 复写方法 getFileProgramPageBean
	  * @param id
	  * @return 
	 */
	public Map<String, String> getCarManageViolationrecord(String id);
}
