package com.chinacreator.xtbg.core.common.note.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;

import com.chinacreator.xtbg.core.common.note.dao.NoteBufferDao;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean;
import com.frameworkset.common.poolman.PreparedDBUtil;

/**
 *<p>Title:NoteBufferDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-17
 */
public class NoteBufferDaoImpl implements NoteBufferDao{

	/**
	  * <b>Summary: </b>
	  *     复写方法 insertNoteBuffer
	  * @param noteBufferBean
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteBufferDao#insertNoteBuffer(com.chinacreator.xtbg.core.common.note.entity.NoteBufferBean, java.sql.Connection)
	 */
	@Override
	public boolean insertNoteBuffer(NoteBufferBean noteBufferBean,Connection conn) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_note_buffer");
		sql.append("  (buffer_id,");
		sql.append("   content,");
		sql.append("   create_date,");
		sql.append("   send_date,");
		sql.append("   need_status,");
		sql.append("   need_content,");
		sql.append("   retry_times,");
		sql.append("   user_id,");
		sql.append("   user_name,");
		sql.append("   org_id,");
		sql.append("   org_name,");
		sql.append("   business_id,");
		sql.append("   business_type,");
		sql.append("   subject,");
		sql.append("   tag)");
		sql.append("values");
		sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, noteBufferBean.getBuffer_id());
		pdb.setString(2, noteBufferBean.getContent());
		pdb.setTimestamp(3, noteBufferBean.getCreate_date());
		pdb.setTimestamp(4, noteBufferBean.getSend_date());
		pdb.setString(5, noteBufferBean.getNeed_status());
		pdb.setString(6, noteBufferBean.getNeed_content());
		pdb.setString(7,"0");
		pdb.setString(8, noteBufferBean.getUser_id());
		pdb.setString(9, noteBufferBean.getUser_name());
		pdb.setString(10, noteBufferBean.getOrg_id());
		pdb.setString(11, noteBufferBean.getOrg_name());
		pdb.setString(12, noteBufferBean.getBusiness_id());
		pdb.setString(13, noteBufferBean.getBusiness_type());
		pdb.setString(14, noteBufferBean.getSubject());
		pdb.setString(15, noteBufferBean.getTag());
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 queryBufferBean
	  * @param retry_times
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteBufferDao#queryBufferBean(java.lang.String, java.sql.Connection)
	 */
	public NoteBufferBean queryBufferBean(String retry_times,Connection conn) throws SQLException{
		StringBuffer sql = new StringBuffer();
		sql.append("  select b.buffer_id,");
		sql.append("         b.content,");
		sql.append("         b.create_date,");
		sql.append("         b.need_status,");
		sql.append("         b.need_content,");
		sql.append("         b.retry_times,");
		sql.append("         b.user_id,");
		sql.append("         b.user_name,");
		sql.append("         b.org_id,");
		sql.append("         b.org_name,");
		sql.append("         b.business_id,");
		sql.append("         b.business_type,");
		sql.append("         b.subject,");
		sql.append("         b.tag");
		sql.append("    from oa_note_buffer b");
		sql.append("   where b.retry_times < ").append(retry_times);
		sql.append("     and b.send_date < sysdate and rownum < 2 order by b.send_date asc  ");//升序排序，取最远要发送的短信
		
		PreparedDBUtil pdb = new PreparedDBUtil();
		pdb.preparedSelect(sql.toString()); 
		pdb.executePrepared(conn);
		
		NoteBufferBean noteBufferBean = null;
		
		if(pdb.size() > 0) {
			noteBufferBean = new NoteBufferBean();
			noteBufferBean.setBuffer_id(pdb.getString(0, "buffer_id"));
			noteBufferBean.setContent(pdb.getString(0, "content"));
			noteBufferBean.setCreate_date(pdb.getTimestamp(0, "create_date"));
			noteBufferBean.setNeed_status(pdb.getString(0, "need_status"));
			noteBufferBean.setNeed_content(pdb.getString(0, "need_content"));
			noteBufferBean.setRetry_times(pdb.getString(0, "retry_times"));
			noteBufferBean.setUser_id(pdb.getString(0, "user_id"));
			noteBufferBean.setUser_name(pdb.getString(0, "user_name"));
			noteBufferBean.setOrg_id(pdb.getString(0, "org_id"));
			noteBufferBean.setOrg_name(pdb.getString(0, "org_name"));
			noteBufferBean.setBusiness_id(pdb.getString(0, "business_id"));
			noteBufferBean.setBusiness_type(pdb.getString(0, "business_type"));
			noteBufferBean.setSubject(pdb.getString(0, "subject"));
			noteBufferBean.setTag(pdb.getString(0, "tag"));
		}
		return noteBufferBean;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 deleteNoteBuffer
	  * @param buffer_id
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteBufferDao#deleteNoteBuffer(java.lang.String, java.sql.Connection)
	 */
	public boolean deleteNoteBuffer(String buffer_id,Connection conn) throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		String sql = "delete oa_note_buffer b where b.buffer_id = ?";
		pdb.preparedDelete(sql);
		pdb.setString(1, buffer_id);
		pdb.executePrepared(conn);
		return true;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 updateAttemptTimes
	  * @param buffer_id
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteBufferDao#updateAttemptTimes(java.lang.String, java.sql.Connection)
	 */
	public boolean updateAttemptTimes(String buffer_id,Connection conn) throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		String sql = "update oa_note_buffer b set b.retry_times = b.retry_times+1 where b.buffer_id = ?";
		pdb.preparedUpdate(sql);
		pdb.setString(1, buffer_id);
		pdb.executePrepared(conn);
		return true;
	}

}
