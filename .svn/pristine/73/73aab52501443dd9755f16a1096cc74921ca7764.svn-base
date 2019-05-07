package com.chinacreator.xtbg.core.workbench.services;

import java.util.List;
import java.util.Map;


/**
 *<p>Title:WorkbenchService.java</p>
 *<p>Description:工作台服务类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-25
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
	
	/**
	*<b>Summary: </b>
	* queryPendingNum(根据配置的dbfunction 查询用户待办统计数据)
	* @param params dbfunction 函数的参数
	* @return Map<pending-item的id,统计值>  总数key 为   total;
	*/
	public Map<String,Integer> queryPendingNum(List<String> params);
	
}
