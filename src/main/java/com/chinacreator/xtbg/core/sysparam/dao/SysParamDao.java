package com.chinacreator.xtbg.core.sysparam.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:SysParamDao.java</p>
 *<p>Description:系统参数设置接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-18
 */
public interface SysParamDao {

	/**
	 * 
	*<b>Summary: </b>
	* selFileStoragoLocationList(查询系统参数设置列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selSysParamList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* selSysParamValueList(查询参数值列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selSysParamvalueList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamBean(根据P_id查询参数信息)
	* @param p_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getSysParamBean(String p_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamByPcode(根据编号查询参数信息)
	* @param p_code
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getSysParamByPcode(String p_code, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamvalueBean(根据Id查询参数值信息)
	* @param p_value_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getSysParamvalueBean(String p_value_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamvalueByPcode(根据编号查询参数值信息)
	* @param p_code
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getSysParamvalueByPcode(String p_code) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamvalueByPvcode(根据参数值编号查询参数值信息)
	* @param p_value_code
	* @return
	* @throws Exception
	 */
	public Map<String, String> getSysParamvalueByPvcode(String p_value_code,String p_code) throws Exception;
}
