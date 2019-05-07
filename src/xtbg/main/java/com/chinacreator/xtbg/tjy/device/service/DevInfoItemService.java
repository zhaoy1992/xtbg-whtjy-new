
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevInfoItemService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-3   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.tjy.device.entity.DevInfoItemBean;

/**
 *<p>Title:DevInfoItemService.java</p>
 *<p>Description:配件列表业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-3
 */
public interface DevInfoItemService {
	/**
	*<b>Summary: </b>
	* getDevInfoItemBean(根据申购计划Id查询配件列表)
	* @param dev_code
	* @return
	 */
	public List<Map<String, String>> getDevInfoItemBean(String dev_code);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateDevAppItem(增加和修改配件列表)
	* @param bean
	* @return
	 */
	public String insertOrUpdateDevInfoItem(DevInfoItemBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteDevAppItemByIds(根据IDs 删除配件列表)
	* @param ids
	* @return
	 */
	public String  deleteDevInfoItemByIds(String[] ids);
}
