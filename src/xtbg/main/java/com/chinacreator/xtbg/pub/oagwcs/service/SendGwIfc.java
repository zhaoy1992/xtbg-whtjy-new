package com.chinacreator.xtbg.pub.oagwcs.service;



public interface SendGwIfc {

	/**
	 * 
	*<b>Summary: 发送公文到webservice服务</b>
	* @param send_id
	* @param user_id
	* @return
	 */
	public boolean SendGwToWebService(String send_id,String user_id);
	
	/**
	*<b>Summary: 发送怀化签呈批件到webservice服务</b>
	* @param send_id
	* @param user_id
	* @param classname
	* @return
	 */
	public boolean SendGwToWebService(String send_id,String user_id,String classname);
}
