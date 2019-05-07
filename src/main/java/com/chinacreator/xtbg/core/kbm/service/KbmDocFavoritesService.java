package com.chinacreator.xtbg.core.kbm.service;
/**
 * 
 *<p>Title:KbmDocFavoritesService.java</p>
 *<p>Description:知识库我的收藏服务接口类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 肖杰
 *@version 1.0
 *2013-8-12
 */
public interface KbmDocFavoritesService {

	/**
	 * 
	*<b>Summary: </b>
	* deleteFavorites(取消收藏)
	* @param p_id
	* @return
	 */
	public Boolean deleteFavorites(String beanids);
	/**
	 * 
	*<b>Summary: </b>
	* insertKbmDocFavorites(添加我的收藏文档)
	* @param userid
	* @param username
	* @param k_doc_ids
	* @return
	 */
	public boolean insertKbmDocFavorites(String userid,String username,String k_doc_ids);
}
