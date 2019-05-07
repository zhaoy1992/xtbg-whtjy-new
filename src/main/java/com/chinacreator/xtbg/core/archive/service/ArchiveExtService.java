
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     ArchiveExtService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-10-25   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.archive.service;

import java.sql.Connection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 *<p>Title:ArchiveExtService.java</p>
 *<p>Description:自定义表单，WORD表单流程各个环节需要做额外的操作，请实现该接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-10-25
 */
public interface ArchiveExtService {
	
	/**
	 * 
	*<b>Summary: </b>
	* doExtFlow(调用方法，请在该方法里进行扩展)
	* @param request
	* @param flowData
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean doExtFlow(HttpServletRequest request,Map<String, String> flowData,Connection conn) throws Exception;
}
