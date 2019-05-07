package com.chinacreator.xtbg.core.common.note.dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;

/**
 *<p>Title:NoteBufferDao.java</p>
 *<p>Description:短信发送缓存表dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-17
 */
public interface NoteBufferDao {
	
	/**
	*<b>Summary: </b>
	* insertNoteBuffer(短信发送内容入库)
	* @param noteBufferBean
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean insertNoteBuffer(NoteBufferBean noteBufferBean,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* queryBufferBean(查询待发送的短信内容数据，每次查询一条)
	* @param retry_times 最大重发次数
	* @param conn
	* @return
	* @throws SQLException
	*/
	public NoteBufferBean queryBufferBean(String retry_times,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* deleteNoteBuffer(删除缓存表数据)
	* @param buffer_id
	* @param conn
	* @return
	* @throws SQLException
	 */
	public boolean deleteNoteBuffer(String buffer_id,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* updateAttemptTimes(增加重发次数)
	* @param buffer_id
	* @param conn
	* @return
	* @throws SQLException
	 */
	public boolean updateAttemptTimes(String buffer_id,Connection conn) throws SQLException;

}
