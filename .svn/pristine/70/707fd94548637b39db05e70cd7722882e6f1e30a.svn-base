package com.chinacreator.xtbg.core.process.flowprocessing.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

/**
 *<p>Title:FlowClassUtil.java</p>
 *<p>Description:流程实例bean工具类</p>
 *<p>Copyright:Copyright (c) 2012</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *@date 2013-4-10
 */
public class FlowClassUtil {

	protected static final Logger log = Logger.getLogger(FlowClassUtil.class.getName());

	/**
	 * 
	*<b>Summary: </b>
	* getNewInstanceCode(产生新instance_code)
	* @param busitype_code
	* @return
	* @throws Exception
	 */
	public static synchronized String getNewInstanceCode(String busitype_code)
			throws Exception {
		Date today = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddhhmmssSSS");
		String currentDate = sf.format(today);
		return currentDate + busitype_code;
	}
	
}
