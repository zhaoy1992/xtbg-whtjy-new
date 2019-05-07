package com.chinacreator.xtbg.core.common.mail.support;
/**
 *<p>Title:MailConstants.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-8-6
 */
public class MailConstants {

	/**
	 * 邮件来源：邮件起草
	 */
	public static final String DRAFT = "1";	
	
	/**
	 * 邮件来源：转发
	 */
	public static final String TRANSFER_SEND = "2"; 	
	
	/**
	 * 邮件来源：业务调用接口发送
	 */
	public static final String BUSINESS_INTERFACE = "3"; 	
	
	/**
	 * 邮件来源：收件
	 */
	public static final String RECV_MAIL = "4"; 	
	
	/**
	 * 邮件发送状态：草稿状态
	 */
	public static final String MAIL_DRAFT = "1";
	
	/**
	 * 邮件发送状态：正在发送
	 */
	public static final String SENDING = "2";
	
	/**
	 * 邮件发送状态：已发送
	 */
	public static final String HAS_SEND = "3";
	
	/**
	 * 邮件发送状态：撤销
	 */
	public static final String HAS_REVOCATION = "4";
	
	/**
	 * 邮件发送状态：已删除
	 */
	public static final String HAS_DELETE = "5";
	
	/**
	 * 收件状态：待阅
	 */
	public static final String WAIT_READ = "1";
	
	/**
	 * 收件状态：已阅
	 */
	public static final String HAS_READ = "2";
	
	/**
	 * 收件状态：被撤销
	 */
	public static final String HAS_REVOCATIONED = "3";
	
	/**
	 * 收件状态：已删除
	 */
	public static final String HAD_DELETE = "4";
	
	/**
	 * 主送
	 */
	public static final String SEND_TYPE_M = "m";
	
	/**
	 * 抄送
	 */
	public static final String SEND_TYPE_C = "c";
	
	/**
	 * 站内邮箱
	 */
	public static final String LOCAL = "local";
	
	/**
	 * 外部邮箱
	 */
	public static final String REMOTE = "remote";
	
}
