
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     FuelCardmangeDao.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-25   Administrator    最初版本
   */
package com.chinacreator.xtbg.yimingju.carmanage.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.pub.common.PagingBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.FuelCardInfoBean;

/**
 *<p>Title:FuelCardmangeDao.java</p>
 *<p>Description:特检院车辆油卡管理dao层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-25
 */
public interface FuelCardmangeDao {
	
	/**
	*<b>Summary: </b>
	* queryFuelCardmangeList(查询车辆油卡管理信息)
	* @param carmanagecarbean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryFuelCardmangeList(CarManageCarBean carmanagecarbean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception ;

	/**
	*<b>Summary: </b>
	* getFuelcardInfo(根据车辆id查询车辆油卡信息)
	* @param car_id
	* @return Map
	 */
	public Map<String, String> getFuelcardInfo(String car_id,Connection conn) throws Exception;
	
	
	/**
	*<b>Summary: </b>
	* queryCardFuelHistory(查询车辆油卡使用记录)
	* @param fuelcardinfobean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryCardFuelHistory(FuelCardInfoBean fuelcardinfobean, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception ;
}
