package com.chinacreator.xtbg.core.archive.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.GWCSUnitBean;

/**
 * 
 *<p>Title:GWCSUnitDao.java</p>
 *<p>Description:公文传输的地址簿dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 陈建华
 *@version 1.0
 *Oct 31, 2013
 */
public interface GWCSUnitDao {
	/**
	 * 
	*<b>Summary: 根据条件查询公文传输的地址簿</b>
	* list()
	* @param bean
	* @param con
	* @return
	* @throws Exception
	 */
	public List<GWCSUnitBean> list(GWCSUnitBean bean,Connection con) throws Exception ;
	
	/**
	 * 
	*<b>Summary: 根据机构名称串查询</b>
	* listByOrgName()
	* @param bean
	* @param con
	* @return
	* @throws Exception
	 */
	public List<GWCSUnitBean> listByOrgNames(String names,Connection con) throws Exception ;
}
