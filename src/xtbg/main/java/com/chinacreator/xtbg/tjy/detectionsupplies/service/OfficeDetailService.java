
 /**
 * [Product]
  *     tjy_xtbg168
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     OfficeDetailService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-9-9   Administrator    最初版本
   */
package com.chinacreator.xtbg.tjy.detectionsupplies.service;

import java.util.Map;
import com.chinacreator.xtbg.tjy.detectionsupplies.entity.OsofficeAccountBean;

/**
 *<p>Title:OfficeDetailService.java</p>
 *<p>Description:固定资产详细台帐业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-9-9
 */
public interface OfficeDetailService {

	/**
	*<b>Summary: </b>
	* getOfficeDetailBean(根据类型Id查询固定资产台帐详细信息)
	* @param id
	* @return
	 */
	public Map<String, String> getOfficeDetailBean(String id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateOfficeDetail(增加和修改固定资产台帐详细信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateOfficeDetail(OsofficeAccountBean bean);
	
	/**
	*<b>Summary: </b>
	* deleteOfficeDetailByIds(根据IDs 删除固定资产台帐详细信息)
	* @param ids
	* @return
	 */
	public String  deleteOfficeDetailByIds(String[] ids);
}
