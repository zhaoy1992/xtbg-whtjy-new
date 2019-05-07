
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     PaperTemplateService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-9-13   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.paper.service;

import java.util.Map;

import com.chinacreator.xtbg.core.paper.entity.PaperTemplateBean;


/**
 *<p>Title:PaperTemplateService.java</p>
 *<p>Description:信息报送模版管理Service接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-13
 */
public interface PaperTemplateService {
	/**
	*<b>Summary: </b>
	* getPaperTemplateBean(根据 模版Id查询模版信息)
	* @param p_template_id
	* @return
	 */
	public Map<String, String> getPaperTemplateBean(String p_template_id);
	
	/**
	*<b>Summary: </b>
	* insertOrUpdateTemplateBean(增加和修改模版信息)
	* @param bean
	* @return
	 */
	public String insertOrUpdateTemplateBean(PaperTemplateBean bean);
	
	/**
	*<b>Summary: </b>
	* deletePaperTemplateByIds(根据ids 删除模版信息)
	* @param ids
	* @return
	 */
	public String  deletePaperTemplateByIds(String[] ids);
}
