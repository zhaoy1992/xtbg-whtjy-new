package com.chinacreator.xtbg.core.common.note.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;

import com.chinacreator.xtbg.core.common.note.dao.NoteBufferHisDao;
import com.chinacreator.xtbg.core.common.note.entity.NoteBufferHisBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:NoteBufferhisDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-17
 */
public class NoteBufferHisDaoImpl implements NoteBufferHisDao {

	/**
	  * <b>Summary: </b>
	  *     复写方法 insertNoteBufferHis
	  * @param NoteBufferHisBean
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteBufferhisDao#insertNoteBufferHis(com.chinacreator.xtbg.core.common.note.entity.NoteBufferHisBean, java.sql.Connection)
	 */
	@Override
	public boolean insertNoteBufferHis(NoteBufferHisBean noteBufferHisBean,
			Connection conn) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_note_bufferhis");
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
		sql.append(" values ");
		sql.append("  (?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		pdb.preparedInsert(sql.toString());
		pdb.setString(1, noteBufferHisBean.getBuffer_id());
		pdb.setString(2, noteBufferHisBean.getContent());
		pdb.setTimestamp(3, noteBufferHisBean.getCreate_date());
		//pdb.setTimestamp(4, noteBufferHisBean.getSend_date());
		pdb.setString(4, noteBufferHisBean.getNeed_status());
		pdb.setString(5, noteBufferHisBean.getNeed_content());
		pdb.setString(6,noteBufferHisBean.getRetry_times());
		pdb.setString(7, noteBufferHisBean.getUser_id());
		pdb.setString(8, noteBufferHisBean.getUser_name());
		pdb.setString(9, noteBufferHisBean.getOrg_id());
		pdb.setString(10, noteBufferHisBean.getOrg_name());
		pdb.setString(11, noteBufferHisBean.getBusiness_id());
		pdb.setString(12, noteBufferHisBean.getBusiness_type());
		pdb.setString(13, noteBufferHisBean.getSubject());
		pdb.setString(14, noteBufferHisBean.getTag());
		pdb.executePrepared(conn);
		return true;
	}

}
