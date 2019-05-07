package com.chinacreator.xtbg.pub.sms.service;

import java.sql.Connection;
import java.util.Map;
/**
 * 
 *<p>Title:SmsProxy.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 李星
 *@version 1.0
 *2013-5-9
 */
public class SmsProxy {
	private static SmsServiceIfc smsServiceIfc = null;
	/**
	 * 
	*<b>Summary: </b>
	* doSendMesg(请用一句话描述这个方法的作用)
	* 通过代理的方式，实现实例化类
	* @param map
	 */
	public static void doSendMesg(Map<String,String> map,Connection con) throws Exception{
		smsServiceIfc = SmsFactory.instanceSendGwIfc();
		if(null != smsServiceIfc){
			smsServiceIfc.smsDataAssembling(map,con);
		}
	}
}
