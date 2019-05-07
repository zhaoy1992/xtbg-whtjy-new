package com.chinacreator.xtbg.core.agency.service;

import com.chinacreator.xtbg.core.agency.entity.AgencyBean;
/**
 * 
 *<p>Title:AgencyService.java</p>
 *<p>Description:委托待办服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-12-26
 */
public interface AgencyService {
	/**
	 * 
	*<b>Summary: </b>
	* delAgencyById(根据id删除委托待办信息)
	* @param id
	* @return
	* @throws Exception
	 */
	public String delAgencyById(String id)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* setAgencyByName(添加委托待办信息)
	* @param paramjosn
	* @return
	* @throws Exception
	 */
	public String setAgencyByName(String paramjosn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findAgencyBeanById(根据id查询委托待办信息)
	* @param id
	* @return
	* @throws Exception
	 */
	public AgencyBean findAgencyBeanById(String id) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* updateAgencyBeanById(修改委托待办信息)
	* @param paramjosn
	* @return
	* @throws Exception
	 */
	public String updateAgencyBeanById(String paramjosn)throws Exception;
}
	

