package com.chinacreator.xtbg.core.kbm.service;

import java.util.Map;

import com.chinacreator.xtbg.core.kbm.entity.KbmDocRssBean;

/**
 * 
 *<p>Title:KbmDocRssService.java</p>
 *<p>Description:知识库文档订阅服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-13
 */
public interface KbmDocRssService {

	/**
	 * 
	*<b>Summary: </b>
	* deleteKbmDocRss(删除文档订阅)
	* @param beanids
	* @return
	 */
	public Boolean deleteKbmDocRss(String beanids);
	/**
	 * 
	*<b>Summary: </b>
	* getKbmDocRssBean(根据id查询文档订阅信息)
	* @param k_rss_id
	* @return
	 */
	public Map<String, String> getKbmDocRssBean(String k_rss_id);
	/**
	 * 
	*<b>Summary: </b>
	* addKbmDocRss(添加文档订阅)
	* @param bean
	* @return
	 */
	public Boolean addKbmDocRss(KbmDocRssBean bean);
	/**
	 * 
	*<b>Summary: </b>
	* updKbmDocRss(修改文档订阅)
	* @param bean
	* @return
	 */
	public Boolean updKbmDocRss(KbmDocRssBean bean);
}
