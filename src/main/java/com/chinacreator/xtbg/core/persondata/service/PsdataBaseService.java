
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PsdataBaseService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-14   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.persondata.service;

import java.util.Map;
import com.chinacreator.xtbg.core.persondata.entity.PsdataBaseBean;

/**
 *<p>Title:PsdataBaseService.java</p>
 *<p>Description:个人文件柜资料服务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-14
 */
public interface PsdataBaseService {
	/**
	*<b>Summary: </b>
	* getPsdataTypeBean(根据资料分类Id查询资料信息)
	* @param p_type_id
	* @return
	 */
	public Map<String, String> getPsdataBaseBean(String p_data_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdatePsdataBaseBean(增加和修改资料基本信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdatePsdataBaseBean(PsdataBaseBean bean);
	
	/**
	*<b>Summary: </b>
	* deletePsdatabaseByIds(根据IDs 删除资料基本信息)
	* @param ids
	* @return
	 */
	public String  deletePsdatabaseByIds(String[] ids);
}
