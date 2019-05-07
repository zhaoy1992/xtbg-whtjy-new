package com.chinacreator.xtbg.core.file.dao;

import java.sql.Connection;
import java.util.Set;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.file.entity.FileFilesQueryBean;


/**
 * 
 *<p>Title:FileFavoritesDao.java</p>
 *<p>Description:收藏文件Dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 24, 2013
 */
public interface FileFavoritesDao{
	/**
	 * 
	 *<b>Summary: </b>
	 * queryList(查询本人收藏)
	 * @param bean
	 * @param sortName
	 * @param sortOrder
	 * @param offset
	 * @param maxPagesize
	 * @return
	 * @throws Exception
	 */
	public PagingBean queryList(FileFilesQueryBean bean,
			String sortName, String sortOrder, long offset, int maxPagesize)
			throws Exception;
	/**
	 * 
	 *<b>Summary: </b>
	 * getDocIdByUserId(查询某用户收藏的文件)
	 * @param userId
	 * @param conn
	 * @param flag true:sql加了for update
	 * @return
	 * @throws Exception
	 */
	public Set<String> getDocIdByUserId(String userId,Connection conn,boolean flag)
			throws Exception;
}
