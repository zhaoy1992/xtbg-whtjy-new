package com.chinacreator.xtbg.core.dataresources.service;

import java.util.List;
import java.util.Map;

/**
 * 
 *<p>Title:DataResourcesServiceIfc.java</p>
 *<p>Description:数据资源服务处理接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-7-19
 */
public interface DataResourcesServiceIfc {
	
	/**
	 * 
	*<b>Summary: </b>
	* getDataResourcesBeanMap(查询单位接收的数据资源)
	* @return
	 */
	public List<Map<String, String>> getDataResourcesBeanMap();
	
	/**
	 * 
	*<b>Summary: </b>
	* getUserBeanMap(查询单位下面的用户)
	* @param org_id
	* @return
	 */
	public List<Map<String, String>> getUserBeanMap(String org_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* insertOrgResourceConfig(插入机构资源配置)
	* @param boxvalue
	* @param org_id
	* @return
	 */
	public boolean insertOrgResourceConfig(String boxvalue, String org_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* getChooseOrgUser(查询已选择的机构用户)
	* @param org_id
	* @return
	 */
	public List<String> getChooseOrgUser(String org_id);
	
	/**
	 * 
	*<b>Summary: </b>
	* delAllChooseOrgUser(删除所有单位资源选择的用户)
	* @param org_id
	* @return
	 */
	public boolean delAllChooseOrgUser(String org_id);
}
