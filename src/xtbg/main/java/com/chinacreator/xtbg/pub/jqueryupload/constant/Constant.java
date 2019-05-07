package com.chinacreator.xtbg.pub.jqueryupload.constant;

public final class Constant {
	/**
	 * FILE_SIZE_LIMIT
	 */
	public static String FILE_SIZE_LIMIT_KEY = "FILE_SIZE_LIMIT";
	/**
	 * FILE_COUNT_LIMIT
	 */
	public static final String FILE_COUNT_LIMIT_KEY = "FILE_COUNT_LIMIT";
	/**
	 * ENCODING
	 */
	public static String ENCODING_KEY = "ENCODING";
	/**
	 * USE_CUSTOMDIR
	 */
	public static String USE_CUSTOMDIR_KEY = "USE_CUSTOMDIR";
	/**
	 * ROOT_UPLOADDIR
	 */
	public static String ROOT_UPLOADDIR_KEY = "ROOT_UPLOADDIR";
	
	public static String webroot;

	
	//上传通知信息代号
	public static final String UPLOAD_COMPLETE 				="2";//成功并且完成了全部的上传
	public static final String UPLOAD_SUCCESS 				="1";//成功
	public static final String UPLOAD_FAILED                ="0";//失败
	public static final String UNKONW_EXCEPTION				="-1";//未知异常
	public static final String HTTP_ERROR                   ="-2";
	public static final String MISSING_UPLOAD_URL           ="-3";
	public static final String IO_ERROR                     ="-4";
	public static final String UPLOAD_LIMIT_EXCEEDED        ="-5";
	public static final String SPECIFIED_FILE_ID_NOT_FOUND  ="-6";
	public static final String FILE_VALIDATION_FAILED       ="-7";
	public static final String FILE_OVERSETSIZE				="-8";//超出上传最大尺寸限制
	public static final String FILE_CANCELLED               ="-9";//取消上传
	public static final String UPLOAD_STOPPED               ="-10";//停止上传
	public static final String RESIZE                       ="-11";
	
	//下载通知信息代号
	
	/**
	 * 下载通知信息：输入流为null
	 */
	public static final String MSG_CODE_100 = "100";
	/**
	 * 下载通知信息：用户自定义操作异常
	 */
	public static final String MSG_CODE_200 = "200";
	/**
	 * 下载通知信息：向客户端写文件IO异常
	 */
	public static final String MSG_CODE_300 = "300";
	
	
}
