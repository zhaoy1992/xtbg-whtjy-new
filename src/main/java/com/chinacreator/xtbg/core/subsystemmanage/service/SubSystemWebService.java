
 /**
 * [Product]
  *     xtbgbase
  * [Copyright]
  *     Copyright © 2013 ICSS All Rights Reserved.
  * [FileName]
  *     SubuseSystemServiceIfc.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2013-8-26   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.subsystemmanage.service;

import javax.jws.WebService;

/**
 *<p>Title:SubuseSystemServiceIfc.java</p>
 *<p>Description:子系统用webService 调用</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2013-8-26
 */

@WebService
public interface SubSystemWebService {
	
	/**
	*<b>Summary: </b>
	* modUserPasss(修改OA中单点登录 中用户ID和密码)
	* @param uuid
	* @return
	 */
	public String modUserPasss(String uuid, String user_id, String user_name,
			String password);
}
