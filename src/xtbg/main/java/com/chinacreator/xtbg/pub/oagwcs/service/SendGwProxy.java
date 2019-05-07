package com.chinacreator.xtbg.pub.oagwcs.service;

import com.chinacreator.xtbg.pub.util.StringUtil;

/**
 * 
 *<p>Title:SendGwProxy.java</p>
 *<p>Description:发送公文代理类，封装具体发送公文的功能组装</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-24
 */
public class SendGwProxy  {
	private static SendGwIfc sendGwIfc = null;

	/**
	*<b>Summary: 发送公文到公文传输</b></br>
	* (根据【环节定义id】和【发文id】以及底层的【当前系统区域码】发送公文到公文传输)
	* @param action_defid  环节定义id [可以为空]
	* @param sendId  发文id
	* @param user_id 当前用户ID
	* @param classname 怀化的特殊处理
	* @return
	 */
	public static boolean SendGwToWebService(String action_defid,String sendId,String user_id,String classname) {
		if(StringUtil.nullOrBlank(action_defid)){
			if(StringUtil.nullOrBlank(classname)){
				sendGwIfc = SendGwFactory.instanceSendGwIfc();
			} else {
				sendGwIfc = SendGwFactory.instanceSendGwIfc("",classname);
			}
		}else if(!StringUtil.nullOrBlank(action_defid)){
			sendGwIfc = SendGwFactory.instanceSendGwIfc(action_defid);
		}
		if(null != sendGwIfc){
			//为空的时候
			if(StringUtil.nullOrBlank(classname)){
				return sendGwIfc.SendGwToWebService(sendId,user_id);
			} else {
				return sendGwIfc.SendGwToWebService(sendId,user_id,classname);
			}
		}
		return false;
	}


}
