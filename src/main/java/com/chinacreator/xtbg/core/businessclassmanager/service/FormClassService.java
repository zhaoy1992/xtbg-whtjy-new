package com.chinacreator.xtbg.core.businessclassmanager.service;

import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.businessclassmanager.entity.FormClass;

/**
 * 
 *<p>Title:FormClassService.java</p>
 *<p>Description:业务类型服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-30
 */
public interface FormClassService {

	/**
	 * 
	*<b>Summary: </b>
	* getEformClassList(根据应用id和上级id查询业务类型信息)
	* @param appID
	* @param upid
	* @return
	 */
	public List<Map<String, String>> getEformClassList(String appID, String upid);
	/**
	 * 
	*<b>Summary: </b>
	* getFormClassByClassId(根据ID查询业务类型信息)
	* @param classId
	* @return
	 */
	public Map<String, String> getFormClassByClassId(String classId);
	/**
	 * 
	*<b>Summary: </b>
	* getMaxEc_SnByAppId(根据应用id查询排序号)
	* @param appId
	* @return
	 */
	public int getMaxEc_SnByAppId(String appId);
	/**
	 * 
	*<b>Summary: </b>
	* isExistByUpId(判断该业务类型是否存在)
	* @param ec_name
	* @param app_id
	* @param ec_upid
	* @return
	 */
	public boolean isExistByUpId(String ec_name, String app_id, String ec_upid);
	/**
	 * 
	*<b>Summary: </b>
	* isExistSonByUpId(查询是否有子类)
	* @param ec_upid
	* @return
	 */
	public boolean isExistSonByUpId(String ec_upid);
	/**
	 * 
	*<b>Summary: </b>
	* isExistByEc_name(判断该业务类型是否存在)
	* @param ec_name
	* @param app_id
	* @param ec_id
	* @param up_id
	* @return
	 */
	public boolean isExistByEc_name(String ec_name, String app_id, String ec_id, String up_id);
	/**
	 * 
	*<b>Summary: </b>
	* insertFormClass(添加业务类型)
	* @param formClass
	* @return
	 */
	public boolean insertFormClass(FormClass formClass);
	/**
	 * 
	*<b>Summary: </b>
	* updateFormClass(更新业务类型)
	* @param formClass
	* @return
	 */
	public boolean updateFormClass(FormClass formClass);
	/**
	 * 
	*<b>Summary: </b>
	* delFormClass(删除业务类型)
	* @param ec_id
	* @return
	 */
	public boolean delFormClass(String ec_id);
}
