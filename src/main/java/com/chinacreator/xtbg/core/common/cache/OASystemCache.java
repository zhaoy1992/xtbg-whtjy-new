package com.chinacreator.xtbg.core.common.cache;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

/**
 *<p>Title:OASystemCache.java</p>
 *<p>Description:自定义PropertyPlaceholderConfigurer返回properties内容</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-7-1
 */
public class OASystemCache extends PropertyPlaceholderConfigurer implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private static Map<String, String> ctxPropertiesMap;//系统properties 配置键值对

	@Override
	protected void processProperties(
			ConfigurableListableBeanFactory beanFactoryToProcess,
			Properties props) throws BeansException {
		super.processProperties(beanFactoryToProcess, props);
		ctxPropertiesMap = new HashMap<String, String>();
		for (Object key : props.keySet()) {
			String keyStr = key.toString();
			String value = props.getProperty(keyStr);
			ctxPropertiesMap.put(keyStr, value);
		}
	}
	
	/**
	 *<b>Summary: 获取系统properties 配置值</b>
	 * getContextProperty()
	 * @param name
	 * @return
	 */
	public static String getContextProperty(String name) {  
        return ctxPropertiesMap.get(name);  
    }  
}

