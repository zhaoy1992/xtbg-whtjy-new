package com.chinacreator.xtbg.core.pubconfig.service;

import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypeTypeBean;
import com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypebean;

/**
 * 
 *<p>Title:FlowBusitypeServiceIfc.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-19
 */

public interface FlowBusitypeServiceIfc {

	/**
	 * 
	*<b>Summary: </b>
	* findFormBusitypeInfoById(根据业务类型编号查询业务类型信息)
	* @param busitype_code
	* @return
	* @throws SQLException
	 */
	public FlowBusitypebean findFlowBusitypeInfoById(String busitype_code) ;
	/**
	 * 
	*<b>Summary: </b>
	* saveFormBusitypeInfo(保存业务类型信息)
	* @param paramjosn
	* @return
	* @throws Exception
	 */
	public boolean saveFlowBusitypeInfo(String paramjosn) ;
	
	/**
	 * 
	*<b>Summary: </b>
	* saveFormBusitypeInfo(保存业务类型信息)
	* @param paramjosn
	* @return
	* @throws Exception
	 */
	public boolean updateFlowBusitypeInfo(String paramjosn) ;
	
	/**
	 * 
	*<b>Summary: </b>
	* deleteSysParamvalue(删除业务类型信息)
	* @param p_value_id
	* @return
	 */
	public Boolean deleteFlowBusitype(String busitype_codes);
	
	/**
	 * 
	*<b>Summary: </b>
	* addBusitypeType(新增业务类型分类)
	* @param flowBusitypeTypeBean
	* @return
	 */
	public boolean addBusitypeType(FlowBusitypeTypeBean FlowBusitypeTypeBean) ;
	
	/**
	 * 
	*<b>Summary: </b>
	* updateBusitypeType(修改业务类型分类)
	* @param flowBusitypeTypeBean
	* @return
	 */
	public boolean updateBusitypeType(FlowBusitypeTypeBean FlowBusitypeTypeBean) ;
	
	/**
	 * 
	*<b>Summary: </b>
	* delBusitypeType(删除业务类型分类)
	* @param busitype_type_code
	* @return
	 */
	public boolean delBusitypeType(String busitype_type_code) ;
	
	/**
	 * 
	*<b>Summary: </b>
	* findFlowBusitypeTypeInfoById(查询业务类型分类)
	* @param busitype_type_code
	* @return
	 */
	public FlowBusitypeTypeBean findFlowBusitypeTypeInfoById(String busitype_type_code) ;
	
	/**
	 * 
	*<b>Summary: </b>
	* getBusitype_type(获取所有的业务类型分类)
	* @return
	 */
	public List<FlowBusitypeTypeBean> getBusitype_type();
	
	/**
	 * 
	*<b>Summary: </b>
	* getBusitypeByTypeId(根据业务类型分类获取业务类型列表)
	* @return
	 */
	public List<FlowBusitypebean> getBusitypeByTypeId(String busitype_type_code);
	/**
	 * 
	*<b>Summary: </b>
	* isBusitypecodeandname(判断是否唯一)
	* @param busitype_code
	* @param busitype_name
	* @param type
	* @return
	 */
	public String isBusitypecodeandname(String busitype_code,String busitype_name,String type);
	
}
