package com.chinacreator.xtbg.core.file.service;

/**
 * 
 *<p>Title:FileFavoritesServiceIfc.java</p>
 *<p>Description:收藏</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 邹拓
 *@version 1.0
 *Jul 24, 2013
 */
public interface FileFavoritesServiceIfc {
	/**
	 * 
	 *<b>Summary: </b>
	 * add(加收藏)
	 * @param FileDocBeanIds
	 * @param userId
	 * @return
	 */
	public boolean add(String[] FileDocBeanIds,String userId);
	/**
	 * 
	 *<b>Summary: </b>
	 * delete(删收藏)
	 * @param beanId
	 * @return
	 */
	public boolean delete(String[] beanId);
}
