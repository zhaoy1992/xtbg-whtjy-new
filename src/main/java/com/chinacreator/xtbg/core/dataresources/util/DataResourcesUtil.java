package com.chinacreator.xtbg.core.dataresources.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.chinacreator.xtbg.core.common.startup.LoadSpringContext;
import com.chinacreator.xtbg.core.dataresources.dao.DataResourcesDao;

/**
 * 
 *<p>Title:DataResourcesUtil.java</p>
 *<p>Description:数据资源工具类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-24
 */
public class DataResourcesUtil {
	private static final Log LOG = LogFactory.getLog(DataResourcesUtil.class);
	/**
	 * 
	*<b>Summary: </b>
	* getDataResourcesRecipient(获得数据资源的单位接收人(用户,号分开))
	* @param unit_id
	* @param resources_id
	* @return
	 */
	public static String getDataResourcesRecipient(String unit_id, String resources_logo) {
		String config_ids = "";
		DataResourcesDao dataResourcesDao = (DataResourcesDao)LoadSpringContext.getApplicationContext().getBean("dataResourcesDaoImpl");
		try {
			config_ids = dataResourcesDao.getDataResourcesRecipient(unit_id, resources_logo);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return config_ids;
		
	}
}
