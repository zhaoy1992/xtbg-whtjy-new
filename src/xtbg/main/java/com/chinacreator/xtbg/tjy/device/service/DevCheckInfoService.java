
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCheckInfoService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-7   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.Map;

import com.chinacreator.xtbg.tjy.device.entity.DevCheckInfoBean;

/**
 *<p>Title:DevCheckInfoService.java</p>
 *<p>Description:核查记录业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-7
 */
public interface DevCheckInfoService {
	/**
	*<b>Summary: </b>
	* getDevCheckInfoBean(根据类型Id查询核查记录)
	* @param id
	* @return
	 */
	public Map<String, String> getDevCheckInfoBean(String id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateDevCheckInfo(增加和修改核查记录)
	* @param bean
	* @return
	 */
	public String insertOrUpdateDevCheckInfo(DevCheckInfoBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteDevCheckInfoByIds(根据IDs 删除核查记录)
	* @param ids
	* @return
	 */
	public String  deleteDevCheckInfoByIds(String[] ids);
}
