package com.chinacreator.xtbg.core.pubconfig.dao;

import java.util.List;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypeTypeBean;
import com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypebean;

/**
 * 
 *<p>Title:FlowBusitypeDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-16
 */

public interface FlowBusitypeDao {

	/**
	 * 
	*<b>Summary: </b>
	* getFlowBusitypeList(查询业务类型列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean getFlowBusitypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;

	
	/**
	*<b>Summary: </b>
	* findFormBusitypeInfoById(查询业务类型详细信息)
	* @param busitype_code
	* @return 
	*/
	public FlowBusitypebean findFormBusitypeInfoById(String busitype_code)throws Exception;


	
	/**
	*<b>Summary: </b>
	* findFormBusitypeTypeInfoById(查询业务类型分类)
	* @param busitype_type_code
	* @return 
	*/
	public FlowBusitypeTypeBean findFormBusitypeTypeInfoById(String busitype_type_code)throws Exception;


	
	/**
	*<b>Summary: </b>
	* getBusitype_type(获取所有的业务类型分类)
	* @return 
	*/
	public List<FlowBusitypeTypeBean> getBusitype_type()throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isBusiType_code(是否存在业务类型编码)
	* @return
	 */
	public  boolean isBusiType_code(String busitype_code)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isBusiType_code(是否存在业务类型名称)
	* @return
	 */
	public  boolean isBusiType_name(String busitype_name,String busitype_code)throws Exception;
	
}
