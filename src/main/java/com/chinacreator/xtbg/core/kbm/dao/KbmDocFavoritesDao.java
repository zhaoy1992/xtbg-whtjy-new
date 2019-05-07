package com.chinacreator.xtbg.core.kbm.dao;

import java.sql.Connection;

/**
 * 
 *<p>Title:KbmDocFavoritesDao.java</p>
 *<p>Description:知识库我的文档实体接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-15
 */
public interface KbmDocFavoritesDao {
	
	/**
	 * 
	*<b>Summary: </b>
	* delFavoritesBan(根据人Id和文档id删除我的收藏)
	* @param userid
	* @param k_doc_id
	* @param conn
	* @throws Exception
	 */
	public void delFavoritesBan(String userid,String k_doc_id,Connection conn)throws Exception;
}
