package com.chinacreator.xtbg.core.upload.dao.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.chinacreator.xtbg.core.common.commonlist.PagingBean;
import com.chinacreator.xtbg.core.common.dbbase.dao.XtDbBaseDao;
import com.chinacreator.xtbg.core.common.util.DateUtil;
import com.chinacreator.xtbg.core.common.util.DbManager;
import com.chinacreator.xtbg.core.common.util.StringUtil;
import com.chinacreator.xtbg.core.upload.dao.UploadDao;
import com.chinacreator.xtbg.core.upload.entity.UploadModel;
import com.frameworkset.common.poolman.PreparedDBUtil;


public class UploadDaoImpl extends XtDbBaseDao  implements UploadDao {
	
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 queryUploadListByAttachId 按附件id查询附件列表
	  * @param conn
	  * @param tableName
	  * @param attach_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.upload.dao.UploadDao#queryUploadListByAttachId(java.sql.Connection, java.lang.String, java.lang.String) 
	  */
	public List<Map<String, String>> queryUploadListByAttachId(Connection conn,String tableName,String attach_id) throws Exception{
		List<Map<String, String>> viewMap = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.*, t.file_name||'.'||t.file_extra  FileName from "+tableName+" t where t.attach_id=? ");
		viewMap= queryToListMap(sql.toString(),conn, attach_id); 
		return viewMap;
	}

	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteUploadById
	  * @param conn
	  * @param tableName
	  * @param fileid
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.upload.dao.UploadDao#deleteUploadById(java.sql.Connection, java.lang.String, java.lang.String) 
	  */
	public boolean deleteUploadById(Connection conn,String tableName,String fileid) throws SQLException {
		boolean flag=false;
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "delete from "+tableName+" t where t.file_id = '"+ fileid.trim() + "'";
		db.executeSql(sql, conn);
		flag = true;
		return flag;
	}
	
	
	
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 deleteUploadByAttachId 根据附件id删除全部附件记录
	  * @param conn
	  * @param tableName
	  * @param attachId
	  * @return
	  * @throws SQLException 
	  * @see com.chinacreator.xtbg.core.upload.dao.UploadDao#deleteUploadByAttachId(java.sql.Connection, java.lang.String, java.lang.String) 
	  */
	public boolean deleteUploadByAttachId(Connection conn,String tableName,String attachId) throws SQLException {
		boolean flag=false;
		PreparedDBUtil db = new PreparedDBUtil();
		String sql = "delete from "+tableName+" t where t.ATTACH_ID = '"+ attachId.trim() + "'";
		db.executeSql(sql, conn);
		flag = true;
		return flag;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 queryUploadList
	  * @param model
	  * @param sortName
	  * @param sortOrder
	  * @param offset
	  * @param maxPagesize
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.upload.dao.UploadDao#queryUploadList(com.chinacreator.xtbg.core.upload.entity.UploadModel, java.lang.String, java.lang.String, long, int) 
	  */
	public PagingBean queryUploadList(UploadModel model, String sortName,
			String sortOrder, long offset, int maxPagesize) throws Exception {
		Connection conn = null;
		PagingBean pb = new PagingBean();
		try {
			conn = DbManager.getInstance().getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append(" select yearfolder,monthfolder,file_id,file_name,file_extra,file_id||'.'||file_extra as filepos,serverfile_name,to_char(creatortime,'yyyy-mm-dd hh24:mi') as creatortime from "+model.getTableName());
			sql.append(" where 1=1 ");
			sql.append(" and ATTACH_ID='"+model.getAttach_id()+"' ");
			sql.append(" order by " + sortName + " " + sortOrder);
			pb = queryToPagingBean(sql.toString(), offset, maxPagesize, conn);
		} finally {
			DbManager.closeConnection(conn);
		}
		return pb;
	}
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 updateUploadFileInfo
	  * @param conn
	  * @param uploadModel
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.upload.dao.UploadDao#updateUploadFileInfo(java.sql.Connection, com.chinacreator.xtbg.core.upload.entity.UploadModel) 
	  */
	public boolean updateUploadFileInfo(Connection conn, UploadModel uploadModel)
			throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		sql.append("update  "+uploadModel.getTableName());
		sql.append("   set  ");

		if (!StringUtil.nullOrBlank(uploadModel.getFile_name())) {
			sql.append("       file_name       = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getFile_type())) {
			sql.append("       file_type       = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getServerfile_name())) {
			sql.append("       serverfile_name = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getFile_extra())) {
			sql.append("       file_extra      = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getServerfile_path())) {
			sql.append("       serverfile_path = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getFile_size())) {
			sql.append("       file_size       = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getParentfile_id())) {
			sql.append("       parentfile_id   = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getUser_id())) {
			sql.append("       user_id         = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getDepart_id())) {
			sql.append("       depart_id       = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getUpload_time())) {
			sql.append("       upload_time     = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getIs_share())) {
			sql.append("       is_share        = ?,");
		}
		if (!StringUtil.nullOrBlank(uploadModel.getIs_systemcreate())) {
			sql.append("       is_systemcreate       = ?,");
		}
		pdb.preparedUpdate(sql.substring(0, sql.length() - 1)
				+ " where file_id         = ?");
		int i = 1;

		if (!StringUtil.nullOrBlank(uploadModel.getFile_name())) {
			pdb.setString(i++, StringUtil.deNull(uploadModel.getFile_name()));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getFile_type())) {
			pdb.setString(i++, StringUtil.deNull(uploadModel.getFile_type()));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getServerfile_name())) {
			pdb.setString(i++,
					StringUtil.deNull(uploadModel.getServerfile_name()));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getFile_extra())) {
			pdb.setString(i++, StringUtil.deNull(uploadModel.getFile_extra()));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getServerfile_path())) {
			pdb.setString(i++,
					StringUtil.deNull(uploadModel.getServerfile_path()));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getFile_size())) {
			pdb.setString(i++, StringUtil.deNull(uploadModel.getFile_size()));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getParentfile_id())) {
			pdb.setString(i++,
					StringUtil.deNull(uploadModel.getParentfile_id()));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getUser_id())) {
			pdb.setString(i++, StringUtil.deNull(uploadModel.getUser_id()));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getDepart_id())) {
			pdb.setString(i++, StringUtil.deNull(uploadModel.getDepart_id()));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getUpload_time())) {
			pdb.setTimestamp(i++, DateUtil.parseTimeString(StringUtil
					.deNull(uploadModel.getUpload_time())));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getIs_share())) {
			pdb.setString(i++, StringUtil.deNull(uploadModel.getIs_share()));
		}
		if (!StringUtil.nullOrBlank(uploadModel.getIs_systemcreate())) {
			pdb.setString(i++,
					StringUtil.deNull(uploadModel.getIs_systemcreate()));
		}

		pdb.setString(i++, StringUtil.deNull(uploadModel.getFile_id()));
		pdb.executePrepared(conn);
		return true;
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 saveUploadFileInfo
	  * @param conn
	  * @param uploadModel
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.upload.dao.UploadDao#saveUploadFileInfo(java.sql.Connection, com.chinacreator.xtbg.core.upload.entity.UploadModel) 
	  */
	public boolean saveUploadFileInfo(Connection conn,UploadModel uploadModel) throws Exception{
		PreparedDBUtil pdb   = new PreparedDBUtil();
		StringBuffer   sql   = new StringBuffer();
		
		sql.append("insert into "+uploadModel.getTableName());
		sql.append("  (file_id, ");
		sql.append("   file_name, ");
		sql.append("   file_type, ");
		sql.append("   serverfile_name, ");
		sql.append("   file_extra, ");
		sql.append("   serverfile_path, ");
		sql.append("   file_size, ");
		sql.append("   parentfile_id, ");
		sql.append("   user_id, ");
		sql.append("   depart_id, ");
		sql.append("   upload_time, ");
		sql.append("   is_systemcreate, ");
		sql.append("   is_share, ");
		sql.append("   creatortime, ");
		sql.append("   yearfolder, ");
		sql.append("   monthfolder, ");
		sql.append("   attach_id) ");
		sql.append(" values ");
		sql.append("  (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate,?,?,?) ");
		pdb.preparedInsert(sql.toString());
		int i = 1;
		pdb.setString(i++, uploadModel.getFile_id());
		pdb.setString(i++, StringUtil.deNull(uploadModel.getFile_name()));
		pdb.setString(i++, StringUtil.deNull(uploadModel.getFile_type()));
		pdb.setString(i++, StringUtil.deNull(uploadModel.getServerfile_name()));
		pdb.setString(i++, StringUtil.deNull(uploadModel.getFile_extra()));
		pdb.setString(i++, StringUtil.deNull(uploadModel.getServerfile_path()));
		pdb.setString(i++, StringUtil.deNull(uploadModel.getFile_size()));
		pdb.setString(i++, StringUtil.deNull(uploadModel.getParentfile_id()));
		pdb.setString(i++, StringUtil.deNull(uploadModel.getUser_id()));
		pdb.setString(i++, StringUtil.deNull(uploadModel.getDepart_id()));
		pdb.setTimestamp(i++, DateUtil.parseTimeString(StringUtil.deNull(uploadModel.getUpload_time())));
		pdb.setString(i++, StringUtil.deNull(uploadModel.getIs_systemcreate()));
		pdb.setString(i++, StringUtil.deNull(uploadModel.getIs_share()));
		pdb.setString(i++, DateUtil.getCurrentYear());
		pdb.setString(i++, DateUtil.getCurrentMonth());
		pdb.setString(i++, StringUtil.deNull(uploadModel.getAttach_id()));
		pdb.executePrepared(conn);
		if("OA_FILEUPLOAD_KBM".equals(uploadModel.getTableName())){
			updateKbmDocCreatime(uploadModel.getAttach_id());
		}
		return true;
	}

	/**
	 * 特检院特殊操作
	 */
	public void updateKbmDocCreatime(String attachid){
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		StringBuffer upsql = new StringBuffer();
		sql.append(" select k.k_doc_id from oa_kbm_doc  k where k.k_attach_id =? ");
		String k_doc_id ="";
		try {
			pdb.preparedSelect(sql.toString());
			int j = 1;
			if (!StringUtil.nullOrBlank(attachid)) {
				pdb.setString(j++, attachid);
			}
			pdb.executePrepared();
			for(int i = 0 ; i< pdb.size(); i++ ){
				k_doc_id = pdb.getString(i,"k_doc_id");
			}
			if(null != k_doc_id  && !"".equals(k_doc_id)){
				upsql.append("update oa_kbm_doc k set k.k_create_time =  ");
				upsql.append(" to_date(?,'yyyy-mm-dd hh24:mi:ss') where k.k_doc_id =? ");
				pdb.preparedUpdate(upsql.toString());
				pdb.setString(1, DateUtil.getCurrentDateTime());
				pdb.setString(2, k_doc_id);
				pdb.executePrepared();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	 /** 
	  * <b>Summary: </b>
	  *     复写方法 isExsitFile
	  * @param tableName
	  * @param serverfilename
	  * @param extrainfo
	  * @param attach_id
	  * @return
	  * @throws Exception 
	  * @see com.chinacreator.xtbg.core.upload.dao.UploadDao#isExsitFile(java.lang.String, java.lang.String, java.lang.String, java.lang.String) 
	  */
	public String isExsitFile(String tableName, String serverfilename,
			String extrainfo, String attach_id) throws Exception {
		PreparedDBUtil pdb = new PreparedDBUtil();
		StringBuffer sql = new StringBuffer();
		String fileid = "";
		sql.append("select file_id from "+tableName+" t ");
		sql.append("where 1=1  ");
		if (!StringUtil.nullOrBlank(serverfilename)) {
			sql.append(" and file_name = ?  ");
		}
		if (!StringUtil.nullOrBlank(extrainfo)) {
			sql.append(" and file_extra = ?  ");
		}
		if (!StringUtil.nullOrBlank(attach_id)) {
			sql.append(" and attach_id = ?  ");
		}
		pdb.preparedSelect(sql.toString());
		int i = 1;
		if (!StringUtil.nullOrBlank(serverfilename)) {
			pdb.setString(i++, serverfilename);
		}
		if (!StringUtil.nullOrBlank(extrainfo)) {
			pdb.setString(i++, extrainfo);
		}
		if (!StringUtil.nullOrBlank(attach_id)) {
			pdb.setString(i++, attach_id);
		}
		pdb.executePrepared();
		if (pdb.size() > 0) {
			fileid = pdb.getString(0, "file_id");
		}
		return fileid;
	}


	@Override
	public List<Map<String, String>> queryFileUploadBeanList(Connection conn,
			String tableName, String attachId) throws Exception {
		
		List<Map<String, String>> viewMap = new ArrayList<Map<String,String>>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t.* from "+tableName+" t where t.djsn in ("+attachId+") ");
		viewMap= queryToListMap(sql.toString(),conn); 
		return viewMap;
	}

}
