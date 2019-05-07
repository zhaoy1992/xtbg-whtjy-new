package com.chinacreator.xtbg.core.archive.service;
/**
 * 
 *<p>Title:DispenseService.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-21
 */

public interface DispenseService {
	
	/**
	 * 
	*<b>Summary: </b>
	* dispense(完成流程中的分发功能)
	* @param busi_id 流程业务id
	* @param send_userid 发送人员id
	* @param receive_userid 接收人员id
	* @param title 传阅标题
	* @param action_from 活动表单（JSP相对路径）
	* @param ins_id 流程实例id
	* @param end_type
	* @return
	 */
	public  boolean dispense(String busi_id,String send_userid,String receive_userid,String title,String action_form,String ins_id ,String busiTypeCode, String template_id);

}
