
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     PersonHolderServiceIfc.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-2-21   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.personholder.service;

import java.util.Map;
import com.chinacreator.xtbg.core.personholder.entity.PersonHolder;

/**
 *<p>Title:PersonHolderServiceIfc.java</p>
 *<p>Description:人员持证信息管理</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-2-21
 */
public interface PersonHolderServiceIfc {
	/**
	*<b>Summary: </b>
	* getPersonHolderBean(根据资料分类Id查询资料分类信息)
	* @param hold_id
	* @return
	 */
	public Map<String, String> getPersonHolderBean(String hold_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdatePersonHolder(增加和修改人员持证管理)
	* @param bean
	* @return
	 */
	public boolean insertOrUpdatePersonHolder(PersonHolder bean);
	
	/**
	*<b>Summary: </b>
	* deletePersonHolderByIds(根据IDs 删除人员持证信息)
	* @param ids
	* @return
	 */
	public String deletePersonHolderByIds(String[] ids);
}
