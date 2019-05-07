package com.chinacreator.xtbg.core.meeting.util;

/**
 *<p>Title:MeetingConstants.java</p>
 *<p>Description:会议管理中的常量</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-6-20
 */
public class MeetingConstants {
	//会议状态类型如下：
	
	 /** 
	  * STATUS_DRAFT:TODO（暂存） 
	  */
	public static final String STATUS_DRAFT = "3";// 暂存  
	
	 /** 
	  * STATUS_PENDING:TODO（待审核  已送审） 
	  */
	public static final String STATUS_PENDING = "0";// 待审核  已送审
	
	 /** 
	  * STATUS_CHECKPASS:TODO（审核通过） 
	  */
	public static final String STATUS_CHECKPASS = "1";// 审核通过
	
	 /** 
	  * STATUS_UNCHECKPASS:TODO（审核不通过） 
	  */
	public static final String STATUS_UNCHECKPASS = "2";// 审核不通过
	
	 /** 
	  * STATUS_PUBLISHED:TODO（已发布） 
	  */
	public static final String STATUS_PUBLISHED = "4";// 已发布
	
	 /** 
	  * STATUS_REPUBLISHED:TODO（重新发布） 
	  */
	public static final String STATUS_REPUBLISHED = "5";// 重新发布
	
	 /** 
	  * STATUS_UNDONE:TODO（请用一句话描述这个变量表示什么） 
	  */
	public static final String STATUS_UNDONE = "6";// 已撤消
	//回复类型如下
	
	 /** 
	  * REPLY_YES:TODO（参加） 
	  */
	public static final String REPLY_YES = "1";   //本人参加          ----   回复情况
	
	 /** 
	  * REPLY_2:TODO（委托人参加） 
	  */
	public static final String REPLY_2 = "2";   //委托人参加          ----   回复情况
	
	 /** 
	  * REPLY_3:TODO（安排人参加） 
	  */
	public static final String REPLY_3 = "3";   //安排人参加          ----   回复情况
	
	 /** 
	  * REPLY_9:TODO（请假） 
	  */
	public static final String REPLY_9 = "9";   //请假          ----   回复情况
	
	 /** 
	  * REPLY_NO:TODO（未报名） 
	  */
	public static final String REPLY_NO = "0";    //未报名
	
	
	
	 /** 
	  * REPLY_Leave:TODO（请假） 
	  */
	public static final String REPLY_Leave = "9"; //请假
	//常用
	
	 /** 
	  * STATUS_TRUE:TODO（是） 
	  */
	public static final String STATUS_TRUE = "1"; // 是      用到有如已阅读、未阅读 这类 两种枚举值的简单情况
	
	 /** 
	  * STATUS_FALSE:TODO（否） 
	  */
	public static final String STATUS_FALSE = "0"; // 否
	//消息发送类型
	
	 /** 
	  * MSG_ADD_SEND:TODO（补发--发送消息时的状态） 
	  */
	public static final String MSG_ADD_SEND = "7"; // 补发
	
	 /** 
	  * MSG_RE_SEND:TODO（重发--发送消息时的状态） 
	  */
	public static final String MSG_RE_SEND = "5"; // 重发
	
	
	 /** 
	  * MSG_GO_SEND:TODO（ 转发） 
	  */
	public static final String MSG_GO_SEND = "6"; // 转发
	
	 /** 
	  * MSG_DRAFT_SEND:TODO（草稿--发送消息时的状态） 
	  */
	public static final String MSG_DRAFT_SEND = "3"; // 草稿
	
	 /** 
	  * MSG_PUBLISHED_SEND:TODO（发布--发送消息时的状态） 
	  */
	public static final String MSG_PUBLISHED_SEND = "4"; // 发布
	
	 /** 
	  * MSG_CALL_SEND:TODO（催发--发送消息时的状态） 
	  */
	public static final String MSG_CALL_SEND = "8"; // 催发
	
	//提醒方式类型
	
	 /** 
	  * MSG:TODO（即时消息） 
	  */
	public static final String MSG = "msg"; //即时消息
	
	 /** 
	  * NOTE:TODO（短信） 
	  */
	public static final String NOTE = "note"; //短信
	
	
	 /** 
	  * BUFA:TODO（补发） 
	  */
	public static final String BUFA = "bufa"; //补发 
	
	 /** 
	  * CHONGFA:TODO（重发） 
	  */
	public static final String CHONGFA = "chongfa";//重发
	
	
	
	 /** 
	  * ZHUANGFA:TODO（转发） 
	  */
	public static final String ZHUANGFA = "zhuangfa";//转发
	
	
	 /** 
	  * MEETINGTYPE_YUYUE:TODO（会议室预约） 
	  */
	public static final String MEETINGTYPE_YUYUE = "会议室预约";
	
	 /** 
	  * MEETINGTYPE_NOTICE:TODO（会议通知） 
	  */
	public static final String MEETINGTYPE_NOTICE = "会议通知";
	
	
	 /** 
	  * TABLE_WIDTH:TODO（JqGrid宽度） 
	  */
	public static final String TABLE_WIDTH = "99%";
	
	
	 /** 
	  * ROLENAME:TODO（会议系统管理员） 
	  */
	public static final String ROLENAME = "会议系统管理员";
	/** 
	  * ROLENAME:TODO（会议消息模版类型） 
	  */
	public static final String MEETING_MSG = "meeting_msg";
	/** 
	  * ROLENAME:TODO（会议消息模版类型） 
	  */
	public static final String MEETING_MSG_REPLY = "meeting_msg_reply";
	/** 
	  * ROLENAME:TODO（会议消息模版类型） 
	  */
	public static final String MEETING_MSG_CANCEL = "meeting_msg_cancel";
	
	
	 /** 
	  * MEETING_PARAM_TMPISOK:TODO（会议暂存是否为预约成功） 
	  * 0暂存的会议时间段不会占用，可以允许使用；
	  * 1暂存的会议时间段会被占用，不允许再被使用。
	  */
	public static final String MEETING_PARAM_TMPISOK = "tmpisok";

}
