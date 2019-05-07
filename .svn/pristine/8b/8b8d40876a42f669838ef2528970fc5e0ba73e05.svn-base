package com.chinacreator.xtbg.core.pubconfig.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:FormActionDao.java</p>
 *<p>Description:表单环节定义实体接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-31
 */
public interface FormActionDao {

	/**
	 * 
	*<b>Summary: </b>
	* selFormActionList(查询表单环节定义列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selFormActionList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getFormAciton(根据Id查询表单环节信息)
	* @param action_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getFormAciton(String action_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getFormAcitons(根据业务id查询表单环节信息)
	* @param busitype_code
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getFormAcitons(String busitype_code) throws Exception;
}
