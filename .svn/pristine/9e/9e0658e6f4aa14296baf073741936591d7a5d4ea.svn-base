package com.chinacreator.xtbg.core.archive.dao;

import java.sql.Connection;
import java.util.List;

import com.chinacreator.xtbg.core.archive.entity.DocumentComideaBean;

/**
 * 
 *<p>Title:ComideaDao.java</p>
 *<p>Description:常用意见接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-11-20
 */
public interface ComideaDao {
	/**
	 * 
	*<b>Summary: </b>
	* delComidea(删除常用内容)
	* @param content
	* @param conn
	* @return
	* @throws Exception
	 */
	public boolean delComidea(String content,String user_id,Connection conn) throws Exception;
	/**
	 * 得常用内容列表
	 * @param user_id
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<DocumentComideaBean> getList(String user_id,Connection conn)throws Exception;
}
