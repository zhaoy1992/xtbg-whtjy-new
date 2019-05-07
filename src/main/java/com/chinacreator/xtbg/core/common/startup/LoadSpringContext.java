package com.chinacreator.xtbg.core.common.startup;

import javax.servlet.ServletContext;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;


/**
 *<p>Title:LoadSpringContext.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-4-7
 */
public class LoadSpringContext {
	
	private static WebApplicationContext applicationContext = null;
	
	protected LoadSpringContext(){
		
	}	
	
	/**
	*<b>Summary: </b>
	* init(复制 spring上下文环境到 servlet中)
	* @param context
	*/
	public static void init(ServletContext context){
		if(context == null){
			throw new IllegalArgumentException("ServletContext is null");
		}
		applicationContext = WebApplicationContextUtils.getWebApplicationContext(context);		
		if (applicationContext == null) {
			throw new IllegalArgumentException("applicationContext is null");
		}
	}
	
	/**
	*<b>Summary: </b>
	* getApplicationContext(获取spring上下文)
	* @return
	*/
	public static WebApplicationContext getApplicationContext(){
		return applicationContext;
		
	}
}
