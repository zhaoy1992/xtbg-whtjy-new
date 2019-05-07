
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PsdataTypeService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-9   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.persondata.service;

import java.util.Map;

import com.chinacreator.xtbg.core.persondata.entity.PsdataTypeBean;


/**
 *<p>Title:PsdataTypeService.java</p>
 *<p>Description:个人文件柜分类服务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-9
 */
public interface PsdataTypeService {
	
	/**
	*<b>Summary: </b>
	* getPsdataTypeBean(根据资料分类Id查询资料分类信息)
	* @param p_type_id
	* @return
	 */
	public Map<String, String> getPsdataTypeBean(String p_type_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdatePsdataTypeBean(增加和修改资料分类信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdatePsdataTypeBean(PsdataTypeBean bean);
	
	/**
	*<b>Summary: </b>
	* deletePsdataTypeInfoByIds(根据IDs 删除资料分类信息)
	* @param ids
	* @return
	 */
	public String  deletePsdataTypeInfoByIds(String[] ids);
	
	/**
	*<b>Summary: </b>
	* findTypeTopInfo(查询资料分类默认信息分类)
	* @param user_id
	* @return
	 */
	public Map<String, String> findTypeTopInfo(String user_id);

}
