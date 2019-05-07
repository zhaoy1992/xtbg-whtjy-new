
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsupplieUseTypeService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.canteenitemssupplies.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsupplieUseType;

/**
 *<p>Title:OsupplieUseTypeService.java</p>
 *<p>Description:常用物品业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public interface OsupplieUseTypeService {
	/**
	*<b>Summary: </b>
	* getOsupplieUseTypeBean(根据类型Id查询物品信息)
	* @param ofus_id
	* @return
	 */
	public Map<String, String> getOsupplieUseTypeBean(String ofus_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateOsUserTypeBean(增加和修改物品信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateOsUserTypeBean(OsupplieUseType bean);
	
	/**
	*<b>Summary: </b>
	* deleteOsUsTypeInfoByIds(根据IDs 删除物品信息)
	* @param ids
	* @return
	 */
	public String  deleteOsUsTypeInfoByIds(String[] ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryAllOsupplieUseType(查询所有物品信息)
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryAllOsupplieUseType(String unit_id) throws Exception;
}
