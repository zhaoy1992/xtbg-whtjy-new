package com.chinacreator.xtbg.pub.sms.service;

import java.sql.Connection;
import java.util.Map;
/**
 * 
 *<p>Title:SmsServiceIfc.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 李星
 *@version 1.0
 *2013-5-9
 */
public interface SmsServiceIfc {
		/**
		 * 
		*<b>Summary: </b>
		* smsDataAssembling(请用一句话描述这个方法的作用)
		* 短信发送接口
		* @param map
		 */
		public void smsDataAssembling(Map<String,String> map,Connection con) throws Exception;

}
