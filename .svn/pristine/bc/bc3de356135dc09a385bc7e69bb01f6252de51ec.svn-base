package com.chinacreator.xtbg.yimingju.carmanage.service;

import java.util.List;

import com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean;

/**
 * 
 *<p>Title:CarDriverService.java</p>
 *<p>Description:发改委所用车辆管理司机信息管理业务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 童佳
 *@version 1.0
 *2013-10-24
 */
public interface CarDriverService {
	/**
	 * 
	*<b>Summary: </b>
	* insertDriver(新增司机详细信息)
	* @param driverBean
	* @return
	 */
   public  boolean insertDriver(DriverBean driverBean);
   /**
    * 
   *<b>Summary: </b>
   * findDriverInfoById(根据主键信息查询司机详情)
   * @param driver_id
   * @return
   * @throws Exception
    */
   public List<DriverBean> findDriverInfoById(String driver_id)throws Exception ;
   /**
    * 
   *<b>Summary: </b>
   * updateDriver(修改司机详细信息)
   * @param driverBean
   * @return
    */
   public boolean updateDriver(DriverBean driverBean);
   /**
    * 
   *<b>Summary: </b>
   * deleteDriver(根据主键删除司机信息)
   * @param driverBean
   * @param driver_ids
   * @return
    */
   public boolean deleteDriver(DriverBean driverBean,String driver_ids);
}
