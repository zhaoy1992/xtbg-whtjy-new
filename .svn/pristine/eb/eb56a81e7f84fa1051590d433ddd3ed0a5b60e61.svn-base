package com.chinacreator.xtbg.core.kbm.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * 
 *<p>Title:KbmDocSuggestDao.java</p>
 *<p>Description:知识库文档推荐实体接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-16
 */
public interface KbmDocSuggestDao {

	/**
	 * 
	*<b>Summary: </b>
	* delFavoritesBan(根据人Ids和文档id删除文档推荐)
	* @param userids
	* @param k_doc_id
	* @param conn
	* @throws Exception
	 */
	public void delSuggestBean(String userids,String k_doc_id,Connection conn)throws Exception;
	
	public List<Map<String, String>> getUserBeanbyuserids(String userids,Connection conn)throws Exception;
}
