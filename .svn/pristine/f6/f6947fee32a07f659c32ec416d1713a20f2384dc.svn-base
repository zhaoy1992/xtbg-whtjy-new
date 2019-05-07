package com.chinacreator.xtbg.core.common.note.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;

/**
 *<p>Title:NoteDetailDao.java</p>
 *<p>Description:短信接收人缓存表dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-17
 */
public interface NoteDetailDao {
	
	/**
	*<b>Summary: </b>
	* insertNoteDetail(短信接收人入库)
	* @param detailList
	* @param conn
	* @return
	* @throws SQLException
	 */
	public boolean insertNoteDetail(List<NoteDetailBean> detailList,Connection conn) throws SQLException;

	/**
	*<b>Summary: </b>
	* queryNoteDetails(根据短信bufferid查询短信接收人信息)
	* @param buffer_id
	* @param conn
	* @return
	* @throws SQLException
	*/
	public List<NoteDetailBean> queryNoteDetails(String buffer_id,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* deleteNoteDetailByBufferId(根据bufferid删除短信接收人缓存信息)
	* @param buffer_id
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean deleteNoteDetailByBufferId(String buffer_id,Connection conn) throws SQLException;

}
