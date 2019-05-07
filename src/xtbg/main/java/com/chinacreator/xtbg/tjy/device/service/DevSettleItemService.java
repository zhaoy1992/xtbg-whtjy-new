
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevSettleItemService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-3-15   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.List;
import java.util.Map;
import com.chinacreator.xtbg.tjy.device.entity.DevSettleItemBean;

/**
 *<p>Title:DevSettleItemService.java</p>
 *<p>Description:政府采购验收结算货品业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-3-15
 */
public interface DevSettleItemService {
	/**
	*<b>Summary: </b>
	* getDevSettleItem(根据验收结算Id查询结算货品列表)
	* @param devsettle_id
	* @return
	 */
	public List<Map<String, String>> getDevSettleItem(String devsettle_id);
	
	/**
	*<b>Summary: </b>
	* getDevSettleItemBeanInfo(根据结算货品明细ID查询结算货品明细数据表数据)
	* @param t_id
	* @return
	 */
	public Map<String, String> getDevSettleItemBeanInfo(String t_id);
	
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateDevSettleItem(增加和修改结算货品列表)
	* @param bean
	* @return
	 */
	public String insertOrUpdateDevSettleItem(DevSettleItemBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteDevSettleItemByIds(根据IDs 删除结算货品列表)
	* @param ids
	* @return
	 */
	public String  deleteDevSettleItemByIds(String[] ids);
}
