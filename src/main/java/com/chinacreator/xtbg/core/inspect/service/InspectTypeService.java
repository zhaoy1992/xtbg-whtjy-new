package com.chinacreator.xtbg.core.inspect.service;

import java.util.Map;

import com.chinacreator.xtbg.core.inspect.entity.InspectTypeBean;

/**
 * 
 *<p>Title:InspectTypeService.java</p>
 *<p>Description:督查督办任务类别服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-4
 */
public interface InspectTypeService {

	/**
	 * 
	*<b>Summary: </b>
	* getInspectTypeByid(根据id查询类别信息)
	* @param type_id
	* @return
	 */
	public Map<String, String> getInspectTypeByid(String type_id);
	/**
	 * 
	*<b>Summary: </b>
	* addInspectType(新增类别)
	* @param bean
	* @return
	 */
	public boolean addInspectType(InspectTypeBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* updateInspectType(修改类别)
	* @param bean
	* @return
	 */
	public boolean updateInspectType(InspectTypeBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* delInspectType(删除类别)
	* @param type_id
	* @return
	 */
	public boolean delInspectType(String type_id);
}
