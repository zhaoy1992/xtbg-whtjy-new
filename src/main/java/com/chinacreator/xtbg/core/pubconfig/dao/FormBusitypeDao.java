package com.chinacreator.xtbg.core.pubconfig.dao;

import java.sql.SQLException;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.pubconfig.entity.FormBusitypebean;

/**
 * 
 *<p>Title:FormBusitypeDao.java</p>
 *<p>Description:表单业务类型接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-29
 */
public interface FormBusitypeDao {

	/**
	 * 
	*<b>Summary: </b>
	* selFormBusitypeList(查询表单业务类型列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selFormBusitypeList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* findFormBusitypeInfoById(根据业务类型编号查询业务类型信息)
	* @param busitype_code
	* @return
	* @throws SQLException
	 */
	public FormBusitypebean findFormBusitypeInfoById(String busitype_code) throws SQLException;
}
