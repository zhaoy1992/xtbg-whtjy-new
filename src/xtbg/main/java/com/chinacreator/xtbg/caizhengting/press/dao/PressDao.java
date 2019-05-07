package com.chinacreator.xtbg.caizhengting.press.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.caizhengting.press.entity.PressBean;
import com.chinacreator.xtbg.core.common.commonlist.PagingBean;

/**
 * 出版社dao接口
 *<p>Title:PressDao.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author pingan.liu
 *@version 1.0
 *Sep 10, 2013
 */
public interface PressDao {

	/**
	 * 插入
	*<b>Summary: </b>
	* insert(请用一句话描述这个方法的作用)
	* @param bean
	* @param conn
	* @return
	* @throws Exception
	 */
	public String insert(PressBean bean, Connection conn) throws Exception;

	/**
	 * 更新
	*<b>Summary: </b>
	* update(请用一句话描述这个方法的作用)
	* @param bean
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean update(PressBean bean, Connection conn) throws Exception;

	/**
	 * 根据id串删除
	*<b>Summary: </b>
	* delete(请用一句话描述这个方法的作用)
	* @param ids
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean delete(String ids, Connection conn) throws Exception;

	/**
	 * 根据名字查找出版社
	*<b>Summary: </b>
	* findPressBeanByName(请用一句话描述这个方法的作用)
	* @param name
	* @param conn
	* @return
	* @throws Exception
	 */
	public PressBean findPressBeanByName(String name, Connection conn)
			throws Exception;
	
	/**
	 * 出版社list
	*<b>Summary: </b>
	* list(请用一句话描述这个方法的作用)
	* @param bean
	* @param sortname
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean list(PressBean bean,
			String sortname, String sortOrder, long offset, int maxPagesize,Connection conn) throws Exception;

}
