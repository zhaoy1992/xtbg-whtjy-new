
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevRepairService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-6   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.Map;

/**
 *<p>Title:DevRepairService.java</p>
 *<p>Description:仪器设备维修业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-6
 */
public interface DevRepairService {
	/**
	*<b>Summary: </b>
	* getDevRepairInfo(根据id查询仪器设备维修信息)
	* @param t_id
	* @return Map
	 */
	public Map<String, String> getDevRepairInfo(String t_id);
}
