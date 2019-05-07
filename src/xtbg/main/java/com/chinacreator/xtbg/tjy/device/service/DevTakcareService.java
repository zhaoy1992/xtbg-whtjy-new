
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevTakcareService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.Map;
import com.chinacreator.xtbg.tjy.device.entity.DevTakcareBean;

/**
 *<p>Title:DevTakcareService.java</p>
 *<p>Description:设备维修和保养记录业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-8
 */
public interface DevTakcareService {
	
	/**
	*<b>Summary: </b>
	* getDevCheckInfoBean(根据类型Id查询设备维修和保养记录)
	* @param id
	* @return
	 */
	public Map<String, String> getDevTakcareBean(String id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateDevTakcare(增加和修改设备维修和保养记录)
	* @param bean
	* @return
	 */
	public String insertOrUpdateDevTakcare(DevTakcareBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteDevDevTakcareByIds(根据IDs 删除设备维修和保养记录)
	* @param ids
	* @return
	 */
	public String  deleteDevDevTakcareByIds(String[] ids);
}
