package com.chinacreator.xtbg.core.subsystemmanage.dao;

import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean;

/**
 * 
 *<p>Title:SubSystemManageDao.java</p>
 *<p>Description:子系统管理Dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 夏天
 *@version 1.0
 *2013-4-28
 */
public interface SubSystemOrgConfigDao {
	/**
	 * @Description 根据条件查询机构配置信息
	 * 分页显示
	 * @param bean
	 * @param sortKey
	 * @param desc
	 * @param offset
	 * @param maxPagesize
	 * @return PagingBean
	 */
	
	public PagingBean findSubSystemOrgConfigList(Map<String,String> SearchConditionMap, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * 
	*<b>Summary: 获取外部子系统机构映射信息</b>
	* @param sys_id
	* @return
	* @throws Exception
	 */
	public Map<String,String> findSubSystemOrgMappingInfo(String subsysorgid) throws Exception;
	
	/**
	 * 
	*<b>Summary: 获取外部子系统机构映射信息</b>
	* @param sys_id
	* @return
	* @throws Exception
	 */
	public Map<String,String> findSubSystemOrgMappingInfoByOAid(String orgid) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getGwcsConfigByID(根绝配置ID查询公文配置)
	* @param id
	* @return
	* @throws Exception
	 */
	public OaGwcsConfigBean getGwcsConfigByID(String id) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* findOaGwcsOrgConfigList(查询OA公文传输系统映射)
	* @param SearchConditionMap
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findOaGwcsOrgConfigList(Map<String,String> SearchConditionMap, String sortName, String sortOrder, long offset, int maxPagesize);
	
	/**
	 * 
	*<b>Summary: </b>
	* findOaGwcsOrgMappingInfo(获取OA公文传输配置)
	* @param orgid
	* @return
	* @throws Exception
	 */
	public Map<String,String> findOaGwcsOrgMappingInfo(String config_id) throws Exception;

	/**
	 * 
	*<b>Summary: </b>
	* findGwcsOrgList(获取公文传输单位列表)
	* @param map
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	 */
	public PagingBean findGwcsOrgList(Map<String, String> map, String sortName,String sortOrder, long offset, int maxPagesize);
}	
