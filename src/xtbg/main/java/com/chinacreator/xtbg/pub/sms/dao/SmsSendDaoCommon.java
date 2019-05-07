package com.chinacreator.xtbg.pub.sms.dao;

import java.util.Map;
/**
 * 
 *<p>Title:SmsSendDaoCommon.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 李星
 *@version 1.0
 *2013-5-14
 */
public interface SmsSendDaoCommon {
	/**
	 * 
	*<b>Summary: </b>
	* smsDataAssembling(请用一句话描述这个方法的作用)
	* 短信发送的数据的接口,
	* @param map
	 */
	public void smsSendDao(Map<String,String> map) throws Exception;
}
