package com.chinacreator.xtbg.core.kbm.service;

import java.util.List;
import java.util.Map;


/**
 *<p>Title:WorkbenchService.java</p>
 *<p>Description:知识库服务类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-8-16
 */
public interface WorkbenchService {

	/**
	*<b>Summary: </b>
	* queryUserData(根据显示模块id和用户id查询相应的显示数据)
	* @param itemID 显示模块id first_config.xml中show-item 的id
	* @param userID	用户id
	* @return   List<Map<字段名, 字段值>>  
	*/
	public List<Map<String, String>> queryUserData(String itemID,String userID);
	
	
	
}
