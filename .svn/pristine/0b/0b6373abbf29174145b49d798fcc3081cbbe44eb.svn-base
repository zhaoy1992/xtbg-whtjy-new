package com.chinacreator.xtbg.core.kbm.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeRightConfig;

/**
 * 
 *<p>Title:KbmDocTypeconfigDao.java</p>
 *<p>Description:知识库分类权限设置接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-8
 */
public interface KbmDocTypeconfigDao {

	/**
	 * 
	*<b>Summary: </b>
	* getMaxDocTypeConfigNum(获得密级个数)
	* @param conn
	* @return
	* @throws Exception
	 */
	public int getMaxDocTypeConfigNum(Connection conn)throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getDocTypeConfigBeanById(根据id查询知识库分类权限信息)
	* @param conn
	* @param beanId
	* @return
	 */
	public Map<String, String> getDocTypeConfigBeanById(Connection conn,String beanId)throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getKbmDocTypeConfigList(查询知识库分类权限设置列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean getKbmDocTypeConfigList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* queryListKbmDocTypeConfig(根据分类id查询该分类下所有权限信息)
	* @param beanid
	* @param con
	* @return
	* @throws Exception
	 */
	public List<KbmDocTypeRightConfig> queryListKbmDocTypeConfig(String beanid,Connection con) throws Exception;
}
