package com.chinacreator.xtbg.core.common.note.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.note.entity.NoteDetailHisBean;

/**
 *<p>Title:NoteDetailhisDao.java</p>
 *<p>Description:短信接收人历史表dao</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-17
 */
public interface NoteDetailHisDao {
	
	/**
	*<b>Summary: </b>
	* insertNoteDetail(短信接收人历史数据入库)
	* @param detailList
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean insertNoteDetailHis(List<NoteDetailHisBean> detailHisList,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* updateReport(更新短信回执状态)
	* @param detailHisList
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean updateReport(List<NoteDetailHisBean> detailHisList,Connection conn) throws SQLException;
	
	/**
	*<b>Summary: </b>
	* updateResponseContent(更新回复内容)
	* @param detailHisList
	* @param conn
	* @return
	* @throws SQLException
	*/
	public boolean updateResponseContent(List<NoteDetailHisBean> detailHisList,Connection conn) throws SQLException;

}
