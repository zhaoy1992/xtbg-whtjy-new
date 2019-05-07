package com.chinacreator.xtbg.core.notice.util;
/**
 * 
 *<p>Title:NoticeConstants.java</p>
 *<p>Description:通知公告中用到常量</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-8
 */
public class NoticeConstants {

	/**
	 * STATUS_DRAFT:TODO（系统全局参数编号 ）
	 */
	public static final String SYSTEM_CODE = "system";
	/**
	 * STATUS_DRAFT:TODO（消息模版 ）
	 */
	public static final String 	NOTICE_MSG = "notice_msg";
	/**
	 * STATUS_DRAFT:TODO（是否有邮件提醒 ）
	 */
	public static final String IS_PUB_MAIL = "is_pub_mail";
	/**
	 * STATUS_DRAFT:TODO（是否有及时通信 ）
	 */
	public static final String IS_PUB_RTX = "is_pub_rtx";
	/**
	 * STATUS_DRAFT:TODO（系统是否有短信全局参数 ）
	 */
	public static final String IS_PUB_SMS = "is_pub_sms";
	/**
	 * STATUS_DRAFT:TODO（是否有站内消息提醒 ）
	 */
	public static final String IS_PUB_MSG = "is_pub_msg";
	
	public static String getSystemCode() {
		return SYSTEM_CODE;
	}
	public static String getIsPubMail() {
		return IS_PUB_MAIL;
	}
	public static String getIsPubRtx() {
		return IS_PUB_RTX;
	}
	public static String getIsPubSms() {
		return IS_PUB_SMS;
	}
	public static String getIsPubMsg() {
		return IS_PUB_MSG;
	}
	
}
