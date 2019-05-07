
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsupplieTypeService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.detectionsupplies.service;

import java.util.Map;

import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsupplieTypeBean;

/**
 *<p>Title:OsupplieTypeService.java</p>
 *<p>Description:设备易耗品类型的业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public interface OsupplieTypeService {
	/**
	*<b>Summary: </b>
	* getOsupplieTypeBean(根据类型Id查询类型信息)
	* @param oftype_id
	* @param oftype_flag
	* @return
	 */
	public Map<String, String> getOsupplieTypeBean(String oftype_id,String oftype_flag);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateOsTypeBean(增加和修改类型信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateOsTypeBean(OsupplieTypeBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteOsTypeInfoByIds(根据IDs 删除类型信息)
	* @param ids
	* @return
	 */
	public String  deleteOsTypeInfoByIds(String[] ids);
	
}
