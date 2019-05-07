package com.chinacreator.xtbg.core.common.note.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.chinacreator.xtbg.core.common.note.dao.NoteDetailDao;
import com.chinacreator.xtbg.core.common.note.entity.NoteDetailBean;
import com.frameworkset.common.poolman.PreparedDBUtil;
/**
 *<p>Title:NoteDetailDaoImpl.java</p>
 *<p>Description:</p>
 *<p>Copyright:Copyright (c) 2013</p>
 *<p>Company:湖南科创</p>
 *@author 王博
 *@version 1.0
 *2013-6-17
 */
public class NoteDetailDaoImpl implements NoteDetailDao {

	/**
	  * <b>Summary: </b>
	  *     复写方法 insertNoteDetail
	  * @param detailList
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteDetailDao#insertNoteDetail(java.util.List, java.sql.Connection)
	 */
	@Override
	public boolean insertNoteDetail(List<NoteDetailBean> detailList,
			Connection conn) throws SQLException {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into oa_note_detail");
		sql.append("  (recv_id, buffer_id, phone_num, user_id, user_name, org_id, org_name)");
		sql.append("values");
		sql.append("  (?, ?, ?, ?, ?, ?, ?)");
		for (NoteDetailBean noteDetailBean : detailList) {
			pdb.preparedInsert(sql.toString());
			pdb.setString(1, noteDetailBean.getRecv_id());
			pdb.setString(2, noteDetailBean.getBuffer_id());
			pdb.setString(3, noteDetailBean.getPhone_num());
			pdb.setString(4, noteDetailBean.getUser_id());
			pdb.setString(5, noteDetailBean.getUser_name());
			pdb.setString(6, noteDetailBean.getOrg_id());
			pdb.setString(7, noteDetailBean.getOrg_name());
			pdb.addPreparedBatch();
			
		}
		pdb.executePreparedBatch(conn);
		return true;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 queryNoteDetails
	  * @param buffer_id
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteDetailDao#queryNoteDetails(java.lang.String, java.sql.Connection)
	 */
	public List<NoteDetailBean> queryNoteDetails(String buffer_id,Connection conn) throws SQLException{
		
		//查询要发送的人的信息
		StringBuffer sql = new StringBuffer();
		sql.append("  select d.recv_id,");
		sql.append("         d.buffer_id,");
		sql.append("         d.phone_num,");
		sql.append("         d.user_id,");
		sql.append("         d.user_name,");
		sql.append("         d.org_id,");
		sql.append("         d.org_name");
		sql.append("    from oa_note_detail d");
		sql.append("   where d.buffer_id = ?");
		
		PreparedDBUtil pdbdetail = new PreparedDBUtil();
		pdbdetail.preparedSelect(sql.toString()); 
		pdbdetail.setString(1,buffer_id);
		pdbdetail.executePrepared(conn);
		List<NoteDetailBean> noteDetailBeanList = new ArrayList<NoteDetailBean>();
		for (int j = 0; j < pdbdetail.size(); j++) {
			NoteDetailBean noteDetailBean = new NoteDetailBean();
			noteDetailBean.setRecv_id(pdbdetail.getString(j, "recv_id"));
			noteDetailBean.setBuffer_id(pdbdetail.getString(j, "buffer_id"));
			noteDetailBean.setPhone_num(pdbdetail.getString(j, "phone_num"));
			noteDetailBean.setUser_id(pdbdetail.getString(j, "user_id"));
			noteDetailBean.setUser_name(pdbdetail.getString(j, "user_name"));
			noteDetailBean.setOrg_id(pdbdetail.getString(j, "org_id"));
			noteDetailBean.setOrg_name(pdbdetail.getString(j, "org_name"));
			noteDetailBeanList.add(noteDetailBean);
		}
		return noteDetailBeanList;
	}
	
	/**
	  * <b>Summary: </b>
	  *     复写方法 deleteNoteDetailByBufferId
	  * @param buffer_id
	  * @param conn
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.common.note.dao.NoteDetailDao#deleteNoteDetailByBufferId(java.lang.String, java.sql.Connection)
	 */
	public boolean deleteNoteDetailByBufferId(String buffer_id,Connection conn) throws SQLException{
		PreparedDBUtil pdb = new PreparedDBUtil();
		String sql = "delete oa_note_detail d where d.buffer_id = ?";
		pdb.preparedDelete(sql);
		pdb.setString(1, buffer_id);
		pdb.executePrepared(conn);
		return true;
	}
}
