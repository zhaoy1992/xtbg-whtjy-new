package com.chinacreator.xtbg.core.common.note.services.impl.mas2.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.note.services.impl.mas2.entity.SmsOutBoxbean;

/**
 *<p>Title:SmsOutBoxDao.java</p>
 *<p>Description:mas2短信发送dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-18
 */
public interface SmsOutBoxDao {
	
	/**
	*<b>Summary: </b>
	* insertSmsOutBox(短信数据入库)
	* @param list
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean insertSmsOutBox(List<SmsOutBoxbean> list,Connection conn) throws SQLException;

}
