
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     FuelCardmangeService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-25   Administrator    最初版本
   */
package com.chinacreator.xtbg.yimingju.carmanage.service;

import java.util.Map;
import com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean;
import com.chinacreator.xtbg.yimingju.carmanage.entity.FuelCardInfoBean;

/**
 *<p>Title:FuelCardmangeService.java</p>
 *<p>Description:特检院 车辆油卡管理信息业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-25
 */
public interface FuelCardmangeService {
	
	/**
	*<b>Summary: </b>
	* getFuelcardInfo(根据车辆id查询车辆油卡信息)
	* @param car_id
	* @return Map
	 */
	public Map<String, String> getFuelcardInfo(String car_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateFuelCardmange(增加和修改车辆油卡信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateFuelCardmange(CarManageCarBean bean);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateFuelCardinfo(登记加油和充值处理)
	* @param bean
	* @return
	 */
	public String insertOrUpdateFuelCardinfo(FuelCardInfoBean bean);
	
}
