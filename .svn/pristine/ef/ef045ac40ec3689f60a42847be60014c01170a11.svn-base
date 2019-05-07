
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevAppItemService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-27   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.tjy.device.entity.DevAppItem;

/**
 *<p>Title:DevAppItemService.java</p>
 *<p>Description:政府采购申请业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-27
 */
public interface DevAppItemService {
	
	/**
	*<b>Summary: </b>
	* getDevAppItemBean(根据申购计划Id查询物品列表)
	* @param it_planid
	* @return
	 */
	public List<Map<String, String>> getDevAppItemBean(String it_planid);
	
	/**
	*<b>Summary: </b>
	* getDevAppItemBeanInfo(根据物品明细ID查询物品明细数据表数据)
	* @param item_id
	* @return
	 */
	public Map<String, String> getDevAppItemBeanInfo(String item_id);
	
	
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateDevAppItem(增加和修改物品列表)
	* @param bean
	* @return
	 */
	public String insertOrUpdateDevAppItem(DevAppItem bean);
	
	/**
	*<b>Summary: </b>
	* deleteDevAppItemByIds(根据IDs 删除物品列表)
	* @param ids
	* @return
	 */
	public String  deleteDevAppItemByIds(String[] ids);
}
