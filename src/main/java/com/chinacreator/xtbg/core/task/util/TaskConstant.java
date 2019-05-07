package com.chinacreator.xtbg.core.task.util;
/**
 * 
 *<p>Title:TaskConstant.java</p>
 *<p>Description:task任务交办常量类</p>
 *<p>Copyright:Copyright (c)2013</p>
 *<p>Company:湖南科创</p>
 *@author 戴连春
 *@version 1.0
 *2013-7-9
 */
public class TaskConstant {
	/**
	 * 任务交办重要程度
	 */
	public static final String TASK_IMPORTANCE = "importance";	
	
	/**
	 * 重要程度_普通
	 */
	public static final String IMPORTANCE_NORMAL = "1";
	/**
	 * 重要程度_重要
	 */
	public static final String IMPORTANCE_HIGHT = "2";
	/**
	 * 重要程度_非常重要
	 */
	public static final String IMPORTANCE_HIGHEST = "3";
	
	/**
	 *任务交办类型
	 */
	public static final String TASK_TYPE = "tasktype";
	/**
	 * 任务交办状态
	 */
	public static final String TASK_STATUS = "status";
	/**
	 * 任务状态 :  未办理
	 */
	public static final String STATUS_UNDO = "1";
	/**
	 * 任务状态 : 办理中
	 */
	public static final String STATUS_DOING = "2";
	/**
	 * 任务状态: 已办结
	 */
	public static final String STATUS_DID = "3";
	
	/**
	 * 未读
	 */
	public static final String UNREAD = "0";
	/**
	 * 已读
	 */
	public static final String READ = "1";
	
	/**
	 * STATUS_DRAFT:TODO（系统全局参数编号 ）
	 */
	public static final String SYSTEM_CODE = "system";
	/**
	 * STATUS_DRAFT:TODO（交办消息模版 ）
	 */
	public static final String 	TASK_MSG = "task_msg";
	/**
	 * STATUS_DRAFT:TODO（办结消息模版 ）
	 */
	public static final String 	TASK_MSG_END = "task_msg_end";
	/**
	 * STATUS_DRAFT:TODO（回复消息模版 ）
	 */
	public static final String 	TASK_MSG_REPLY = "task_msg_reply";
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
	
}

