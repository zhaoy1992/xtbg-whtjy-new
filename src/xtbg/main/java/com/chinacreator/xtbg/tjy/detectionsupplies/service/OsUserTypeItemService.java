
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OsUserTypeItemService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-18   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.detectionsupplies.service;

import java.util.List;
import java.util.Map;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsuserTypeItemBean;

/**
 *<p>Title:OsUserTypeItemService.java</p>
 *<p>Description:物品规格业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-18
 */
public interface OsUserTypeItemService {
	/**
	*<b>Summary: </b>
	* getOsUserTypeItemBean(根据类型Id查询物品规格)
	* @param ofus_id
	* @return
	 */
	public Map<String, String> getOsUserTypeItemBean(String it_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateOsUserTypeItem(增加和修改物品规格)
	* @param bean
	* @return
	 */
	public String insertOrUpdateOsUserTypeItem(OsuserTypeItemBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteOsUserTypeItemByIds(根据IDs 删除物品规格信息)
	* @param ids
	* @return
	 */
	public String  deleteOsUserTypeItemByIds(String[] ids);
	
	/**
	 * 
	*<b>Summary: </b>
	* queryOsuserTyptItemList(根据物品ID查询出规格列表)
	* @param ofustypeId
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> queryOsuserTyptItemList(String ofustypeId) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* queryOsoFtypeItemList(根据物品ID查询出物品类别)
	* @param ofustypeId
	* @return
	* @throws Exception
	 */
	public Map<String, String> queryOsoFtypeItemList(String ofustypeId) throws Exception;
	
	
}
