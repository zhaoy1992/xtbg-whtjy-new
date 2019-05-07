package com.chinacreator.xtbg.core.kbm.dao;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * 
 *<p>Title:KbmDocBbsDao.java</p>
 *<p>Description:知识库文档评阅实体接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-15
 */
public interface KbmDocBbsDao {

	/**
	 * 
	*<b>Summary: </b>
	* getKbmDocBbsBeans(根据文档id查询文档所有评阅信息)
	* @param k_doc_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public List<Map<String, String>> getKbmDocBbsBeans(String k_doc_id, Connection conn) throws Exception;
}
