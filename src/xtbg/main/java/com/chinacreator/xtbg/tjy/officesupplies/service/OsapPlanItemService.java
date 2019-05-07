
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsapPlanItemService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-20   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.officesupplies.service;

import java.util.List;
import java.util.Map;
import com.chinacreator.xtbg.tjy.officesupplies.entity.OsapPlanItem;


/**
 *<p>Title:OsapPlanItemService.java</p>
 *<p>Description:物品列表业务层接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-20
 */
public interface OsapPlanItemService {
	
	/**
	*<b>Summary: </b>
	* getOsapPlanItemBean(根据申购计划Id查询物品列表)
	* @param it_planid
	* @return
	 */
	public List<Map<String, String>> getOsapPlanItemBean(String it_planid);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateOsapPlanItem(增加和修改物品列表)
	* @param bean
	* @return
	 */
	public String insertOrUpdateOsapPlanItem(OsapPlanItem bean);
	
	/**
	*<b>Summary: </b>
	* deleteOsapPlanItemByIds(根据IDs 删除物品列表)
	* @param ids
	* @return
	 */
	public String  deleteOsapPlanItemByIds(String[] ids);
}
