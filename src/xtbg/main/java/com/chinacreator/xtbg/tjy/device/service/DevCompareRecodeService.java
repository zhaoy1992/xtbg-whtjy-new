
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevCompareRecodeService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-8   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.Map;

import com.chinacreator.xtbg.tjy.device.entity.DevCompareRecode;

/**
 *<p>Title:DevCompareRecodeService.java</p>
 *<p>Description:对比记录业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-8
 */
public interface DevCompareRecodeService {
	/**
	*<b>Summary: </b>
	* getDevCompareRecode(根据类型Id查询对比记录)
	* @param id
	* @return
	 */
	public Map<String, String> getDevCompareRecode(String id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateDevCompareRecode(增加和修改对比记录)
	* @param bean
	* @return
	 */
	public String insertOrUpdateDevCompareRecode(DevCompareRecode bean);
	
	/**
	*<b>Summary: </b>
	* deleteDevCompareRecodeByIds(根据IDs 删除对比记录)
	* @param ids
	* @return
	 */
	public String  deleteDevCompareRecodeByIds(String[] ids);
}
