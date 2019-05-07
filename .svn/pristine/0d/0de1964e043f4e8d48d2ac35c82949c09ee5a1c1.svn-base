package com.chinacreator.xtbg.core.file.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
/**
 * 
 *<p>FilePurviewDao.java</p>
 *<p>Description:档案分类密级数据访问接口</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 18, 2013
 */
public interface FilePurviewDao {
	/**
	 * 
	 *<b>Summary: </b>
	 * getFileTypeList(查询档案分类密级)
	 * @param parmjson
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean getFilePurviewList(String parmjson, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	
	/**
	 * 
	 *<b>Summary: </b>
	 * getFilePurviewBeanById(通过beanId获得Map形式的行数据集合)
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getFilePurviewBeanById(Connection conn,
			String beanId) throws Exception;

	/**
	 * 
	 *<b>Summary: </b>
	 * deleteFilePurviewBeansById(通过beanId删除以beanId节点为根节点的树结构数据上的所有FilePurviewBean[包含beanId])
	 * @param conn
	 * @param beanId
	 * @return
	 * @throws Exception
	 */
	public boolean deleteFilePurviewBeansById(Connection conn,String beanId)
		throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getMaxFilePurviewNum(获得密级种类数量)
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public int getMaxFilePurviewNum(Connection conn) throws Exception;


}
