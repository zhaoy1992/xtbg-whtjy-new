package com.chinacreator.xtbg.yimingju.mail.service;

/**
 * 
 *<p>Title:MailConfigServiceIfc.java</p>
 *<p>Description:邮箱配置服务接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *@author 夏天
 *@version 1.0
 *2013-10-30
 */
public interface MailConfigServiceIfc {
	/**
	 * 
	*<b>Summary: </b>
	* saveMailConfigInfo(保存邮箱配置信息)
	* @param user_ids
	* @param memory
	* @return
	 */
	public boolean saveMailConfigInfo(String user_ids,String memory);
}
