
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAccountService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.Map;

import com.chinacreator.xtbg.tjy.device.entity.DevAccountInfo;

/**
 *<p>Title:DevAccountInfoService.java</p>
 *<p>Description:设备台帐业务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public interface DevAccountInfoService {
	/**
	*<b>Summary: </b>
	* getDevAccountBean(根据类型Id查询设备基本信息)
	* @param id
	* @return
	 */
	public Map<String, String> getDevAccountBean(String id);
	/**
	*<b>Summary: </b>
	* getDevAccountByCode(根据设备编号查询设备基本信息)
	* @param id
	* @return
	 */
	public Map<String, String> getDevAccountByCode(String dev_code);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateDevAccount(增加和修改设备基本信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateDevAccount(DevAccountInfo bean);
	
	/**
	*<b>Summary: </b>
	* deleteDevAccountByIds(根据IDs 删除设备台帐信息)
	* @param ids
	* @return
	 */
	public String  deleteDevAccountByIds(String[] ids);	
	/**
	*<b>Summary: </b>
	* getDevEquipmentacc(根据id查询政府采购设备验证信息)
	* @param t_sb_id
	* @return Map
	 */
	public Map<String, String> getDevEquipmentacc(String t_sb_id);
	

	/**
	*<b>Summary: </b>
	* getDevEqAppInfo(根据id查询政府采购单信息)
	* @param id  采购明细表ID
	* @return Map
	 */
	public Map<String, String> getDevEqAppInfo(String id);
	
	
}
