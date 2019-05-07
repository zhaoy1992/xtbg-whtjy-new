package com.chinacreator.xtbg.core.common.note.services.impl.jingdi.dao;

import java.sql.Connection;

import com.chinacreator.xtbg.core.common.note.services.impl.jingdi.entity.SendTask;

/**
 * 
 *<p>Title:JingdiDoteSendDao.java</p>
 *<p>Description:金迪Dao服务类</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 黄艺平
 *@version 1.0
 *2013-6-24
 */
public interface JingdiDoteSendDao {
	
	/**
	 * 
	*<b>Summary: </b>
	* smsSendDao(发送短信)
	* @param sendTask
	* @return
	* @throws Exception
	 */
	public boolean smsSendDao(SendTask sendTask, Connection conn) throws Exception;
}
