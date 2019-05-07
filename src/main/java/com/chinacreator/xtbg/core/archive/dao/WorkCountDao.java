package com.chinacreator.xtbg.core.archive.dao;


import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.archive.entity.SearchBean;
import com.chinacreator.xtbg.core.archive.entity.SfwdjUserListConfBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

public interface WorkCountDao {
	/**
	 * 
	*<b>Summary: </b>
	* workcount(查询发文统计)
	* @param SearchBean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	PagingBean workcount(SearchBean searchBean, String sortName, String sortOrder, long offset, int maxPagesize) throws Exception;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getAllTableByListType(根据列表类别获取所有相应的公文业务表)
	* @param listtype
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> getAllGWTableByListType(String listtype) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getColumnsByTableId(根据tableid查出相应的字段)
	* @param tableid
	* @return
	* @throws Exception
	 */
	public List<Map<String,String>> getColumnsByTableId(String tableid) throws Exception;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* saveUserListConfig(保存用户列表配置信息)
	* @param sfwdjUserListConfBean
	* @throws Exception
	 */
	public void saveUserListConfig(SfwdjUserListConfBean sfwdjUserListConfBean) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getUserListConfigInfo(请用一句话描述这个方法的作用)
	* @param listtype
	* @param userid
	* @return
	* @throws Exception
	 */
	public SfwdjUserListConfBean getUserListConfigInfo(String listtype,String userid) throws Exception;
	
	
	/**
	 * 
	*<b>Summary: </b>
	* getListExtendFields(获取列表扩展属性)
	* @param list_type
	* @param user_id
	* @return
	* @throws Exception
	 */
	public Map<String,String> getListExtendFields(String list_type,String user_id) throws Exception;
}
