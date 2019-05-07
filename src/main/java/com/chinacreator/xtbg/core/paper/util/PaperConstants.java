package com.chinacreator.xtbg.core.paper.util;

/**
 *<p>Title:PaperConstants.java</p>
 *<p>Description:信息报送常量类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-12
 */
public class PaperConstants {
//信息状态：
	 /** 
	  * STATUS_DRAFT:TODO（草稿） 
	  */
	public static final String STATUS_DRAFT = "3";// 草稿
	
	 /** 
	  * STATUS_PENDING:TODO（待采编） 
	  */
	public static final String STATUS_PENDING = "0";// 待采编
	
	 /** 
	  * STATUS_ACCEPT:TODO（已采编） 
	  */
	public static final String STATUS_ACCEPT = "1";// 已采编
	
	 /** 
	  * STATUS_UNACCEPT:TODO（退稿） 
	  */
	public static final String STATUS_UNACCEPT = "2";// 退稿
	
	 /** 
	  * STATUS_PUBLISHED:TODO（已发布） 
	  */
	public static final String STATUS_PUBLISHED = "4";// 已发布
	
	 /** 
	  * STATUS_WAIT_PUBLISH:TODO（待发布） 
	  */
	public static final String STATUS_WAIT_PUBLISH = "5";// 待发布

	 /** 
	  * STATUS_UNDONE:TODO（退回） 
	  */
	public static final String STATUS_UNDONE = "6";// 退回
	
	 /** 
	  * STATUS_UNDONE:TODO（约稿短信提示类型） 
	  */
	public static final String PAPER_MAKE_NOTICE = "PAPER_MAKE_NOTICE";// 
	
	 /** 
	  * STATUS_TMP:TODO（草稿（采编）） 
	  */
	public static final String STATUS_TMP = "7";// 草稿（采编）

	
	 /** 
	  * STATUS_REVISE:TODO（草稿（发布）） 
	  */
	public static final String STATUS_REVISE = "8";// 草稿（发布）
	
	/** 
	  * STATUS_REVISE:TODO（约稿通知单位接收人） 
	  */
	public static final String PAPER_UNIT_RECEIVEROLE = "接收约稿通知者角色";// 草稿（发布）
	
	
	 /** 
	  * PAPERREPORTTOUNIT:TODO（上报的接收单位 oa_data_resources 表的id 注意脚本初始化时要统一） 
	  */
	public static final String PAPERREPORTTOUNIT = "31";
	
}
