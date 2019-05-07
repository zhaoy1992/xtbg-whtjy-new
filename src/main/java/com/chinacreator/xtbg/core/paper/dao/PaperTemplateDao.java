package com.chinacreator.xtbg.core.paper.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 *<p>Title:PaperTemplateDao.java</p>
 *<p>Description:信息报送模版管理Dao接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄海
 *@version 1.0
 *2013-9-13
 */
public interface PaperTemplateDao {
	/**
	 * 
	*<b>Summary: </b>
	* selPaperTemplateList(查询信息报送模版管理列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selPaperTemplateList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	*<b>Summary: </b>
	* getPaperTemplate(根据id查询信息报送模版管理)
	* @param p_template_typeid
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getPaperTemplate(String p_template_typeid, Connection conn) throws Exception;
	
	/**
	*<b>Summary: </b>
	* deletePaperTemplateById(根据id删除信息报送模版管理)
	* @param conn
	* @param beanId
	* @return
	* @throws Exception
	 */
	public boolean deletePaperTemplateById(Connection conn,String beanId)throws Exception;
}
