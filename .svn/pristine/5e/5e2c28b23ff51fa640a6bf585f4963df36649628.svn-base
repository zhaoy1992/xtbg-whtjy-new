package com.chinacreator.xtbg.core.file.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 
 *<p>Title:FileFondsnoDao.java</p>
 *<p>Description:档案全宗号接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-7-12
 */
public interface FileFondsnoDao {
	/**
	 * 
	*<b>Summary: </b>
	* selFileProgramPageList(查看档案全宗号列表)
	* @param parmjson
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean selFileFondsnoList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getFileProgramPageBean(根据ID查询全宗号信息)
	* @param f_fonds_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getFileFondsnoBean(String f_fonds_id, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getFileProgramPageBean(根据orgID查询全宗号信息)
	* @param f_fonds_orgid
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getFileFondsnoBeanByOrgid(String f_fonds_orgid, Connection conn) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* isNameorCode(判断全宗号和名称是否被引用)
	* @param name
	* @param code
	* @return
	* @throws Exception
	 */
	public String isNameorCode(String name,String code,String id)throws Exception;
}
