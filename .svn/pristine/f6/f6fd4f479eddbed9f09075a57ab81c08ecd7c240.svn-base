package com.chinacreator.xtbg.core.businessclassmanager.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * 
 *<p>Title:FormClassDao.java</p>
 *<p>Description:业务类型接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-10-30
 */
public interface FormClassDao {
	
	/**
	 * 
	*<b>Summary: </b>
	* getEformClassList(根据应用id和上级id查询业务类型信息)
	* @param appID
	* @param upid
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getEformClassList(String appID, String upid,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getFormClassByClassId(根据ID查询业务类型信息)
	* @param classId
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getFormClassByClassId(String classId,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getMaxEc_SnByAppId(根据应用id查询排序号)
	* @param appId
	* @param conn
	* @return
	* @throws Exception
	 */
	public int getMaxEc_SnByAppId(String appId,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isExistByUpId(判断该业务类型是否存在)
	* @param ec_name
	* @param app_id
	* @param ec_upid
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean isExistByUpId(String ec_name, String app_id, String ec_upid,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isExistByEc_name(判断该业务类型是否存在)
	* @param ec_name
	* @param app_id
	* @param ec_id
	* @param up_id
	* @return
	* @throws Exception
	 */
	public boolean isExistByEc_name(String ec_name, String app_id, String ec_id, String up_id,Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isExistSonByUpId(查询是否有子类)
	* @param ec_upid
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean isExistSonByUpId(String ec_upid,Connection conn)throws Exception;
}
