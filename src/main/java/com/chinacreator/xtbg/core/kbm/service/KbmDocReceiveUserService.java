
 /**
 * [Product]
  *     xtbg-tjy
  * [Copyright]
  *     Copyright © 2014 ICSS All Rights Reserved.
  * [FileName]
  *     KbmDocReceiveUserService.java
  * [History]
  *     Version  Date      Author     Content
  *     -------- --------- ---------- ------------------------
   *     1.0.0    2014-4-1   Administrator    最初版本
   */
package com.chinacreator.xtbg.core.kbm.service;

/**
 *<p>Title:KbmDocReceiveUserService.java</p>
 *<p>Description:文件更新通知业务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邱炼
 *@version 1.0
 *2014-4-1
 */
public interface KbmDocReceiveUserService {
	
	/**
	*<b>Summary: </b>
	* updateDocReceiverUserState(修改接收人查看状态)
	* @param k_receiverid
	 */
	public void updateDocReceiverUserState(String k_receiverid);
	
}
