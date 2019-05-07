package com.chinacreator.xtbg.core.archive.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.CircularizeBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;


/**
 * 
 *<p>Title:CircularizeDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author shuqi.liu
 *@version 1.0
 *2013-8-21
 */

public interface CircularizeDao {
	/**
	 * 
	*<b>Summary: </b>
	* findCirularizeList( 根据参数查询，查询文件传阅这个功能的待阅读列表) 
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return 
	 */
	public PagingBean findCirularizeList(CircularizeBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize) ;
	
	/**
	 * 
	*<b>Summary: </b>
	* savaCircularize(保存文件传阅信息)
	* @param bean
	* @return
	* @throws SQLException
	 */
	public boolean savaCircularize(List<CircularizeBean> circularizeBeanList , Connection conn) throws SQLException; 
	
	/**
	*<b>Summary: </b>
	* findCirularizeUserReadList( 根据参数查询,查看阅读人员信息) 
	* @param bean
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return 
	 */
	public PagingBean findCirularizeUserReadList(CircularizeBean bean, String sortName,
			String sortOrder, long offset, int maxPagesize);
	/**
	 * 更改已办状态
	 * @param circularize_id
	 * @return
	 * @throws SQLException
	 */
	public boolean updateDone(String circularize_id) throws SQLException;
}
