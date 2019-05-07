package com.chinacreator.business.common.tools;

import org.apache.log4j.Logger;

import com.chinacreator.business.common.publuc.Dictionary;

/**
 * <p>
 * Title:ScheduleServlet.java
 * </p>
 * <p>
 * Description:缓存管理代理类，代缓存管理类做一些额外的扩展操作
 * </p>
 * <p>
 * Company:湖南科创
 * </p>
 * @author 夏天
 * @version 1.0 2012-11-20
 */
public class CacheCommonManageProxy {
	private static final Logger logger = Logger.getLogger(CacheCommonManageProxy.class);
	private static CacheCommonManage cacheCommonManage = CacheCommonManage.getInstance();
	
	/**
	 * 
	*<b>Summary: 根据key获取系统配置文件中的值</b></br>
	* (优先从当前系统对应的配置文件中取值，如果值为null,则再从系统共用的配置文件中找)
	* @param key
	* @return
	 */
	public static String getSystemParam(String key){
		String areaCode = "";
		String value = "";
		String middle_char = Dictionary.SYSTEM_COMMON_CONFIG_MIDDLE_CHAR;//通用配置文件中间的隔开符
		if(null != cacheCommonManage){
			areaCode = cacheCommonManage.getSystemParam("CURSYSTEMCODE");
		}else{
			return "";
		}
		value = cacheCommonManage.getSystemParam(key+middle_char+areaCode);//优先从当前系统对应的配置文件中取值
		if(null == value){
			value = cacheCommonManage.getSystemParam(key);//如果value值为null,则再从系统共用的配置文件中找
		}
		return value;
	}
	
	public static boolean getBooleanSystemParam(String key){
		if(null == getSystemParam(key))
			return false;
		return "true".equals(getSystemParam(key).trim());
	}
}
