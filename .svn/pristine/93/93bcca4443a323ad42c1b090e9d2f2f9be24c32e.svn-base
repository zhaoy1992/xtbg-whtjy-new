package com.chinacreator.xtbg.core.kbm.dao;

import java.sql.Connection;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.kbm.entity.KbmDocRssBean;

/**
 * 
 *<p>Title:KbmDocRssDao.java</p>
 *<p>Description:知识库文档订阅接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-13
 */
public interface KbmDocRssDao {

	/**
	 * 
	*<b>Summary: </b>
	* queryKbmDocRssList(查询文档订阅列表)
	* @param model
	* @param sortName
	* @param sortOrder
	* @param offset
	* @param maxPagesize
	* @return
	* @throws Exception
	 */
	public PagingBean queryKbmDocRssList(KbmDocRssBean model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception;
	/**
	 * 
	*<b>Summary: </b>
	* getKbmDocRss(根据id查询文档订阅的信息)
	* @param k_rss_id
	* @param conn
	* @return
	* @throws Exception
	 */
	public Map<String, String> getKbmDocRss(String k_rss_id, Connection conn) throws Exception;
}
