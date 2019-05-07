package com.chinacreator.xtbg.core.common.note.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.chinacreator.xtbg.core.common.note.dao.NoteDetailHisDao;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailHisBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:NoteDetailhisDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-17
 */
public class NoteDetailHisDaoImpl implements NoteDetailHisDao {

	/**
	  * <b>Summary: </b>
	  *     复写方法 insertNoteDetailHis
	  * @param detailHisList
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteDetailhisDao#insertNoteDetailHis(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean insertNoteDetailHis(List<NoteDetailHisBean> detailHisList,
			Connection conn) throws SQLException {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_note_detailhis(recv_id,buffer_id,")
			.append("phone_num,user_id,user_name,org_id,org_name,response_id,")
			.append("response_status) values (?,?,?,?,?,?,?,?,?)");
		PreparedDBUtil pdb = new PreparedDBUtil();
		for(NoteDetailHisBean bean : detailHisList){
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, bean.getRecv_id());
			pdb.setString(2, bean.getBuffer_id());
			pdb.setString(3, bean.getPhone_num());
			pdb.setString(4, bean.getUser_id());
			pdb.setString(5, bean.getUser_name());
			pdb.setString(6, bean.getOrg_id());
			pdb.setString(7, bean.getOrg_name());
			pdb.setString(8, bean.getResponse_id());
			pdb.setString(9, bean.getResponse_status());
			pdb.addPreparedBatch();
		}
		pdb.executePreparedBatch(conn);
		return true;
	}

	/**
	  * <b>Summary: </b>
	  *     复写方法 updateReport
	  * @param detailHisList
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteDetailHisDao#updateReport(java.util.List, java.sql.Connection)
	 */
	public boolean updateReport(List<NoteDetailHisBean> detailHisList,Connection conn) throws SQLException{
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_note_detailhis t set t.response_status=?,t.status_date = sysdate where t.response_id=? and t.phone_num=? ");
		PreparedDBUtil pdb = new PreparedDBUtil();
		for(NoteDetailHisBean bean : detailHisList){
			pdb.preparedUpdate(sql.toString());
			pdb.setString(1, bean.getResponse_status());
			pdb.setString(2, bean.getResponse_id());
			pdb.setString(3, bean.getPhone_num());
			pdb.addPreparedBatch();
		}
		pdb.executePreparedBatch(conn);
		return true;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 updateResponseContent
	  * @param detailHisList
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteDetailHisDao#updateResponseContent(java.util.List, java.sql.Connection)
	 */
	public boolean updateResponseContent(List<NoteDetailHisBean> detailHisList,Connection conn) throws SQLException{
		StringBuffer sql = new StringBuffer();
		sql.append("update oa_note_detailhis t set t.response_content = t.response_content || '|' || ?, t.content_date = sysdate where t.response_id=? and t.phone_num=? ");
		PreparedDBUtil pdb = new PreparedDBUtil();
		for(NoteDetailHisBean bean : detailHisList){
			pdb.preparedUpdate(sql.toString());
			pdb.setString(1, bean.getResponse_content());
			pdb.setString(2, bean.getResponse_id());
			pdb.setString(3, bean.getPhone_num());
			pdb.addPreparedBatch();
		}
		pdb.executePreparedBatch(conn);
		return true;
	}
}
