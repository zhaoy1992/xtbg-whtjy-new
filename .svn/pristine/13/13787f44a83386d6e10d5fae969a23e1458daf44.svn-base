
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     DevSupplierService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-27   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.device.service;

import java.util.Map;

import com.chinacreator.xtbg.tjy.device.entity.DevSupplier;

/**
 *<p>Title:DevSupplierService.java</p>
 *<p>Description:供应商名录业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-27
 */
public interface DevSupplierService {
	/**
	*<b>Summary: </b>
	* getDevSupplierBean(根据类型Id查询供应商名录)
	* @param ofus_id
	* @return
	 */
	public Map<String, String> getDevSupplierBean(String ofus_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateDevSupplier(增加和修改供应商名录)
	* @param bean
	* @return
	 */
	public String insertOrUpdateDevSupplier(DevSupplier bean);
	
	/**
	*<b>Summary: </b>
	* deleteDevSupplierByIds(根据IDs 删除供应商名录)
	* @param ids
	* @return
	 */
	public String  deleteDevSupplierByIds(String[] ids);
}
