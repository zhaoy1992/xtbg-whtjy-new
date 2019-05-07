package com.chinacreator.xtbg.core.sysparam.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.sysparam.entity.SysParamBean;
import com.chinacreator.xtbg.core.sysparam.entity.SysParamvalueBean;

/**
 * 
 *<p>Title:SysParamServiceIfc.java</p>
 *<p>Description:系统存放位置服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-18
 */
public interface SysParamServiceIfc {

	/**
	 * 
	*<b>Summary: </b>
	* deleteSysParam(删除系统参数)
	* @param p_id
	* @return
	 */
	public Boolean deleteSysParam(String p_id);
	/**
	 * 
	*<b>Summary: </b>
	* deleteSysParamvalue(删除参数值)
	* @param p_value_id
	* @return
	 */
	public Boolean deleteSysParamvalue(String p_value_id);
	/**
	 * 
	*<b>Summary: </b>
	* addSysParam(添加系统参数)
	* @param sysParamBean
	* @return
	 */
	public boolean addSysParam(SysParamBean sysParamBean);
	/**
	 * 
	*<b>Summary: </b>
	* addSysParamvalue(添加参数值)
	* @param sysParamvalueBean
	* @return
	 */
	public boolean addSysParamvalue(SysParamvalueBean sysParamvalueBean);
	/**
	 * 
	*<b>Summary: </b>
	* updateSysParam(修改系统参数)
	* @param sysParamBean
	* @return
	 */
	public boolean updateSysParam(SysParamBean sysParamBean);
	/**
	 * 
	*<b>Summary: </b>
	* updateSysParamvalue(修改参数值)
	* @param sysParamvalueBean
	* @return
	 */
	public boolean updateSysParamvalue(SysParamvalueBean sysParamvalueBean);
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamBean(根据Id查询参数信息)
	* @param p_id
	* @return
	 */
	public Map<String, String> getSysParamBean(String p_id);
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamByPcode(根据编号p_code查询参数信息)
	* @param p_code
	* @return
	 */
	public Map<String, String> getSysParamByPcode(String p_code);
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamBean(根据id查询参数值信息)
	* @param p_id
	* @return
	 */
	public Map<String, String> getSysParamvalueBean(String p_value_id);
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamvalueByPcode(根据编号p_code查询参数值信息)
	* @param p_code
	* @return
	 */
	public List<Map<String, String>> getSysParamvalueByPcode(String p_code);
	/**
	 * 
	*<b>Summary: </b>
	* getSysParamvalueByPvcode(根据编号p_value_code查询参数值信息)
	* @param p_value_code
	* @return
	 */
	public Map<String, String> getSysParamvalueByPvcode(String p_value_code,String p_code);
}
